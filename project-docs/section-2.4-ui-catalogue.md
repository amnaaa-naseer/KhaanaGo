# Section 2.4 user interface catalogue

Draft for Chapter 2, Section 2.4. The Word chapter is still empty and is not edited here.
Each page uses the screen-register ID. Descriptions are the register's required states, not new requirements.
The interface follows the KhaanaGo design system: orange for the action, charcoal for text, cream for the page, and capacity shown with an icon, a word, and a colour.

## E22-US3-UI1 Offline banner and pending-sync badge

- App: shared. Priority: P2. Type: Overlay.
- Stories: E22-US3.
- Page: Offline banner; each queued status action marked Pending; ordered sync after reconnection; do not show unsynced actions as confirmed.
- Prototype: Not started.

## E22-US3-UI2 Sync conflict message

- App: shared. Priority: P2. Type: Overlay.
- Stories: E22-US3.
- Page: What changed while offline and which version was kept (AC2)
- Prototype: Not started.

## E22-US3-UI3 Something went wrong

- App: shared. Priority: P3. Type: Screen.
- Stories: E22-US3.
- Page: Plain reason, "Try again" button, no technical codes
- Prototype: Not started.

## E22-US1-UI2 Page not found (web)

- App: shared. Priority: P3. Type: Screen.
- Stories: E22-US1.
- Page: Message and a link back to Home or the dashboard
- Prototype: Not started.

## E1-US1-UI6 App launch

- App: customer. Priority: P3. Type: Screen.
- Stories: E1-US1.
- Page: Logo and loading; goes to Home if signed in, otherwise Login
- Prototype: Not started.

## E1-US1-UI1 Registration

- App: customer. Priority: P2. Type: Screen.
- Stories: E1-US1.
- Page: Name, mobile, email, password strength rules; duplicate email/number, invalid inputs and minimum-password boundary states (E1-US1).
- Prototype: Not started.

## E1-US1-UI2 Verification code

- App: customer. Priority: P2. Type: Screen.
- Stories: E1-US1.
- Page: Verification input and resend; wrong, expired and reused code states; no session before successful verification.
- Prototype: Not started.

## E1-US1-UI3 Login

- App: customer. Priority: P1. Type: Screen.
- Stories: E1-US1.
- Page: Mobile or email, password, "Forgot password?"; session-expired message (AC4)
- Prototype: Implemented, mock data.

## E1-US1-UI4 Reset password: request

- App: customer. Priority: P2. Type: Screen.
- Stories: E1-US1.
- Page: Registered email or mobile; confirmation that a code was sent (AC3)
- Prototype: Not started.

## E1-US1-UI5 Reset password: code and new password

- App: customer. Priority: P2. Type: Screen.
- Stories: E1-US1.
- Page: Code, new password, rules checklist, success state
- Prototype: Not started.

## E1-US5-UI6 Location permission

- App: customer. Priority: P3. Type: Overlay.
- Stories: E1-US5.
- Page: Why the app needs location, then the system prompt
- Prototype: Not started.

## E17-US1-UI3 Notification permission

- App: customer. Priority: P3. Type: Overlay.
- Stories: E17-US1.
- Page: Why order updates matter, then the system prompt
- Prototype: Not started.

## E1-US5-UI1 Profile

- App: customer. Priority: P2. Type: Screen.
- Stories: E1-US5.
- Page: Name, mobile, email; links to addresses, orders, sign out
- Prototype: Not started.

## E1-US5-UI4 Edit profile

- App: customer. Priority: P2. Type: Screen.
- Stories: E1-US5.
- Page: Editable name and mobile; change applies to notifications (AC2)
- Prototype: Not started.

## E1-US5-UI2 Saved addresses

- App: customer. Priority: P2. Type: Screen.
- Stories: E1-US5.
- Page: Address cards with default marker, edit, delete, add (AC1)
- Prototype: Not started.

## E1-US5-UI3 Add or edit address

- App: customer. Priority: P2. Type: Screen.
- Stories: E1-US5.
- Page: Map with draggable pin, search, current location, label, address line
- Prototype: Not started.

## E1-US5-UI5 Delete address confirmation

- App: customer. Priority: P3. Type: Overlay.
- Stories: E1-US5.
- Page: Which address, "Delete" and "Keep"
- Prototype: Not started.

## E3-US1-UI1 Home

- App: customer. Priority: P1. Type: Screen.
- Stories: E2-US3, E3-US1, E17-US3.
- Page: Address selector, search, filter chips, top-rated row, vendor cards with open and capacity state
- Prototype: Implemented, mock data.

## E3-US1-UI4 Search results

- App: customer. Priority: P2. Type: Screen.
- Stories: E3-US1.
- Page: Results for typed search and filters; "no match" state with suggestions (AC2)
- Prototype: Not started.

## E3-US1-UI5 Filter sheet

- App: customer. Priority: P2. Type: Overlay.
- Stories: E3-US1.
- Page: Cuisine, dietary tags, open now; "Show N restaurants"
- Prototype: Not started.

## E3-US1-UI2 Vendor menu

- App: customer. Priority: P1. Type: Screen.
- Stories: E2-US2, E3-US1.
- Page: Hours and status, categories, item rows with nutrition badge, unavailable items greyed (AC4), cart bar
- Prototype: Implemented, mock data.

## E3-US1-UI6 Vendor info and reviews

- App: customer. Priority: P3. Type: Screen.
- Stories: E3-US1.
- Page: Address, hours, rating summary, recent reviews
- Prototype: Not started.

## E3-US1-UI3 Item detail

- App: customer. Priority: P1. Type: Screen.
- Stories: E3-US1, E8-US2, E8-US3.
- Page: Price, add-ons, nutrition badge, allergen warning, "Customize" or "Add to cart" (AC3)
- Prototype: Implemented, mock data.

## E4-US1-UI1 Customization builder

- App: customer. Priority: P1. Type: Screen.
- Stories: E2-US4, E4-US1.
- Page: Size, flavour, add-ons, custom text, exclusions and swaps; live price and prep time
- Prototype: Implemented, mock data.

## E4-US2-UI1 Reference image and instructions

- App: customer. Priority: P2. Type: Overlay.
- Stories: E4-US2.
- Page: Camera or gallery, thumbnail, instructions with counter, upload errors
- Prototype: Not started.

## E4-US3-UI1 Revised quote approval

- App: customer. Priority: P2. Type: Screen.
- Stories: E4-US3.
- Page: Original and revised price and lead time, vendor note, Approve or Cancel (AC2); decline reason
- Prototype: Not started.

## E3-US2-UI1 Cart

- App: customer. Priority: P1. Type: Screen.
- Stories: E2-US2, E3-US2, E9-US2.
- Page: Items, quantities, remove and subtotal; empty cart and invalid quantity states; revalidate unavailable items before checkout.
- Prototype: Implemented, mock data.

## E3-US2-UI3 Different-restaurant dialog

- App: customer. Priority: P2. Type: Overlay.
- Stories: E3-US2.
- Page: "Keep current cart" or "Start new cart" (AC2)
- Prototype: Not started.

## E14-US2-UI1 Delivery type

- App: customer. Priority: P1. Type: Screen.
- Stories: E2-US4, E4-US3, E14-US2.
- Page: Pooled discount and added time versus Express prices; fragile cake or spillable items excluded; Express never pooled; eligible options return when fragile items are removed.
- Prototype: Implemented, mock data.

## E5-US3-UI1 Slot selector

- App: customer. Priority: P1. Type: Screen.
- Stories: E5-US2, E5-US3, E6-US1, E6-US2.
- Page: Today and upcoming slots, Available/Limited/Full, realistic arrival window and weather note; no immediate order at full capacity; refreshed availability after cancellation.
- Prototype: Implemented, mock data.

## E5-US4-UI1 Slot taken dialog

- App: customer. Priority: P1. Type: Overlay.
- Stories: E5-US4.
- Page: "That slot was just taken" with nearest free windows (AC1)
- Prototype: Implemented, mock data.

## E5-US4-UI2 Slot released dialog

- App: customer. Priority: P2. Type: Overlay.
- Stories: E5-US4.
- Page: Hold expired, back to the selector (AC2)
- Prototype: Not started.

## E3-US3-UI1 Payment method

- App: customer. Priority: P1. Type: Screen.
- Stories: E3-US3.
- Page: Cash on delivery, JazzCash, Easypaisa, card
- Prototype: Implemented, mock data.

## E3-US3-UI2 Payment gateway handoff

- App: customer. Priority: P2. Type: Screen.
- Stories: E3-US3.
- Page: Loading and return states around the gateway's own page
- Prototype: Not started.

## E3-US4-UI1 Voucher and offers sheet

- App: customer. Priority: P2. Type: Overlay.
- Stories: E3-US4.
- Page: Code field, auto-applied offers, rejection reason (AC2)
- Prototype: Not started.

## E3-US2-UI2 Review order

- App: customer. Priority: P1. Type: Screen.
- Stories: E2-US3, E3-US2.
- Page: Address, held slot and countdown, delivery and payment; separate food, base fare, road-distance charge, surcharges, discount and total; prevent duplicate submission.
- Prototype: Implemented, mock data.

## E10-US3-UI1 Payment failed

- App: customer. Priority: P2. Type: Screen.
- Stories: E10-US3.
- Page: "Order not placed", Try again, Choose another method
- Prototype: Not started.

## E3-US4-UI2 Order placed

- App: customer. Priority: P1. Type: Screen.
- Stories: E3-US4.
- Page: Order number, slot, estimate, "Track order"
- Prototype: Implemented, mock data.

## E17-US1-UI1 Live tracking

- App: customer. Priority: P1. Type: Screen.
- Stories: E6-US1, E14-US2, E17-US1.
- Page: Preparation stage/ready time or live rider map, current arrival window, timeline, pooled sequence, delivery code and refund status; replace stale ETA and retain in-app updates when notifications are disabled.
- Prototype: Implemented, mock data.

## E6-US4-UI1 Delay explanation

- App: customer. Priority: P1. Type: Overlay.
- Stories: E6-US4.
- Page: Banner and push with the reason, naming the weather (AC1, AC2)
- Prototype: Implemented, mock data.

## E16-US4-UI1 Confirm corrected drop-off pin

- App: customer. Priority: P2. Type: Overlay.
- Stories: E16-US4.
- Page: Map with the rider's proposed pin; confirm or adjust
- Prototype: Not started.

## E10-US1-UI1 Cancel order

- App: customer. Priority: P3. Type: Overlay.
- Stories: E9-US2, E10-US1.
- Page: Reason, what is refunded, confirm (before preparation only)
- Prototype: Not started.

## E17-US1-UI2 Notification centre

- App: customer. Priority: P2. Type: Screen.
- Stories: E17-US1.
- Page: Updates grouped by order, newest first (AC6)
- Prototype: Not started.

## E17-US2-UI1 Order history

- App: customer. Priority: P2. Type: Screen.
- Stories: E17-US2.
- Page: Orders newest first; empty state (AC2)
- Prototype: Not started.

## E17-US2-UI2 Order detail and invoice

- App: customer. Priority: P2. Type: Screen.
- Stories: E10-US1, E17-US2.
- Page: Items and options, bill, payment status, Download invoice, Reorder, Rate, Report a problem
- Prototype: Not started.

## E17-US2-UI3 Reorder summary

- App: customer. Priority: P2. Type: Overlay.
- Stories: E17-US2.
- Page: Reorder with original options and current prices; available items added, unavailable items skipped with explanation (E17-US2 AC3, AC4).
- Prototype: Not started.

## E18-US1-UI1 Rating

- App: customer. Priority: P2. Type: Screen.
- Stories: E18-US1.
- Page: Restaurant, item and rider ratings kept separate
- Prototype: Not started.

## E18-US3-UI1 Complaint form

- App: customer. Priority: P2. Type: Screen.
- Stories: E18-US3.
- Page: Order read-only, category, description Include optional attachment upload with configured type/size limits; reject unsupported or oversized files and duplicate submission.
- Prototype: Not started.

## E18-US3-UI2 Complaint status

- App: customer. Priority: P3. Type: Screen.
- Stories: E18-US3.
- Page: Ticket reference, progress, outcome when resolved
- Prototype: Not started.

## E19-US1-UI1 Assistant chat

- App: customer. Priority: P2. Type: Screen.
- Stories: E19-US1, E19-US4.
- Page: Text/mic input, results respecting exclusions, no-match alternatives, current order ETA or no-active-order reply; unsupported and cross-role requests refused (E19-US4).
- Prototype: Not started.

## E19-US2-UI1 Voice order

- App: customer. Priority: P2. Type: Screen.
- Stories: E19-US2.
- Page: Live transcript, read-back card, Confirm and Cancel Ambiguous or low-confidence speech asks for clarification; no checkout until explicit confirmation.
- Prototype: Not started.

## E22-US1-UI1 Responsive web layouts

- App: customer. Priority: P2. Type: Layout set.
- Stories: E22-US1.
- Page: Home, Menu with cart panel and Checkout at 360, 768 and 1280 px Include graceful unsupported-device guidance and breakpoint boundary layouts; verify rider Android/iOS layouts as well as customer web.
- Prototype: Not started.

## E1-US2-UI1 App launch

- App: rider. Priority: P3. Type: Screen.
- Stories: E1-US2.
- Page: Logo and loading
- Prototype: Not started.

## E1-US2-UI2 Sign in

- App: rider. Priority: P1. Type: Screen.
- Stories: E1-US2, E22-US1.
- Page: Mobile and password, "Forgot password?"
- Prototype: Implemented, mock data.

## E1-US2-UI3 Registration 1: personal details

- App: rider. Priority: P2. Type: Screen.
- Stories: E1-US2.
- Page: Name, CNIC, phone, password
- Prototype: Not started.

## E1-US2-UI4 Registration 2: vehicle and phone

- App: rider. Priority: P2. Type: Screen.
- Stories: E1-US2.
- Page: Motorbike, car or van; phone operating system
- Prototype: Not started.

## E1-US2-UI5 Registration 3: documents

- App: rider. Priority: P2. Type: Screen.
- Stories: E1-US2.
- Page: Licence and CNIC upload, field errors for missing items (TC3)
- Prototype: Not started.

## E1-US2-UI6 Pending verification

- App: rider. Priority: P2. Type: Screen.
- Stories: E1-US2.
- Page: "Under review"; cannot go online until approved (AC1)
- Prototype: Not started.

## E1-US2-UI7 Application rejected or more information needed

- App: rider. Priority: P2. Type: Screen.
- Stories: E1-US2.
- Page: Reason and what to resubmit (E20-US1 AC3, AC4)
- Prototype: Not started.

## E1-US2-UI8 Verification code

- App: rider. Priority: P3. Type: Screen.
- Stories: E1-US2.
- Page: Code entry and resend
- Prototype: Not started.

## E1-US2-UI9 Reset password

- App: rider. Priority: P3. Type: Screen.
- Stories: E1-US2.
- Page: Request, then code and new password, same pattern as the customer app
- Prototype: Not started.

## E13-US2-UI1 Location permission

- App: rider. Priority: P2. Type: Overlay.
- Stories: E13-US2, E13-US5.
- Page: Why location is needed while online, then the system prompt
- Prototype: Not started.

## E13-US1-UI4 Notification and sound permission

- App: rider. Priority: P3. Type: Overlay.
- Stories: E13-US1.
- Page: Why alerts matter for pickups
- Prototype: Not started.

## E13-US2-UI2 Home: offline and online

- App: rider. Priority: P1. Type: Screen.
- Stories: E13-US2, E22-US1.
- Page: Online toggle, vehicle type, today's deliveries and earnings (E1-US2 AC2)
- Prototype: Implemented, mock data.

## E13-US2-UI3 Outside service area

- App: rider. Priority: P2. Type: Overlay.
- Stories: E13-US2.
- Page: Why no offers arrive and where to go (AC3)
- Prototype: Not started.

## E13-US2-UI4 Delivery offer

- App: rider. Priority: P1. Type: Screen.
- Stories: E13-US2.
- Page: Vendor, drop-off area, distance, pay, countdown, Accept and Decline (AC1)
- Prototype: Implemented, mock data.

## E14-US1-UI1 Pooled trip offer

- App: rider. Priority: P2. Type: Screen.
- Stories: E14-US1.
- Page: Two pickups/drop-offs, maximum two orders and combined pay; eligibility distances/corridor and hold limit; exclude fragile and spillable items; no third order.
- Prototype: Not started.

## E13-US2-UI5 Offer expired

- App: rider. Priority: P2. Type: Overlay.
- Stories: E13-US2.
- Page: Offer passed to another rider (AC2)
- Prototype: Not started.

## E13-US1-UI1 Head to pickup

- App: rider. Priority: P1. Type: Screen.
- Stories: E13-US1, E13-US5.
- Page: Pickup route, vendor and preparation progress; dispatch only after 80% or Ready signal; nearest suitable rider assignment; no early assignment.
- Prototype: Implemented, mock data.

## E13-US1-UI2 Order ready alert

- App: rider. Priority: P1. Type: Overlay.
- Stories: E13-US1, E16-US1.
- Page: Full-screen alert with sound, vibration and text (AC3)
- Prototype: Implemented, mock data.

## E13-US4-UI1 At the store

- App: rider. Priority: P1. Type: Screen.
- Stories: E13-US4, E15-US2.
- Page: Arrival timestamp, waiting timer and configured threshold; fee only for excess minutes at pickup, zero below or exactly at threshold.
- Prototype: Implemented, mock data.

## E13-US1-UI3 Pickup handover

- App: rider. Priority: P1. Type: Screen.
- Stories: E13-US1, E16-US2.
- Page: Order number and items to check, hold to confirm "Picked up"
- Prototype: Implemented, mock data.

## E14-US2-UI2 Pooled parcels and labels

- App: rider. Priority: P2. Type: Screen.
- Stories: E14-US2.
- Page: Each parcel's label to match at drop-off, stop order (AC4)
- Prototype: Not started.

## E14-US1-UI2 Second pickup hold

- App: rider. Priority: P2. Type: Overlay.
- Stories: E14-US1.
- Page: Countdown, then "Order uncoupled, continue with the first" (AC3, AC4)
- Prototype: Not started.

## E13-US3-UI1 Head to drop-off

- App: rider. Priority: P1. Type: Screen.
- Stories: E13-US3, E13-US5, E22-US1.
- Page: Route, customer area, call and quick messages
- Prototype: Implemented, mock data.

## E13-US3-UI2 Delivery code entry

- App: rider. Priority: P1. Type: Screen.
- Stories: E13-US3, E16-US2.
- Page: Customer delivery-code entry; wrong code leaves delivery incomplete with Retry and Contact support; hold-to-confirm for critical transitions. Code format follows configured verification rules.
- Prototype: Implemented, mock data.

## E13-US3-UI3 Out-of-sequence prompt

- App: rider. Priority: P2. Type: Overlay.
- Stories: E13-US3.
- Page: Why the tap was blocked and what to do next (AC2)
- Prototype: Not started.

## E10-US2-UI2 Collect cash

- App: rider. Priority: P2. Type: Screen.
- Stories: E10-US2.
- Page: Amount due, confirm cash collected (COD, AC2)
- Prototype: Not started.

## E13-US3-UI4 Delivered

- App: rider. Priority: P1. Type: Screen.
- Stories: E13-US3, E15-US2.
- Page: Earnings for this delivery: base, distance, waiting, surcharge
- Prototype: Implemented, mock data.

## E16-US4-UI2 Quick messages

- App: rider. Priority: P2. Type: Overlay.
- Stories: E16-US4.
- Page: Preset messages for arrival and delay, one tap or voice (AC1)
- Prototype: Not started.

## E16-US4-UI3 Request corrected pin

- App: rider. Priority: P2. Type: Overlay.
- Stories: E16-US4.
- Page: Ask the customer to confirm a new pin (AC2)
- Prototype: Not started.

## E16-US1-UI1 Voice check-in

- App: rider. Priority: P2. Type: Overlay.
- Stories: E16-US1.
- Page: "Confirm arrival at customer", say "Confirm" or press the headset button; repeats once (AC1, AC2)
- Prototype: Not started.

## E19-US3-UI1 Rider voice assistant

- App: rider. Priority: P2. Type: Overlay.
- Stories: E19-US3, E19-US4.
- Page: Next pickup, readiness, spoken answer shown as text
- Prototype: Not started.

## E18-US3-UI3 Report a problem

- App: rider. Priority: P2. Type: Screen.
- Stories: E18-US3.
- Page: Order, category, description
- Prototype: Not started.

## E13-US2-UI6 Shift summary

- App: rider. Priority: P2. Type: Screen.
- Stories: E13-US2.
- Page: Deliveries, distance, waiting time, earnings (AC4)
- Prototype: Not started.

## E15-US3-UI1 Shift earnings invoice

- App: rider. Priority: P2. Type: Screen.
- Stories: E15-US2, E15-US3.
- Page: Per delivery: base fee, per-km, waiting fee, surcharges, total (AC1)
- Prototype: Not started.

## E15-US3-UI2 Delivery earnings detail

- App: rider. Priority: P2. Type: Screen.
- Stories: E15-US2, E15-US3.
- Page: One delivery; pooled orders shown separately (AC2)
- Prototype: Not started.

## E1-US2-UI10 Delivery history

- App: rider. Priority: P2. Type: Screen.
- Stories: E1-US2.
- Page: Past deliveries, newest first
- Prototype: Not started.

## E18-US2-UI1 My ratings

- App: rider. Priority: P2. Type: Screen.
- Stories: E18-US2.
- Page: Average and recent comments (AC1)
- Prototype: Not started.

## E1-US2-UI11 Rider profile

- App: rider. Priority: P2. Type: Screen.
- Stories: E1-US2.
- Page: Details, vehicle type, document status
- Prototype: Not started.

## E1-US2-UI12 Settings

- App: rider. Priority: P3. Type: Screen.
- Stories: E1-US2.
- Page: List of the settings below, sign out
- Prototype: Not started.

## E13-US5-UI1 Navigation preference

- App: rider. Priority: P2. Type: Screen.
- Stories: E13-US5.
- Page: Open external maps, or use the in-app map (AC1, AC2) Location-permission withdrawal shows a recovery prompt; invalid route coordinates do not launch navigation.
- Prototype: Not started.

## E16-US2-UI1 Display and alerts

- App: rider. Priority: P2. Type: Screen.
- Stories: E16-US1, E16-US2.
- Page: High-contrast mode, audio mute with vibration fallback (E16-US1 AC4)
- Prototype: Not started.

## E16-US3-UI1 Data saver

- App: rider. Priority: P3. Type: Screen.
- Stories: E16-US3.
- Page: Low-data display, lighter map and GPS disconnected/recovering states; resume tracking without losing the trip when GPS returns.
- Prototype: Not started.

## E15-US1-UI1 Tariff settings

- App: rider. Priority: P2. Type: Screen.
- Stories: E15-US1.
- Page: Base fare and per-kilometre rate, negative-rate validation; routed road distance; defined maps-service fallback flagged for review.
- Prototype: Not started.

## E20-US1-UI1 Vendor application 1: business details

- App: portal. Priority: P2. Type: Screen.
- Stories: E20-US1.
- Page: Business name, type (restaurant, cloud kitchen, home baker), contact, area
- Prototype: Not started.

## E20-US1-UI2 Vendor application 2: documents

- App: portal. Priority: P2. Type: Screen.
- Stories: E20-US1.
- Page: Required document uploads with format and size rules
- Prototype: Not started.

## E20-US1-UI3 Vendor application 3: bank details

- App: portal. Priority: P2. Type: Screen.
- Stories: E20-US1.
- Page: Payout account entry, review and submit
- Prototype: Not started.

## E20-US1-UI4 Application status

- App: portal. Priority: P2. Type: Screen.
- Stories: E20-US1.
- Page: Pending, more information needed, rejected with reason, approved
- Prototype: Not started.

## E1-US3-UI1 Vendor sign-in

- App: portal. Priority: P1. Type: Screen.
- Stories: E1-US3.
- Page: Credentials; routes owner and staff to their own dashboards (AC1)
- Prototype: Implemented, mock data.

## E1-US3-UI2 Account locked

- App: portal. Priority: P2. Type: Screen.
- Stories: E1-US3.
- Page: Locked after five failed attempts; owner informed (AC2)
- Prototype: Not started.

## E1-US3-UI4 Reset password

- App: portal. Priority: P3. Type: Screen.
- Stories: E1-US3.
- Page: Request, then code and new password
- Prototype: Not started.

## E1-US3-UI3 No access

- App: portal. Priority: P2. Type: Screen.
- Stories: E1-US3.
- Page: "You do not have access to this page", back to dashboard (AC3)
- Prototype: Not started.

## E1-US3-UI5 Owner dashboard

- App: portal. Priority: P1. Type: Screen.
- Stories: E1-US3.
- Page: Today's orders and revenue, capacity now, low-stock count, pending custom orders
- Prototype: Implemented, mock data.

## E1-US3-UI6 Staff home

- App: portal. Priority: P2. Type: Screen.
- Stories: E1-US3.
- Page: Kitchen-operation view only: board link and duties assigned
- Prototype: Not started.

## E1-US4-UI1 Staff list

- App: portal. Priority: P2. Type: Screen.
- Stories: E1-US4.
- Page: Staff with duties and status
- Prototype: Not started.

## E1-US4-UI2 Add or edit staff

- App: portal. Priority: P2. Type: Screen.
- Stories: E1-US4.
- Page: Name, employee ID, duty set (take orders, prepare, edit stock)
- Prototype: Not started.

## E1-US4-UI3 Deactivate staff

- App: portal. Priority: P2. Type: Overlay.
- Stories: E1-US4.
- Page: What changes; audit history is kept (AC2)
- Prototype: Not started.

## E2-US1-UI1 Business profile

- App: portal. Priority: P2. Type: Screen.
- Stories: E2-US1.
- Page: Type, service area, cuisine, dietary tags, preferred transport (bike or car)
- Prototype: Not started.

## E2-US3-UI1 Operating hours and open/closed

- App: portal. Priority: P2. Type: Screen.
- Stories: E2-US3.
- Page: Weekly hours, manual close and reopen (AC1, AC2)
- Prototype: Not started.

## E14-US3-UI1 Delivery settings

- App: portal. Priority: P2. Type: Screen.
- Stories: E14-US3.
- Page: Own riders, independent riders, partner fleet; fallback behaviour (AC1, AC2)
- Prototype: Not started.

## E15-US1-UI2 Tariff settings

- App: portal. Priority: P2. Type: Screen.
- Stories: E15-US1.
- Page: Base fare and per-kilometre rate, negative-rate validation; routed road distance; defined maps-service fallback flagged for review.
- Prototype: Not started.

## E1-US3-UI7 Bank details and payout account

- App: portal. Priority: P2. Type: Screen.
- Stories: E1-US3.
- Page: Owner-only account and payout schedule
- Prototype: Not started.

## E2-US2-UI1 Menu list

- App: portal. Priority: P1. Type: Screen.
- Stories: E2-US2.
- Page: Items by category, availability toggle, search
- Prototype: Implemented, mock data.

## E2-US2-UI2 Add or edit item

- App: portal. Priority: P1. Type: Screen.
- Stories: E2-US2.
- Page: Name, price, category, photo, description, add-ons; invalid price error (AC2)
- Prototype: Implemented, mock data.

## E2-US2-UI3 Remove item

- App: portal. Priority: P3. Type: Overlay.
- Stories: E2-US2.
- Page: Confirm; note for items in customers' carts (AC4)
- Prototype: Not started.

## E2-US4-UI1 Customization options

- App: portal. Priority: P2. Type: Screen.
- Stories: E2-US4.
- Page: Sizes, flavours, text and image fields with price differences, lead time, fragile flag
- Prototype: Not started.

## E5-US1-UI1 Kitchen capacity setup

- App: portal. Priority: P1. Type: Screen.
- Stories: E5-US1.
- Page: Orders per hour, per-item prep times, resource limits; zero rejected (AC2)
- Prototype: Implemented, mock data.

## E5-US1-UI2 Temporary capacity change

- App: portal. Priority: P2. Type: Overlay.
- Stories: E5-US1.
- Page: New limit, duration, automatic return to default (AC3, AC4)
- Prototype: Not started.

## E5-US1-UI3 Live utilisation

- App: portal. Priority: P1. Type: Screen.
- Stories: E5-US1.
- Page: Capacity meter, current load, remaining capacity, upcoming slot occupancy (AC6)
- Prototype: Implemented, mock data.

## E5-US2-UI1 Intake paused

- App: portal. Priority: P1. Type: Overlay.
- Stories: E5-US2.
- Page: Banner with queue size and Resume (AC3, AC4)
- Prototype: Implemented, mock data.

## E6-US2-UI1 Buffers and overrides

- App: portal. Priority: P2. Type: Screen.
- Stories: E6-US2.
- Page: Weather and peak buffers in force, vendor override with audit note (AC4) Weather-service failure shows the fallback or last-known-condition state; never invent a weather reason.
- Prototype: Not started.

## E7-US1-UI1 New order alert

- App: portal. Priority: P1. Type: Overlay.
- Stories: E7-US1.
- Page: Sound, visual alert, tab-title flash (AC1, AC2)
- Prototype: Implemented, mock data.

## E7-US1-UI2 Order ticket

- App: portal. Priority: P1. Type: Overlay.
- Stories: E7-US1, E7-US2.
- Page: Items, custom text, swaps, reference image and prominent allergen exclusions; Accept moves to Preparing and notifies customer (E7-US2 AC1); reject opens reason dialog.
- Prototype: Implemented, mock data.

## E7-US2-UI1 Reject order

- App: portal. Priority: P2. Type: Overlay.
- Stories: E7-US2.
- Page: Reason list; refund flag for prepaid orders (AC2)
- Prototype: Not started.

## E7-US3-UI1 Live kitchen board

- App: portal. Priority: P1. Type: Screen.
- Stories: E7-US2, E7-US3.
- Page: New, Preparing, Ready, Handed Over columns with timers; 80% prepared and Ready actions
- Prototype: Implemented, mock data.

## E7-US3-UI2 Order history

- App: portal. Priority: P3. Type: Screen.
- Stories: E7-US3.
- Page: Searchable list of past orders with status
- Prototype: Not started.

## E7-US4-UI1 Voice commands

- App: portal. Priority: P2. Type: Overlay.
- Stories: E7-US4.
- Page: Heard command, confirmation, "repeat" prompt (AC1, AC2)
- Prototype: Not started.

## E4-US3-UI2 Custom order review

- App: portal. Priority: P2. Type: Screen.
- Stories: E4-US3.
- Page: Accept, propose new price or time, or decline with a reason (AC1)
- Prototype: Not started.

## E8-US1-UI1 Recipe list

- App: portal. Priority: P2. Type: Screen.
- Stories: E8-US1.
- Page: Dishes with recipe status; hidden from staff (AC4)
- Prototype: Not started.

## E8-US1-UI2 Recipe editor

- App: portal. Priority: P1. Type: Screen.
- Stories: E8-US1.
- Page: Ingredients, quantities, units; blank or invalid unit rejected (AC2)
- Prototype: Implemented, mock data.

## E8-US2-UI1 Nutrition and allergen review

- App: portal. Priority: P1. Type: Screen.
- Stories: E8-US2, E8-US3.
- Page: Calculated values per serving, retry flag when the API is unreachable (E8-US2 AC1, AC2)
- Prototype: Implemented, mock data.

## E8-US4-UI1 Recipe change impact

- App: portal. Priority: P2. Type: Overlay.
- Stories: E8-US4.
- Page: Nutrition and BOM will refresh; active orders keep the old recipe (AC1, AC2) Failed recalculation shows a recoverable pending/error state; do not expose inconsistent BOM and nutrition versions.
- Prototype: Not started.

## E9-US1-UI1 Stock list

- App: portal. Priority: P1. Type: Screen.
- Stories: E9-US1, E9-US2, E9-US4, E10-US1.
- Page: Ingredient units, quantity, reorder level, storage type and low-stock highlight; automatic BOM deduction on confirmation and restoration after cancellation before preparation.
- Prototype: Implemented, mock data.

## E9-US1-UI2 Add or edit ingredient

- App: portal. Priority: P2. Type: Screen.
- Stories: E9-US1, E9-US4.
- Page: Name, unit, opening stock, reorder level and perishable/non-perishable type; valid quantity/unit checks; storage type feeds E9-US4 planning. Include expiry date or batch expiry where needed to distinguish usable and expired stock (E9-US4-TC7).
- Prototype: Not started.

## E9-US1-UI3 Stock intake

- App: portal. Priority: P2. Type: Overlay.
- Stories: E9-US1.
- Page: Purchase quantity; entry logged with the user's name (AC2)
- Prototype: Not started.

## E9-US1-UI4 Dish BOM

- App: portal. Priority: P1. Type: Screen.
- Stories: E9-US1.
- Page: Ingredients and quantity per serving for one dish (AC3)
- Prototype: Implemented, mock data.

## E9-US1-UI5 Bulk BOM entry

- App: portal. Priority: P3. Type: Screen.
- Stories: E9-US1.
- Page: Many dishes at once, shared ingredients not re-entered (AC4)
- Prototype: Not started.

## E9-US2-UI1 Low-stock alerts

- App: portal. Priority: P2. Type: Screen.
- Stories: E9-US2.
- Page: Ingredients under reorder level, dishes made unavailable at zero stock (AC3, AC4)
- Prototype: Not started.

## E9-US2-UI2 Notification panel

- App: portal. Priority: P3. Type: Overlay.
- Stories: E9-US2.
- Page: Low stock, new orders, discrepancies, newest first
- Prototype: Not started.

## E9-US3-UI1 Log wastage

- App: portal. Priority: P2. Type: Overlay.
- Stories: E9-US3.
- Page: Ingredient, quantity, reason; over-stock quantity rejected (AC2)
- Prototype: Not started.

## E9-US3-UI2 Variance report

- App: portal. Priority: P2. Type: Screen.
- Stories: E9-US3.
- Page: Expected, actual, variance per ingredient; over-threshold rows highlighted (AC3, AC4) Provide physical stock-count input and configurable variance threshold; show below, equal and above-threshold states.
- Prototype: Not started.

## E9-US4-UI1 Material requirements planner

- App: portal. Priority: P2. Type: Screen.
- Stories: E9-US4.
- Page: Look-back period, requirements, current stock and shortfall; perishable needs from confirmed upcoming orders, non-perishable needs from historical sales and stock-holding buffer; insufficient-history state (AC1-AC4).
- Prototype: Not started.

## E10-US1-UI2 Invoice list

- App: portal. Priority: P2. Type: Screen.
- Stories: E10-US1.
- Page: Invoice number, order, total, payment state, date filter
- Prototype: Not started.

## E10-US1-UI3 Invoice detail

- App: portal. Priority: P1. Type: Screen.
- Stories: E10-US1.
- Page: Lines, discounts, delivery, total; earlier revisions kept (AC1, AC2); void state (AC6)
- Prototype: Implemented, mock data.

## E10-US2-UI1 Payments

- App: portal. Priority: P2. Type: Screen.
- Stories: E10-US2.
- Page: Online and COD payments against invoices; method and reference (AC1, AC2) Show partial, exact and excess-payment outcomes according to the Chapter 2 test; duplicate references must not change totals.
- Prototype: Not started.

## E10-US3-UI2 Refunds

- App: portal. Priority: P2. Type: Screen.
- Stories: E10-US3.
- Page: Rejected prepaid orders flagged for refund and their status
- Prototype: Not started.

## E10-US4-UI1 COD reconciliation

- App: portal. Priority: P2. Type: Screen.
- Stories: E10-US4.
- Page: Cash collected per rider against COD invoices, unmatched differences (AC1)
- Prototype: Not started.

## E10-US4-UI2 Flag discrepancy

- App: portal. Priority: P2. Type: Overlay.
- Stories: E10-US4.
- Page: Note sent to the administrator (AC2)
- Prototype: Not started.

## E12-US1-UI1 Finance dashboard

- App: portal. Priority: P1. Type: Screen.
- Stories: E10-US1, E12-US1.
- Page: Revenue, commission, payouts, expenses with date-range filter (AC3, AC4)
- Prototype: Implemented, mock data.

## E12-US1-UI2 Commission and payouts

- App: portal. Priority: P2. Type: Screen.
- Stories: E12-US1.
- Page: Deductions per order and payout history
- Prototype: Not started.

## E12-US1-UI3 Expenses

- App: portal. Priority: P2. Type: Screen.
- Stories: E12-US1.
- Page: Expense list by category and date
- Prototype: Not started.

## E12-US1-UI4 Add expense

- App: portal. Priority: P2. Type: Overlay.
- Stories: E12-US1.
- Page: Category, amount, date (AC1)
- Prototype: Not started.

## E12-US2-UI1 Net profit and dish margins

- App: portal. Priority: P2. Type: Screen.
- Stories: E12-US2.
- Page: Revenue minus commission and costs; margin per dish (AC1, AC2) Missing BOM cost shows an unavailable margin rather than fabricated profit; display negative, zero and positive results.
- Prototype: Not started.

## E12-US3-UI1 Export report

- App: portal. Priority: P3. Type: Overlay.
- Stories: E12-US3.
- Page: Period and contents; download link (AC1)
- Prototype: Not started.

## E11-US1-UI1 Offers list

- App: portal. Priority: P2. Type: Screen.
- Stories: E11-US1.
- Page: Active, scheduled and expired offers and vouchers
- Prototype: Not started.

## E11-US1-UI2 Create or edit offer

- App: portal. Priority: P2. Type: Screen.
- Stories: E11-US1.
- Page: Percentage or fixed, code, minimum order, usage limit, schedule; end-before-start error (AC2)
- Prototype: Not started.

## E11-US2-UI1 Combo builder

- App: portal. Priority: P2. Type: Screen.
- Stories: E11-US2.
- Page: Choose items, set bundle price, availability follows items (AC1, AC2)
- Prototype: Not started.

## E11-US3-UI1 Offer performance

- App: portal. Priority: P2. Type: Screen.
- Stories: E11-US3.
- Page: Uses, discount given and sales per offer; zero values not errors (AC1, AC2)
- Prototype: Not started.

## E18-US2-UI2 Product feedback

- App: portal. Priority: P2. Type: Screen.
- Stories: E18-US2.
- Page: Average, count and recent comments per item; date filter (AC3, AC4)
- Prototype: Not started.

## E18-US3-UI4 Report a problem

- App: portal. Priority: P3. Type: Screen.
- Stories: E18-US3.
- Page: Order, category, description
- Prototype: Not started.

## E19-US3-UI2 Vendor assistant

- App: portal. Priority: P2. Type: Overlay.
- Stories: E19-US3, E19-US4.
- Page: Docked chat: pending orders, stock, capacity; refuses owner-only data for staff (AC1, AC2)
- Prototype: Not started.

## E21-US2-UI1 Audit log (owner only)

- App: portal. Priority: P2. Type: Screen.
- Stories: E6-US2, E21-US1, E21-US2.
- Page: Read-only entries with timestamp, named employee, task and reason; employee/date filters and no-results state; staff access denied; no edit/delete controls.
- Prototype: Not started.

## E22-US2-UI1 Responsive portal layouts

- App: portal. Priority: P2. Type: Layout set.
- Stories: E22-US2.
- Page: Dashboard, board and tables on phone, tablet and laptop; PWA standalone launch
- Prototype: Not started.

## E1-US3-UI8 Admin sign-in

- App: portal. Priority: P1. Type: Screen.
- Stories: E1-US3.
- Page: Credentials, lockout message
- Prototype: Implemented, mock data.

## E20-US1-UI5 Verification queue

- App: portal. Priority: P2. Type: Screen.
- Stories: E20-US1.
- Page: Vendors, riders and fleet partners awaiting review, oldest first
- Prototype: Not started.

## E20-US1-UI6 Vendor application review

- App: portal. Priority: P2. Type: Screen.
- Stories: E20-US1.
- Page: Business details and documents; approve, reject with reason, or request more information (AC1)
- Prototype: Not started.

## E20-US1-UI7 Rider verification review

- App: portal. Priority: P2. Type: Screen.
- Stories: E20-US1.
- Page: Documents, vehicle type; approve or reject (AC3, AC4)
- Prototype: Not started.

## E20-US1-UI9 Fleet partner review

- App: portal. Priority: P3. Type: Screen.
- Stories: E20-US1.
- Page: Partner details and documents; approve or reject
- Prototype: Not started.

## E20-US1-UI8 Decision dialog

- App: portal. Priority: P2. Type: Overlay.
- Stories: E20-US1.
- Page: Required reason on rejection; message sent to the applicant
- Prototype: Not started.

## E14-US4-UI1 Partner fleets

- App: portal. Priority: P2. Type: Screen.
- Stories: E14-US4.
- Page: Partners, API connection status, active deliveries
- Prototype: Not started.

## E14-US4-UI2 Partner details and status log

- App: portal. Priority: P2. Type: Screen.
- Stories: E14-US4, E16-US1.
- Page: Acknowledgements, status updates and IVR confirmations per delivery (AC1, AC2)
- Prototype: Not started.

## E20-US2-UI1 Commission settings

- App: portal. Priority: P2. Type: Screen.
- Stories: E20-US2.
- Page: Global and per-vendor rate within the 8 to 12 percent range; out-of-range error (AC1, AC2) Include effective date/time and show the rate applicable to new orders; preserve the rate on existing orders.
- Prototype: Not started.

## E6-US3-UI1 Buffer rules

- App: portal. Priority: P1. Type: Screen.
- Stories: E6-US3.
- Page: Weather and peak rules with period, area and percentage
- Prototype: Implemented, mock data.

## E6-US3-UI2 Create or edit buffer rule

- App: portal. Priority: P1. Type: Overlay.
- Stories: E6-US3.
- Page: Period, affected area, buffer percentage; effect applies within a minute (AC1, AC2)
- Prototype: Implemented, mock data.

## E19-US4-UI1 Assistant scope and permissions

- App: portal. Priority: P3. Type: Screen.
- Stories: E19-US4.
- Page: Role scope and permission information; preview unsupported-action reply directing to complaints and cross-role refusal. Supporting design for guardrails, not a required settings editor.
- Prototype: Not started.

## E20-US3-UI1 Users

- App: portal. Priority: P2. Type: Screen.
- Stories: E20-US3.
- Page: Search across customers, vendors, riders and staff
- Prototype: Not started.

## E20-US3-UI2 User detail

- App: portal. Priority: P2. Type: Screen.
- Stories: E20-US3.
- Page: Profile, status, history, Suspend or Reactivate (AC1, AC2)
- Prototype: Not started.

## E20-US3-UI3 Suspend user

- App: portal. Priority: P2. Type: Overlay.
- Stories: E20-US3.
- Page: Consequence (sessions end) and confirm
- Prototype: Not started.

## E20-US3-UI4 Complaints queue

- App: portal. Priority: P2. Type: Screen.
- Stories: E20-US3.
- Page: Open tickets by age and parties
- Prototype: Not started.

## E20-US3-UI5 Complaint detail

- App: portal. Priority: P2. Type: Screen.
- Stories: E20-US3.
- Page: Order, timeline and parties involved (AC3)
- Prototype: Not started.

## E20-US3-UI6 Resolve complaint

- App: portal. Priority: P2. Type: Overlay.
- Stories: E20-US3.
- Page: Outcome text; all parties notified, case closed (AC4)
- Prototype: Not started.

## E18-US2-UI3 Rating review

- App: portal. Priority: P3. Type: Screen.
- Stories: E18-US2.
- Page: Mark a low rating as vendor-attributed so it leaves the rider's average (AC2)
- Prototype: Not started.

## E20-US4-UI1 Live dashboard

- App: portal. Priority: P1. Type: Screen.
- Stories: E20-US4.
- Page: Active orders, delayed orders, riders online, slot utilisation (AC2)
- Prototype: Implemented, mock data.

## E20-US4-UI2 Reports

- App: portal. Priority: P2. Type: Screen.
- Stories: E20-US4.
- Page: Orders, revenue, commission, slot utilisation for a date range (AC1) Include report export with private-field exclusion; valid, empty and invalid date-range states.
- Prototype: Not started.

## E16-US1-UI3 Safety escalations

- App: portal. Priority: P2. Type: Screen.
- Stories: E16-US1.
- Page: Missed rider check-ins past the grace period, with rider and order (AC6)
- Prototype: Not started.

## E21-US3-UI1 Audit investigation

- App: portal. Priority: P2. Type: Screen.
- Stories: E21-US1, E21-US3.
- Page: Cross-vendor log for a dispute, recipe quantities hidden (AC1)
- Prototype: Not started.

## E21-US3-UI2 Export audit log

- App: portal. Priority: P3. Type: Overlay.
- Stories: E21-US3.
- Page: Range and format; the export is itself logged (AC2)
- Prototype: Not started.

## E22-US2-UI2 Responsive admin layouts

- App: portal. Priority: P3. Type: Layout set.
- Stories: E22-US2.
- Page: Queues, tables and dashboard on tablet and laptop
- Prototype: Not started.

