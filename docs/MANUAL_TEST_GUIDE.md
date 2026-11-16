# KhaanaGo manual test guide

Updated 5 November 2026.

Use this guide to click through every design. Automated tests check that each ID renders its title and a primary action. They do not replace this walkthrough, and this walkthrough is not a visual sign-off against the design system.

## Start

From `C:\FYP\KhaanaGo`:

```powershell
cd C:\FYP\KhaanaGo\services\mock-api
node server.js
```

In a second terminal:

```powershell
Invoke-RestMethod -Method Post http://127.0.0.1:8787/v1/demo/reset
```

| App | Folder | Command | Opens on |
| --- | --- | --- | --- |
| Customer app | `apps/customer_flutter` | `flutter run -d chrome` | E1-US1-UI3 |
| Rider app | `apps/rider_flutter` | `flutter run` | E1-US2-UI2 |
| Vendor portal | `apps/vendor_portal` | `npm run dev` | E1-US3-UI1 |
| Admin portal | `apps/admin_portal` | `npm run dev` | E1-US3-UI8 |

Vendor serves on port 5173. Admin serves on port 5174. Use the four apps in the table above.

## Demo accounts

Password length 8–128 is provisional. Demo sign-in does not hash passwords.

| Role | Identifier | Where |
| --- | --- | --- |
| Customer | 03001234567 | Customer login |
| Vendor owner | owner@bakecharm.test | Vendor portal, Owner |
| Kitchen staff | staff@bakecharm.test | Vendor portal, Kitchen staff |
| Rider | 03007654321 | Rider sign-in. Hamza Ali, Motorbike, approved |
| Admin | admin@khaanago.test | Admin sign-in |

Any password from 8 to 128 characters is accepted for these identifiers. `password12` is a convenient demo value.

## One order across roles

1. Reset the demo API.
2. Customer: open menu, item, cart, delivery, slot, payment, and place the chocolate cake as express. Fragile items cannot use pooled delivery.
3. Vendor owner: dashboard counts move, then Kitchen board. Accept, then Ready.
4. Rider: pick up only after Ready, then enter delivery code `482913`.
5. Vendor owner: revenue and an invoice appear. Cream stock drops because the cake recipe uses it. Staff still cannot open finance or recipes.
6. Admin live dashboard: the order is no longer active after delivery. Delayed stays 0.

Empty dashboards after a reset are correct. “No orders yet.” is the empty state.

## Vendor dashboard checks

Open `E1-US3-UI5` after signing in as Owner.

- Orders today, new/pending, in preparation, and ready for pickup match the kitchen columns.
- Revenue matches Finance. Capacity shows the 12-segment meter and Available, Limited, or Full as a word, not colour alone. BakeCharm starts at 72%, which is Limited.
- Low stock lists Cream (2 L, reorder at 3). The 7:30 PM slot is Full. Margalla Grill is Closed.
- Pending custom orders counts active orders whose lines are fragile or carry a note. A reset with no orders shows 0.
- Collapse the sidebar, search for an ID, refresh the browser tab, and confirm the same screen is still open.
- Switch to Kitchen staff. Finance, recipes, nutrition, bill of materials, the owner dashboard, and the owner audit log leave the menu. Invoice list and invoice detail stay. Opening a hidden screen directly shows “You do not have access to this page.”

## Screen index

Shared designs are repeated under every role because each app includes them.

### Customer app

| ID | Title | Module | Kind | Check |
| --- | --- | --- | --- | --- |
| E22-US3-UI1 | Offline banner and pending-sync badge | Shared | Overlay | Offline banner; each queued status action marked Pending; ordered sync after reconnection; do not show unsynced actions as confirmed. |
| E22-US3-UI2 | Sync conflict message | Shared | Overlay | What changed while offline and which version was kept (AC2) |
| E22-US3-UI3 | Something went wrong | Shared | Screen | Plain reason, "Try again" button, no technical codes |
| E22-US1-UI2 | Page not found (web) | Shared | Screen | Message and a link back to Home or the dashboard |
| E1-US1-UI6 | App launch | Account and Profile | Screen | Logo and loading; goes to Home if signed in, otherwise Login |
| E1-US1-UI1 | Registration | Account and Profile | Screen | Name, mobile, email, password strength rules; duplicate email/number, invalid inputs and minimum-password boundary states (E1-US1). |
| E1-US1-UI2 | Verification code | Account and Profile | Screen | Verification input and resend; wrong, expired and reused code states; no session before successful verification. |
| E1-US1-UI3 | Login | Account and Profile | Screen | Mobile or email, password, "Forgot password?"; session-expired message (AC4) |
| E1-US1-UI4 | Reset password: request | Account and Profile | Screen | Registered email or mobile; confirmation that a code was sent (AC3) |
| E1-US1-UI5 | Reset password: code and new password | Account and Profile | Screen | Code, new password, rules checklist, success state |
| E1-US5-UI6 | Location permission | Account and Profile | Overlay | Why the app needs location, then the system prompt |
| E17-US1-UI3 | Notification permission | Account and Profile | Overlay | Why order updates matter, then the system prompt |
| E1-US5-UI1 | Profile | Account and Profile | Screen | Name, mobile, email; links to addresses, orders, sign out |
| E1-US5-UI4 | Edit profile | Account and Profile | Screen | Editable name and mobile; change applies to notifications (AC2) |
| E1-US5-UI2 | Saved addresses | Account and Profile | Screen | Address cards with default marker, edit, delete, add (AC1) |
| E1-US5-UI3 | Add or edit address | Account and Profile | Screen | Map with draggable pin, search, current location, label, address line |
| E1-US5-UI5 | Delete address confirmation | Account and Profile | Overlay | Which address, "Delete" and "Keep" |
| E3-US1-UI1 | Home | Discovery and Customization | Screen | Address selector, search, filter chips, top-rated row, vendor cards with open and capacity state |
| E3-US1-UI4 | Search results | Discovery and Customization | Screen | Results for typed search and filters; "no match" state with suggestions (AC2) |
| E3-US1-UI5 | Filter sheet | Discovery and Customization | Overlay | Cuisine, dietary tags, open now; "Show N restaurants" |
| E3-US1-UI2 | Vendor menu | Discovery and Customization | Screen | Hours and status, categories, item rows with nutrition badge, unavailable items greyed (AC4), cart bar |
| E3-US1-UI6 | Vendor info and reviews | Discovery and Customization | Screen | Address, hours, rating summary, recent reviews |
| E3-US1-UI3 | Item detail | Discovery and Customization | Screen | Price, add-ons, nutrition badge, allergen warning, "Customize" or "Add to cart" (AC3) |
| E4-US1-UI1 | Customization builder | Discovery and Customization | Screen | Size, flavour, add-ons, custom text, exclusions and swaps; live price and prep time |
| E4-US2-UI1 | Reference image and instructions | Discovery and Customization | Overlay | Camera or gallery, thumbnail, instructions with counter, upload errors |
| E4-US3-UI1 | Revised quote approval | Discovery and Customization | Screen | Original and revised price and lead time, vendor note, Approve or Cancel (AC2); decline reason |
| E3-US2-UI1 | Cart | Cart and Checkout | Screen | Items, quantities, remove and subtotal; empty cart and invalid quantity states; revalidate unavailable items before checkout. |
| E3-US2-UI3 | Different-restaurant dialog | Cart and Checkout | Overlay | "Keep current cart" or "Start new cart" (AC2) |
| E14-US2-UI1 | Delivery type | Cart and Checkout | Screen | Pooled discount and added time versus Express prices; fragile cake or spillable items excluded; Express never pooled; eligible options return when fragile items are removed. |
| E5-US3-UI1 | Slot selector | Cart and Checkout | Screen | Today and upcoming slots, Available/Limited/Full, realistic arrival window and weather note; no immediate order at full capacity; refreshed availability after cancellation. |
| E5-US4-UI1 | Slot taken dialog | Cart and Checkout | Overlay | "That slot was just taken" with nearest free windows (AC1) |
| E5-US4-UI2 | Slot released dialog | Cart and Checkout | Overlay | Hold expired, back to the selector (AC2) |
| E3-US3-UI1 | Payment method | Cart and Checkout | Screen | Cash on delivery, JazzCash, Easypaisa, card |
| E3-US3-UI2 | Payment gateway handoff | Cart and Checkout | Screen | Loading and return states around the gateway's own page |
| E3-US4-UI1 | Voucher and offers sheet | Cart and Checkout | Overlay | Code field, auto-applied offers, rejection reason (AC2) |
| E3-US2-UI2 | Review order | Cart and Checkout | Screen | Address, held slot and countdown, delivery and payment; separate food, base fare, road-distance charge, surcharges, discount and total; prevent duplicate submission. |
| E10-US3-UI1 | Payment failed | Cart and Checkout | Screen | "Order not placed", Try again, Choose another method |
| E3-US4-UI2 | Order placed | Cart and Checkout | Screen | Order number, slot, estimate, "Track order" |
| E17-US1-UI1 | Live tracking | Tracking, History and Feedback | Screen | Preparation stage/ready time or live rider map, current arrival window, timeline, pooled sequence, delivery code and refund status; replace stale ETA and retain in-app updates when notifications are disabled. |
| E6-US4-UI1 | Delay explanation | Tracking, History and Feedback | Overlay | Banner and push with the reason, naming the weather (AC1, AC2) |
| E16-US4-UI1 | Confirm corrected drop-off pin | Tracking, History and Feedback | Overlay | Map with the rider's proposed pin; confirm or adjust |
| E10-US1-UI1 | Cancel order | Tracking, History and Feedback | Overlay | Reason, what is refunded, confirm (before preparation only) |
| E17-US1-UI2 | Notification centre | Tracking, History and Feedback | Screen | Updates grouped by order, newest first (AC6) |
| E17-US2-UI1 | Order history | Tracking, History and Feedback | Screen | Orders newest first; empty state (AC2) |
| E17-US2-UI2 | Order detail and invoice | Tracking, History and Feedback | Screen | Items and options, bill, payment status, Download invoice, Reorder, Rate, Report a problem |
| E17-US2-UI3 | Reorder summary | Tracking, History and Feedback | Overlay | Reorder with original options and current prices; available items added, unavailable items skipped with explanation (E17-US2 AC3, AC4). |
| E18-US1-UI1 | Rating | Tracking, History and Feedback | Screen | Restaurant, item and rider ratings kept separate |
| E18-US3-UI1 | Complaint form | Tracking, History and Feedback | Screen | Order read-only, category, description Include optional attachment upload with configured type/size limits; reject unsupported or oversized files and duplicate submission. |
| E18-US3-UI2 | Complaint status | Tracking, History and Feedback | Screen | Ticket reference, progress, outcome when resolved |
| E19-US1-UI1 | Assistant chat | Assistant and Web | Screen | Text/mic input, results respecting exclusions, no-match alternatives, current order ETA or no-active-order reply; unsupported and cross-role requests refused (E19-US4). |
| E19-US2-UI1 | Voice order | Assistant and Web | Screen | Live transcript, read-back card, Confirm and Cancel Ambiguous or low-confidence speech asks for clarification; no checkout until explicit confirmation. |
| E22-US1-UI1 | Responsive web layouts | Assistant and Web | Layout set | Home, Menu with cart panel and Checkout at 360, 768 and 1280 px Include graceful unsupported-device guidance and breakpoint boundary layouts; verify rider Android/iOS layouts as well as customer web. |

### Rider app

| ID | Title | Module | Kind | Check |
| --- | --- | --- | --- | --- |
| E22-US3-UI1 | Offline banner and pending-sync badge | Shared | Overlay | Offline banner; each queued status action marked Pending; ordered sync after reconnection; do not show unsynced actions as confirmed. |
| E22-US3-UI2 | Sync conflict message | Shared | Overlay | What changed while offline and which version was kept (AC2) |
| E22-US3-UI3 | Something went wrong | Shared | Screen | Plain reason, "Try again" button, no technical codes |
| E22-US1-UI2 | Page not found (web) | Shared | Screen | Message and a link back to Home or the dashboard |
| E1-US2-UI1 | App launch | Sign-in and Registration | Screen | Logo and loading |
| E1-US2-UI2 | Sign in | Sign-in and Registration | Screen | Mobile and password, "Forgot password?" |
| E1-US2-UI3 | Registration 1: personal details | Sign-in and Registration | Screen | Name, CNIC, phone, password |
| E1-US2-UI4 | Registration 2: vehicle and phone | Sign-in and Registration | Screen | Motorbike, car or van; phone operating system |
| E1-US2-UI5 | Registration 3: documents | Sign-in and Registration | Screen | Licence and CNIC upload, field errors for missing items (TC3) |
| E1-US2-UI6 | Pending verification | Sign-in and Registration | Screen | "Under review"; cannot go online until approved (AC1) |
| E1-US2-UI7 | Application rejected or more information needed | Sign-in and Registration | Screen | Reason and what to resubmit (E20-US1 AC3, AC4) |
| E1-US2-UI8 | Verification code | Sign-in and Registration | Screen | Code entry and resend |
| E1-US2-UI9 | Reset password | Sign-in and Registration | Screen | Request, then code and new password, same pattern as the customer app |
| E13-US2-UI1 | Location permission | Sign-in and Registration | Overlay | Why location is needed while online, then the system prompt |
| E13-US1-UI4 | Notification and sound permission | Sign-in and Registration | Overlay | Why alerts matter for pickups |
| E13-US2-UI2 | Home: offline and online | Home and Offers | Screen | Online toggle, vehicle type, today's deliveries and earnings (E1-US2 AC2) |
| E13-US2-UI3 | Outside service area | Home and Offers | Overlay | Why no offers arrive and where to go (AC3) |
| E13-US2-UI4 | Delivery offer | Home and Offers | Screen | Vendor, drop-off area, distance, pay, countdown, Accept and Decline (AC1) |
| E14-US1-UI1 | Pooled trip offer | Home and Offers | Screen | Two pickups/drop-offs, maximum two orders and combined pay; eligibility distances/corridor and hold limit; exclude fragile and spillable items; no third order. |
| E13-US2-UI5 | Offer expired | Home and Offers | Overlay | Offer passed to another rider (AC2) |
| E13-US1-UI1 | Head to pickup | Active Delivery | Screen | Pickup route, vendor and preparation progress; dispatch only after 80% or Ready signal; nearest suitable rider assignment; no early assignment. |
| E13-US1-UI2 | Order ready alert | Active Delivery | Overlay | Full-screen alert with sound, vibration and text (AC3) |
| E13-US4-UI1 | At the store | Active Delivery | Screen | Arrival timestamp, waiting timer and configured threshold; fee only for excess minutes at pickup, zero below or exactly at threshold. |
| E13-US1-UI3 | Pickup handover | Active Delivery | Screen | Order number and items to check, hold to confirm "Picked up" |
| E14-US2-UI2 | Pooled parcels and labels | Active Delivery | Screen | Each parcel's label to match at drop-off, stop order (AC4) |
| E14-US1-UI2 | Second pickup hold | Active Delivery | Overlay | Countdown, then "Order uncoupled, continue with the first" (AC3, AC4) |
| E13-US3-UI1 | Head to drop-off | Active Delivery | Screen | Route, customer area, call and quick messages |
| E13-US3-UI2 | Delivery code entry | Active Delivery | Screen | Customer delivery-code entry; wrong code leaves delivery incomplete with Retry and Contact support; hold-to-confirm for critical transitions. Code format follows configured verification rules. |
| E13-US3-UI3 | Out-of-sequence prompt | Active Delivery | Overlay | Why the tap was blocked and what to do next (AC2) |
| E10-US2-UI2 | Collect cash | Active Delivery | Screen | Amount due, confirm cash collected (COD, AC2) |
| E13-US3-UI4 | Delivered | Active Delivery | Screen | Earnings for this delivery: base, distance, waiting, surcharge |
| E16-US4-UI2 | Quick messages | Active Delivery | Overlay | Preset messages for arrival and delay, one tap or voice (AC1) |
| E16-US4-UI3 | Request corrected pin | Active Delivery | Overlay | Ask the customer to confirm a new pin (AC2) |
| E16-US1-UI1 | Voice check-in | Active Delivery | Overlay | "Confirm arrival at customer", say "Confirm" or press the headset button; repeats once (AC1, AC2) |
| E19-US3-UI1 | Rider voice assistant | Active Delivery | Overlay | Next pickup, readiness, spoken answer shown as text |
| E18-US3-UI3 | Report a problem | Active Delivery | Screen | Order, category, description |
| E13-US2-UI6 | Shift summary | Earnings and History | Screen | Deliveries, distance, waiting time, earnings (AC4) |
| E15-US3-UI1 | Shift earnings invoice | Earnings and History | Screen | Per delivery: base fee, per-km, waiting fee, surcharges, total (AC1) |
| E15-US3-UI2 | Delivery earnings detail | Earnings and History | Screen | One delivery; pooled orders shown separately (AC2) |
| E1-US2-UI10 | Delivery history | Earnings and History | Screen | Past deliveries, newest first |
| E18-US2-UI1 | My ratings | Earnings and History | Screen | Average and recent comments (AC1) |
| E1-US2-UI11 | Rider profile | Profile and Settings | Screen | Details, vehicle type, document status |
| E1-US2-UI12 | Settings | Profile and Settings | Screen | List of the settings below, sign out |
| E13-US5-UI1 | Navigation preference | Profile and Settings | Screen | Open external maps, or use the in-app map (AC1, AC2) Location-permission withdrawal shows a recovery prompt; invalid route coordinates do not launch navigation. |
| E16-US2-UI1 | Display and alerts | Profile and Settings | Screen | High-contrast mode, audio mute with vibration fallback (E16-US1 AC4) |
| E16-US3-UI1 | Data saver | Profile and Settings | Screen | Low-data display, lighter map and GPS disconnected/recovering states; resume tracking without losing the trip when GPS returns. |
| E15-US1-UI1 | Tariff settings | Profile and Settings | Screen | Base fare and per-kilometre rate, negative-rate validation; routed road distance; defined maps-service fallback flagged for review. |

### Vendor portal

| ID | Title | Module | Kind | Check |
| --- | --- | --- | --- | --- |
| E22-US3-UI1 | Offline banner and pending-sync badge | Shared | Overlay | Offline banner; each queued status action marked Pending; ordered sync after reconnection; do not show unsynced actions as confirmed. |
| E22-US3-UI2 | Sync conflict message | Shared | Overlay | What changed while offline and which version was kept (AC2) |
| E22-US3-UI3 | Something went wrong | Shared | Screen | Plain reason, "Try again" button, no technical codes |
| E22-US1-UI2 | Page not found (web) | Shared | Screen | Message and a link back to Home or the dashboard |
| E20-US1-UI1 | Vendor application 1: business details | Application, Sign-in and Access | Screen | Business name, type (restaurant, cloud kitchen, home baker), contact, area |
| E20-US1-UI2 | Vendor application 2: documents | Application, Sign-in and Access | Screen | Required document uploads with format and size rules |
| E20-US1-UI3 | Vendor application 3: bank details | Application, Sign-in and Access | Screen | Payout account entry, review and submit |
| E20-US1-UI4 | Application status | Application, Sign-in and Access | Screen | Pending, more information needed, rejected with reason, approved |
| E1-US3-UI1 | Vendor sign-in | Application, Sign-in and Access | Screen | Credentials; routes owner and staff to their own dashboards (AC1) |
| E1-US3-UI2 | Account locked | Application, Sign-in and Access | Screen | Locked after five failed attempts; owner informed (AC2) |
| E1-US3-UI4 | Reset password | Application, Sign-in and Access | Screen | Request, then code and new password |
| E1-US3-UI3 | No access | Application, Sign-in and Access | Screen | "You do not have access to this page", back to dashboard (AC3) |
| E1-US3-UI5 | Owner dashboard | Application, Sign-in and Access | Screen | Today's orders and revenue, capacity now, low-stock count, pending custom orders |
| E1-US3-UI6 | Staff home | Application, Sign-in and Access | Screen | Kitchen-operation view only: board link and duties assigned |
| E1-US4-UI1 | Staff list | Staff and Business Setup | Screen | Staff with duties and status |
| E1-US4-UI2 | Add or edit staff | Staff and Business Setup | Screen | Name, employee ID, duty set (take orders, prepare, edit stock) |
| E1-US4-UI3 | Deactivate staff | Staff and Business Setup | Overlay | What changes; audit history is kept (AC2) |
| E2-US1-UI1 | Business profile | Staff and Business Setup | Screen | Type, service area, cuisine, dietary tags, preferred transport (bike or car) |
| E2-US3-UI1 | Operating hours and open/closed | Staff and Business Setup | Screen | Weekly hours, manual close and reopen (AC1, AC2) |
| E14-US3-UI1 | Delivery settings | Staff and Business Setup | Screen | Own riders, independent riders, partner fleet; fallback behaviour (AC1, AC2) |
| E15-US1-UI2 | Tariff settings | Staff and Business Setup | Screen | Base fare and per-kilometre rate, negative-rate validation; routed road distance; defined maps-service fallback flagged for review. |
| E1-US3-UI7 | Bank details and payout account | Staff and Business Setup | Screen | Owner-only account and payout schedule |
| E2-US2-UI1 | Menu list | Menu | Screen | Items by category, availability toggle, search |
| E2-US2-UI2 | Add or edit item | Menu | Screen | Name, price, category, photo, description, add-ons; invalid price error (AC2) |
| E2-US2-UI3 | Remove item | Menu | Overlay | Confirm; note for items in customers' carts (AC4) |
| E2-US4-UI1 | Customization options | Menu | Screen | Sizes, flavours, text and image fields with price differences, lead time, fragile flag |
| E5-US1-UI1 | Kitchen capacity setup | Capacity | Screen | Orders per hour, per-item prep times, resource limits; zero rejected (AC2) |
| E5-US1-UI2 | Temporary capacity change | Capacity | Overlay | New limit, duration, automatic return to default (AC3, AC4) |
| E5-US1-UI3 | Live utilisation | Capacity | Screen | Capacity meter, current load, remaining capacity, upcoming slot occupancy (AC6) |
| E5-US2-UI1 | Intake paused | Capacity | Overlay | Banner with queue size and Resume (AC3, AC4) |
| E6-US2-UI1 | Buffers and overrides | Capacity | Screen | Weather and peak buffers in force, vendor override with audit note (AC4) Weather-service failure shows the fallback or last-known-condition state; never invent a weather reason. |
| E7-US1-UI1 | New order alert | Kitchen and Orders | Overlay | Sound, visual alert, tab-title flash (AC1, AC2) |
| E7-US1-UI2 | Order ticket | Kitchen and Orders | Overlay | Items, custom text, swaps, reference image and prominent allergen exclusions; Accept moves to Preparing and notifies customer (E7-US2 AC1); reject opens reason dialog. |
| E7-US2-UI1 | Reject order | Kitchen and Orders | Overlay | Reason list; refund flag for prepaid orders (AC2) |
| E7-US3-UI1 | Live kitchen board | Kitchen and Orders | Screen | New, Preparing, Ready, Handed Over columns with timers; 80% prepared and Ready actions |
| E7-US3-UI2 | Order history | Kitchen and Orders | Screen | Searchable list of past orders with status |
| E7-US4-UI1 | Voice commands | Kitchen and Orders | Overlay | Heard command, confirmation, "repeat" prompt (AC1, AC2) |
| E4-US3-UI2 | Custom order review | Kitchen and Orders | Screen | Accept, propose new price or time, or decline with a reason (AC1) |
| E8-US1-UI1 | Recipe list | Recipes and Nutrition (owner only) | Screen | Dishes with recipe status; hidden from staff (AC4) |
| E8-US1-UI2 | Recipe editor | Recipes and Nutrition (owner only) | Screen | Ingredients, quantities, units; blank or invalid unit rejected (AC2) |
| E8-US2-UI1 | Nutrition and allergen review | Recipes and Nutrition (owner only) | Screen | Calculated values per serving, retry flag when the API is unreachable (E8-US2 AC1, AC2) |
| E8-US4-UI1 | Recipe change impact | Recipes and Nutrition (owner only) | Overlay | Nutrition and BOM will refresh; active orders keep the old recipe (AC1, AC2) Failed recalculation shows a recoverable pending/error state; do not expose inconsistent BOM and nutrition versions. |
| E9-US1-UI1 | Stock list | Inventory and Planning | Screen | Ingredient units, quantity, reorder level, storage type and low-stock highlight; automatic BOM deduction on confirmation and restoration after cancellation before preparation. |
| E9-US1-UI2 | Add or edit ingredient | Inventory and Planning | Screen | Name, unit, opening stock, reorder level and perishable/non-perishable type; valid quantity/unit checks; storage type feeds E9-US4 planning. Include expiry date or batch expiry where needed to distinguish usable and expired stock (E9-US4-TC7). |
| E9-US1-UI3 | Stock intake | Inventory and Planning | Overlay | Purchase quantity; entry logged with the user's name (AC2) |
| E9-US1-UI4 | Dish BOM | Inventory and Planning | Screen | Ingredients and quantity per serving for one dish (AC3) |
| E9-US1-UI5 | Bulk BOM entry | Inventory and Planning | Screen | Many dishes at once, shared ingredients not re-entered (AC4) |
| E9-US2-UI1 | Low-stock alerts | Inventory and Planning | Screen | Ingredients under reorder level, dishes made unavailable at zero stock (AC3, AC4) |
| E9-US2-UI2 | Notification panel | Inventory and Planning | Overlay | Low stock, new orders, discrepancies, newest first |
| E9-US3-UI1 | Log wastage | Inventory and Planning | Overlay | Ingredient, quantity, reason; over-stock quantity rejected (AC2) |
| E9-US3-UI2 | Variance report | Inventory and Planning | Screen | Expected, actual, variance per ingredient; over-threshold rows highlighted (AC3, AC4) Provide physical stock-count input and configurable variance threshold; show below, equal and above-threshold states. |
| E9-US4-UI1 | Material requirements planner | Inventory and Planning | Screen | Look-back period, requirements, current stock and shortfall; perishable needs from confirmed upcoming orders, non-perishable needs from historical sales and stock-holding buffer; insufficient-history state (AC1-AC4). |
| E10-US1-UI2 | Invoice list | Invoices, Payments and Finance (owner only except invoices) | Screen | Invoice number, order, total, payment state, date filter |
| E10-US1-UI3 | Invoice detail | Invoices, Payments and Finance (owner only except invoices) | Screen | Lines, discounts, delivery, total; earlier revisions kept (AC1, AC2); void state (AC6) |
| E10-US2-UI1 | Payments | Invoices, Payments and Finance (owner only except invoices) | Screen | Online and COD payments against invoices; method and reference (AC1, AC2) Show partial, exact and excess-payment outcomes according to the Chapter 2 test; duplicate references must not change totals. |
| E10-US3-UI2 | Refunds | Invoices, Payments and Finance (owner only except invoices) | Screen | Rejected prepaid orders flagged for refund and their status |
| E10-US4-UI1 | COD reconciliation | Invoices, Payments and Finance (owner only except invoices) | Screen | Cash collected per rider against COD invoices, unmatched differences (AC1) |
| E10-US4-UI2 | Flag discrepancy | Invoices, Payments and Finance (owner only except invoices) | Overlay | Note sent to the administrator (AC2) |
| E12-US1-UI1 | Finance dashboard | Invoices, Payments and Finance (owner only except invoices) | Screen | Revenue, commission, payouts, expenses with date-range filter (AC3, AC4) |
| E12-US1-UI2 | Commission and payouts | Invoices, Payments and Finance (owner only except invoices) | Screen | Deductions per order and payout history |
| E12-US1-UI3 | Expenses | Invoices, Payments and Finance (owner only except invoices) | Screen | Expense list by category and date |
| E12-US1-UI4 | Add expense | Invoices, Payments and Finance (owner only except invoices) | Overlay | Category, amount, date (AC1) |
| E12-US2-UI1 | Net profit and dish margins | Invoices, Payments and Finance (owner only except invoices) | Screen | Revenue minus commission and costs; margin per dish (AC1, AC2) Missing BOM cost shows an unavailable margin rather than fabricated profit; display negative, zero and positive results. |
| E12-US3-UI1 | Export report | Invoices, Payments and Finance (owner only except invoices) | Overlay | Period and contents; download link (AC1) |
| E11-US1-UI1 | Offers list | Marketing | Screen | Active, scheduled and expired offers and vouchers |
| E11-US1-UI2 | Create or edit offer | Marketing | Screen | Percentage or fixed, code, minimum order, usage limit, schedule; end-before-start error (AC2) |
| E11-US2-UI1 | Combo builder | Marketing | Screen | Choose items, set bundle price, availability follows items (AC1, AC2) |
| E11-US3-UI1 | Offer performance | Marketing | Screen | Uses, discount given and sales per offer; zero values not errors (AC1, AC2) |
| E18-US2-UI2 | Product feedback | Feedback, Assistant and Audit | Screen | Average, count and recent comments per item; date filter (AC3, AC4) |
| E18-US3-UI4 | Report a problem | Feedback, Assistant and Audit | Screen | Order, category, description |
| E19-US3-UI2 | Vendor assistant | Feedback, Assistant and Audit | Overlay | Docked chat: pending orders, stock, capacity; refuses owner-only data for staff (AC1, AC2) |
| E21-US2-UI1 | Audit log (owner only) | Feedback, Assistant and Audit | Screen | Read-only entries with timestamp, named employee, task and reason; employee/date filters and no-results state; staff access denied; no edit/delete controls. |
| E22-US2-UI1 | Responsive portal layouts | Feedback, Assistant and Audit | Layout set | Dashboard, board and tables on phone, tablet and laptop; PWA standalone launch |

### Admin portal

| ID | Title | Module | Kind | Check |
| --- | --- | --- | --- | --- |
| E22-US3-UI1 | Offline banner and pending-sync badge | Shared | Overlay | Offline banner; each queued status action marked Pending; ordered sync after reconnection; do not show unsynced actions as confirmed. |
| E22-US3-UI2 | Sync conflict message | Shared | Overlay | What changed while offline and which version was kept (AC2) |
| E22-US3-UI3 | Something went wrong | Shared | Screen | Plain reason, "Try again" button, no technical codes |
| E22-US1-UI2 | Page not found (web) | Shared | Screen | Message and a link back to Home or the dashboard |
| E1-US3-UI8 | Admin sign-in | Access, Verification and Fleets | Screen | Credentials, lockout message |
| E20-US1-UI5 | Verification queue | Access, Verification and Fleets | Screen | Vendors, riders and fleet partners awaiting review, oldest first |
| E20-US1-UI6 | Vendor application review | Access, Verification and Fleets | Screen | Business details and documents; approve, reject with reason, or request more information (AC1) |
| E20-US1-UI7 | Rider verification review | Access, Verification and Fleets | Screen | Documents, vehicle type; approve or reject (AC3, AC4) |
| E20-US1-UI9 | Fleet partner review | Access, Verification and Fleets | Screen | Partner details and documents; approve or reject |
| E20-US1-UI8 | Decision dialog | Access, Verification and Fleets | Overlay | Required reason on rejection; message sent to the applicant |
| E14-US4-UI1 | Partner fleets | Access, Verification and Fleets | Screen | Partners, API connection status, active deliveries |
| E14-US4-UI2 | Partner details and status log | Access, Verification and Fleets | Screen | Acknowledgements, status updates and IVR confirmations per delivery (AC1, AC2) |
| E20-US2-UI1 | Commission settings | Rules | Screen | Global and per-vendor rate within the 8 to 12 percent range; out-of-range error (AC1, AC2) Include effective date/time and show the rate applicable to new orders; preserve the rate on existing orders. |
| E6-US3-UI1 | Buffer rules | Rules | Screen | Weather and peak rules with period, area and percentage |
| E6-US3-UI2 | Create or edit buffer rule | Rules | Overlay | Period, affected area, buffer percentage; effect applies within a minute (AC1, AC2) |
| E19-US4-UI1 | Assistant scope and permissions | Rules | Screen | Role scope and permission information; preview unsupported-action reply directing to complaints and cross-role refusal. Supporting design for guardrails, not a required settings editor. |
| E20-US3-UI1 | Users | Users, Complaints and Ratings | Screen | Search across customers, vendors, riders and staff |
| E20-US3-UI2 | User detail | Users, Complaints and Ratings | Screen | Profile, status, history, Suspend or Reactivate (AC1, AC2) |
| E20-US3-UI3 | Suspend user | Users, Complaints and Ratings | Overlay | Consequence (sessions end) and confirm |
| E20-US3-UI4 | Complaints queue | Users, Complaints and Ratings | Screen | Open tickets by age and parties |
| E20-US3-UI5 | Complaint detail | Users, Complaints and Ratings | Screen | Order, timeline and parties involved (AC3) |
| E20-US3-UI6 | Resolve complaint | Users, Complaints and Ratings | Overlay | Outcome text; all parties notified, case closed (AC4) |
| E18-US2-UI3 | Rating review | Users, Complaints and Ratings | Screen | Mark a low rating as vendor-attributed so it leaves the rider's average (AC2) |
| E20-US4-UI1 | Live dashboard | Monitoring, Safety and Audit | Screen | Active orders, delayed orders, riders online, slot utilisation (AC2) |
| E20-US4-UI2 | Reports | Monitoring, Safety and Audit | Screen | Orders, revenue, commission, slot utilisation for a date range (AC1) Include report export with private-field exclusion; valid, empty and invalid date-range states. |
| E16-US1-UI3 | Safety escalations | Monitoring, Safety and Audit | Screen | Missed rider check-ins past the grace period, with rider and order (AC6) |
| E21-US3-UI1 | Audit investigation | Monitoring, Safety and Audit | Screen | Cross-vendor log for a dispute, recipe quantities hidden (AC1) |
| E21-US3-UI2 | Export audit log | Monitoring, Safety and Audit | Overlay | Range and format; the export is itself logged (AC2) |
| E22-US2-UI2 | Responsive admin layouts | Monitoring, Safety and Audit | Layout set | Queues, tables and dashboard on tablet and laptop |
