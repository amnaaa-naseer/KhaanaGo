import { readFileSync, writeFileSync } from 'node:fs'

const screens = JSON.parse(readFileSync(new URL('../packages/screen-catalog/screens.json', import.meta.url), 'utf8'))
const roles = [
  ['customer', 'Customer app', 'apps/customer_flutter', 'flutter run -d chrome', 'E1-US1-UI3'],
  ['rider', 'Rider app', 'apps/rider_flutter', 'flutter run', 'E1-US2-UI2'],
  ['vendor', 'Vendor portal', 'apps/vendor_portal', 'npm run dev', 'E1-US3-UI1'],
  ['admin', 'Admin portal', 'apps/admin_portal', 'npm run dev', 'E1-US3-UI8'],
]

function table(role) {
  const rows = screens.filter((screen) => screen.role === role || screen.role === 'shared')
  const lines = rows.map((screen) => `| ${screen.id} | ${screen.title.replaceAll('|', '/')} | ${screen.module || 'Shared'} | ${screen.kind} | ${(screen.requirements || '').replaceAll('|', '/').replaceAll('\n', ' ')} |`)
  return ['| ID | Title | Module | Kind | Check |', '| --- | --- | --- | --- | --- |', ...lines].join('\n')
}

const body = `# KhaanaGo manual test guide

Updated 5 November 2026.

Use this guide to click through every design. Automated tests check that each ID renders its title and a primary action. They do not replace this walkthrough, and this walkthrough is not a visual sign-off against the design system.

Chapter 2 extract in \`docs/planning/KhaanaGo_Chapter2_Requirements.md\` states 22 epics, 82 user stories, and 393 test cases. Those Chapter 2 tests are still open. The UI does not add business rules beyond that extract and \`config/prototype-assumptions.json\`.

## What changed in this pass

- Vendor and admin portals use a collapsible sidebar grouped by the inventory module, a sticky header, breadcrumbs, and screen search. The open screen, sidebar, and owner/staff choice are kept in session storage for that browser tab.
- Owner dashboard \`E1-US3-UI5\` shows orders today, new/pending, in preparation, ready for pickup, revenue, capacity now, low stock, and pending custom orders. Figures come from the shared demo state.
- Kitchen staff do not see finance, recipes, or the owner dashboard in the menu. Opening one of those screens shows “You do not have access to this page.”
- Admin live dashboard \`E20-US4-UI1\` shows active orders, delayed orders, approved riders, and slot utilisation. Delayed stays at 0 unless an order is already marked delayed. The demo state does not invent delays.
- Customer and rider apps use the same cream, charcoal, and orange theme, with module groups and screen search in the drawer.
- Colour and type stay on the Zesty Orange and Charcoal system: orange \`#F97316\` with charcoal labels, cream pages, Plus Jakarta Sans on the web portals.

## Start

From \`C:\\FYP\\KhaanaGo\`:

\`\`\`powershell
cd C:\\FYP\\KhaanaGo\\services\\mock-api
node server.js
\`\`\`

In a second terminal:

\`\`\`powershell
Invoke-RestMethod -Method Post http://127.0.0.1:8787/v1/demo/reset
\`\`\`

| App | Folder | Command | Opens on |
| --- | --- | --- | --- |
${roles.map(([, name, folder, command, home]) => `| ${name} | \`${folder}\` | \`${command}\` | ${home} |`).join('\n')}

Vendor serves on port 5173. Admin serves on port 5174. Older folders \`apps/customer\`, \`apps/rider\`, and \`apps/portal\` are the earlier Flutter scaffold. They do not share this mock API. Use the four apps in the table above.

## Demo accounts

Password length 8–128 is provisional. Demo sign-in does not hash passwords.

| Role | Identifier | Where |
| --- | --- | --- |
| Customer | 03001234567 | Customer login |
| Vendor owner | owner@bakecharm.test | Vendor portal, Owner |
| Kitchen staff | staff@bakecharm.test | Vendor portal, Kitchen staff |
| Rider | 03007654321 | Rider sign-in. Hamza Ali, Motorbike, approved |
| Admin | admin@khaanago.test | Admin sign-in |

Any password from 8 to 128 characters is accepted for these identifiers. \`password12\` is a convenient demo value.

## One order across roles

1. Reset the demo API.
2. Customer: open menu, item, cart, delivery, slot, payment, and place the chocolate cake as express. Fragile items cannot use pooled delivery.
3. Vendor owner: dashboard counts move, then Kitchen board. Accept, then Ready.
4. Rider: pick up only after Ready, then enter delivery code \`482913\`.
5. Vendor owner: revenue and an invoice appear. Cream stock drops because the cake recipe uses it. Staff still cannot open finance or recipes.
6. Admin live dashboard: the order is no longer active after delivery. Delayed stays 0.

Empty dashboards after a reset are correct. “No orders yet.” is the empty state.

## Vendor dashboard checks

Open \`E1-US3-UI5\` after signing in as Owner.

- Orders today, new/pending, in preparation, and ready for pickup match the kitchen columns.
- Revenue matches Finance. Capacity shows the 12-segment meter and Available, Limited, or Full as a word, not colour alone. BakeCharm starts at 72%, which is Limited.
- Low stock lists Cream (2 L, reorder at 3). The 7:30 PM slot is Full. Margalla Grill is Closed.
- Pending custom orders counts active orders whose lines are fragile or carry a note. A reset with no orders shows 0.
- Collapse the sidebar, search for an ID, refresh the browser tab, and confirm the same screen is still open.
- Switch to Kitchen staff. Finance, recipes, nutrition, bill of materials, and the owner dashboard leave the menu.

## Screen index

Shared designs are repeated under every role because each app includes them.

${roles.map(([role, name]) => `### ${name}\n\n${table(role)}`).join('\n\n')}
`
writeFileSync(new URL('../docs/MANUAL_TEST_GUIDE.md', import.meta.url), body)
console.log('wrote docs/MANUAL_TEST_GUIDE.md', screens.length)
