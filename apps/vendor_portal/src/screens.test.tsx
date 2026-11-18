import { render, screen } from '@testing-library/react'
import { describe, expect, it } from 'vitest'
import catalog from '../../../packages/screen-catalog/screens.json'
import { KitchenBoard } from '../../../packages/khaana-web/src/KitchenBoard'
import { ScreenBody, modulesFor, type ScreenSpec } from '../../../packages/khaana-web/src/ScreenApp'

const vendor = (catalog as ScreenSpec[]).filter((item) => item.role === 'vendor' || item.role === 'shared')

describe('vendor inventory', () => {
  it('covers every vendor and shared design', () => {
    expect(vendor).toHaveLength(73)
    expect(new Set(vendor.map((item) => item.id)).size).toBe(73)
  })

  it('renders each title and save action without a design id', () => {
    for (const spec of vendor) {
      const view = render(<ScreenBody spec={spec} role="vendor_owner" onOpen={() => undefined} />)
      expect(screen.queryByText(spec.id)).toBeNull()
      expect(screen.queryByText(`${spec.priority} · ${spec.kind}`)).toBeNull()
      expect(screen.getByRole('heading', { name: spec.title })).toBeTruthy()
      if (spec.id === 'E7-US3-UI1') {
        expect(screen.getByRole('heading', { name: /New/ })).toBeTruthy()
        expect(screen.getByRole('heading', { name: /Handed to rider/ })).toBeTruthy()
        expect(screen.queryByRole('button', { name: `Save ${spec.title}` })).toBeNull()
      } else {
        expect(screen.getByRole('button', { name: `Save ${spec.title}` })).toBeTruthy()
      }
      view.unmount()
    }
  })

  it('shows the owner every vendor module and kitchen staff only live orders', () => {
    expect(modulesFor('vendor_owner').map((item) => item.label)).toEqual([
      'Live Orders', 'Menu', 'Inventory (BOM/MRP)', 'Capacity', 'Offers', 'Finance', 'Staff', 'Settings',
    ])
    expect(modulesFor('vendor_staff').map((item) => item.label)).toEqual(['Live Orders'])
  })

  it('shows a new order card with its customization, slot, and payment', () => {
    render(<KitchenBoard orders={[{
      id: 'KG-1042',
      status: 'new',
      createdAt: new Date().toISOString(),
      slotLabel: '7:40 PM',
      payment: 'Cash on delivery',
      lines: [{ name: 'Chocolate fudge cake', qty: 1, note: 'No nuts' }],
    }]} onAdvance={() => undefined} />)
    expect(screen.getByText('KG-1042')).toBeTruthy()
    expect(screen.getByText('COD')).toBeTruthy()
    expect(screen.getByText('No nuts')).toBeTruthy()
    expect(screen.getByText('Ref')).toBeTruthy()
    expect(screen.getByRole('button', { name: 'Accept' })).toBeTruthy()
    expect(screen.queryByText('Finance')).toBeNull()
  })
})
