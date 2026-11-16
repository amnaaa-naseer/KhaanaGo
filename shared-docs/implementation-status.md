# Implementation status

P1 screens are implemented with mock data and local navigation. P2 and P3 stay not started.
Provisional numbers are labelled in the UI and in `config/prototype-assumptions.json`. They are awaiting review.
The original screen register workbook is unchanged.

| UI ID | Screen | App | Route | Status | Requirements | What the UI can show | What the mock cannot prove |
| --- | --- | --- | --- | --- | --- | --- | --- |
| E22-US3-UI1 | Offline banner and pending-sync badge | shared |  | Not started | E22-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E22-US3-UI2 | Sync conflict message | shared |  | Not started | E22-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E22-US3-UI3 | Something went wrong | shared |  | Not started | E22-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E22-US1-UI2 | Page not found (web) | shared |  | Not started | E22-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US1-UI6 | App launch | customer |  | Not started | E1-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US1-UI1 | Registration | customer |  | Not started | E1-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US1-UI2 | Verification code | customer |  | Not started | E1-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US1-UI3 | Login | customer | /login | Implemented, mock data | E1-US1 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E1-US1-UI4 | Reset password: request | customer |  | Not started | E1-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US1-UI5 | Reset password: code and new password | customer |  | Not started | E1-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US5-UI6 | Location permission | customer |  | Not started | E1-US5 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E17-US1-UI3 | Notification permission | customer |  | Not started | E17-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US5-UI1 | Profile | customer |  | Not started | E1-US5 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US5-UI4 | Edit profile | customer |  | Not started | E1-US5 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US5-UI2 | Saved addresses | customer |  | Not started | E1-US5 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US5-UI3 | Add or edit address | customer |  | Not started | E1-US5 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US5-UI5 | Delete address confirmation | customer |  | Not started | E1-US5 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E3-US1-UI1 | Home | customer | /home | Implemented, mock data | E2-US3, E3-US1, E17-US3 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E3-US1-UI4 | Search results | customer |  | Not started | E3-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E3-US1-UI5 | Filter sheet | customer |  | Not started | E3-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E3-US1-UI2 | Vendor menu | customer | /menu | Implemented, mock data | E2-US2, E3-US1 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E3-US1-UI6 | Vendor info and reviews | customer |  | Not started | E3-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E3-US1-UI3 | Item detail | customer | /item | Implemented, mock data | E3-US1, E8-US2, E8-US3 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E4-US1-UI1 | Customization builder | customer | /customize | Implemented, mock data | E2-US4, E4-US1 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E4-US2-UI1 | Reference image and instructions | customer |  | Not started | E4-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E4-US3-UI1 | Revised quote approval | customer |  | Not started | E4-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E3-US2-UI1 | Cart | customer | /cart | Implemented, mock data | E2-US2, E3-US2, E9-US2 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E3-US2-UI3 | Different-restaurant dialog | customer |  | Not started | E3-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E14-US2-UI1 | Delivery type | customer | /delivery | Implemented, mock data | E2-US4, E4-US3, E14-US2 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E5-US3-UI1 | Slot selector | customer | /slots | Implemented, mock data | E5-US2, E5-US3, E6-US1, E6-US2 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E5-US4-UI1 | Slot taken dialog | customer | /slots dialog | Implemented, mock data | E5-US4 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E5-US4-UI2 | Slot released dialog | customer |  | Not started | E5-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E3-US3-UI1 | Payment method | customer | /payment | Implemented, mock data | E3-US3 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E3-US3-UI2 | Payment gateway handoff | customer |  | Not started | E3-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E3-US4-UI1 | Voucher and offers sheet | customer |  | Not started | E3-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E3-US2-UI2 | Review order | customer | /review | Implemented, mock data | E2-US3, E3-US2 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E10-US3-UI1 | Payment failed | customer |  | Not started | E10-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E3-US4-UI2 | Order placed | customer | /placed | Implemented, mock data | E3-US4 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E17-US1-UI1 | Live tracking | customer | /tracking | Implemented, mock data | E6-US1, E14-US2, E17-US1 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E6-US4-UI1 | Delay explanation | customer | /delay | Implemented, mock data | E6-US4 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E16-US4-UI1 | Confirm corrected drop-off pin | customer |  | Not started | E16-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E10-US1-UI1 | Cancel order | customer |  | Not started | E9-US2, E10-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E17-US1-UI2 | Notification centre | customer |  | Not started | E17-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E17-US2-UI1 | Order history | customer |  | Not started | E17-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E17-US2-UI2 | Order detail and invoice | customer |  | Not started | E10-US1, E17-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E17-US2-UI3 | Reorder summary | customer |  | Not started | E17-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E18-US1-UI1 | Rating | customer |  | Not started | E18-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E18-US3-UI1 | Complaint form | customer |  | Not started | E18-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E18-US3-UI2 | Complaint status | customer |  | Not started | E18-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E19-US1-UI1 | Assistant chat | customer |  | Not started | E19-US1, E19-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E19-US2-UI1 | Voice order | customer |  | Not started | E19-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E22-US1-UI1 | Responsive web layouts | customer |  | Not started | E22-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US2-UI1 | App launch | rider |  | Not started | E1-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US2-UI2 | Sign in | rider | /sign-in | Implemented, mock data | E1-US2, E22-US1 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E1-US2-UI3 | Registration 1: personal details | rider |  | Not started | E1-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US2-UI4 | Registration 2: vehicle and phone | rider |  | Not started | E1-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US2-UI5 | Registration 3: documents | rider |  | Not started | E1-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US2-UI6 | Pending verification | rider |  | Not started | E1-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US2-UI7 | Application rejected or more information needed | rider |  | Not started | E1-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US2-UI8 | Verification code | rider |  | Not started | E1-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US2-UI9 | Reset password | rider |  | Not started | E1-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E13-US2-UI1 | Location permission | rider |  | Not started | E13-US2, E13-US5 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E13-US1-UI4 | Notification and sound permission | rider |  | Not started | E13-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E13-US2-UI2 | Home: offline and online | rider | /home | Implemented, mock data | E13-US2, E22-US1 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E13-US2-UI3 | Outside service area | rider |  | Not started | E13-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E13-US2-UI4 | Delivery offer | rider | /offer | Implemented, mock data | E13-US2 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E14-US1-UI1 | Pooled trip offer | rider |  | Not started | E14-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E13-US2-UI5 | Offer expired | rider |  | Not started | E13-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E13-US1-UI1 | Head to pickup | rider | /pickup | Implemented, mock data | E13-US1, E13-US5 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E13-US1-UI2 | Order ready alert | rider | /ready | Implemented, mock data | E13-US1, E16-US1 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E13-US4-UI1 | At the store | rider | /at-store | Implemented, mock data | E13-US4, E15-US2 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E13-US1-UI3 | Pickup handover | rider | /handover | Implemented, mock data | E13-US1, E16-US2 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E14-US2-UI2 | Pooled parcels and labels | rider |  | Not started | E14-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E14-US1-UI2 | Second pickup hold | rider |  | Not started | E14-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E13-US3-UI1 | Head to drop-off | rider | /dropoff | Implemented, mock data | E13-US3, E13-US5, E22-US1 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E13-US3-UI2 | Delivery code entry | rider | /code | Implemented, mock data | E13-US3, E16-US2 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E13-US3-UI3 | Out-of-sequence prompt | rider |  | Not started | E13-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E10-US2-UI2 | Collect cash | rider |  | Not started | E10-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E13-US3-UI4 | Delivered | rider | /delivered | Implemented, mock data | E13-US3, E15-US2 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E16-US4-UI2 | Quick messages | rider |  | Not started | E16-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E16-US4-UI3 | Request corrected pin | rider |  | Not started | E16-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E16-US1-UI1 | Voice check-in | rider |  | Not started | E16-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E19-US3-UI1 | Rider voice assistant | rider |  | Not started | E19-US3, E19-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E18-US3-UI3 | Report a problem | rider |  | Not started | E18-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E13-US2-UI6 | Shift summary | rider |  | Not started | E13-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E15-US3-UI1 | Shift earnings invoice | rider |  | Not started | E15-US2, E15-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E15-US3-UI2 | Delivery earnings detail | rider |  | Not started | E15-US2, E15-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US2-UI10 | Delivery history | rider |  | Not started | E1-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E18-US2-UI1 | My ratings | rider |  | Not started | E18-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US2-UI11 | Rider profile | rider |  | Not started | E1-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US2-UI12 | Settings | rider |  | Not started | E1-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E13-US5-UI1 | Navigation preference | rider |  | Not started | E13-US5 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E16-US2-UI1 | Display and alerts | rider |  | Not started | E16-US1, E16-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E16-US3-UI1 | Data saver | rider |  | Not started | E16-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E15-US1-UI1 | Tariff settings | rider |  | Not started | E15-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E20-US1-UI1 | Vendor application 1: business details | portal |  | Not started | E20-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E20-US1-UI2 | Vendor application 2: documents | portal |  | Not started | E20-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E20-US1-UI3 | Vendor application 3: bank details | portal |  | Not started | E20-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E20-US1-UI4 | Application status | portal |  | Not started | E20-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US3-UI1 | Vendor sign-in | portal | /vendor/sign-in | Implemented, mock data | E1-US3 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E1-US3-UI2 | Account locked | portal |  | Not started | E1-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US3-UI4 | Reset password | portal |  | Not started | E1-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US3-UI3 | No access | portal |  | Not started | E1-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US3-UI5 | Owner dashboard | portal | /vendor/dashboard | Implemented, mock data | E1-US3 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E1-US3-UI6 | Staff home | portal |  | Not started | E1-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US4-UI1 | Staff list | portal |  | Not started | E1-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US4-UI2 | Add or edit staff | portal |  | Not started | E1-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US4-UI3 | Deactivate staff | portal |  | Not started | E1-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E2-US1-UI1 | Business profile | portal |  | Not started | E2-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E2-US3-UI1 | Operating hours and open/closed | portal |  | Not started | E2-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E14-US3-UI1 | Delivery settings | portal |  | Not started | E14-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E15-US1-UI2 | Tariff settings | portal |  | Not started | E15-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US3-UI7 | Bank details and payout account | portal |  | Not started | E1-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E2-US2-UI1 | Menu list | portal | /vendor/menu | Implemented, mock data | E2-US2 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E2-US2-UI2 | Add or edit item | portal | /vendor/menu/edit | Implemented, mock data | E2-US2 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E2-US2-UI3 | Remove item | portal |  | Not started | E2-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E2-US4-UI1 | Customization options | portal |  | Not started | E2-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E5-US1-UI1 | Kitchen capacity setup | portal | /vendor/capacity | Implemented, mock data | E5-US1 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E5-US1-UI2 | Temporary capacity change | portal |  | Not started | E5-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E5-US1-UI3 | Live utilisation | portal | /vendor/utilisation | Implemented, mock data | E5-US1 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E5-US2-UI1 | Intake paused | portal | /vendor/utilisation banner | Implemented, mock data | E5-US2 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E6-US2-UI1 | Buffers and overrides | portal |  | Not started | E6-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E7-US1-UI1 | New order alert | portal | /vendor/kitchen alert | Implemented, mock data | E7-US1 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E7-US1-UI2 | Order ticket | portal | /vendor/kitchen ticket | Implemented, mock data | E7-US1, E7-US2 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E7-US2-UI1 | Reject order | portal |  | Not started | E7-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E7-US3-UI1 | Live kitchen board | portal | /vendor/kitchen | Implemented, mock data | E7-US2, E7-US3 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E7-US3-UI2 | Order history | portal |  | Not started | E7-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E7-US4-UI1 | Voice commands | portal |  | Not started | E7-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E4-US3-UI2 | Custom order review | portal |  | Not started | E4-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E8-US1-UI1 | Recipe list | portal |  | Not started | E8-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E8-US1-UI2 | Recipe editor | portal | /vendor/recipe | Implemented, mock data | E8-US1 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E8-US2-UI1 | Nutrition and allergen review | portal | /vendor/nutrition | Implemented, mock data | E8-US2, E8-US3 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E8-US4-UI1 | Recipe change impact | portal |  | Not started | E8-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E9-US1-UI1 | Stock list | portal | /vendor/stock | Implemented, mock data | E9-US1, E9-US2, E9-US4, E10-US1 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E9-US1-UI2 | Add or edit ingredient | portal |  | Not started | E9-US1, E9-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E9-US1-UI3 | Stock intake | portal |  | Not started | E9-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E9-US1-UI4 | Dish BOM | portal | /vendor/bom | Implemented, mock data | E9-US1 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E9-US1-UI5 | Bulk BOM entry | portal |  | Not started | E9-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E9-US2-UI1 | Low-stock alerts | portal |  | Not started | E9-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E9-US2-UI2 | Notification panel | portal |  | Not started | E9-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E9-US3-UI1 | Log wastage | portal |  | Not started | E9-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E9-US3-UI2 | Variance report | portal |  | Not started | E9-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E9-US4-UI1 | Material requirements planner | portal |  | Not started | E9-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E10-US1-UI2 | Invoice list | portal |  | Not started | E10-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E10-US1-UI3 | Invoice detail | portal | /vendor/invoice | Implemented, mock data | E10-US1 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E10-US2-UI1 | Payments | portal |  | Not started | E10-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E10-US3-UI2 | Refunds | portal |  | Not started | E10-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E10-US4-UI1 | COD reconciliation | portal |  | Not started | E10-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E10-US4-UI2 | Flag discrepancy | portal |  | Not started | E10-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E12-US1-UI1 | Finance dashboard | portal | /vendor/finance | Implemented, mock data | E10-US1, E12-US1 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E12-US1-UI2 | Commission and payouts | portal |  | Not started | E12-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E12-US1-UI3 | Expenses | portal |  | Not started | E12-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E12-US1-UI4 | Add expense | portal |  | Not started | E12-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E12-US2-UI1 | Net profit and dish margins | portal |  | Not started | E12-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E12-US3-UI1 | Export report | portal |  | Not started | E12-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E11-US1-UI1 | Offers list | portal |  | Not started | E11-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E11-US1-UI2 | Create or edit offer | portal |  | Not started | E11-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E11-US2-UI1 | Combo builder | portal |  | Not started | E11-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E11-US3-UI1 | Offer performance | portal |  | Not started | E11-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E18-US2-UI2 | Product feedback | portal |  | Not started | E18-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E18-US3-UI4 | Report a problem | portal |  | Not started | E18-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E19-US3-UI2 | Vendor assistant | portal |  | Not started | E19-US3, E19-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E21-US2-UI1 | Audit log (owner only) | portal |  | Not started | E6-US2, E21-US1, E21-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E22-US2-UI1 | Responsive portal layouts | portal |  | Not started | E22-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E1-US3-UI8 | Admin sign-in | portal | /admin/sign-in | Implemented, mock data | E1-US3 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E20-US1-UI5 | Verification queue | portal |  | Not started | E20-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E20-US1-UI6 | Vendor application review | portal |  | Not started | E20-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E20-US1-UI7 | Rider verification review | portal |  | Not started | E20-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E20-US1-UI9 | Fleet partner review | portal |  | Not started | E20-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E20-US1-UI8 | Decision dialog | portal |  | Not started | E20-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E14-US4-UI1 | Partner fleets | portal |  | Not started | E14-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E14-US4-UI2 | Partner details and status log | portal |  | Not started | E14-US4, E16-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E20-US2-UI1 | Commission settings | portal |  | Not started | E20-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E6-US3-UI1 | Buffer rules | portal | /admin/buffers | Implemented, mock data | E6-US3 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E6-US3-UI2 | Create or edit buffer rule | portal | /admin/buffers/edit | Implemented, mock data | E6-US3 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E19-US4-UI1 | Assistant scope and permissions | portal |  | Not started | E19-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E20-US3-UI1 | Users | portal |  | Not started | E20-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E20-US3-UI2 | User detail | portal |  | Not started | E20-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E20-US3-UI3 | Suspend user | portal |  | Not started | E20-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E20-US3-UI4 | Complaints queue | portal |  | Not started | E20-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E20-US3-UI5 | Complaint detail | portal |  | Not started | E20-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E20-US3-UI6 | Resolve complaint | portal |  | Not started | E20-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E18-US2-UI3 | Rating review | portal |  | Not started | E18-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E20-US4-UI1 | Live dashboard | portal | /admin/dashboard | Implemented, mock data | E20-US4 | Visible layout, labels, validation text, and navigation can be checked on the mock. | A screenshot does not prove persistence, permissions, payment, concurrency, notifications, or device signals. |
| E20-US4-UI2 | Reports | portal |  | Not started | E20-US4 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E16-US1-UI3 | Safety escalations | portal |  | Not started | E16-US1 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E21-US3-UI1 | Audit investigation | portal |  | Not started | E21-US1, E21-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E21-US3-UI2 | Export audit log | portal |  | Not started | E21-US3 | Not built. | Not built. Backend tests remain out of scope for a screen. |
| E22-US2-UI2 | Responsive admin layouts | portal |  | Not started | E22-US2 | Not built. | Not built. Backend tests remain out of scope for a screen. |
