# Implementation Roadmap: Prototype → Complete Applications

## Phase A — Freeze UX and requirements (current)

Use the `data/screens.json` registry as the inventory and `docs/UI_Traceability.csv` as the test/UAT key. Link each GUI route to `E#-US#-UI#` and its Chapter 2 acceptance criteria. Confirm final copy, sample states (happy/empty/error/loading/no access), accessible touch targets and in-scope behaviour for all P1/P2/P3 designs. Treat any *generic prototype panels* as screen contracts awaiting a finalized screen-specific design.

## Phase B — Set up the monorepo

```text
khaanago/
  apps/customer_flutter/
  apps/rider_flutter/
  apps/vendor_portal_react/
  apps/admin_portal_react/         # may share shell with vendor portal
  services/api/                   # Express + TypeScript
  services/workers/               # background processing
  packages/contracts/             # versioned request/response schemas
  packages/design-tokens/         # colors/spacing/states/icons
  infra/                          # deployment + monitoring configurations
```

Start with TypeScript strict mode, lint rules, formatter, unit tests, route guards, and CI pipelines. Convert `handoff/react/types.ts` into production API types after approval. Port Flutter theme from `handoff/flutter/khaanago_theme.dart`.

## Phase C — Backend and contract-driven UI

Build PostgreSQL schemas for users/roles, vendor profiles, recipes/BOM, item variations, ingredient movements, capacity time buckets, slot holds, orders/order events, rider assignments, invoices/payments, promotions, complaints and audit events. Define an API version and publish OpenAPI schemas. Use the API as the **source of truth**, not client-side demo state.

### Critical end-to-end transaction

1. Vendor sets kitchen resources, hourly caps, recipe/BOM and menu availability.
2. Customer chooses item customizations; server computes total and checks availability.
3. Server offers slots with truthful capacity, prep-time and weather/peak buffers.
4. On checkout, server creates a short-lived, atomic slot hold; releases expired holds.
5. Payment and order confirmation are idempotent. On confirmation, publish order to the kitchen.
6. Kitchen accepts/prepares and emits `80% ready`/`ready` signals.
7. Dispatch optimizer assigns rider only near meal readiness, subject to vehicle, area and pooling constraints.
8. On fulfilment, inventory movement, invoice creation, COD/online payment state and reporting events reconcile transactionally.
9. Notify and track customers/riders via Socket.IO and push notifications, with durable event replay.

## Phase D — Implement role-specific screens

- **Flutter customer:** routing, login, discovery/search, vendor/menu, customizations/image upload, cart, slot selection, payment, tracked orders, rating, assistant, offline states.
- **Flutter rider:** onboarding/verification, online/offline, offers, safe one-action fulfilment, hold-to-confirm, navigation, voice/IVR safety handling, COD, earnings, offline-first action queue.
- **React vendor:** onboarding, RBAC owner/staff, catalogue, capacity, dark kitchen board, recipe privacy/nutrition, stock/BOM/MRP, invoices, marketing, finance, reports and audit.
- **React admin:** verification, commission/buffer rules, fleets, users/complaints, live operations, safety escalations, analytics and audit.

Implement each page with loading, empty, invalid, conflict, expired, offline and permission denied states, as called out in the inventory. The P1 flow is the first testable vertical slice.

## Phase E — Test/deploy

- **Unit:** prices, VAT/fees if applicable, slot generation, capacity limits, recipe quantities, tariff and commission range validation.
- **Contract/integration:** JWT expiry, RBAC, idempotent orders, slot concurrency, payment reconciliation, inventory movements and real-time event order.
- **E2E:** customer order → kitchen → rider → stock/invoice/finance; offline replay; notification delays; pooled delivery safeguards.
- **Accessibility:** high-contrast rider, screen-reader labels, focus order, 48dp controls (64dp confirmations), low-end Android devices, responsive tablet/desktop.
- **Deployment:** environment separation, secrets management, migrations, backups, Redis service, HTTPS, CI/CD, structured logs and monitoring. Explicit production gates for security and payment provider approval.

This roadmap is an engineering handoff, not an assertion that these services have already been built.
