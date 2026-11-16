# Frontend audit

Audit date: 3 November 2026. This is the Phase 1 specification. No redesign code is included. Implementation starts after this plan is approved.

## What was read

The folder `docs/reference/` does not exist. These files were used instead.

| Asked for | Found |
| --- | --- |
| Chapter 2 | `docs/KhaanaGo_Chapter2_Deduplicated_Complete_Coverage.docx`, already extracted to `docs/planning/KhaanaGo_Chapter2_Requirements.md` |
| Screen inventory | `docs/KhaanaGo_Screen_Inventory_Verified.docx`. Coverage counts match the register: 189 designs, 139 screens, 47 overlays, 3 layout sets |
| Screen register | `docs/KhaanaGo_Screen_Register.xlsx`, extracted to `docs/planning/KhaanaGo_Screen_Register.csv` |
| Design system | `docs/KhaanaGo Design System.html`, summarized in `docs/planning/KhaanaGo_Design_System_Summary.md` |
| Chapter 1 | Not in the repository |
| Project details | Not in the repository |
| Decisions already recorded | `docs/requirements-decisions.md` and `config/prototype-assumptions.json` |

The Word chapter, the workbook, the design-system HTML, and the logo files were not edited.

Parsed totals: 22 epics, 82 stories, 256 acceptance criteria, 393 tests, 189 UI IDs.

## What exists in code

| App | Path | Platforms | What it actually is |
| --- | --- | --- | --- |
| Customer | `apps/customer` | Android, iOS, web | 14 P1 routes. One in-memory session. No photographs, no logo, no registration. |
| Rider | `apps/rider` | Android only | 10 P1 routes. Separate in-memory session. Not connected to the customer order. |
| Vendor, kitchen, and admin | `apps/portal` | Web only | 20 P1 routes in one Flutter web app. Role navigation exists. Not connected to the other two apps. |
| Visual kit | `packages/khaana_design` | Dart package | Tokens, three themes, a page shell, buttons, capacity badge, price lines, a simulated map, a hold button, and an access-denied panel. |

The three apps do not share an order. Placing an order in the customer app does not create a kitchen ticket or a rider offer.

The current screens are text layouts on the design-system colours. They do not meet the bar in this brief: photography, full states, cross-role behaviour, or a reviewed visual design. The older tracker that says “Implemented, mock data” only means a route exists. This audit does not accept those 44 routes as finished. `UI_SCREEN_TRACKER.md` marks them `Scaffold, not accepted`. The other 145 IDs are `Not started`.

## Screen counts

| Interface | P1 | P2 | P3 | Total |
| --- | ---: | ---: | ---: | ---: |
| Customer | 14 | 27 | 7 | 48 |
| Rider | 10 | 27 | 6 | 43 |
| Vendor and kitchen | 16 | 46 | 7 | 69 |
| Admin | 4 | 16 | 5 | 25 |
| Shared | 0 | 2 | 2 | 4 |
| Total | 44 | 118 | 27 | 189 |

## Why the current UI is not the deliverable

- Each P1 screen is one happy path, sometimes with a labelled preview button. Loading, empty, offline, and server-error states are missing on almost every screen.
- Search, filters, vouchers, order history, invoices, addresses, rider registration, vendor onboarding, stock movements, and admin governance are not built.
- Prices, capacity, and invoices are sample numbers inside each app. They are not one calculation.
- Logos in `assets/brand/` are not bundled.
- There is no food photography.
- Widget tests only check that a sign-in title appears. They do not walk a journey.
- The last Android install on the Medium Phone emulator failed after the APK had built. Web launch is the reliable way to open the customer and portal scaffolds today.

## Conflict between sources

Chapter 2 wins for behaviour. The verified inventory wins for which screens exist. The design system wins for colour, type, spacing, and components. Differences are listed in `REQUIREMENTS_GAPS.md` and are not turned into new requirements.

The design system and the screen register describe the vendor portal as a React PWA and admin as React. The approved prototype decision D17 is one Flutter web app, `apps/portal`, with separate navigation for the owner, kitchen staff, and admin. This plan keeps that decision. A second React portal is not part of the build unless the plan approval reverses D17.

## Implementation plan

No inventory ID is dropped. Phases can overlap only when a later screen needs a component from an earlier phase.

### Phase 1. Audit and specification

This document set. Stop here until the plan is approved.

### Phase 2. Design foundation

Expand `packages/khaana_design` to the full token set: colour, type, 8 dp spacing, radii, focus rings, and status colours that always include an icon and a word. Add the shared controls the inventory repeats: fields, sheets, dialogs, tables, skeletons, empty states, the 12-segment meter, price lines, and the offline, conflict, error, and not-found patterns (`E22-US3-UI1`, `E22-US3-UI2`, `E22-US3-UI3`, `E22-US1-UI2`).

Bundle the existing logo files into the design package without editing the originals.

Add `packages/khaana_domain` for typed models and repository interfaces, and a local demo broker so the three apps read and write one order. Presentation stays separate from those repositories.

### Phase 3. End-to-end demo, all 44 P1 designs

Rebuild the 44 P1 designs as real screens, not as the current text scaffolds. One scripted order must move from the customer, to the kitchen, to the rider, and show up on the admin monitor. Include the unhappy previews already named on those screens: slot taken, hold expired, fragile item forced to express, wrong delivery code, staff access denied, and nutrition API unavailable.

P1 IDs and current routes are in `UI_SCREEN_TRACKER.md`.

### Phase 4. Rest of the customer app

All remaining customer screens and overlays: launch, registration, verification, password reset, search, filters, addresses, vouchers, history, invoices, reorder, reviews, assistant, and the layout sets.

### Phase 5. Vendor, kitchen, and mini ERP

All remaining vendor screens: onboarding, staff duties, menu configuration, offers, stock movements, wastage, purchasing, reports, and owner-only finance. Kitchen stays tablet-first. The owner dashboard stays a dense desktop layout. Staff still cannot open finance or recipes.

### Phase 6. Rider

All remaining rider screens: registration and documents, approval state, pooled trips, earnings history, safety, voice prompts that are clearly simulated, and support.

### Phase 7. Administration

All remaining admin screens: vendor approval, users, complaints, commission rules, audit, and notifications. Admin stays inside `apps/portal`.

### Phase 8. Remaining support UI

Every P3 design and any shared state not already built in Phase 2.

### Phase 9. Verification

Cross-role reset of the demo data, screenshots against the design system, interaction tests, small phone, large phone, tablet, and desktop, and an accessibility pass against the design-system contrast rules. Update the tracker only after a screen is visually reviewed and its visible checks pass. Backend tests stay open.

## Definition of done for a screen

A screen is finished only when all of these are true:

- The inventory states for that ID are present.
- Every visible control does something a tester can repeat.
- Copy and colours follow the design system.
- The screen has been looked at on its target size.
- The tracker names the requirement IDs it covers and the tests a screenshot cannot pass.

## What is already safe to keep

- App boundaries: customer, rider, and one portal.
- `config/prototype-assumptions.json` as the only place for provisional numbers.
- Named routes and the requirement IDs already on the P1 scaffolds.
- Generated Android `minSdk = flutter.minSdkVersion`. Do not treat API 24 as an approved product requirement.
