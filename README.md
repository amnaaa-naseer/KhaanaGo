# KhaanaGo

Intelligent multi-vendor food ordering, capacity-aware logistics, and kitchen operations.

Customer and rider run as Flutter apps. Vendor and admin run as React portals. All four talk to one mock API in demo mode. Payments, maps, and other outside services are mocked.

## Run the demo

Start the API first, then the apps. Sign in again after an API restart. Sessions live in memory and are cleared when the API process stops.

| App | From | Command | Address |
| --- | --- | --- | --- |
| Mock API | `services/mock-api` | `node server.js` | http://127.0.0.1:8787 |
| Customer | `apps/customer_flutter` | `flutter run -d web-server --web-hostname 127.0.0.1 --web-port 7357` | http://127.0.0.1:7357 |
| Rider | `apps/rider_flutter` | `flutter run -d web-server --web-hostname 127.0.0.1 --web-port 7358` | http://127.0.0.1:7358 |
| Vendor | `apps/vendor_portal` | `npm run dev` | http://localhost:5173 |
| Admin | `apps/admin_portal` | `npm run dev` | http://localhost:5174 |

On a browser wider than 600px, the customer and rider apps sit in a centered 430px column.

## Accounts

Every account uses the password `password12`.

| Who | Sign in with | Where |
| --- | --- | --- |
| Ayesha Khan, customer | `03001234567` | Customer app |
| Hamza Ali, rider | `03007654321` | Rider app |
| BakeCharm owner | `owner@bakecharm.test` | Vendor portal. All vendor modules. |
| Kitchen staff | `staff@bakecharm.test` | Vendor portal. Live orders only. |
| Platform admin | `admin@khaanago.test` | Admin portal |

The vendor sidebar is Live Orders, Menu, Inventory (BOM/MRP), Capacity, Offers, Finance, Staff, and Settings. Kitchen staff see Live Orders only.

The admin sidebar is nine groups: Overview, Vendors, Riders and fleets, Orders, Finance, Operations, Complaints and ratings, Audit log, and Users. Sign-in, Something went wrong, and Page not found stay out of that list.

Hold a page title for about a second, or add `?dev=1` to the URL, to open the screen list and the loading, empty, and error previews. Those stay off by default.

## Docs

- [Demo accounts](docs/demo-accounts.md)
- [Click-through walkthrough](docs/demo-walkthrough.md)
- [Screens that are still a single field, Save, and Back to workspace](docs/screen-inventory.md)

## Tests

```text
flutter test
```

from `packages/khaana_screens`, and `npm test` from `apps/vendor_portal` and `apps/admin_portal`. The mock API tests are `node --test test/lifecycle.test.js` from `services/mock-api`.
