# Draft integration boundaries (for future backend planning)

These routes and Socket.IO event names are **proposals**, not existing endpoints or a confirmed API contract. Review with the team and validate against Chapter 2 before implementing.

| Domain | Example REST endpoint | Main consumer | Related UI IDs |
|---|---|---|---|
| Identity | `POST /v1/auth/login`, `POST /v1/auth/refresh` | All roles | `E1-US1-UI3`, `E1-US3-UI1`, `E1-US2-UI2` |
| Vendors | `GET /v1/vendors?area=...` | Customer | `E3-US1-UI1` |
| Menus | `GET /v1/vendors/:id/menu` | Customer | `E3-US1-UI2` |
| Customizations | `POST /v1/carts/:id/lines` | Customer | `E4-US1-UI1` |
| Capacity | `PUT /v1/vendor/capacity` | Vendor | `E5-US1-UI1` |
| Slot availability | `GET /v1/vendors/:id/slots` | Customer | `E5-US3-UI1` |
| Slot hold | `POST /v1/slots/:id/holds` | Customer | `E5-US4-UI1` |
| Checkout | `POST /v1/orders` | Customer | `E3-US2-UI2` |
| Kitchen board | `GET /v1/vendor/orders?stage=...` | Vendor | `E7-US3-UI1` |
| Kitchen progress | `PATCH /v1/vendor/orders/:id/stage` | Vendor | `E7-US1-UI2` |
| Rider offers | `GET /v1/rider/offers` | Rider | `E13-US2-UI4` |
| Rider handover | `POST /v1/rider/jobs/:id/pickup-confirmation` | Rider | `E13-US1-UI3` |
| Delivery proof | `POST /v1/rider/jobs/:id/delivery-verification` | Rider | `E13-US3-UI2` |
| Inventory | `GET /v1/vendor/stock`, `POST /v1/vendor/stock-movements` | Vendor | `E9-US1-UI1` |
| Recipes | `PUT /v1/vendor/recipes/:id` | Vendor owner | `E8-US1-UI2` |
| Accounting | `GET /v1/vendor/invoices`, `GET /v1/vendor/finance/summary` | Vendor owner | `E10-US1-UI3`, `E12-US1-UI1` |
| Verification | `POST /v1/admin/verifications/:id/decisions` | Admin | `E20-US1-UI5` |
| Buffers | `PUT /v1/admin/buffer-rules/:id` | Admin | `E6-US3-UI1` |

**Proposed Socket.IO events:** `order.created`, `order.accepted`, `order.preparing`, `order.near_ready`, `order.ready`, `dispatch.assigned`, `rider.picked_up`, `order.delivered`, `slot.capacity_changed`, `notification.created`.

**Security rules:** Authorize each resource server-side. Separate `vendor.owner` from `vendor.staff`. Never expose recipe quantities, costs, profit margins, bank data or payout details to staff or customers. Do not rely on UI visibility for access control. Design all transitions to be idempotent and persist an auditable event history. Avoid trusting client-supplied totals, ETA, slot availability or role claims.
