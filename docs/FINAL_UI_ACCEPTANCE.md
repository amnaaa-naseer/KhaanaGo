# Final UI acceptance

This is not a claim that all 189 designs are visually finished or that all 393 tests passed.

## What passed

| Command | Result |
| --- | --- |
| `node --test test/lifecycle.test.js` in `services/mock-api` | Pass on 8 Nov 2026. Sign-in returns a demo token. The server prices the cake at Rs 1,850 even if the client sends price 1. A slot hold is required. Fragile pooled delivery is rejected. The returned code delivers; `000000` does not. Flour stock falls. An invoice and revenue are recorded. Staff state hides recipes and finance. A request without a token is rejected. |
| `flutter test` in `packages/khaana_screens` | Pass on 8 Nov 2026. Inventory counts stay exact. Every ID still renders a title and a primary action. `checkout_test.dart` keeps quantity 2 and the note "No nuts" from the item screen through review, and the saved order total is Rs 3,880. |
| `flutter analyze` in `packages/khaana_screens` | No issues. |
| `npm test` in `apps/vendor_portal` | Pass. 73 vendor and shared designs render. |
| `npm test` in `apps/admin_portal` | Pass. 29 admin and shared designs render. |

## What is not claimed

- No design is marked visually reviewed.
- No Chapter 2 test is marked passed.
- Payment, maps, nutrition, sound, and the assistant are labelled simulations.
- 177 designs are still catalog scaffolds. Twelve customer checkout designs are interaction-tested. None are visually reviewed.
- Vendor and admin pages still include generic clause fields and a Save action. The owner/staff switch is still a demo control, not a sign-in.
- Chapter 2’s 393 tests stay open. Backend-only rules are not marked passed from the UI.

## How to run

Start the mock API first:

```powershell
cd C:\FYP\KhaanaGo\services\mock-api
node server.js
```

Reset the demo data:

```powershell
Invoke-RestMethod -Method Post http://127.0.0.1:8787/v1/demo/reset
```

Then, in separate terminals:

```powershell
cd C:\FYP\KhaanaGo\apps\customer_flutter
flutter run -d chrome
```

```powershell
cd C:\FYP\KhaanaGo\apps\rider_flutter
flutter run
```

```powershell
cd C:\FYP\KhaanaGo\apps\vendor_portal
npm run dev
```

```powershell
cd C:\FYP\KhaanaGo\apps\admin_portal
npm run dev
```

Customer starts at login. The drawer lists all 52 customer and shared designs. Rider starts at sign-in and lists its 47 designs. Vendor runs at port 5173 and admin at 5174. The sidebar lists every design for that role. Owner and kitchen staff are a control on the vendor sidebar. Staff who open a finance or recipe design see access denied.

Demo sign-in accepts any identifier that exists in the mock users and a password of 8 to 128 characters. Example customer identifier: `03001234567`. Owner: `owner@bakecharm.test`. Staff: `staff@bakecharm.test`. Rider: `03007654321`. Admin: `admin@khaanago.test`.
