import { useEffect, useRef, useState } from 'react'
import { Button, StatusBadge } from './ui'

const emptyColumn: Record<string, string> = {
  new: 'No new orders',
  preparing: 'No orders being prepared',
  ready: 'No orders ready',
  ready_for_pickup: 'No orders with the rider',
}

export type KitchenLine = { name?: string; qty?: number; note?: string; image?: string }
export type KitchenOrder = {
  id: string
  status: string
  createdAt?: string
  slotLabel?: string
  payment?: string
  lines?: KitchenLine[]
  events?: { preparing?: string }
}

const columns = [
  { status: 'new', label: 'New', match: ['new'] },
  { status: 'preparing', label: 'Preparing', match: ['preparing'] },
  { status: 'ready', label: 'Ready', match: ['ready'] },
  { status: 'ready_for_pickup', label: 'Handed to rider', match: ['ready_for_pickup', 'picked_up'] },
]

export function nextKitchenAction(status: string) {
  if (status === 'new') return { action: 'accept', label: 'Accept', to: 'preparing' }
  if (status === 'preparing') return { action: 'ready', label: 'Mark ready', to: 'ready' }
  if (status === 'ready') return { action: 'handoff', label: 'Hand to rider', to: 'ready_for_pickup' }
  return null
}

function clockLabel(from: string | undefined, now: number) {
  const placed = Date.parse(from || '')
  if (!Number.isFinite(placed)) return ''
  const minutes = Math.max(0, Math.floor((now - placed) / 60000))
  return minutes < 1 ? 'Just now' : minutes < 60 ? `${minutes} min` : `${Math.floor(minutes / 60)} h ${minutes % 60} min`
}

function ageOf(createdAt: string | undefined, now: number) {
  const label = clockLabel(createdAt, now)
  if (!label) return { label: '', tone: '' }
  const placed = Date.parse(createdAt || '')
  const minutes = Math.max(0, Math.floor((now - placed) / 60000))
  const tone = minutes >= 20 ? 'late' : minutes >= 10 ? 'warn' : ''
  return { label, tone }
}

function cardTimer(order: KitchenOrder, now: number) {
  if (order.status === 'new' || order.status === 'preparing') return ageOf(order.createdAt, now)
  if (order.status === 'ready') return { label: clockLabel(order.events?.preparing, now), tone: '' }
  return { label: '', tone: '' }
}

function payBadge(payment: string | undefined) {
  return /cash/i.test(payment || '') || !payment ? 'COD' : 'Paid'
}

export function KitchenBoard({ orders, onAdvance }: { orders: KitchenOrder[]; onAdvance: (id: string, action: string) => Promise<void> | void }) {
  const [now, setNow] = useState(() => Date.now())
  const [dragId, setDragId] = useState('')
  const [over, setOver] = useState('')
  const [fresh, setFresh] = useState<string[]>([])
  const [note, setNote] = useState('')
  const known = useRef<Set<string> | null>(null)

  useEffect(() => {
    const timer = window.setInterval(() => setNow(Date.now()), 15000)
    return () => window.clearInterval(timer)
  }, [])

  useEffect(() => {
    const ids = orders.map((order) => order.id)
    if (known.current) {
      const arrived = ids.filter((id) => !known.current?.has(id) && orders.find((order) => order.id === id)?.status === 'new')
      if (arrived.length) {
        setFresh((current) => [...arrived, ...current])
        window.setTimeout(() => setFresh((current) => current.filter((id) => !arrived.includes(id))), 4000)
      }
    }
    known.current = new Set(ids)
  }, [orders])

  async function move(order: KitchenOrder, target: string) {
    const step = nextKitchenAction(order.status)
    if (!step || step.to !== target) {
      setNote('Move the order into the next column.')
      return
    }
    setNote('')
    await onAdvance(order.id, step.action)
  }

  return (
    <div className="board-wrap">
      {note && <p role="status">{note}</p>}
      <div className="kitchen-board">
        {columns.map((column) => {
          const cards = orders.filter((order) => column.match.includes(order.status))
          return (
            <article
              key={column.status}
              className={[dragId ? 'drag-target' : '', over === column.status ? 'over' : ''].filter(Boolean).join(' ')}
              onDragOver={(event) => { event.preventDefault(); setOver(column.status) }}
              onDragLeave={(event) => {
                const next = event.relatedTarget
                if (next instanceof Node && event.currentTarget.contains(next)) return
                setOver((current) => current === column.status ? '' : current)
              }}
              onDrop={(event) => {
                event.preventDefault()
                setOver('')
                const order = orders.find((item) => item.id === dragId)
                if (order) void move(order, column.status)
              }}
            >
              <h2><span>{column.label}</span> <span className="count">{cards.length}</span></h2>
              <div className="column-body">
              {dragId && over === column.status && <p className="drop-hint">Drop here</p>}
              {cards.map((order) => {
                const step = nextKitchenAction(order.status)
                const age = cardTimer(order, now)
                return (
                  <div
                    key={order.id}
                    className={`ticket status-${order.status}${fresh.includes(order.id) ? ' fresh' : ''}`}
                    role="group"
                    aria-label={order.id}
                    draggable={!!step}
                    onDragStart={(event) => {
                      setDragId(order.id)
                      event.dataTransfer.effectAllowed = 'move'
                      event.dataTransfer.setData('text/plain', order.id)
                    }}
                    onDragEnd={() => { setDragId(''); setOver('') }}
                  >
                    <div className="ticket-top">
                      <strong>{order.id}</strong>
                      <OrderAge label={age.label} tone={age.tone} />
                    </div>
                    <ul>
                      {(order.lines ?? []).map((line, index) => (
                        <li key={`${order.id}-${index}`}>
                          {(line.note || line.image) && (
                            <span className="thumb">{line.image ? <img src={line.image} alt="" /> : 'Ref'}</span>
                          )}
                          <span>
                            <b>{line.qty || 1} × {line.name}</b>
                            {line.note && <small>{line.note}</small>}
                          </span>
                        </li>
                      ))}
                    </ul>
                    <div className="ticket-meta">
                      <span>{order.slotLabel || 'No slot'}</span>
                      <StatusBadge tone={payBadge(order.payment) === 'COD' ? 'limited' : 'available'}>{payBadge(order.payment)}</StatusBadge>
                    </div>
                    {step && <Button onClick={() => void move(order, step.to)}>{step.label}</Button>}
                  </div>
                )
              })}
              {cards.length === 0 && <EmptyColumn label={emptyColumn[column.status]} />}
              </div>
            </article>
          )
        })}
      </div>
    </div>
  )
}

function OrderAge({ label, tone }: { label: string; tone: string }) {
  if (!label) return null
  const late = tone === 'late'
  return (
    <span className={`age ${tone}`}>
      {late ? <AlertIcon /> : <ClockIcon />}
      <span>{late ? `Late · ${label}` : label}</span>
    </span>
  )
}

function EmptyColumn({ label }: { label: string }) {
  return (
    <div className="column-empty">
      <svg className="empty-art" viewBox="0 0 64 48" aria-hidden="true">
        <rect x="10" y="16" width="44" height="22" rx="6" fill="none" stroke="currentColor" strokeWidth="2" />
        <path d="M18 16v-2a6 6 0 0 1 6-6h16a6 6 0 0 1 6 6v2" fill="none" stroke="currentColor" strokeWidth="2" />
        <path d="M24 27h16" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
      </svg>
      <p className="empty">{label}</p>
    </div>
  )
}

function ClockIcon() {
  return (
    <svg className="age-icon" viewBox="0 0 16 16" aria-hidden="true">
      <circle cx="8" cy="8" r="6" fill="none" stroke="currentColor" strokeWidth="1.5" />
      <path d="M8 4.5V8l2.5 1.5" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" />
    </svg>
  )
}

function AlertIcon() {
  return (
    <svg className="age-icon" viewBox="0 0 16 16" aria-hidden="true">
      <path d="M8 1.8 14.5 13.2H1.5L8 1.8Z" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinejoin="round" />
      <path d="M8 6.2v3.2" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" />
      <circle cx="8" cy="11.2" r="0.7" fill="currentColor" />
    </svg>
  )
}
