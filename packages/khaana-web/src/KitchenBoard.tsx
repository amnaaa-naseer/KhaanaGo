import { useEffect, useRef, useState } from 'react'

export type KitchenLine = { name?: string; qty?: number; note?: string; image?: string }
export type KitchenOrder = {
  id: string
  status: string
  createdAt?: string
  slotLabel?: string
  payment?: string
  lines?: KitchenLine[]
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

function ageOf(createdAt: string | undefined, now: number) {
  const placed = Date.parse(createdAt || '')
  if (!Number.isFinite(placed)) return { label: '', tone: '' }
  const minutes = Math.max(0, Math.floor((now - placed) / 60000))
  const tone = minutes >= 20 ? 'late' : minutes >= 10 ? 'warn' : ''
  const label = minutes < 1 ? 'Just now' : minutes < 60 ? `${minutes} min` : `${Math.floor(minutes / 60)} h ${minutes % 60} min`
  return { label, tone }
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
    <div>
      {note && <p role="status">{note}</p>}
      <div className="kitchen-board">
        {columns.map((column) => {
          const cards = orders.filter((order) => column.match.includes(order.status))
          return (
            <article
              key={column.status}
              className={over === column.status ? 'over' : ''}
              onDragOver={(event) => { event.preventDefault(); setOver(column.status) }}
              onDragLeave={() => setOver((current) => current === column.status ? '' : current)}
              onDrop={(event) => {
                event.preventDefault()
                setOver('')
                const order = orders.find((item) => item.id === dragId)
                if (order) void move(order, column.status)
              }}
            >
              <h2>{column.label} <span>{cards.length}</span></h2>
              {cards.map((order) => {
                const step = nextKitchenAction(order.status)
                const age = ageOf(order.createdAt, now)
                return (
                  <div
                    key={order.id}
                    className={fresh.includes(order.id) ? 'ticket fresh' : 'ticket'}
                    role="group"
                    aria-label={order.id}
                    draggable={!!step}
                    onDragStart={() => setDragId(order.id)}
                    onDragEnd={() => { setDragId(''); setOver('') }}
                  >
                    <div className="ticket-top">
                      <strong>{order.id}</strong>
                      {age.label && <span className={`age ${age.tone}`}>{age.label}</span>}
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
                      <span className={payBadge(order.payment) === 'COD' ? 'badge limited' : 'badge available'}>{payBadge(order.payment)}</span>
                    </div>
                    {step && <button className="primary" onClick={() => void move(order, step.to)}>{step.label}</button>}
                  </div>
                )
              })}
              {cards.length === 0 && <p className="empty">No orders</p>}
            </article>
          )
        })}
      </div>
    </div>
  )
}
