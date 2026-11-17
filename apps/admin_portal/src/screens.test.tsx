import { render, screen } from '@testing-library/react'
import { describe, expect, it } from 'vitest'
import catalog from '../../../packages/screen-catalog/screens.json'
import { ScreenBody, type ScreenSpec } from '../../../packages/khaana-web/src/ScreenApp'

const admin = (catalog as ScreenSpec[]).filter((item) => item.role === 'admin' || item.role === 'shared')

describe('admin inventory', () => {
  it('covers every admin and shared design', () => {
    expect(admin).toHaveLength(29)
    expect(new Set(admin.map((item) => item.id)).size).toBe(29)
  })

  it('renders each title and save action without a design id', () => {
    for (const spec of admin) {
      const view = render(<ScreenBody spec={spec} role="admin" onOpen={() => undefined} />)
      expect(screen.queryByText(spec.id)).toBeNull()
      expect(screen.queryByText(`${spec.priority} · ${spec.kind}`)).toBeNull()
      expect(screen.getByRole('heading', { name: spec.title })).toBeTruthy()
      expect(screen.getByRole('button', { name: `Save ${spec.title}` })).toBeTruthy()
      view.unmount()
    }
  })
})