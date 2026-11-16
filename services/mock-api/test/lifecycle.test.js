import { test } from 'node:test'
import assert from 'node:assert/strict'
import { start, resetState } from '../server.js'

test('customer order updates kitchen, rider, stock, invoice, and finance', async () => {
  resetState()
  const server = await start(8791)
  const base = 'http://127.0.0.1:8791'
  const call = (path, opts = {}) => fetch(base + path, {
    method: opts.method || 'GET',
    headers: { 'content-type': 'application/json', ...(opts.token ? { authorization: `Bearer ${opts.token}` } : {}) },
    body: opts.body ? JSON.stringify(opts.body) : undefined,
  })
  const login = async (identifier, role) => {
    const response = await call('/v1/auth/login', { method: 'POST', body: { identifier, password: 'password12', role } })
    assert.equal(response.status, 200)
    return (await response.json()).token
  }
  try {
    const customer = await login('03001234567', 'customer')
    const owner = await login('owner@bakecharm.test', 'vendor_owner')
    const staff = await login('staff@bakecharm.test', 'vendor_staff')
    const rider = await login('03007654321', 'rider')
    assert.equal((await call('/v1/slots/2030/hold', { method: 'POST', token: customer, body: {} })).status, 200)
    const created = await call('/v1/orders', { method: 'POST', token: customer, body: { slotId: '2030', delivery: 'express', payment: 'Cash on delivery', lines: [{ id: 'cake', qty: 1, price: 1 }] } })
    assert.equal(created.status, 201)
    const order = await created.json()
    assert.equal(order.status, 'new')
    assert.equal(order.food, 1850)
    assert.notEqual(order.code, '482913')
    assert.equal((await call('/v1/slots/1830/hold', { method: 'POST', token: customer, body: {} })).status, 200)
    const fragile = await call('/v1/orders', { method: 'POST', token: customer, body: { slotId: '1830', delivery: 'pooled', lines: [{ id: 'cake', qty: 1 }] } })
    assert.equal(fragile.status, 409)
    assert.equal((await call(`/v1/orders/${order.id}/accept`, { method: 'POST', token: staff, body: { screen: 'E7-US3-UI1' } })).status, 200)
    assert.equal((await call(`/v1/orders/${order.id}/ready`, { method: 'POST', token: staff, body: {} })).status, 200)
    assert.equal((await call(`/v1/orders/${order.id}/pickup`, { method: 'POST', token: rider, body: {} })).status, 200)
    const wrong = await call(`/v1/orders/${order.id}/deliver`, { method: 'POST', token: rider, body: { code: '000000' } })
    assert.equal(wrong.status, 400)
    const done = await call(`/v1/orders/${order.id}/deliver`, { method: 'POST', token: rider, body: { code: order.code } })
    assert.equal(done.status, 200)
    const state = await (await call('/v1/state', { token: owner })).json()
    assert.equal(state.orders[0].status, 'delivered')
    assert.equal(state.invoices.length, 1)
    assert.ok(state.finance.revenue > 0)
    assert.ok(state.stock.find((item) => item.id === 'flour').quantity < 8)
    const staffState = await (await call('/v1/state', { token: staff })).json()
    assert.equal(staffState.recipes, null)
    assert.equal(staffState.finance, null)
    const stranger = await call('/v1/orders', { method: 'POST', body: { slotId: '1830', lines: [{ id: 'cake', qty: 1 }] } })
    assert.equal(stranger.status, 401)
  } finally {
    server.close()
  }
})
