# User journeys

The journeys below are the ones the finished prototype has to demonstrate. Today only pieces of the customer, kitchen, and rider paths exist, and they do not share an order.

## Journey A. One order across all four roles

This is the Phase 3 demonstration. Screen IDs are the P1 set unless noted.

1. Customer signs in (`E1-US1-UI3`) and opens Home (`E3-US1-UI1`).
2. Customer opens a vendor menu (`E3-US1-UI2`) and an item (`E3-US1-UI3`).
3. Customer customizes the item (`E4-US1-UI1`). Price and preparation time change on the screen.
4. Cart (`E3-US2-UI1`) shows lines and blocks a second restaurant.
5. Delivery type (`E14-US2-UI1`). A fragile item cannot be pooled. Express is never pooled. The pooled offer is 30% off the delivery fee and an extra 10–15 minutes, labelled as an estimate.
6. Slot list (`E5-US3-UI1`) uses the intake bands. A full slot cannot be booked.
7. Payment method (`E3-US3-UI1`) is recorded locally. The gateway page is not part of KhaanaGo.
8. Review (`E3-US2-UI2`) shows separate price lines and the provisional five-minute hold.
9. Order placed (`E3-US4-UI2`).
10. Vendor kitchen receives a ticket (`E7-US1-UI1`, `E7-US1-UI2`) on the board (`E7-US3-UI1`).
11. Accept moves the ticket to Preparing. Marking 80% prepared, then Ready, is what makes dispatch eligible.
12. Utilisation (`E5-US1-UI3`) and the customer slot list read the same intake.
13. Rider, online (`E13-US2-UI2`), receives the offer (`E13-US2-UI4`) only after that readiness rule.
14. Pickup (`E13-US1-UI1`), ready alert (`E13-US1-UI2`), wait at the store (`E13-US4-UI1`), handover (`E13-US1-UI3`).
15. Drop-off (`E13-US3-UI1`) and the 6-digit code (`E13-US3-UI2`). A wrong code does not complete the delivery.
16. Customer tracking (`E17-US1-UI1`) shows the same stage, the same code, and a simulated map.
17. Delivered (`E13-US3-UI4`). Stock (`E9-US1-UI1`), the invoice (`E10-US1-UI3`), owner finance (`E12-US1-UI1`), and the admin monitor (`E20-US4-UI1`) show the same order. Staff who open finance see access denied.

## Journey B. Unhappy paths that must be demonstrable

| Situation | Where it appears | Expected visible result |
| --- | --- | --- |
| Empty sign-in | Each sign-in screen | Field errors, no navigation |
| Session expired | Customer login | Message, then sign-in. The token check itself is a backend test |
| Duplicate mobile | Registration, Phase 4 | Clear rejection. Persistence is a backend test |
| Item unavailable | Menu, cart | Grey item. Checkout blocked for that line |
| Second restaurant | Cart | Warning. The dedicated dialog is `E3-US2-UI3`, still not started |
| Fragile item | Delivery type | Pooled disabled |
| Slot just taken | `E5-US4-UI1` | Message and the nearest free windows. Two real customers at once is a backend test |
| Hold expired | Review | Released-slot message, return to slots |
| Full intake | Slots and meter | No immediate order |
| Wrong delivery code | Rider code screen | Stays incomplete, retry and contact support |
| Staff opens finance or recipes | Portal | Access denied, no figures |
| Nutrition lookup off | Nutrition screen | Retry state, values not invented |
| Map off | Tracking and rider navigation | Text address and retry |
| Declined card | Payment, later state | Order not confirmed. The gateway callback is a backend test |
| Offline | Shared banner, Phase 2 | Pending, not shown as confirmed |

## Journey C. Later journeys, not in the P1 set

These stay in the tracker and are required. They are not part of the first build after approval.

- Customer account: launch, register, verify, reset, profile, addresses.
- Discovery: search results, filters, vendor info.
- After delivery: history, invoice, reorder, ratings.
- Vendor business: onboarding, staff duties, offers, wastage, purchasing, reports.
- Rider: documents, approval, pooling, earnings history, safety.
- Admin: vendor approval, complaints, commission, audit.
- Assistant: customer, vendor, and rider surfaces. Replies are scripted and labelled. No model is claimed.

## Demo cast

Resettable data, Islamabad, prices in PKR:

- BakeCharm, bakery, limited intake, custom cake, fragile option.
- A second open kitchen with a simpler menu.
- A closed vendor with an opening time.
- One owner, one kitchen staff account, one admin, one approved rider on a motorbike, one pending rider who must not receive offers.
- Addresses in F-11 and G-9.
- Delivery code `482913` for the scripted order.

Sample figures are demo data. They are labelled as such wherever the screen could be mistaken for an engine result. The waiting-pay rate is not shown, because it is undecided.
