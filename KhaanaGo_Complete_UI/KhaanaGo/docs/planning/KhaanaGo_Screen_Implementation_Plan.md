# KhaanaGo screen implementation plan

Planning only. No screens are built yet. The `apps` folder is empty, and every row in the register is Design: Not started, Implementation: Not started, Review: Not reviewed.

Sources: `KhaanaGo_Screen_Register.xlsx` (sheet `Screen register`), `KhaanaGo_Screen_Inventory_Verified.docx` (design order), and `KhaanaGo Design System.html`. The full register, including platform, candidate tests, and status columns, is in `KhaanaGo_Screen_Register.csv` in this folder.

Provisional prototype rules are in `docs/requirements-decisions.md`. Numbers the screens must read are in `config/prototype-assumptions.json`. Chapter 2 and the screen register are unchanged. Logos for later launch and sign-in screens are `assets/brand/khaanago-logo.png` and `assets/brand/khaanago-wordmark.png`.

## What is ready to build

These can be built as a prototype shell. Every provisional number below still needs team and supervisor confirmation before it is treated as a Chapter 2 requirement.

- Shared visual parts: colour, type, spacing, buttons, fields, chips, capacity badges, the 12-segment meter, price lines, sheets, snackbars, and bottom navigation. No open product number blocks these.
- Customer discovery and checkout screens, using the config for password length, the 500-character note, the 5 MB JPG/PNG rule, the 5-minute slot hold, the 60/85 intake bands, the 30% pooled offer, and the fragile-item rule.
- Vendor kitchen screens that show capacity, tickets, and the order board. The meter uses the same configurable bands and must say they are an intake rule.
- Rider delivery screens with a simulated map, a text-address fallback, a 6-digit code, a 2-minute check-in grace period, a 5-minute second-pickup hold, and an 8-minute free wait. Waiting pay shows excess minutes only. It does not show a rupee rate until one is chosen.
- Current IDs only: reorder is E17-US2, rating highlights are E17-US3, storage rules are E9-US4.

## What is still unresolved

- Backend password policy. The client may validate 8–128 characters. Hashing and the final policy are not decided.
- Waiting-pay rate per minute. The 8-minute threshold is provisional. The rate in config is null.
- Android minimum version. E16-US3 says “Android 10 or older.” The design system and inventory say “Android 10 and up.” Flutter 3.47 supports API 24–37 and does not support API 23 or earlier. Do not print a minimum version.
- Real maps and live tracking. The prototype simulates them and must say so.
- Chapter 2, Section 2.4 is empty. The design system mentions a Section 2.4.2 that does not exist. Do not invent that subsection. Field limits come from the config file.
- Test-to-screen links. Review each test on its own. A screenshot does not verify a backend, security, or integration rule.
- E4-US3 AC3 and AC4 use the customer’s voice inside a vendor story. The behaviour stands: a fragile item forces express, and pooled delivery returns only if the order still qualifies. The wording is for a later Chapter 2 correction.

## Screens to build first

Build in this order. Stop before treating any provisional value as final.

1. Brand and tokens, including the two logo files, then the shared components listed above.
2. The 14-screen customer order journey in the P1 table below. It is the demonstration path and the provisional rules now cover its missing numbers.
3. Registration `E1-US1-UI1` and password reset `E1-US1-UI5` immediately after Login, even though they are P2, because the password messages are now specified.
4. The reference-image overlay `E4-US2-UI1` with the customization builder, so the 500-character counter and the 5 MB states exist before vendor tickets need them.
5. The vendor kitchen P1 wave, starting at sign-in, menu, capacity, and the live board.
6. The rider P1 wave, with simulated maps and no waiting-pay amount.

Admin buffer rules and the live dashboard can follow. They are P1, and they do not unblock the order story.

## How to use this plan

- **P1** is the demonstration path (44 designs). **P2** is what a story's acceptance criteria need (118). **P3** is a supporting design that no story names as its own page (27).
- A row is one design. Empty, loading, error, and boundary states are frames inside that design, not extra screen IDs. Expect two to four states for most rows.
- `Mapped stories` lists every story the inventory attaches to that design. A design can serve more than one story. Candidate test IDs in the CSV are copied at story level. Review each test individually (decision D15). Mark it as a visible GUI state or as a backend, security, or integration test. A screenshot does not prove a backend rule.
- Build shared visual parts first (colour, type, buttons, fields, chips, capacity badges, sheets), then the P1 wave below, then P2 interface by interface, then P3.
- These behaviours do not get their own screens: IVR phone check-ins, push notification bodies, the payment gateway's own page, and the PWA install prompt. Design only the screens around their results.
- Service rules (atomic slot holds, password hashing, immutable audit, routing, concurrency) need API or device tests. A screen can show the outcome; it does not prove the rule.

## Build the 44 P1 designs in this order

This order is the inventory's design sequence. It walks one order from the customer, through the kitchen, to the rider, with the admin controls that keep estimates honest.

### Customer order journey

| Step | UI ID | Screen | Must show / states |
| --- | --- | --- | --- |
| 1 | E1-US1-UI3 | Login | Mobile or email, password, "Forgot password?"; session-expired message (AC4) |
| 2 | E3-US1-UI1 | Home | Address selector, search, filter chips, top-rated row, vendor cards with open and capacity state |
| 3 | E3-US1-UI2 | Vendor menu | Hours and status, categories, item rows with nutrition badge, unavailable items greyed (AC4), cart bar |
| 4 | E3-US1-UI3 | Item detail | Price, add-ons, nutrition badge, allergen warning, "Customize" or "Add to cart" (AC3) |
| 5 | E4-US1-UI1 | Customization builder | Size, flavour, add-ons, custom text, exclusions and swaps; live price and prep time |
| 6 | E3-US2-UI1 | Cart | Items, quantities, remove and subtotal; empty cart and invalid quantity states; revalidate unavailable items before checkout. |
| 7 | E14-US2-UI1 | Delivery type | Provisional 30% off the delivery fee and an estimated extra 10–15 minutes, labelled as an estimate rather than a guaranteed time. A fragile item forces Express (E4-US3 AC3). Pooled returns only after that item is removed and the order still passes the other eligibility rules (E4-US3 AC4). Express is never pooled. |
| 8 | E5-US3-UI1 | Slot selector | Today and upcoming slots. Available below 60%, Limited from 60% to below 85%, Full at 85% or above. Thresholds come from config and mean an intake rule, not that the kitchen is physically full. Show the arrival window and weather note. No immediate order at full intake. Refresh after cancellation. |
| 9 | E5-US4-UI1 | Slot taken dialog | "That slot was just taken" with nearest free windows (AC1) |
| 10 | E3-US3-UI1 | Payment method | Cash on delivery, JazzCash, Easypaisa, card |
| 11 | E3-US2-UI2 | Review order | Address, 5-minute slot hold and countdown, delivery and payment. Separate food, base fare, road-distance charge, surcharges, discount and total. Block a second submit. On hold expiry, show the released-slot message and return to the selector. |
| 12 | E3-US4-UI2 | Order placed | Order number, slot, estimate, "Track order" |
| 13 | E17-US1-UI1 | Live tracking | Preparation stage or ready time, current arrival window, timeline, pooled sequence, 6-digit delivery code, and refund status. Map and rider position are simulated until maps are integrated. If the map is unavailable, show the text address and a retry action. Replace a stale ETA. Keep in-app updates when notifications are off. Rating highlights stay on Home under E17-US3, not on this screen. |
| 14 | E6-US4-UI1 | Delay explanation | Banner and push with the reason, naming the weather (AC1, AC2) |

### Vendor kitchen and the order-to-books link

| Step | UI ID | Screen | Must show / states |
| --- | --- | --- | --- |
| 1 | E1-US3-UI1 | Vendor sign-in | Credentials; routes owner and staff to their own dashboards (AC1) |
| 2 | E1-US3-UI5 | Owner dashboard | Today's orders and revenue, capacity now, low-stock count, pending custom orders |
| 3 | E2-US2-UI1 | Menu list | Items by category, availability toggle, search |
| 4 | E2-US2-UI2 | Add or edit item | Name, price, category, photo, description, add-ons; invalid price error (AC2) |
| 5 | E5-US1-UI1 | Kitchen capacity setup | Orders per hour, per-item prep times, resource limits; zero rejected (AC2) |
| 6 | E5-US1-UI3 | Live utilisation | Capacity meter using the configurable 60/85 intake bands, current load, remaining intake, and upcoming slot occupancy (AC6). Say that a Full band is an intake limit, not proof the kitchen is physically full. |
| 7 | E5-US2-UI1 | Intake paused | Banner with queue size and Resume (AC3, AC4) |
| 8 | E7-US1-UI1 | New order alert | Sound, visual alert, tab-title flash (AC1, AC2) |
| 9 | E7-US1-UI2 | Order ticket | Items, custom text, swaps, reference image and prominent allergen exclusions; Accept moves to Preparing and notifies customer (E7-US2 AC1); reject opens reason dialog. |
| 10 | E7-US3-UI1 | Live kitchen board | New, Preparing, Ready, Handed Over columns with timers; 80% prepared and Ready actions |
| 11 | E8-US1-UI2 | Recipe editor | Ingredients, quantities, units; blank or invalid unit rejected (AC2) |
| 12 | E8-US2-UI1 | Nutrition and allergen review | Calculated values per serving, retry flag when the API is unreachable (E8-US2 AC1, AC2) |
| 13 | E9-US1-UI1 | Stock list | Ingredient units, quantity, reorder level, storage type and low-stock highlight; automatic BOM deduction on confirmation and restoration after cancellation before preparation. |
| 14 | E9-US1-UI4 | Dish BOM | Ingredients and quantity per serving for one dish (AC3) |
| 15 | E10-US1-UI3 | Invoice detail | Lines, discounts, delivery, total; earlier revisions kept (AC1, AC2); void state (AC6) |
| 16 | E12-US1-UI1 | Finance dashboard | Revenue, commission, payouts, expenses with date-range filter (AC3, AC4) |

### Rider delivery

| Step | UI ID | Screen | Must show / states |
| --- | --- | --- | --- |
| 1 | E1-US2-UI2 | Sign in | Mobile and password, "Forgot password?" |
| 2 | E13-US2-UI2 | Home: offline and online | Online toggle, vehicle type, today's deliveries and earnings (E1-US2 AC2) |
| 3 | E13-US2-UI4 | Delivery offer | Vendor, drop-off area, distance, pay, countdown, Accept and Decline (AC1) |
| 4 | E13-US1-UI1 | Head to pickup | Simulated route, text address, and retry if the map is unavailable. Vendor and preparation progress. Dispatch only after 80% or Ready. No early assignment. |
| 5 | E13-US1-UI2 | Order ready alert | Full-screen alert with sound, vibration and text (AC3) |
| 6 | E13-US4-UI1 | At the store | Arrival timestamp and waiting timer. Provisional free wait is 8 minutes. Show excess minutes only after that. Do not show a rupee waiting-pay amount while the rate in config is null. |
| 7 | E13-US1-UI3 | Pickup handover | Order number and items to check, hold to confirm "Picked up" |
| 8 | E13-US3-UI1 | Head to drop-off | Simulated route or text address with retry, customer area, call and quick messages. Manual pin correction stays on `E16-US4-UI3`. |
| 9 | E13-US3-UI2 | Delivery code entry | Provisional 6-digit numeric code. A wrong code leaves the delivery incomplete, with Retry and Contact support. Hold-to-confirm for the critical transition. |
| 10 | E13-US3-UI4 | Delivered | Earnings for this delivery: base, distance, and surcharge. Waiting pay only for minutes past the 8-minute threshold, with no rupee amount until the rate is decided. |

### Admin controls

| Step | UI ID | Screen | Must show / states |
| --- | --- | --- | --- |
| 1 | E1-US3-UI8 | Admin sign-in | Credentials, lockout message |
| 2 | E6-US3-UI1 | Buffer rules | Weather and peak rules with period, area and percentage |
| 3 | E6-US3-UI2 | Create or edit buffer rule | Period, affected area, buffer percentage; effect applies within a minute (AC1, AC2) |
| 4 | E20-US4-UI1 | Live dashboard | Active orders, delayed orders, riders online, slot utilisation (AC2) |

Stories that appear inside another screen, rather than owning the P1 page: preparation time and ETA on the slot selector and live tracking (`E6-US1`); allergen warnings on item detail (`E8-US3`); rating highlights on Home (`E17-US3`); waiting and surcharge lines on rider earnings screens (`E15-US2`); audit events only through the vendor and admin audit viewers (`E21-US1`).

## Customer mobile app

Flutter on Android and iOS, plus a responsive web layout. Comfortable density, 48 dp targets, light cream theme that follows the system. Capacity and price stay visible before payment.

48 designs: 34 screens, 13 overlays, 1 layout sets. Priority: 14 P1, 27 P2, 7 P3.

### Account and Profile

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E1-US1-UI3 | Login | Screen | P1 | Mobile or email, password, "Forgot password?"; session-expired message (AC4) | E1-US1 |
| E1-US1-UI1 | Registration | Screen | P2 | Name, mobile, email. Provisional password rule is 8–128 characters, with client-side messages. Duplicate email or number, invalid inputs, and the length boundary. Backend password policy is still pending review. | E1-US1 |
| E1-US1-UI2 | Verification code | Screen | P2 | Verification input and resend; wrong, expired and reused code states; no session before successful verification. | E1-US1 |
| E1-US1-UI4 | Reset password: request | Screen | P2 | Registered email or mobile; confirmation that a code was sent (AC3) | E1-US1 |
| E1-US1-UI5 | Reset password: code and new password | Screen | P2 | Code, new password, the same 8–128 checklist, success state. Backend policy remains pending review. | E1-US1 |
| E1-US5-UI1 | Profile | Screen | P2 | Name, mobile, email; links to addresses, orders, sign out | E1-US5 |
| E1-US5-UI2 | Saved addresses | Screen | P2 | Address cards with default marker, edit, delete, add (AC1) | E1-US5 |
| E1-US5-UI3 | Add or edit address | Screen | P2 | Map with draggable pin, search, current location, label, address line | E1-US5 |
| E1-US5-UI4 | Edit profile | Screen | P2 | Editable name and mobile; change applies to notifications (AC2) | E1-US5 |
| E1-US1-UI6 | App launch | Screen | P3 | Logo and loading; goes to Home if signed in, otherwise Login | E1-US1 |
| E1-US5-UI5 | Delete address confirmation | Overlay | P3 | Which address, "Delete" and "Keep" | E1-US5 |
| E1-US5-UI6 | Location permission | Overlay | P3 | Why the app needs location, then the system prompt | E1-US5 |
| E17-US1-UI3 | Notification permission | Overlay | P3 | Why order updates matter, then the system prompt | E17-US1 |

### Discovery and Customization

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E3-US1-UI1 | Home | Screen | P1 | Address selector, search, filter chips, top-rated row, vendor cards with open and capacity state | E2-US3, E3-US1, E17-US3 |
| E3-US1-UI2 | Vendor menu | Screen | P1 | Hours and status, categories, item rows with nutrition badge, unavailable items greyed (AC4), cart bar | E2-US2, E3-US1 |
| E3-US1-UI3 | Item detail | Screen | P1 | Price, add-ons, nutrition badge, allergen warning, "Customize" or "Add to cart" (AC3) | E3-US1, E8-US2, E8-US3 |
| E4-US1-UI1 | Customization builder | Screen | P1 | Size, flavour, add-ons, custom text, exclusions and swaps; live price and prep time | E2-US4, E4-US1 |
| E3-US1-UI4 | Search results | Screen | P2 | Results for typed search and filters; "no match" state with suggestions (AC2) | E3-US1 |
| E3-US1-UI5 | Filter sheet | Overlay | P2 | Cuisine, dietary tags, open now; "Show N restaurants" | E3-US1 |
| E4-US2-UI1 | Reference image and instructions | Overlay | P2 | Camera or gallery, thumbnail, 500-character counter and limit message. JPG or PNG only, maximum 5 MB, with unsupported-format and oversized-file states. | E4-US2 |
| E4-US3-UI1 | Revised quote approval | Screen | P2 | Original and revised price and lead time, vendor note, Approve or Cancel (AC2); decline reason | E4-US3 |
| E3-US1-UI6 | Vendor info and reviews | Screen | P3 | Address, hours, rating summary, recent reviews | E3-US1 |

### Cart and Checkout

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E14-US2-UI1 | Delivery type | Screen | P1 | Provisional 30% off the delivery fee and an estimated extra 10–15 minutes, not a guaranteed time. Fragile items force Express. Pooled returns only if the order still qualifies. Express is never pooled. | E2-US4, E4-US3, E14-US2 |
| E3-US2-UI1 | Cart | Screen | P1 | Items, quantities, remove and subtotal; empty cart and invalid quantity states; revalidate unavailable items before checkout. | E2-US2, E3-US2, E9-US2 |
| E3-US2-UI2 | Review order | Screen | P1 | Address, 5-minute hold and countdown, delivery and payment. Separate food, base fare, distance, surcharges, discount and total. Block a second submit. Expiry returns to slot selection. | E2-US3, E3-US2 |
| E3-US3-UI1 | Payment method | Screen | P1 | Cash on delivery, JazzCash, Easypaisa, card | E3-US3 |
| E3-US4-UI2 | Order placed | Screen | P1 | Order number, slot, estimate, "Track order" | E3-US4 |
| E5-US3-UI1 | Slot selector | Screen | P1 | Today and upcoming slots. Available below 60%, Limited from 60% to below 85%, Full at 85% or above. Bands are a configurable intake rule, not physical occupancy. Arrival window and weather note. No immediate order when intake is full. Refresh after cancellation. | E5-US2, E5-US3, E6-US1, E6-US2 |
| E5-US4-UI1 | Slot taken dialog | Overlay | P1 | "That slot was just taken" with nearest free windows (AC1) | E5-US4 |
| E10-US3-UI1 | Payment failed | Screen | P2 | "Order not placed", Try again, Choose another method | E10-US3 |
| E3-US2-UI3 | Different-restaurant dialog | Overlay | P2 | "Keep current cart" or "Start new cart" (AC2) | E3-US2 |
| E3-US3-UI2 | Payment gateway handoff | Screen | P2 | Loading and return states around the gateway's own page | E3-US3 |
| E3-US4-UI1 | Voucher and offers sheet | Overlay | P2 | Code field, auto-applied offers, rejection reason (AC2) | E3-US4 |
| E5-US4-UI2 | Slot released dialog | Overlay | P2 | After the provisional 5-minute hold, say the hold expired and return to the selector (AC2). | E5-US4 |

### Tracking, History and Feedback

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E17-US1-UI1 | Live tracking | Screen | P1 | Preparation stage or ready time, arrival window, timeline, pooled sequence, 6-digit code, and refund status. Map is simulated, with a text address and retry. Replace a stale ETA. Keep in-app updates when notifications are off. | E6-US1, E14-US2, E17-US1 |
| E6-US4-UI1 | Delay explanation | Overlay | P1 | Banner and push with the reason, naming the weather (AC1, AC2) | E6-US4 |
| E16-US4-UI1 | Confirm corrected drop-off pin | Overlay | P2 | Map with the rider's proposed pin; confirm or adjust | E16-US4 |
| E17-US1-UI2 | Notification centre | Screen | P2 | Updates grouped by order, newest first (AC6) | E17-US1 |
| E17-US2-UI1 | Order history | Screen | P2 | Orders newest first; empty state (AC2) | E17-US2 |
| E17-US2-UI2 | Order detail and invoice | Screen | P2 | Items and options, bill, payment status, Download invoice, Reorder, Rate, Report a problem | E10-US1, E17-US2 |
| E17-US2-UI3 | Reorder summary | Overlay | P2 | Reorder with original options and current prices; available items added, unavailable items skipped with explanation (E17-US2 AC3, AC4). | E17-US2 |
| E18-US1-UI1 | Rating | Screen | P2 | Restaurant, item and rider ratings kept separate | E18-US1 |
| E18-US3-UI1 | Complaint form | Screen | P2 | Order read-only, category, description Include optional attachment upload with configured type/size limits; reject unsupported or oversized files and duplicate submission. | E18-US3 |
| E10-US1-UI1 | Cancel order | Overlay | P3 | Reason, what is refunded, confirm (before preparation only) | E9-US2, E10-US1 |
| E18-US3-UI2 | Complaint status | Screen | P3 | Ticket reference, progress, outcome when resolved | E18-US3 |

### Assistant and Web

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E19-US1-UI1 | Assistant chat | Screen | P2 | Text/mic input, results respecting exclusions, no-match alternatives, current order ETA or no-active-order reply; unsupported and cross-role requests refused (E19-US4). | E19-US1, E19-US4 |
| E19-US2-UI1 | Voice order | Screen | P2 | Live transcript, read-back card, Confirm and Cancel Ambiguous or low-confidence speech asks for clarification; no checkout until explicit confirmation. | E19-US2 |
| E22-US1-UI1 | Responsive web layouts | Layout set | P2 | Home, Menu with cart panel and Checkout at 360, 768 and 1280 px Include graceful unsupported-device guidance and breakpoint boundary layouts; verify rider Android/iOS layouts as well as customer web. | E22-US1 |

## Rider mobile app

Flutter, aimed at phones used on the road. High-contrast dark theme, one primary action, 64 dp status buttons, at least 16 sp text, and no more than three text lines during an active delivery. Status changes use hold-to-confirm.

43 designs: 32 screens, 11 overlays, 0 layout sets. Priority: 10 P1, 27 P2, 6 P3.

### Sign-in and Registration

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E1-US2-UI2 | Sign in | Screen | P1 | Mobile and password, "Forgot password?" | E1-US2, E22-US1 |
| E1-US2-UI3 | Registration 1: personal details | Screen | P2 | Name, CNIC, phone, password | E1-US2 |
| E1-US2-UI4 | Registration 2: vehicle and phone | Screen | P2 | Motorbike, car or van; phone operating system | E1-US2 |
| E1-US2-UI5 | Registration 3: documents | Screen | P2 | Licence and CNIC upload, field errors for missing items (TC3) | E1-US2 |
| E1-US2-UI6 | Pending verification | Screen | P2 | "Under review"; cannot go online until approved (AC1) | E1-US2 |
| E1-US2-UI7 | Application rejected or more information needed | Screen | P2 | Reason and what to resubmit (E20-US1 AC3, AC4) | E1-US2 |
| E13-US2-UI1 | Location permission | Overlay | P2 | Why location is needed while online, then the system prompt | E13-US2, E13-US5 |
| E1-US2-UI1 | App launch | Screen | P3 | Logo and loading | E1-US2 |
| E1-US2-UI8 | Verification code | Screen | P3 | Code entry and resend | E1-US2 |
| E1-US2-UI9 | Reset password | Screen | P3 | Request, then code and new password, same pattern as the customer app | E1-US2 |
| E13-US1-UI4 | Notification and sound permission | Overlay | P3 | Why alerts matter for pickups | E13-US1 |

### Home and Offers

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E13-US2-UI2 | Home: offline and online | Screen | P1 | Online toggle, vehicle type, today's deliveries and earnings (E1-US2 AC2) | E13-US2, E22-US1 |
| E13-US2-UI4 | Delivery offer | Screen | P1 | Vendor, drop-off area, distance, pay, countdown, Accept and Decline (AC1) | E13-US2 |
| E13-US2-UI3 | Outside service area | Overlay | P2 | Why no offers arrive and where to go (AC3) | E13-US2 |
| E13-US2-UI5 | Offer expired | Overlay | P2 | Offer passed to another rider (AC2) | E13-US2 |
| E14-US1-UI1 | Pooled trip offer | Screen | P2 | Two pickups/drop-offs, maximum two orders and combined pay; eligibility distances/corridor and hold limit; exclude fragile and spillable items; no third order. | E14-US1 |

### Active Delivery

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E13-US1-UI1 | Head to pickup | Screen | P1 | Simulated route, text address, and retry if the map is unavailable. Vendor and preparation progress. Dispatch only after 80% or Ready. No early assignment. | E13-US1, E13-US5 |
| E13-US1-UI2 | Order ready alert | Overlay | P1 | Full-screen alert with sound, vibration and text (AC3) | E13-US1, E16-US1 |
| E13-US1-UI3 | Pickup handover | Screen | P1 | Order number and items to check, hold to confirm "Picked up" | E13-US1, E16-US2 |
| E13-US3-UI1 | Head to drop-off | Screen | P1 | Simulated route or text address with retry, customer area, call and quick messages. | E13-US3, E13-US5, E22-US1 |
| E13-US3-UI2 | Delivery code entry | Screen | P1 | Provisional 6-digit numeric code. A wrong code leaves delivery incomplete, with Retry and Contact support. Hold-to-confirm for the critical transition. | E13-US3, E16-US2 |
| E13-US3-UI4 | Delivered | Screen | P1 | Earnings: base, distance, and surcharge. Waiting pay only past 8 minutes, with no rupee amount until the rate is decided. | E13-US3, E15-US2 |
| E13-US4-UI1 | At the store | Screen | P1 | Arrival timestamp and waiting timer. Provisional free wait is 8 minutes. Show excess minutes only. Do not show a rupee amount while the rate is null. | E13-US4, E15-US2 |
| E10-US2-UI2 | Collect cash | Screen | P2 | Amount due, confirm cash collected (COD, AC2) | E10-US2 |
| E13-US3-UI3 | Out-of-sequence prompt | Overlay | P2 | Why the tap was blocked and what to do next (AC2) | E13-US3 |
| E14-US1-UI2 | Second pickup hold | Overlay | P2 | Provisional 5-minute countdown, then "Order uncoupled, continue with the first" (AC3, AC4). | E14-US1 |
| E14-US2-UI2 | Pooled parcels and labels | Screen | P2 | Each parcel's label to match at drop-off, stop order (AC4) | E14-US2 |
| E16-US1-UI1 | Voice check-in | Overlay | P2 | "Confirm arrival at customer", say "Confirm" or press the headset button; repeats once (AC1, AC2). Missed check-ins use the provisional 2-minute grace period before admin escalation. | E16-US1 |
| E16-US4-UI2 | Quick messages | Overlay | P2 | Preset messages for arrival and delay, one tap or voice (AC1) | E16-US4 |
| E16-US4-UI3 | Request corrected pin | Overlay | P2 | Ask the customer to confirm a new pin (AC2) | E16-US4 |
| E18-US3-UI3 | Report a problem | Screen | P2 | Order, category, description | E18-US3 |
| E19-US3-UI1 | Rider voice assistant | Overlay | P2 | Next pickup, readiness, spoken answer shown as text | E19-US3, E19-US4 |

### Earnings and History

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E1-US2-UI10 | Delivery history | Screen | P2 | Past deliveries, newest first | E1-US2 |
| E13-US2-UI6 | Shift summary | Screen | P2 | Deliveries, distance, waiting time, earnings (AC4) | E13-US2 |
| E15-US3-UI1 | Shift earnings invoice | Screen | P2 | Per delivery: base fee, per-km, waiting fee, surcharges, total (AC1) | E15-US2, E15-US3 |
| E15-US3-UI2 | Delivery earnings detail | Screen | P2 | One delivery; pooled orders shown separately (AC2) | E15-US2, E15-US3 |
| E18-US2-UI1 | My ratings | Screen | P2 | Average and recent comments (AC1) | E18-US2 |

### Profile and Settings

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E1-US2-UI11 | Rider profile | Screen | P2 | Details, vehicle type, document status | E1-US2 |
| E13-US5-UI1 | Navigation preference | Screen | P2 | Open external maps, or use the in-app map (AC1, AC2) Location-permission withdrawal shows a recovery prompt; invalid route coordinates do not launch navigation. | E13-US5 |
| E15-US1-UI1 | Tariff settings | Screen | P2 | Base fare and per-kilometre rate, negative-rate validation; routed road distance; defined maps-service fallback flagged for review. | E15-US1 |
| E16-US2-UI1 | Display and alerts | Screen | P2 | High-contrast mode, audio mute with vibration fallback (E16-US1 AC4) | E16-US1, E16-US2 |
| E1-US2-UI12 | Settings | Screen | P3 | List of the settings below, sign out | E1-US2 |
| E16-US3-UI1 | Data saver | Screen | P3 | Low-data display, lighter simulated map, and GPS disconnected or recovering states. Resume tracking without losing the trip. Do not state a minimum Android version; that conflict is unresolved. | E16-US3 |

## Vendor and kitchen web portal

React PWA. Owner screens are light and dense. The kitchen board is tablet-first and dark. Kitchen staff must not see finance, bank details, commission, or recipe quantities; a direct link shows an access-denied page.

69 designs: 52 screens, 16 overlays, 1 layout sets. Priority: 16 P1, 46 P2, 7 P3.

### Application, Sign-in and Access

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E1-US3-UI1 | Vendor sign-in | Screen | P1 | Credentials; routes owner and staff to their own dashboards (AC1) | E1-US3 |
| E1-US3-UI5 | Owner dashboard | Screen | P1 | Today's orders and revenue, capacity now, low-stock count, pending custom orders | E1-US3 |
| E1-US3-UI2 | Account locked | Screen | P2 | Locked after five failed attempts; owner informed (AC2) | E1-US3 |
| E1-US3-UI3 | No access | Screen | P2 | "You do not have access to this page", back to dashboard (AC3) | E1-US3 |
| E1-US3-UI6 | Staff home | Screen | P2 | Kitchen-operation view only: board link and duties assigned | E1-US3 |
| E20-US1-UI1 | Vendor application 1: business details | Screen | P2 | Business name, type (restaurant, cloud kitchen, home baker), contact, area | E20-US1 |
| E20-US1-UI2 | Vendor application 2: documents | Screen | P2 | Required document uploads with format and size rules | E20-US1 |
| E20-US1-UI3 | Vendor application 3: bank details | Screen | P2 | Payout account entry, review and submit | E20-US1 |
| E20-US1-UI4 | Application status | Screen | P2 | Pending, more information needed, rejected with reason, approved | E20-US1 |
| E1-US3-UI4 | Reset password | Screen | P3 | Request, then code and new password | E1-US3 |

### Staff and Business Setup

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E1-US3-UI7 | Bank details and payout account | Screen | P2 | Owner-only account and payout schedule | E1-US3 |
| E1-US4-UI1 | Staff list | Screen | P2 | Staff with duties and status | E1-US4 |
| E1-US4-UI2 | Add or edit staff | Screen | P2 | Name, employee ID, duty set (take orders, prepare, edit stock) | E1-US4 |
| E1-US4-UI3 | Deactivate staff | Overlay | P2 | What changes; audit history is kept (AC2) | E1-US4 |
| E14-US3-UI1 | Delivery settings | Screen | P2 | Own riders, independent riders, partner fleet; fallback behaviour (AC1, AC2) | E14-US3 |
| E15-US1-UI2 | Tariff settings | Screen | P2 | Base fare and per-kilometre rate, negative-rate validation; routed road distance; defined maps-service fallback flagged for review. | E15-US1 |
| E2-US1-UI1 | Business profile | Screen | P2 | Type, service area, cuisine, dietary tags, preferred transport (bike or car) | E2-US1 |
| E2-US3-UI1 | Operating hours and open/closed | Screen | P2 | Weekly hours, manual close and reopen (AC1, AC2) | E2-US3 |

### Menu

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E2-US2-UI1 | Menu list | Screen | P1 | Items by category, availability toggle, search | E2-US2 |
| E2-US2-UI2 | Add or edit item | Screen | P1 | Name, price, category, photo, description, add-ons; invalid price error (AC2) | E2-US2 |
| E2-US4-UI1 | Customization options | Screen | P2 | Sizes, flavours, text and image fields with price differences, lead time, fragile flag | E2-US4 |
| E2-US2-UI3 | Remove item | Overlay | P3 | Confirm; note for items in customers' carts (AC4) | E2-US2 |

### Capacity

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E5-US1-UI1 | Kitchen capacity setup | Screen | P1 | Orders per hour, per-item prep times, resource limits; zero rejected (AC2) | E5-US1 |
| E5-US1-UI3 | Live utilisation | Screen | P1 | Capacity meter using the configurable 60/85 intake bands, current load, remaining intake, and upcoming slot occupancy (AC6). Full is an intake limit, not physical occupancy. | E5-US1 |
| E5-US2-UI1 | Intake paused | Overlay | P1 | Banner with queue size and Resume (AC3, AC4) | E5-US2 |
| E5-US1-UI2 | Temporary capacity change | Overlay | P2 | New limit, duration, automatic return to default (AC3, AC4) | E5-US1 |
| E6-US2-UI1 | Buffers and overrides | Screen | P2 | Weather and peak buffers in force, vendor override with audit note (AC4) Weather-service failure shows the fallback or last-known-condition state; never invent a weather reason. | E6-US2 |

### Kitchen and Orders

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E7-US1-UI1 | New order alert | Overlay | P1 | Sound, visual alert, tab-title flash (AC1, AC2) | E7-US1 |
| E7-US1-UI2 | Order ticket | Overlay | P1 | Items, custom text, swaps, reference image and prominent allergen exclusions; Accept moves to Preparing and notifies customer (E7-US2 AC1); reject opens reason dialog. | E7-US1, E7-US2 |
| E7-US3-UI1 | Live kitchen board | Screen | P1 | New, Preparing, Ready, Handed Over columns with timers; 80% prepared and Ready actions | E7-US2, E7-US3 |
| E4-US3-UI2 | Custom order review | Screen | P2 | Accept, propose new price or time, or decline with a reason (AC1) | E4-US3 |
| E7-US2-UI1 | Reject order | Overlay | P2 | Reason list; refund flag for prepaid orders (AC2) | E7-US2 |
| E7-US4-UI1 | Voice commands | Overlay | P2 | Heard command, confirmation, "repeat" prompt (AC1, AC2) | E7-US4 |
| E7-US3-UI2 | Order history | Screen | P3 | Searchable list of past orders with status | E7-US3 |

### Recipes and Nutrition (owner only)

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E8-US1-UI2 | Recipe editor | Screen | P1 | Ingredients, quantities, units; blank or invalid unit rejected (AC2) | E8-US1 |
| E8-US2-UI1 | Nutrition and allergen review | Screen | P1 | Calculated values per serving, retry flag when the API is unreachable (E8-US2 AC1, AC2) | E8-US2, E8-US3 |
| E8-US1-UI1 | Recipe list | Screen | P2 | Dishes with recipe status; hidden from staff (AC4) | E8-US1 |
| E8-US4-UI1 | Recipe change impact | Overlay | P2 | Nutrition and BOM will refresh; active orders keep the old recipe (AC1, AC2) Failed recalculation shows a recoverable pending/error state; do not expose inconsistent BOM and nutrition versions. | E8-US4 |

### Inventory and Planning

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E9-US1-UI1 | Stock list | Screen | P1 | Ingredient units, quantity, reorder level, storage type and low-stock highlight; automatic BOM deduction on confirmation and restoration after cancellation before preparation. | E9-US1, E9-US2, E9-US4, E10-US1 |
| E9-US1-UI4 | Dish BOM | Screen | P1 | Ingredients and quantity per serving for one dish (AC3) | E9-US1 |
| E9-US1-UI2 | Add or edit ingredient | Screen | P2 | Name, unit, opening stock, reorder level and perishable/non-perishable type; valid quantity/unit checks; storage type feeds E9-US4 planning. Include expiry date or batch expiry where needed to distinguish usable and expired stock (E9-US4-TC7). | E9-US1, E9-US4 |
| E9-US1-UI3 | Stock intake | Overlay | P2 | Purchase quantity; entry logged with the user's name (AC2) | E9-US1 |
| E9-US2-UI1 | Low-stock alerts | Screen | P2 | Ingredients under reorder level, dishes made unavailable at zero stock (AC3, AC4) | E9-US2 |
| E9-US3-UI1 | Log wastage | Overlay | P2 | Ingredient, quantity, reason; over-stock quantity rejected (AC2) | E9-US3 |
| E9-US3-UI2 | Variance report | Screen | P2 | Expected, actual, variance per ingredient; over-threshold rows highlighted (AC3, AC4) Provide physical stock-count input and configurable variance threshold; show below, equal and above-threshold states. | E9-US3 |
| E9-US4-UI1 | Material requirements planner | Screen | P2 | Look-back period, requirements, current stock and shortfall; perishable needs from confirmed upcoming orders, non-perishable needs from historical sales and stock-holding buffer; insufficient-history state (AC1-AC4). | E9-US4 |
| E9-US1-UI5 | Bulk BOM entry | Screen | P3 | Many dishes at once, shared ingredients not re-entered (AC4) | E9-US1 |
| E9-US2-UI2 | Notification panel | Overlay | P3 | Low stock, new orders, discrepancies, newest first | E9-US2 |

### Invoices, Payments and Finance (owner only except invoices)

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E10-US1-UI3 | Invoice detail | Screen | P1 | Lines, discounts, delivery, total; earlier revisions kept (AC1, AC2); void state (AC6) | E10-US1 |
| E12-US1-UI1 | Finance dashboard | Screen | P1 | Revenue, commission, payouts, expenses with date-range filter (AC3, AC4) | E10-US1, E12-US1 |
| E10-US1-UI2 | Invoice list | Screen | P2 | Invoice number, order, total, payment state, date filter | E10-US1 |
| E10-US2-UI1 | Payments | Screen | P2 | Online and COD payments against invoices; method and reference (AC1, AC2) Show partial, exact and excess-payment outcomes according to the Chapter 2 test; duplicate references must not change totals. | E10-US2 |
| E10-US3-UI2 | Refunds | Screen | P2 | Rejected prepaid orders flagged for refund and their status | E10-US3 |
| E10-US4-UI1 | COD reconciliation | Screen | P2 | Cash collected per rider against COD invoices, unmatched differences (AC1) | E10-US4 |
| E10-US4-UI2 | Flag discrepancy | Overlay | P2 | Note sent to the administrator (AC2) | E10-US4 |
| E12-US1-UI2 | Commission and payouts | Screen | P2 | Deductions per order and payout history | E12-US1 |
| E12-US1-UI3 | Expenses | Screen | P2 | Expense list by category and date | E12-US1 |
| E12-US1-UI4 | Add expense | Overlay | P2 | Category, amount, date (AC1) | E12-US1 |
| E12-US2-UI1 | Net profit and dish margins | Screen | P2 | Revenue minus commission and costs; margin per dish (AC1, AC2) Missing BOM cost shows an unavailable margin rather than fabricated profit; display negative, zero and positive results. | E12-US2 |
| E12-US3-UI1 | Export report | Overlay | P3 | Period and contents; download link (AC1) | E12-US3 |

### Marketing

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E11-US1-UI1 | Offers list | Screen | P2 | Active, scheduled and expired offers and vouchers | E11-US1 |
| E11-US1-UI2 | Create or edit offer | Screen | P2 | Percentage or fixed, code, minimum order, usage limit, schedule; end-before-start error (AC2) | E11-US1 |
| E11-US2-UI1 | Combo builder | Screen | P2 | Choose items, set bundle price, availability follows items (AC1, AC2) | E11-US2 |
| E11-US3-UI1 | Offer performance | Screen | P2 | Uses, discount given and sales per offer; zero values not errors (AC1, AC2) | E11-US3 |

### Feedback, Assistant and Audit

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E18-US2-UI2 | Product feedback | Screen | P2 | Average, count and recent comments per item; date filter (AC3, AC4) | E18-US2 |
| E19-US3-UI2 | Vendor assistant | Overlay | P2 | Docked chat: pending orders, stock, capacity; refuses owner-only data for staff (AC1, AC2) | E19-US3, E19-US4 |
| E21-US2-UI1 | Audit log (owner only) | Screen | P2 | Read-only entries with timestamp, named employee, task and reason; employee/date filters and no-results state; staff access denied; no edit/delete controls. | E6-US2, E21-US1, E21-US2 |
| E22-US2-UI1 | Responsive portal layouts | Layout set | P2 | Dashboard, board and tables on phone, tablet and laptop; PWA standalone launch | E22-US2 |
| E18-US3-UI4 | Report a problem | Screen | P3 | Order, category, description | E18-US3 |

## Admin web portal

React desktop portal, light theme, dense 13 sp tables. Queues come first: verification, complaints, and safety escalations. Audit views never show recipe quantities.

25 designs: 19 screens, 5 overlays, 1 layout sets. Priority: 4 P1, 16 P2, 5 P3.

### Access, Verification and Fleets

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E1-US3-UI8 | Admin sign-in | Screen | P1 | Credentials, lockout message | E1-US3 |
| E14-US4-UI1 | Partner fleets | Screen | P2 | Partners, API connection status, active deliveries | E14-US4 |
| E14-US4-UI2 | Partner details and status log | Screen | P2 | Acknowledgements, status updates and IVR confirmations per delivery (AC1, AC2) | E14-US4, E16-US1 |
| E20-US1-UI5 | Verification queue | Screen | P2 | Vendors, riders and fleet partners awaiting review, oldest first | E20-US1 |
| E20-US1-UI6 | Vendor application review | Screen | P2 | Business details and documents; approve, reject with reason, or request more information (AC1) | E20-US1 |
| E20-US1-UI7 | Rider verification review | Screen | P2 | Documents, vehicle type; approve or reject (AC3, AC4) | E20-US1 |
| E20-US1-UI8 | Decision dialog | Overlay | P2 | Required reason on rejection; message sent to the applicant | E20-US1 |
| E20-US1-UI9 | Fleet partner review | Screen | P3 | Partner details and documents; approve or reject | E20-US1 |

### Rules

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E6-US3-UI1 | Buffer rules | Screen | P1 | Weather and peak rules with period, area and percentage | E6-US3 |
| E6-US3-UI2 | Create or edit buffer rule | Overlay | P1 | Period, affected area, buffer percentage; effect applies within a minute (AC1, AC2) | E6-US3 |
| E20-US2-UI1 | Commission settings | Screen | P2 | Global and per-vendor rate within the 8 to 12 percent range; out-of-range error (AC1, AC2) Include effective date/time and show the rate applicable to new orders; preserve the rate on existing orders. | E20-US2 |
| E19-US4-UI1 | Assistant scope and permissions | Screen | P3 | Role scope and permission information; preview unsupported-action reply directing to complaints and cross-role refusal. Supporting design for guardrails, not a required settings editor. | E19-US4 |

### Users, Complaints and Ratings

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E20-US3-UI1 | Users | Screen | P2 | Search across customers, vendors, riders and staff | E20-US3 |
| E20-US3-UI2 | User detail | Screen | P2 | Profile, status, history, Suspend or Reactivate (AC1, AC2) | E20-US3 |
| E20-US3-UI3 | Suspend user | Overlay | P2 | Consequence (sessions end) and confirm | E20-US3 |
| E20-US3-UI4 | Complaints queue | Screen | P2 | Open tickets by age and parties | E20-US3 |
| E20-US3-UI5 | Complaint detail | Screen | P2 | Order, timeline and parties involved (AC3) | E20-US3 |
| E20-US3-UI6 | Resolve complaint | Overlay | P2 | Outcome text; all parties notified, case closed (AC4) | E20-US3 |
| E18-US2-UI3 | Rating review | Screen | P3 | Mark a low rating as vendor-attributed so it leaves the rider's average (AC2) | E18-US2 |

### Monitoring, Safety and Audit

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E20-US4-UI1 | Live dashboard | Screen | P1 | Active orders, delayed orders, riders online, slot utilisation (AC2) | E20-US4 |
| E16-US1-UI3 | Safety escalations | Screen | P2 | Missed rider check-ins past the provisional 2-minute grace period, with rider and order (AC6). The duration is not a Chapter 2 figure. | E16-US1 |
| E20-US4-UI2 | Reports | Screen | P2 | Orders, revenue, commission, slot utilisation for a date range (AC1) Include report export with private-field exclusion; valid, empty and invalid date-range states. | E20-US4 |
| E21-US3-UI1 | Audit investigation | Screen | P2 | Cross-vendor log for a dispute, recipe quantities hidden (AC1) | E21-US1, E21-US3 |
| E21-US3-UI2 | Export audit log | Overlay | P3 | Range and format; the export is itself logged (AC2) | E21-US3 |
| E22-US2-UI2 | Responsive admin layouts | Layout set | P3 | Queues, tables and dashboard on tablet and laptop | E22-US2 |

## Shared screens and states

Designed once and reused in every app. Offline, sync-conflict, generic error, and web not-found states sit on top of the screen that was open.

4 designs: 2 screens, 2 overlays, 0 layout sets. Priority: 0 P1, 2 P2, 2 P3.

### Shared

| UI ID | Screen | Type | Priority | Required states | Mapped requirements |
| --- | --- | --- | --- | --- | --- |
| E22-US3-UI1 | Offline banner and pending-sync badge | Overlay | P2 | Offline banner; each queued status action marked Pending; ordered sync after reconnection; do not show unsynced actions as confirmed. | E22-US3 |
| E22-US3-UI2 | Sync conflict message | Overlay | P2 | What changed while offline and which version was kept (AC2) | E22-US3 |
| E22-US1-UI2 | Page not found (web) | Screen | P3 | Message and a link back to Home or the dashboard | E22-US1 |
| E22-US3-UI3 | Something went wrong | Screen | P3 | Plain reason, "Try again" button, no technical codes | E22-US3 |

## After each interface

Update the register columns `Design status`, `Implementation status`, `Review status`, `Route / component`, and `Screenshot path` only after a screen exists. Leave `Mapping review` as `Review test-to-screen relevance` until each candidate test is tied to one visible state or marked as a backend, security, or integration check. Do not edit Chapter 2 or the screen-register workbook as part of building a screen. Provisional numbers stay in `config/prototype-assumptions.json`.
