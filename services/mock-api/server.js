import { createServer } from 'node:http'
import { readFileSync, writeFileSync, mkdirSync, existsSync } from 'node:fs'
import { dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'

const root = dirname(fileURLToPath(import.meta.url))
const statePath = join(root, 'data', 'state.json')

export function freshState() {
  return {
    vendors: [
      { id: 'bakecharm', name: 'BakeCharm', cuisine: 'Bakery', dietary: ['Vegetarian'], area: 'F-11 Markaz, Islamabad', rating: 4.7, open: true, intakePercent: 72, etaMin: 40, etaMax: 55, fragile: true },
      { id: 'lazeez', name: 'Lazeez Karahi', cuisine: 'Pakistani', dietary: ['Halal'], area: 'G-9, Islamabad', rating: 4.5, open: true, intakePercent: 40, etaMin: 25, etaMax: 35, fragile: false },
      { id: 'margalla', name: 'Margalla Grill', cuisine: 'BBQ', dietary: ['Halal'], area: 'F-10, Islamabad', rating: 4.2, open: false, opensAt: '12:00', intakePercent: 0, etaMin: 30, etaMax: 40, fragile: false },
    ],
    menu: [
      { id: 'cake', vendorId: 'bakecharm', name: 'Chocolate fudge cake', price: 1850, category: 'Cakes', available: true, customizable: true, fragile: true, allergens: 'Milk, egg, gluten', kcal: 420, prepMinutes: 50 },
      { id: 'brownie', vendorId: 'bakecharm', name: 'Walnut brownie', price: 450, category: 'Cakes', available: false, customizable: false, fragile: false, allergens: 'Nuts, gluten', kcal: 310, prepMinutes: 15 },
      { id: 'karahi', vendorId: 'lazeez', name: 'Chicken karahi', price: 1450, category: 'Mains', available: true, customizable: true, fragile: false, allergens: 'Dairy', kcal: 640, prepMinutes: 30 },
    ],
    slots: [
      { id: '1830', vendorId: 'bakecharm', label: '6:30 PM', booked: 4, limit: 10 },
      { id: '1900', vendorId: 'bakecharm', label: '7:00 PM', booked: 7, limit: 10 },
      { id: '1930', vendorId: 'bakecharm', label: '7:30 PM', booked: 9, limit: 10 },
      { id: '2030', vendorId: 'bakecharm', label: '8:30 PM', booked: 2, limit: 10 },
      { id: 'lz1900', vendorId: 'lazeez', label: '7:00 PM', booked: 3, limit: 10 },
      { id: 'lz1930', vendorId: 'lazeez', label: '7:30 PM', booked: 5, limit: 10 },
    ],
    stock: [
      { id: 'flour', name: 'Flour', unit: 'kg', quantity: 8, reorderAt: 5, storage: 'Dry' },
      { id: 'cream', name: 'Cream', unit: 'L', quantity: 2, reorderAt: 3, storage: 'Chilled' },
      { id: 'eggs', name: 'Eggs', unit: 'pcs', quantity: 24, reorderAt: 12, storage: 'Chilled' },
    ],
    recipes: {
      cake: [{ ingredientId: 'flour', quantity: 0.4, unit: 'kg' }, { ingredientId: 'cream', quantity: 0.2, unit: 'L' }, { ingredientId: 'eggs', quantity: 3, unit: 'pcs' }],
    },
    orders: [],
    holds: [],
    invoices: [],
    complaints: [{ id: 'C-12', subject: 'Late delivery', status: 'Open', vendorId: 'lazeez' }],
    buffers: [{ id: 'rain', name: 'Rain', area: 'Islamabad', percent: 15 }, { id: 'peak', name: 'Dinner peak', area: 'F-11', percent: 10 }],
    users: [
      { id: 'cust', role: 'customer', name: 'Ayesha Khan', identifier: '03001234567' },
      { id: 'owner', role: 'vendor_owner', name: 'BakeCharm owner', identifier: 'owner@bakecharm.test' },
      { id: 'staff', role: 'vendor_staff', name: 'Kitchen staff', identifier: 'staff@bakecharm.test' },
      { id: 'rider', role: 'rider', name: 'Hamza Ali', identifier: '03007654321', vehicle: 'Motorbike', approved: true },
      { id: 'admin', role: 'admin', name: 'Platform admin', identifier: 'admin@khaanago.test' },
    ],
    submissions: {},
    audit: [],
    finance: { revenue: 0, commission: 0, expenses: 1200 },
    nextOrder: 1042,
    demo: true,
  }
}

let state = freshState()
const sessions = new Map()

function deliveryCode(orderNumber) {
  return String(100000 + (orderNumber * 7919) % 900000)
}

function actor(req) {
  const header = String(req.headers.authorization || '')
  const token = header.startsWith('Bearer ') ? header.slice(7) : ''
  return sessions.get(token) || null
}

export function loadState() {
  if (existsSync(statePath)) {
    state = JSON.parse(readFileSync(statePath, 'utf8'))
  } else {
    resetState()
  }
  return state
}

export function resetState() {
  state = freshState()
  persist()
  return state
}

function persist() {
  mkdirSync(dirname(statePath), { recursive: true })
  writeFileSync(statePath, JSON.stringify(state, null, 2))
}

function band(percent) {
  if (percent >= 85) return 'Full'
  if (percent >= 60) return 'Limited'
  return 'Available'
}

function slotView(slot) {
  const percent = Math.round((slot.booked / slot.limit) * 100)
  return { ...slot, percent, band: band(percent), bookable: percent < 85 }
}

function visibleOrders(user) {
  if (!user) return []
  if (user.role === 'customer') return state.orders.filter((order) => order.customerId === user.id)
  if (user.role === 'vendor_owner' || user.role === 'vendor_staff') return state.orders.filter((order) => order.vendorId === 'bakecharm')
  if (user.role === 'rider') return state.orders.filter((order) => ['ready', 'picked_up', 'delivered'].includes(order.status))
  return state.orders
}

function publicState(user) {
  const role = user?.role
  const hideRecipes = !user || role === 'vendor_staff' || role === 'customer' || role === 'rider'
  return {
    demo: true,
    simulation: 'Payments, maps, nutrition lookup, and the assistant are simulated.',
    vendors: state.vendors,
    menu: state.menu,
    slots: state.slots.map(slotView),
    orders: visibleOrders(user),
    stock: state.stock,
    recipes: hideRecipes ? null : state.recipes,
    invoices: state.invoices,
    complaints: state.complaints,
    buffers: state.buffers,
    finance: !user || role === 'vendor_staff' || role === 'customer' || role === 'rider' ? null : state.finance,
    riders: state.users.filter((user) => user.role === 'rider').map((user) => ({ name: user.name, vehicle: user.vehicle, approved: user.approved })),
    submissions: state.submissions,
    audit: state.audit.slice(-40),
    capacity: {
      ordersPerHour: 12,
      intakePercent: state.vendors[0].intakePercent,
      band: band(state.vendors[0].intakePercent),
      paused: state.vendors[0].intakePercent >= 85,
    },
  }
}

function json(res, code, body) {
  res.writeHead(code, {
    'content-type': 'application/json',
    'access-control-allow-origin': '*',
    'access-control-allow-headers': 'content-type, authorization, x-role',
    'access-control-allow-methods': 'GET,POST,PATCH,OPTIONS',
  })
  res.end(JSON.stringify(body))
}

function readBody(req) {
  return new Promise((resolve, reject) => {
    const chunks = []
    req.on('data', (c) => chunks.push(c))
    req.on('end', () => {
      const raw = Buffer.concat(chunks).toString('utf8')
      if (!raw) return resolve({})
      try { resolve(JSON.parse(raw)) } catch (err) { reject(err) }
    })
  })
}

export function handle(req, res, body) {
  const url = new URL(req.url, 'http://127.0.0.1')
  const user = actor(req)
  if (req.method === 'OPTIONS') return json(res, 204, {})
  if (url.pathname === '/health') return json(res, 200, { ok: true })
  if (url.pathname === '/v1/demo/reset' && req.method === 'POST') return json(res, 200, resetState())
  if (url.pathname === '/v1/state' && req.method === 'GET') return json(res, 200, publicState(user))

  if (url.pathname === '/v1/auth/login' && req.method === 'POST') {
    const password = String(body.password || '')
    if (!body.identifier || !password) return json(res, 400, { error: 'Enter your mobile or email and a password.' })
    if (password.length < 8 || password.length > 128) return json(res, 400, { error: 'Password must be 8 to 128 characters. This check is provisional and awaiting review.' })
    const user = state.users.find((u) => u.identifier === body.identifier && (!body.role || u.role === body.role))
    if (!user) return json(res, 401, { error: 'Those details do not match an account.' })
    const token = `demo-${user.id}`
    sessions.set(token, user)
    return json(res, 200, { user, token, demo: true, note: 'Demo sign-in. Passwords are not hashed or stored. This is not production authentication.' })
  }

  const hold = url.pathname.match(/^\/v1\/slots\/([^/]+)\/hold$/)
  if (hold && req.method === 'POST') {
    if (!user) return json(res, 401, { error: 'Sign in before holding a slot.' })
    const slot = state.slots.find((item) => item.id === hold[1])
    if (!slot || !slotView(slot).bookable) return json(res, 409, { error: 'That slot is full. Choose another time.' })
    const expiresAt = new Date(Date.now() + 300000).toISOString()
    state.holds = state.holds.filter((item) => item.expiresAt > new Date().toISOString() && !(item.userId === user.id && item.slotId === slot.id))
    state.holds.push({ userId: user.id, slotId: slot.id, expiresAt })
    persist()
    return json(res, 200, { slotId: slot.id, expiresAt, holdSeconds: 300 })
  }

  if (url.pathname === '/v1/orders' && req.method === 'POST') {
    if (!user || user.role !== 'customer') return json(res, 401, { error: 'Sign in as a customer before placing an order.' })
    if (body.simulateFailure === true) return json(res, 402, { error: 'Payment did not go through. Your order has not been placed.' })
    const requested = body.lines || []
    if (!requested.length) return json(res, 400, { error: 'Your cart is empty.' })
    const lines = []
    let vendorId = null
    for (const line of requested) {
      const item = state.menu.find((entry) => entry.id === line.id)
      if (!item) return json(res, 400, { error: 'That item is not on the menu.' })
      if (!item.available) return json(res, 409, { error: 'That item is sold out.' })
      if (vendorId && item.vendorId !== vendorId) return json(res, 409, { error: 'A cart can only contain one kitchen.' })
      vendorId = item.vendorId
      const qty = Math.max(1, Math.min(20, Number(line.qty) || 1))
      lines.push({ id: item.id, name: item.name, price: item.price, qty, fragile: !!item.fragile, note: String(line.note || '').slice(0, 500) })
    }
    const vendor = state.vendors.find((v) => v.id === vendorId)
    if (!vendor || !vendor.open) return json(res, 409, { error: 'This kitchen is closed.' })
    const slot = state.slots.find((s) => s.id === body.slotId && s.vendorId === vendor.id)
    if (!slot || !slotView(slot).bookable) return json(res, 409, { error: 'That slot is full. Choose another time.' })
    const now = new Date().toISOString()
    const liveHold = state.holds.find((item) => item.userId === user.id && item.slotId === slot.id && item.expiresAt > now)
    if (!liveHold) return json(res, 409, { error: 'That slot hold expired. Pick another time.' })
    if (lines.some((line) => line.fragile) && body.delivery === 'pooled') {
      return json(res, 409, { error: 'A fragile item must use express delivery.' })
    }
    const food = lines.reduce((sum, line) => sum + line.price * line.qty, 0)
    const deliveryBase = body.delivery === 'pooled' ? 120 : 180
    const discount = body.delivery === 'pooled' ? Math.round(deliveryBase * 0.3) : 0
    const number = state.nextOrder++
    const id = `KG-${number}`
    const order = {
      id,
      vendorId: vendor.id,
      customerId: user.id,
      lines,
      slotId: slot.id,
      slotLabel: slot.label,
      delivery: body.delivery || 'express',
      payment: body.payment || 'Cash on delivery',
      status: 'new',
      food,
      deliveryFee: deliveryBase - discount,
      discount,
      total: food + deliveryBase - discount,
      code: deliveryCode(number),
      customer: user.name,
      vendorName: vendor.name,
      createdAt: now,
      events: { placed: now },
    }
    state.holds = state.holds.filter((item) => !(item.userId === user.id && item.slotId === slot.id))
    slot.booked += 1
    vendor.intakePercent = Math.min(100, vendor.intakePercent + 8)
    state.orders.unshift(order)
    state.audit.push({ at: order.createdAt, actor: 'customer', action: `Placed ${id}`, screen: 'E3-US2-UI2' })
    persist()
    return json(res, 201, order)
  }

  const stage = url.pathname.match(/^\/v1\/orders\/([^/]+)\/(accept|ready|pickup|deliver|cancel)$/)
  if (stage && req.method === 'POST') {
    if (!user) return json(res, 401, { error: 'Sign in to update an order.' })
    const order = state.orders.find((o) => o.id === stage[1])
    if (!order) return json(res, 404, { error: 'Order not found.' })
    const action = stage[2]
    const kitchen = user.role === 'vendor_owner' || user.role === 'vendor_staff'
    const allowed = (action === 'accept' || action === 'ready') ? kitchen : (action === 'pickup' || action === 'deliver') ? user.role === 'rider' : action === 'cancel' && (kitchen || user.id === order.customerId)
    if (!allowed) return json(res, 403, { error: 'You do not have access to this page.' })
    order.events = order.events || {}
    const at = new Date().toISOString()
    if (action === 'accept' && order.status === 'new') {
      order.status = 'preparing'
      order.events.accepted = at
    } else if (action === 'ready' && order.status === 'preparing') {
      order.status = 'ready'
      order.events.preparing = at
    } else if (action === 'pickup' && order.status === 'ready') {
      order.status = 'picked_up'
      order.events.ready = at
      order.rider = { name: user.name, vehicle: user.vehicle || 'Motorbike' }
    } else if (action === 'deliver' && order.status === 'picked_up') {
      if (body.code !== order.code) return json(res, 400, { error: 'That code does not match. The delivery stays incomplete.' })
      order.status = 'delivered'
      order.events.onTheWay = at
      order.events.delivered = at
      for (const line of order.lines) {
        const recipe = state.recipes[line.id] || []
        for (const part of recipe) {
          const item = state.stock.find((s) => s.id === part.ingredientId)
          if (item) item.quantity = Math.max(0, +(item.quantity - part.quantity * line.qty).toFixed(2))
        }
      }
      const commission = Math.round(order.food * 0.15)
      state.finance.revenue += order.total
      state.finance.commission += commission
      state.invoices.unshift({ id: `INV-${order.id}`, orderId: order.id, total: order.total, commission, status: order.payment === 'Cash on delivery' ? 'Pending – COD' : 'Paid (simulated)' })
    } else if (action === 'cancel' && !['picked_up', 'delivered'].includes(order.status)) {
      order.status = 'cancelled'
      const slot = state.slots.find((s) => s.id === order.slotId)
      if (slot) slot.booked = Math.max(0, slot.booked - 1)
    } else return json(res, 409, { error: `Cannot ${action} an order that is ${order.status}.` })
    state.audit.push({ at: new Date().toISOString(), actor: user.role, action: `${action} ${order.id}`, screen: body.screen || '' })
    persist()
    return json(res, 200, order)
  }

  const submit = url.pathname.match(/^\/v1\/screens\/([^/]+)\/submit$/)
  if (submit && req.method === 'POST') {
    const id = decodeURIComponent(submit[1])
    const ownerOnly = /finance|recipe|nutrition|bom|profit/i.test(id + JSON.stringify(body))
    if (!user) return json(res, 401, { error: 'Sign in before saving.' })
    if (user.role === 'vendor_staff' && ownerOnly) return json(res, 403, { error: 'You do not have access to this page.' })
    state.submissions[id] = { ...body.fields, savedAt: new Date().toISOString() }
    state.audit.push({ at: state.submissions[id].savedAt, actor: user.role, action: `Saved ${id}`, screen: id })
    persist()
    return json(res, 200, { ok: true, saved: state.submissions[id] })
  }

  return json(res, 404, { error: 'Not found' })
}

export function start(port = 8787) {
  loadState()
  const server = createServer(async (req, res) => {
    try {
      const body = await readBody(req)
      handle(req, res, body)
    } catch {
      json(res, 400, { error: 'The request could not be read.' })
    }
  })
  return new Promise((resolve) => server.listen(port, '127.0.0.1', () => resolve(server)))
}

if (process.argv[1] && fileURLToPath(import.meta.url) === process.argv[1]) {
  const port = Number(process.env.PORT || 8787)
  start(port).then(() => console.log(`KhaanaGo mock API on http://127.0.0.1:${port}`))
}
