import { useEffect, useMemo, useState, type FormEvent, type ReactNode } from 'react'
import catalog from '../../screen-catalog/screens.json'
import { api, setToken } from './api'
import { KitchenBoard } from './KitchenBoard'
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
  return spec.id !== 'E7-US3-UI1'
}

export const vendorModules = [
  { id: 'E7-US3-UI1', label: 'Live Orders', staff: true },
  { id: 'E2-US2-UI1', label: 'Menu', staff: false },
  { id: 'E9-US4-UI1', label: 'Inventory (BOM/MRP)', staff: false },
  { id: 'E5-US1-UI3', label: 'Capacity', staff: false },
  { id: 'E11-US1-UI1', label: 'Offers', staff: false },
  { id: 'E12-US1-UI1', label: 'Finance', staff: false },
  { id: 'E1-US4-UI1', label: 'Staff', staff: false },
  { id: 'E2-US1-UI1', label: 'Settings', staff: false },
]

export function modulesFor(actor: string) {
  return vendorModules.filter((item) => actor === 'vendor_owner' || item.staff)
}

type Session = { token: string; role: string; name: string; identifier: string }

function readSession(appRole: string): Session | null {
  try {
    const raw = sessionStorage.getItem(`khaanago:${appRole}:session`)
    return raw ? JSON.parse(raw) as Session : null
  } catch {
    return null
  }
}

function portalFor(userRole: string) {
  if (userRole === 'admin') return 'admin'
  if (userRole === 'vendor_owner' || userRole === 'vendor_staff') return 'vendor'
  return ''
}

function stored(key: string, fallback: string) {
  try { return sessionStorage.getItem(key) || fallback } catch { return fallback }
}

export function ScreenApp({ role, homeId }: { role: 'vendor' | 'admin'; homeId: string }) {
  const list = useMemo(() => screensFor(role), [role])
  const [session, setSession] = useState<Session | null>(() => {
    const saved = readSession(role)
    setToken(saved?.token ?? null)
    return saved
  })
  const [id, setId] = useState(() => {
    const saved = readSession(role)
    if (role === 'vendor' && saved?.role === 'vendor_staff') return 'E7-US3-UI1'
    return stored(`khaanago:${role}:screen`, homeId)
  })
  const [collapsed, setCollapsed] = useState(() => stored(`khaanago:${role}:collapsed`, '0') === '1')
  const [devTools, setDevTools] = useState(() => {
    try { return new URLSearchParams(window.location.search).get('dev') === '1' } catch { return false }
  })
  const actor = session?.role ?? (role === 'admin' ? 'admin' : 'vendor_owner')
  const nav = role === 'vendor' ? modulesFor(actor) : []
  const spec = list.find((item) => item.id === id) ?? list.find((item) => item.id === homeId) ?? list[0]

  useEffect(() => {
    try {
      sessionStorage.setItem(`khaanago:${role}:screen`, spec.id)
      sessionStorage.setItem(`khaanago:${role}:collapsed`, collapsed ? '1' : '0')
    } catch { /* demo storage can be unavailable */ }
  }, [role, spec.id, collapsed])

  function enter(next: Session | null) {
    setToken(next?.token ?? null)
    setSession(next)
    try {
      if (next) sessionStorage.setItem(`khaanago:${role}:session`, JSON.stringify(next))
      else sessionStorage.removeItem(`khaanago:${role}:session`)
    } catch { /* demo storage can be unavailable */ }
    if (next?.role === 'vendor_staff' || next?.role === 'vendor_owner') setId('E7-US3-UI1')
    if (next?.role === 'admin') setId(homeId)
  }

  if (!session) return <SignIn appRole={role} onSuccess={enter} />
  if (portalFor(session.role) !== role) {
    const vendor = portalFor(session.role) === 'vendor'
    return (
      <SignInFrame title={vendor ? 'Vendor portal' : 'Admin portal'}>
        <p>{vendor ? 'This account is for the vendor portal.' : 'This account is for the platform admin portal.'}</p>
        <a className="primary link" href={vendor ? 'http://localhost:5173' : 'http://localhost:5174'}>{vendor ? 'Open vendor portal' : 'Open admin portal'}</a>
        <button className="ghost" onClick={() => enter(null)}>Use a different account</button>
      </SignInFrame>
    )
  }

  const navLabel = nav.find((item) => item.id === spec.id)?.label ?? spec.title
  return (
    <div className={collapsed ? 'shell collapsed' : 'shell'}>
      <aside>
        <div className="brand">
          <strong>Khaana<em>Go</em></strong>
          <button className="icon-btn" aria-expanded={!collapsed} aria-label={collapsed ? 'Expand navigation' : 'Collapse navigation'} onClick={() => setCollapsed((value) => !value)}>{collapsed ? '>' : '<'}</button>
        </div>
        <p className="role">{session.name}</p>
        {role === 'vendor' && nav.map((item) => (
          <button key={item.id} className="nav" aria-current={item.id === spec.id ? 'page' : undefined} onClick={() => setId(item.id)}>
            {collapsed ? item.label.slice(0, 2) : item.label}
          </button>
        ))}
        {role === 'admin' && list.filter((item) => item.kind === 'Screen').map((item) => (
          <button key={item.id} className="nav" aria-current={item.id === spec.id ? 'page' : undefined} onClick={() => setId(item.id)}>
            {collapsed ? item.title.slice(0, 2) : item.title}
          </button>
        ))}
        <button className="nav sign-out" onClick={() => enter(null)}>Sign out</button>
      </aside>
      <div className="workspace">
        <header className="topbar">
          <div>
            <p className="crumb">{role === 'vendor' ? 'Kitchen' : 'Administration'}</p>
            <p className="page-title" onPointerDown={() => {
              const timer = window.setTimeout(() => setDevTools((value) => !value), 700)
              const clear = () => window.clearTimeout(timer)
              window.addEventListener('pointerup', clear, { once: true })
              window.addEventListener('pointercancel', clear, { once: true })
            }}>{navLabel}</p>
          </div>
        </header>
        <main>
          <ScreenBody spec={spec} role={actor} onOpen={setId} devTools={devTools} />
        </main>
      </div>
    </div>
  )
}

function SignIn({ appRole, onSuccess }: { appRole: 'vendor' | 'admin'; onSuccess: (session: Session) => void }) {
  const [identifier, setIdentifier] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [busy, setBusy] = useState(false)

  async function submit(event: FormEvent) {
    event.preventDefault()
    setBusy(true)
    setError('')
    try {
      const result = await api('/v1/auth/login', { method: 'POST', body: { identifier, password } })
      onSuccess({ token: result.token, role: result.user.role, name: result.user.name, identifier: result.user.identifier })
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Those details do not match an account.')
    } finally {
      setBusy(false)
    }
  }

  return (
    <SignInFrame title={appRole === 'admin' ? 'Admin portal' : 'Vendor portal'}>
      <form onSubmit={submit}>
        <label>Email or mobile
          <input value={identifier} autoComplete="username" onChange={(event) => setIdentifier(event.target.value)} />
        </label>
        <label>Password
          <input value={password} type="password" autoComplete="current-password" onChange={(event) => setPassword(event.target.value)} />
        </label>
        {error && <p role="alert">{error}</p>}
        <button className="primary" type="submit" disabled={busy}>Sign in</button>
      </form>
    </SignInFrame>
  )
}

function SignInFrame({ title, children }: { title: string; children: ReactNode }) {
  return (
    <div className="signin">
      <section>
        <strong>Khaana<em>Go</em></strong>
        <h1>{title}</h1>
        {children}
      </section>
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
  recipes?: Record<string, Array<Record<string, any>>> | null
  offers?: Array<Record<string, any>>
  team?: Array<Record<string, any>>
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
    let stop = false
    async function pull() {
      try {
        const next = await api('/v1/state', { role })
        if (!stop) setData(next)
      } catch (err) {
        if (!stop) setNotice(err instanceof Error ? err.message : 'We could not load this page.')
      }
    }
    void pull()
    if (spec.id !== 'E7-US3-UI1') return () => { stop = true }
    const timer = window.setInterval(() => void pull(), 3000)
    return () => { stop = true; window.clearInterval(timer) }
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
  if (spec.id === 'E7-US3-UI1') {
    return (
      <section className="page">
        <h1>{spec.title}</h1>
        {devTools && <StateSwitcher preview={preview} onChange={setPreview} />}
        {notice && <p role="status">{notice}</p>}
        <KitchenBoard orders={orders} onAdvance={advance} />
      </section>
    )
  }
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
      {spec.id === 'E9-US4-UI1' && <InventoryPanel data={data} />}
      {spec.id === 'E11-US1-UI1' && <OffersPanel data={data} />}
      {spec.id === 'E1-US4-UI1' && <TeamPanel data={data} />}
      {spec.id === 'E2-US1-UI1' && <SettingsPanel data={data} />}
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

function InventoryPanel({ data }: { data: DemoState | null }) {
  const stock = data?.stock ?? []
  const cake = data?.recipes?.cake ?? []
  return (
    <>
      <section className="panel">
        <h2>Stock</h2>
        {stock.length === 0 ? <p className="empty">No ingredients yet.</p> : (
          <table>
            <thead><tr><th>Ingredient</th><th>On hand</th><th>Reorder at</th></tr></thead>
            <tbody>{stock.map((item) => <tr key={item.id}><td>{item.name}</td><td>{item.quantity} {item.unit}</td><td>{item.reorderAt} {item.unit}</td></tr>)}</tbody>
          </table>
        )}
      </section>
      <section className="panel">
        <h2>Bill of materials</h2>
        {cake.length === 0 ? <p className="empty">No recipe is available for this account.</p> : (
          <table>
            <thead><tr><th>Cake ingredient</th><th className="num">Per cake</th></tr></thead>
            <tbody>{cake.map((part) => <tr key={part.ingredientId}><td>{stock.find((item) => item.id === part.ingredientId)?.name || part.ingredientId}</td><td className="num">{part.quantity} {part.unit}</td></tr>)}</tbody>
          </table>
        )}
      </section>
      <section className="panel">
        <h2>Material plan</h2>
        {cake.map((part) => {
          const item = stock.find((row) => row.id === part.ingredientId)
          const onHand = Number(item?.quantity ?? 0)
          const batches = part.quantity ? Math.floor(onHand / Number(part.quantity)) : 0
          return <p key={part.ingredientId}>{item?.name || part.ingredientId}: {onHand} {part.unit} on hand, enough for {batches} cakes.</p>
        })}
      </section>
    </>
  )
}

function OffersPanel({ data }: { data: DemoState | null }) {
  const offers = data?.offers ?? []
  return (
    <section className="panel">
      <h2>Offers</h2>
      {offers.length === 0 ? <p className="empty">No offers yet.</p> : (
        <table>
          <thead><tr><th>Offer</th><th>Status</th><th>Detail</th></tr></thead>
          <tbody>{offers.map((offer) => <tr key={offer.id}><td>{offer.name}</td><td>{offer.status}</td><td>{offer.detail}</td></tr>)}</tbody>
        </table>
      )}
    </section>
  )
}

function TeamPanel({ data }: { data: DemoState | null }) {
  const team = data?.team ?? []
  return (
    <section className="panel">
      <h2>Staff</h2>
      {team.length === 0 ? <p className="empty">No staff yet.</p> : (
        <table>
          <thead><tr><th>Name</th><th>Role</th></tr></thead>
          <tbody>{team.map((person) => <tr key={person.name}><td>{person.name}</td><td>{person.role}</td></tr>)}</tbody>
        </table>
      )}
    </section>
  )
}

function SettingsPanel({ data }: { data: DemoState | null }) {
  const vendor = (data?.vendors ?? []).find((item) => item.id === 'bakecharm') ?? data?.vendors?.[0]
  if (!vendor) return null
  return (
    <section className="panel">
      <h2>{vendor.name}</h2>
      <p>{vendor.cuisine} · {vendor.area}</p>
      <p>{vendor.open ? 'Open for orders' : `Closed${vendor.opensAt ? ` · opens ${vendor.opensAt}` : ''}`}</p>
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
