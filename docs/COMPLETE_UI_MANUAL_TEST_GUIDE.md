# KhaanaGo manual test guide

Updated 8 November 2026. This is not a completion claim. 177 of 189 designs are still catalog scaffolds. The path below is the one that was run.

## Prerequisites

Windows, the repo at `C:\FYP\KhaanaGo`, Node, and Flutter. The mock API is demo software. Sign-in is not production authentication. Card, wallet, map, nutrition, and assistant screens are simulations.

Android emulator calls the host API at `http://10.0.2.2:8787`. Chrome and desktop use `http://127.0.0.1:8787`.

## Reset and start

```powershell
cd C:\FYP\KhaanaGo\services\mock-api
node server.js
```

```powershell
Invoke-RestMethod -Method Post http://127.0.0.1:8787/v1/demo/reset
```

| Role | App | Command | Demo identifier | Password |
| --- | --- | --- | --- | --- |
| Customer | `apps/customer_flutter` | `flutter run -d chrome` | 03001234567 | password12 |
| Rider | `apps/rider_flutter` | `flutter run` | 03007654321 | password12 |
| Vendor | `apps/vendor_portal` | `npm run dev` (port 5173) | owner@bakecharm.test or staff@bakecharm.test | password12 |
| Admin | `apps/admin_portal` | `npm run dev` (port 5174) | admin@khaanago.test | password12 |

Password length 8–128 is provisional. The customer app opens on Login. Home, Orders, Assistant, and Profile are the bottom navigation. The screen-ID drawer is only in a debug build, behind the developer icon.

## Customer checkout that was tested

1. Sign in as the customer. The app stores the demo token from `POST /v1/auth/login`.
2. Home (`E3-US1-UI1`): open BakeCharm. Margalla Grill stays closed.
3. Menu (`E3-US1-UI2`): open Chocolate fudge cake. Walnut brownie stays sold out.
4. Item (`E3-US1-UI3`): raise quantity to 2. The session keeps that quantity when the page changes.
5. Customization (`E4-US1-UI1`): enter a note. The field stops at 500 characters.
6. Cart (`E3-US2-UI1`): one kitchen, food Rs 3,700.
7. Delivery (`E14-US2-UI1`): the cake is fragile, so Pooled cannot be selected. Express stays Rs 180.
8. Slot (`E5-US3-UI1`): choose a bookable slot and hold it. The hold lasts 5 minutes. A full slot cannot be held.
9. Payment (`E3-US3-UI1`): Cash on delivery is simulated. Turning on “Simulate a failed card payment” refuses the order and does not create it.
10. Review (`E3-US2-UI2`): food, delivery, and total come from the session. Place order.
11. The API ignores any price sent by the client and uses the menu price. The response includes a generated 6-digit code. Placed (`E3-US4-UI2`) and Orders (`E17-US2-UI1`) show that order.

Automated evidence: `flutter test test/checkout_test.dart` in `packages/khaana_screens` passed. The saved line was quantity 2, note “No nuts”, price 1850, total 3880.

## Cross-role API path that was tested

`node --test test/lifecycle.test.js` in `services/mock-api` passed.

Customer holds the 8:30 PM slot and orders the cake. A client price of 1 is ignored. Pooled delivery of that fragile cake returns 409. Staff accept and ready. Rider pickup, then deliver with the returned code. Code `000000` does not deliver. Flour stock falls, an invoice is created, and owner finance revenue increases. Staff state has no recipes and no finance. A call with no token returns 401.

## What is still not a completed screen

- Rider, vendor, and admin flows still use shared layouts. Vendor and admin still render requirement clauses as text fields with `Save {title}`.
- The 47 overlays are not opened from parent screens as dialogs. The 3 layout sets are not tested at 360, 390, 768, and 1280.
- No screenshot was compared with the design system. Visual review is 0.
- All 393 Chapter 2 tests remain open. Do not treat a rendered ID as a passed requirement.
- Next implementation file for the remaining customer, rider, and portal screens is `packages/khaana_screens/lib/src/screen_view.dart` and `packages/khaana-web/src/ScreenApp.tsx`.
