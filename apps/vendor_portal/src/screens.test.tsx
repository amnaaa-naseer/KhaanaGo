import { render, screen } from '@testing-library/react'
import { describe, expect, it } from 'vitest'
import catalog from '../../../packages/screen-catalog/screens.json'
import { ScreenBody, type ScreenSpec } from '../../../packages/khaana-web/src/ScreenApp'

const vendor = (catalog as ScreenSpec[]).filter((item) => item.role === 'vendor' || item.role === 'shared')

describe('vendor inventory', () => {
  it('covers every vendor and shared design', () => {
    expect(vendor).toHaveLength(73)
    expect(new Set(vendor.map((item) => item.id)).size).toBe(73)
  })

  it('renders each design id, title, and save action', () => {
    for (const spec of vendor) {
      const view = render(<ScreenBody spec={spec} role="vendor_owner" onOpen={() => undefined} />)
      expect(screen.getByText(spec.id)).toBeTruthy()
      expect(screen.getByRole('heading', { name: spec.title })).toBeTruthy()
      expect(screen.getByRole('button', { name: `Save ${spec.title}` })).toBeTruthy()
      view.unmount()
    }
  })
})
