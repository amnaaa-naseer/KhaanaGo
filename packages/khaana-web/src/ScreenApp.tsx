import { useEffect, useMemo, useState } from 'react'
import catalog from '../../screen-catalog/screens.json'
import { api } from './api'
import './tokens.css'

export type ScreenSpec = {
  id: string
  title: string
  role: string
  priority: string
  kind: string
  module: string
  family: string
  requirements: string
  stories: string
  clauses: string[]
  ownerOnly: boolean
}

const screens = catalog as ScreenSpec[]

export function screensFor(role: 'vendor' | 'admin') {
  return screens.filter((screen) => screen.role === role || screen.role === 'shared')
}

function staffDenied(spec: ScreenSpec) {
  if (spec.id === 'E1-US3-UI5' || spec.id === 'E21-US2-UI1') return true
  const text = `${spec.title} ${spec.module}`.toLowerCase()
  if (spec.title.toLowerCase().includes('invoice')) return false
  if (spec.ownerOnly) return true
  return /\bbom\b|bill of materials|recipe|nutrition/.test(text)
}

function stored(key: string, fallback: string) {
  try { return sessionStorage.getItem(key) || fallback } catch { return fallback }
}

export function ScreenApp({ role, homeId }: { role: 'vendor' | 'admin'; homeId: string }) {
  const list = useMemo(() => screensFor(role), [role])
  const [id, setId] = useState(() => stored(`khaanago:${role}:screen`, homeId))
  const [query, setQuery] = useState('')
  const [collapsed, setCollapsed] = useState(() => stored(`khaanago:${role}:collapsed`, '0') === '1')
  const [actor, setActor] = useState(() => stored(`khaanago:${role}:actor`, role === 'admin' ? 'admin' : 'vendor_owner'))
  const [devTools, setDevTools] = useState(() => {
    try { return new URLSearchParams(window.location.search).get('dev') === '1' } catch { return false }
  })
  const spec = list.find((item) => item.id === id) ?? list[0]
  const visible = list.filter((item) => actor !== 'vendor_staff' || !staffDenied(item))
  const needle = query.trim().toLowerCase()
  const filtered = visible.filter((item) => !needle || `${item.title} ${item.id} ${item.module}`.toLowerCase().includes(needle))
  const groups = new Map<string, ScreenSpec[]>()
  for (const item of filtered) {
    const name = item.module || 'Shared'
    groups.set(name, [...(groups.get(name) ?? []), item])
  }

  useEffect(() => {
    try {
      sessionStorage.setItem(`khaanago:${role}:screen`, spec.id)
      sessionStorage.setItem(`khaanago:${role}:collapsed`, collapsed ? '1' : '0')
      sessionStorage.setItem(`khaanago:${role}:actor`, actor)
    } catch { /* demo storage can be unavailable */ }
  }, [role, spec.id, collapsed, actor])

  function openModule() {
    const first = list.find((item) => item.module === spec.module && item.kind === 'Screen')
    if (first) setId(first.id)
  }

  return (
    <div className={collapsed ? 'shell collapsed' : 'shell'}>
      <aside>
        <div className="brand">
          <strong>Khaana<em>Go</em></strong>
          <button className="icon-btn" aria-expanded={!collapsed} aria-label={collapsed ? 'Expand navigation' : 'Collapse navigation'} onClick={() => setCollapsed((value) => !value)}>{collapsed ? '>' : '<'}</button>
        </div>
        <p className="role">{role === 'admin' ? 'Administration' : 'Vendor and kitchen'}</p>
        {role === 'vendor' && (
          <label>Signed in as
            <select value={actor} onChange={(event) => setActor(event.target.value)}>
              <option value="vendor_owner">Owner</option>
              <option value="vendor_staff">Kitchen staff</option>
            </select>
          </label>
        )}
        <label className="nav-search">Find a screen
          <input value={query} placeholder="Search" onChange={(event) => setQuery(event.target.value)} />
        </label>
        {[...groups.entries()].map(([name, items]) => (
          <div key={name}>
            <div className="nav-group">{name}</div>
            {items.map((item) => (
              <button key={item.id} className="nav" aria-current={item.id === spec.id ? 'page' : undefined} title={item.title} onClick={() => setId(item.id)}>
                {collapsed ? item.title.slice(0, 2) : item.title}
              </button>
            ))}
          </div>
        ))}
        {filtered.length === 0 && <p className="role">No screens match.</p>}
      </aside>
      <div className="workspace">
        <header className="topbar">
          <div>
            <p className="crumb"><button type="button" onClick={openModule}>{spec.module || 'Shared'}</button> / {spec.title}</p>
            <p className="page-title" onPointerDown={() => {
              const timer = window.setTimeout(() => setDevTools((value) => !value), 700)
              const clear = () => window.clearTimeout(timer)
              window.addEventListener('pointerup', clear, { once: true })
              window.addEventListener('pointercancel', clear, { once: true })
            }}>{spec.title}</p>
          </div>
        </header>
        <main>
          <ScreenBody spec={spec} role={actor} onOpen={setId} devTools={devTools} />
        </main>
      </div>
    </div>
  )
}

type DemoState = {
  orders?: Array<Record<string, any>>
  finance?: { revenue?: number; commission?: number; expenses?: number } | null
  stock?: Array<Record<string, any>>
  menu?: Array<Record<string, any>>
  slots?: Array<Record<string, any>>
  invoices?: Array<Record<string, any>>
  complaints?: Array<Record<string, any>>
  vendors?: Array<Record<string, any>>
  capacity?: { intakePercent?: number; band?: string; ordersPerHour?: number }
  riders?: Array<Record<string, any>>
}

function money(value: number) {
  return `Rs ${Math.round(value).toLocaleString('en-PK')}`
}

function paceOf(percent: number) {
  if (percent >= 85) return { label: 'Full', tone: 'full' }
  if (percent >= 60) return { label: 'Busy', tone: 'limited' }
  return { label: 'Quiet', tone: 'available' }
}

function paceLabel(band: unknown, percent?: unknown) {
  const named = String(band ?? '').toLowerCase()
  if (named === 'full') return 'Full'
  if (named === 'limited' || named === 'busy') return 'Busy'
  if (named === 'available' || named === 'quiet') return 'Quiet'
  if (percent != null && percent !== '') return paceOf(Number(percent)).label
  return ''
}

function StateSwitcher({ preview, onChange }: { preview: string; onChange: (state: string) => void }) {
  return (
    <div className="states">
      {['ready', 'loading', 'empty', 'error'].map((state) => (
        <button key={state} aria-pressed={preview === state} onClick={() => onChange(state)}>{state}</button>
      ))}
    </div>
  )
}

function plainLabel(text: string) {
  return text
    .replace(/\s*\([^)]*\b(?:AC\d+|E\d+-US\d+(?:-UI\d+)?)[^)]*\)/g, '')
    .replace(/\bE\d+-US\d+(?:-UI\d+)?\b/g, '')
    .replace(/\bAC\d+\b/g, '')
    .replace(/\s+/g, ' ')
    .replace(/\s+([,.;:])/g, '$1')
    .trim()
}

export function ScreenBody({ spec, role, onOpen, devTools = false }: { spec: ScreenSpec; role: string; onOpen: (id: string) => void; devTools?: boolean }) {
  const [data, setData] = useState<DemoState | null>(null)
  const [preview, setPreview] = useState('ready')
  const [notice, setNotice] = useState('')
  const [fields, setFields] = useState<Record<string, string>>({})
  const staffBlocked = role === 'vendor_staff' && staffDenied(spec)

  useEffect(() => {
    api('/v1/state', { role }).then(setData).catch((err) => setNotice(err.message))
  }, [role, spec.id])

  async function save() {
    try {
      await api(`/v1/screens/${spec.id}/submit`, { method: 'POST', role, body: { fields } })
      setNotice('Saved.')
    } catch (err) {
      setNotice(err instanceof Error ? err.message : 'Save failed')
    }
  }

  async function advance(orderId: string, action: string) {
    try {
      await api(`/v1/orders/${orderId}/${action}`, { method: 'POST', role, body: { screen: spec.id } })
      setData(await api('/v1/state', { role }))
      setNotice(`${orderId} updated.`)
    } catch (err) {
      setNotice(err instanceof Error ? err.message : 'Update failed')
    }
  }

  if (preview === 'loading' || preview === 'error' || preview === 'empty') {
    return (
      <section className="page">
        {devTools && <StateSwitcher preview={preview} onChange={setPreview} />}
        {preview === 'loading' && <p>Loading</p>}
        {preview === 'error' && (
          <>
            <p>We could not load this page. Please try again.</p>
            <button onClick={() => setPreview('ready')}>Try again</button>
          </>
        )}
        {preview === 'empty' && <p>Nothing to show yet.</p>}
      </section>
    )
  }
  if (staffBlocked) {
    return (
      <section>
        <h1>{spec.title}</h1>
        <p>You do not have access to this page.</p>
        <button className="primary" onClick={() => onOpen('E7-US3-UI1')}>Back to kitchen board</button>
      </section>
    )
  }

  const orders = data?.orders ?? []
  return (
    <section className="page">
      <h1>{spec.title}</h1>
      {devTools && <StateSwitcher preview={preview} onChange={setPreview} />}
      {notice && <p role="status">{notice}</p>}
      {spec.id === 'E1-US3-UI5' && <OwnerDashboard data={data} onOpen={onOpen} />}
      {spec.id === 'E1-US3-UI6' && <StaffHome onOpen={onOpen} />}
      {spec.id === 'E20-US4-UI1' && <AdminDashboard data={data} onOpen={onOpen} />}
      {spec.id !== 'E1-US3-UI5' && spec.id !== 'E1-US3-UI6' && spec.id !== 'E20-US4-UI1' && spec.family === 'board' && (
        <div className="kanban">
          {[['new', 'New'], ['preparing', 'Preparing'], ['ready', 'Ready'], ['picked_up', 'Handed over'], ['delivered', 'Delivered']].map(([status, label]) => {
            const column = orders.filter((order) => order.status === status)
            return (
              <article key={status}>
                <h2>{label} · {column.length}</h2>
                {column.map((order) => (
                  <div className="ticket" key={order.id}>
                    <strong>{order.id}</strong>
                    <p className="muted">{order.customer || 'Customer'} · {order.slotLabel || 'No slot'}</p>
                    {status === 'new' && <button className="ghost" onClick={() => advance(order.id, 'accept')}>Accept</button>}
                    {status === 'preparing' && <button className="ghost" onClick={() => advance(order.id, 'ready')}>Ready</button>}
                  </div>
                ))}
                {column.length === 0 && <p className="empty">No orders in this column.</p>}
              </article>
            )
          })}
        </div>
      )}
      {spec.family === 'finance' && <FinancePanel data={data} />}
      {spec.family === 'dashboard' && spec.id !== 'E20-US4-UI1' && <p>Orders {orders.length}. Kitchen {paceOf(Number(data?.capacity?.intakePercent ?? 0)).label}.</p>}
      {spec.family === 'list' && <RecordTable spec={spec} data={data} />}
      {spec.clauses.map((clause) => {
        const label = plainLabel(clause)
        if (!label) return null
        return (
          <label key={clause}>{label}
            <input aria-label={label} value={fields[clause] ?? ''} onChange={(event) => setFields({ ...fields, [clause]: event.target.value })} />
          </label>
        )
      })}
      <button className="primary" onClick={save}>Save {spec.title}</button>
      <button className="ghost" onClick={() => onOpen(role === 'admin' ? 'E20-US4-UI1' : role === 'vendor_staff' ? 'E1-US3-UI6' : 'E1-US3-UI5')}>Back to workspace</button>
    </section>
  )
}

function OwnerDashboard({ data, onOpen }: { data: DemoState | null; onOpen: (id: string) => void }) {
  const orders = data?.orders ?? []
  const active = orders.filter((order) => !['delivered', 'cancelled'].includes(order.status))
  const pendingCustom = active.filter((order) => (order.lines ?? []).some((line: any) => line.fragile || line.note || line.customizable))
  const low = (data?.stock ?? []).filter((item) => Number(item.quantity) <= Number(item.reorderAt))
  const percent = Number(data?.capacity?.intakePercent ?? 0)
  const pace = paceOf(percent)
  const filled = Math.round((percent / 100) * 12)
  const counts = [['new', 'New'], ['preparing', 'Preparing'], ['ready', 'Ready'], ['picked_up', 'Handed over'], ['delivered', 'Delivered']].map(([status, label]) => ({ status, label, count: orders.filter((order) => order.status === status).length }))
  const max = Math.max(1, ...counts.map((item) => item.count))
  const fullSlots = (data?.slots ?? []).filter((slot) => slot.band === 'Full' || slot.bookable === false)
  const closed = (data?.vendors ?? []).filter((vendor) => vendor.open === false)
  return (
    <>
      <div className="kpis">
        <button className="kpi" onClick={() => onOpen('E7-US3-UI1')}><span>Orders today</span><strong>{orders.length}</strong></button>
        <button className="kpi" onClick={() => onOpen('E7-US3-UI1')}><span>New / pending</span><strong>{orders.filter((order) => order.status === 'new').length}</strong></button>
        <button className="kpi" onClick={() => onOpen('E7-US3-UI1')}><span>In preparation</span><strong>{orders.filter((order) => order.status === 'preparing').length}</strong></button>
        <button className="kpi" onClick={() => onOpen('E7-US3-UI1')}><span>Ready for pickup</span><strong>{orders.filter((order) => order.status === 'ready').length}</strong></button>
        <button className="kpi" onClick={() => onOpen('E12-US1-UI1')}><span>Revenue</span><strong>{money(Number(data?.finance?.revenue ?? 0))}</strong></button>
        <button className="kpi" onClick={() => onOpen('E5-US1-UI3')}><span>Kitchen</span><strong>{pace.label}</strong></button>
        <button className="kpi" onClick={() => onOpen('E9-US1-UI1')}><span>Low stock</span><strong>{low.length}</strong></button>
        <button className="kpi" onClick={() => onOpen('E7-US3-UI1')}><span>Pending custom orders</span><strong>{pendingCustom.length}</strong></button>
      </div>
      <div className="grid-2">
        <section className="panel">
          <h2>Kitchen pace</h2>
          <p><span className={`badge ${pace.tone}`}>{pace.label}</span> {filled} of 12 orders this hour</p>
          <div className="meter" aria-label={`${pace.label}, ${filled} of 12`}>
            {Array.from({ length: 12 }, (_, index) => <i key={index} className={index < filled ? `on ${pace.tone}` : ''} />)}
          </div>
          <h2>Orders by status</h2>
          <div className="bars">
            {counts.map((item) => (
              <div key={item.status}><span>{item.label}</span><b style={{ width: `${(item.count / max) * 100}%` }} /><span>{item.count}</span></div>
            ))}
          </div>
        </section>
        <section className="panel">
          <h2>Needs attention</h2>
          {low.map((item) => <p key={item.id}>{item.name}: {item.quantity} {item.unit} at or below reorder {item.reorderAt}</p>)}
          {closed.map((vendor) => <p key={vendor.id}><span className="badge closed">Closed</span> {vendor.name}{vendor.opensAt ? ` · opens ${vendor.opensAt}` : ''}</p>)}
          {fullSlots.map((slot) => <p key={slot.id}><span className="badge full">Full</span> {slot.label} is not bookable</p>)}
          {(data?.complaints ?? []).filter((item) => item.status === 'Open').map((item) => <p key={item.id}><span className="badge info">Open</span> {item.id} {item.subject}</p>)}
          {low.length + closed.length + fullSlots.length + (data?.complaints ?? []).filter((item) => item.status === 'Open').length === 0 && <p className="empty">Nothing needs attention.</p>}
        </section>
      </div>
      <section className="panel">
        <h2>Recent orders</h2>
        {orders.length === 0 ? <p className="empty">No orders yet.</p> : (
          <table>
            <thead><tr><th>Order</th><th>Status</th><th>Slot</th><th className="num">Total</th></tr></thead>
            <tbody>
              {orders.slice(0, 8).map((order) => (
                <tr key={order.id}><td>{order.id}</td><td>{order.status}</td><td>{order.slotLabel || '—'}</td><td className="num">{money(Number(order.total || 0))}</td></tr>
              ))}
            </tbody>
          </table>
        )}
      </section>
    </>
  )
}

function StaffHome({ onOpen }: { onOpen: (id: string) => void }) {
  return (
    <section className="panel">
      <h2>Kitchen operations</h2>
      <p>This home shows the board and assigned kitchen work. Finance, recipes, and the owner dashboard stay hidden.</p>
      <div className="row-actions">
        <button className="primary" onClick={() => onOpen('E7-US3-UI1')}>Open kitchen board</button>
      </div>
    </section>
  )
}

function AdminDashboard({ data, onOpen }: { data: DemoState | null; onOpen: (id: string) => void }) {
  const orders = data?.orders ?? []
  const active = orders.filter((order) => !['delivered', 'cancelled'].includes(order.status))
  const delayed = orders.filter((order) => order.delayed === true)
  const riders = data?.riders ?? []
  const online = riders.filter((rider) => rider.approved !== false)
  const percent = Number(data?.capacity?.intakePercent ?? 0)
  return (
    <>
      <div className="kpis">
        <button className="kpi" onClick={() => onOpen('E20-US4-UI2')}><span>Active orders</span><strong>{active.length}</strong></button>
        <button className="kpi" onClick={() => onOpen('E16-US1-UI3')}><span>Delayed orders</span><strong>{delayed.length}</strong></button>
        <button className="kpi"><span>Riders online</span><strong>{online.length}</strong></button>
        <button className="kpi" onClick={() => onOpen('E6-US3-UI1')}><span>Kitchen</span><strong>{paceOf(percent).label}</strong></button>
      </div>
      <section className="panel">
        <h2>Live queue</h2>
        {delayed.length === 0 && <p className="muted">No delayed orders.</p>}
        {orders.length === 0 ? <p className="empty">No orders yet.</p> : (
          <table>
            <thead><tr><th>Order</th><th>Status</th><th>Vendor</th></tr></thead>
            <tbody>{orders.slice(0, 8).map((order) => <tr key={order.id}><td>{order.id}</td><td>{order.status}</td><td>{order.vendorId}</td></tr>)}</tbody>
          </table>
        )}
      </section>
    </>
  )
}

function FinancePanel({ data }: { data: DemoState | null }) {
  const finance = data?.finance
  const invoices = data?.invoices ?? []
  return (
    <section className="panel">
      <div className="kpis">
        <div className="kpi"><span>Revenue</span><strong>{money(Number(finance?.revenue ?? 0))}</strong></div>
        <div className="kpi"><span>Commission</span><strong>{money(Number(finance?.commission ?? 0))}</strong></div>
        <div className="kpi"><span>Expenses</span><strong>{money(Number(finance?.expenses ?? 0))}</strong></div>
        <div className="kpi"><span>Invoices</span><strong>{invoices.length}</strong></div>
      </div>
      {invoices.length === 0 ? <p className="empty">No invoices yet. A delivered order creates one.</p> : (
        <table>
          <thead><tr><th>Invoice</th><th>Status</th><th className="num">Total</th></tr></thead>
          <tbody>{invoices.map((invoice) => <tr key={invoice.id}><td>{invoice.id}</td><td>{invoice.status}</td><td className="num">{money(Number(invoice.total || 0))}</td></tr>)}</tbody>
        </table>
      )}
    </section>
  )
}

function RecordTable({ spec, data }: { spec: ScreenSpec; data: DemoState | null }) {
  const blob = `${spec.module} ${spec.title}`.toLowerCase()
  const rows = blob.includes('stock') || blob.includes('inventory') ? data?.stock
    : blob.includes('menu') || blob.includes('catalogue') ? data?.menu
    : blob.includes('invoice') ? data?.invoices
    : blob.includes('complaint') ? data?.complaints
    : blob.includes('slot') || blob.includes('capacity') ? data?.slots
    : blob.includes('order') ? data?.orders
    : null
  if (!rows) return null
  if (rows.length === 0) return <p className="empty">No orders yet.</p>
  return (
    <section className="panel">
      <table>
        <tbody>
          {rows.slice(0, 8).map((row, index) => (
            <tr key={row.id || index}><td>{row.name || row.id || row.subject}</td><td className="num">{row.price != null ? money(Number(row.price)) : row.status || paceLabel(row.band, row.percent) || row.quantity || ''}</td></tr>
          ))}
        </tbody>
      </table>
    </section>
  )
}
