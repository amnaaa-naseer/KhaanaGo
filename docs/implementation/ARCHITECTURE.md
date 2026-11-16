# UI architecture

This is the target structure for the redesign. It is not built yet. The current apps keep their own `ChangeNotifier` sessions and do not share data.

## Applications

| App | Project | Who uses it | Shell |
| --- | --- | --- | --- |
| Customer | `apps/customer` | Customer, phone first, also a responsive browser | Bottom navigation: Home, Orders, Assistant, Profile |
| Rider | `apps/rider` | Rider, outdoors, one hand | Dark theme, 64 dp targets, no dense tables |
| Vendor, kitchen, and admin | `apps/portal` | Owner, kitchen staff, administrator | Navigation rail from 900 px. A wrapping row of destinations below that. Staff never see owner-only destinations |

Decision D17 keeps vendor and admin in this one Flutter web app. The design system still says React. That wording is a report update, not a second codebase, unless plan approval reverses D17.

## Packages

| Package | Responsibility |
| --- | --- |
| `packages/khaana_design` | Tokens, themes, and reusable widgets. No order rules. |
| `packages/khaana_domain` | Models, repository interfaces, and the rules Chapter 2 already states: single-vendor cart, intake bands from config, fragile orders forced to express, staff blocked from finance and recipes. |
| `packages/khaana_demo` | Client for the demo broker. Labelled simulations for maps, payment, nutrition, and the assistant. |

Screens call a repository. They do not calculate stock, commission, or slot capacity inline.

## Shared demo broker

Three Flutter processes cannot share memory. The cross-role story needs one store.

`tools/demo_broker` is a small local server, loopback only, with no production database. All three apps use the same repository interface. The demo implementation talks to the broker. A future Node.js API can replace that implementation without rewriting screens.

The broker holds vendors, menus, carts, slots, orders, kitchen tickets, rider assignments, stock, invoices, and the admin monitor. It has a reset action that restores the Pakistani demo data set.

Simulated and labelled as simulated:

- Maps and rider position
- JazzCash, Easypaisa, and card results
- Nutrition lookup when the “API” is switched off
- Assistant replies
- Push, sound, and vibration

Not simulated as success when the requirement says the action must fail: duplicate registration, a full slot, a fragile pooled order, a wrong delivery code, a staff member opening finance.

## Navigation

Customer routes stay under the IDs already used for P1 (`/login`, `/home`, `/menu`, `/item`, `/customize`, `/cart`, `/delivery`, `/slots`, `/payment`, `/review`, `/placed`, `/tracking`, `/delay`). Later screens get their own named routes. Unknown web routes use the shared not-found pattern.

Rider routes stay under `/sign-in`, `/home`, `/offer`, `/pickup`, `/ready`, `/at-store`, `/handover`, `/dropoff`, `/code`, `/delivered`, then the remaining rider IDs.

Portal routes stay under `/vendor/...` and `/admin/...`. A direct link to a forbidden page shows the access-denied panel. It does not reveal the hidden data.

## State on each screen

Every significant screen renders these from the repository, not from a one-off boolean buried in the widget:

- Default
- Loading
- Empty
- Success
- Validation error
- Server error, with retry
- Disabled action
- Offline, where the story has an offline rule

## Data rules the UI must not invent

Provisional numbers stay in `config/prototype-assumptions.json` and are labelled awaiting review. The waiting-pay rate stays empty. Android minimum version stays unresolved. Section 2.4 of the Word chapter stays empty. No recommendation model and no ML forecast are added, because Chapter 2 does not specify one.

## How a feature is added

1. Add or confirm the model and repository method.
2. Add the screen against its UI ID.
3. Connect it to the broker if another role must see the result.
4. Add a widget or integration test for the visible check.
5. Leave the backend-only test open in `REQUIREMENTS_COVERAGE.md`.
