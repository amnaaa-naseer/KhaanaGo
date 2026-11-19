import { render, screen } from '@testing-library/react'
import { describe, expect, it } from 'vitest'
import catalog from '../../../packages/screen-catalog/screens.json'
import { adminNav, ScreenBody, type ScreenSpec } from '../../../packages/khaana-web/src/ScreenApp'

const admin = (catalog as ScreenSpec[]).filter((item) => item.role === 'admin' || item.role === 'shared')

describe('admin inventory', () => {
  it('covers every admin and shared design', () => {
    expect(admin).toHaveLength(29)
    expect(new Set(admin.map((item) => item.id)).size).toBe(29)
  })

  it('keeps the sidebar to nine groups and leaves out error and sign-in screens', () => {
    expect(adminNav.map((group) => group.label)).toEqual([
      'Overview',
      'Vendors',
      'Riders and fleets',
      'Orders',
      'Finance',
      'Operations',
      'Complaints and ratings',
      'Audit log',
      'Users',
    ])
    const titles = adminNav.flatMap((group) => group.screens).map((id) => admin.find((item) => item.id === id)?.title)
    expect(titles).not.toContain('Admin sign-in')
    expect(titles).not.toContain('Something went wrong')
    expect(titles.some((title) => title?.startsWith('Page not found'))).toBe(false)
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