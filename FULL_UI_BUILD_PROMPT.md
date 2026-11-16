# KhaanaGo — Build ALL 189 Designs as a COMPLETE Functional Frontend

You are the technical lead, UX engineering lead, Flutter engineer, React/TypeScript engineer, test engineer, and delivery coordinator for KhaanaGo. **EXECUTE THE FULL IMPLEMENTATION, not just an audit, plan, skeleton, preview, priority subset, or static mockup.** You must ultimately produce working frontend applications covering **EVERY design in the current verified screen inventory**.

## Non-negotiable objective

Build all **189** inventory designs: **139 complete full screens, 47 working overlays, and 3 responsive layout sets**. Interfaces: **48 customer, 43 rider, 69 vendor, 25 administrator, 4 shared**. All navigation and every UI action should have meaningful and correct behavior using development/mock services until backend integration. A simple generic fallback screen, cloned template with changed title, alert-only button, static picture, or 'Coming soon' does **NOT** count as a completed design. Implement all P1, P2, and P3, not just the 44 P1 designs. In the current requirements, cover **22 epics, 82 user stories, and 393 test cases**, correctly distinguishing UI-observable cases from backend-only cases.

## Sources — read and reconcile first

1. `references/requirements/KhaanaGo_Chapter2_Deduplicated_Complete_Coverage.docx` — authoritative product requirements, acceptance criteria, test cases.
2. `references/requirements/KhaanaGo_Screen_Inventory_Verified.docx` — authoritative screen/overlay IDs, priority, role, and required visual states.
3. `references/requirements/KhaanaGo Design System(1).html` — authoritative branding and design foundations.
4. `references/KhaanaGo_GUI/` — existing GUI reference, with actual files including `index.html`, `KhaanaGo_GUI_Standalone.html`, `styles/app.css`, `scripts/app.js`, `data/epics.json`, `data/screens.json`, `data/stories.json`, `docs/UI_Traceability.csv`, `docs/API_CONTRACTS_DRAFT.md`, `handoff/react/tokens.css`, `handoff/flutter/khaanago_theme.dart` and registries.
5. Existing functional application files and project conventions, if present.

The old demo source may show 84 stories; it is **outdated** relative to 82 in the latest Chapter 2. Do not silently take old story IDs or old traceability as authority. Read actual DOCX paragraphs and tables (convert to text/Markdown with a script if necessary), and reconcile every inventory design against current requirements. Do not use a guessed or partial extraction.

## Required architecture

- `apps/customer_flutter`: Flutter/Dart, mobile-first food ordering app.
- `apps/rider_flutter`: Flutter/Dart, rider delivery app.
- `apps/vendor_portal`: React + TypeScript, responsive web/PWA, tablet-ready kitchen.
- `apps/admin_portal`: React + TypeScript, desktop-first admin (can share portal infrastructure where sensible; preserve distinct role routes).
- `packages/` or equivalent for tokens, contracts, shared primitives, fixtures and API models as technically appropriate. Flutter and TypeScript cannot import each other's source code; generate compatible types/tokens from single contract definitions if useful.
- `services/mock-api`: a **single stateful mock API** accessible to all four running apps in development, preserving orders, slots, dispatch, inventory, invoices and payments as demo data. Use deterministic fixtures, realistic latency, and testable state transitions; persist state and provide a reset-to-demo command. Do not let each app use contradictory, independent fake order stores.
- Clearly define interfaces/adapters for later Node.js/Express/TypeScript REST + Socket.IO, PostgreSQL and Redis integration. Do not implement production payments/maps/AI/safety or claim they work when they do not. Label simulation visibly in demo mode.
- Prefer existing libraries, code and working flows when they meet requirements; avoid needless rewrites.

## Workflow and quality standard

1. Parse both authoritative DOCX sources and the HTML design system completely. Generate `docs/SCREEN_REGISTRY.csv` or JSON with every design ID exactly once, interface, epic/story, related tests, screen/overlay/layout category, states, component/route, implementation status, automated test ID, manual test notes. Generate `docs/REQUIREMENTS_TRACEABILITY.md` and `docs/GAPS.md`.
2. Implement the complete visual system: KhaanaGo orange/charcoal/neutral palette, fonts/typography, density, spacing, responsive breakpoints, button/input states, icons, accessible contrast, consistent visual hierarchy. Use professional, distinct, screen-specific layouts rather than repeating a generic placeholder.
3. **Customer**: onboarding, signup/login/verification/reset, permissions, profiles and addresses; home/discovery/search/filtering, vendor cards and menus, item details and customization (including dietary options, photos), nutrition/allergens, favorites, cart, capacity-dependent slots, checkout, discounts, delivery charges, payment choices, order confirmation, live tracking, history/reorder, reviews and AI assistant screen.
4. **Vendor**: registration/verification and staff roles, navigation shell, dashboard; menu/categories/items/add-ons, stock/availability, kitchen capacity and slots, estimate/buffer controls, Kanban/KDS board with order details and status controls, ingredient/recipe BOM privacy and calculations, nutrition, ingredient stock and movements, wastage and purchasing/MRP, promotions, invoices/payment records, finance analytics, alerts, reports and role-specific settings.
5. **Rider**: login/availability, nearby offers, assignment acceptance/decline, pooled trips, pickups synchronized with food readiness, pickup verification, delivery map/status surfaces, drop-off verification, earnings/tariff breakdown, safety/voice-assisted check-in UI, notifications, profile, offline handling.
6. **Admin**: secure role-based access, platform dashboards, vendors and riders management/verification, governance, configurations/buffers, commission rules, users, complaints/disputes, analytics/reporting, audit logs and moderation flows.
7. **Shared**: network/offline banners, queued-sync states, sync conflict handling, general recoverable errors, not-found and shared dialogs as specified by the inventory.
8. Make each screen work in realistic connected flows: all buttons, tabs, menus, links, back actions, drawers/sheets, forms, pickers, toggles, dialogs, searching, filters, sorts, pagination, validation, accessibility controls, confirmations and error recovery. Forms update real mock-service state, not just local static labels. Every role must be navigable both via its primary workflows and available screen-specific menus.
9. Implement positive, negative and boundary UI behaviors, including loading, empty, errors, permissions, revoked sessions, double submissions, invalid inputs, closed kitchens, sold-out items, expired holds, out-of-stock ingredients, connectivity and role restrictions. Use exact constants from requirements; where unclear, put a clearly marked configurable assumption in `docs/ASSUMPTIONS.md` rather than silently inventing a product policy.
10. Shared e2e demo: customer discovers and customizes an item -> slot availability is capacity-checked -> selected slot is held/confirmed -> customer checks out using labeled simulated payment -> vendor receives order -> kitchen prepares it and marks ready -> rider is dispatched appropriately, accepts, picks up and delivers -> tracking shows live state changes -> stock/BOM consumption, invoice/payment entry and dashboard numbers update once. Test cancellation, failed payment, closed vendor, slot expiration and offline/retry paths too.
11. Use readable state management, explicit domain statuses and allowed transitions, service/repository separation, route guards, reusable form components, theme tokens, a11y labels and touch target standards. Do not scatter fake records or duplicate workflows across components. Create production-minded, maintainable code, not one huge widget/file.

## Build all screens — do not stop after P1

Work in coherent implementation batches to maintain build stability, but **the overall deliverable is every required design**, regardless of priority. Completing the first 44 does not complete this task. Keep `docs/BUILD_STATUS.md` as a persistent per-design checklist with `Missing/Implementing/Implemented/Visually-reviewed/Functionally-tested`; update after each batch. At the end of each batch, continue with the next incomplete ID without waiting for a new feature request, while respecting necessary user approvals and platform execution limits. If interrupted by tool/context limits, record exact next steps and remaining IDs for a subsequent session. Never falsely report a task finished or claim background execution.

## Test and completion gates

- Scripts must confirm the inventory contains **exactly 189 unique design IDs**, categorized 139/47/3 and associated to their correct roles; no missing or unmatched design IDs.
- Each screen/overlay must have a route or reachable trigger, required screen-specific content, correct role permissions, working interactions, proper default/loading/empty/error/success states, and at least one corresponding smoke/widget/component/E2E test as appropriate.
- Test with Flutter `flutter analyze`, `flutter test`, and integration tests where applicable; React TypeScript check, lint, unit/component tests and Playwright E2E; test backend mock contracts and state transitions. Run actual commands and fix failing tests. Add responsive checks at small phone, standard phone, tablet and desktop; check keyboard traversal, contrast, focus, accessible labels and tap targets.
- Validate the cross-role E2E order with shared mock API and deterministic fixtures, not just visual clicks.
- Audit all 82 current stories and all 393 test cases for UI applicability; report backend-only items as integration-dependent and never treat them as UI passes.
- Do **not** say '100% functional', 'all 189 complete', or 'all tests passed' until evidence is recorded in `docs/FINAL_UI_ACCEPTANCE.md` with counts, test command output, screenshots, uncovered IDs and mock limitations.

## How to execute now

Do not respond only with explanations, suggestions, a roadmap, a list of proposed files, or an HTML demo. You are in **Agent execution mode**: inspect the repository, create docs and application structure, implement source, run the apps and tests, and iteratively fix until each inventory design is finished. You may plan internally and delegate parallelizable UI tasks where supported, but keep one consistent shared contracts/design system/API. Save coherent working checkpoints in Git, never delete user data or unrelated project files. If a true blocker requires an external key, payment account, device, emulator or approval, implement the honest mock alternative and document the blocker; keep making progress on everything else.

On completion, provide: how to run each app; the mock service reset command; all 189 design IDs with Verified/Blocked status; acceptance test results; real integration work remaining. The goal is **complete functional frontend UI now, production API integration later**.
