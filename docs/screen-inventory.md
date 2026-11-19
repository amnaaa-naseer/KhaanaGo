# Screens built as one text field, Save, and Back to workspace

These are the vendor, admin, and shared screens whose web body is that scaffold and nothing else. The check follows `ScreenBody` in `packages/khaana-web/src/ScreenApp.tsx`:

- The screen does not return early (the live kitchen board is the only early return).
- Clause text produces exactly one text input.
- The body always adds `Save {title}` and `Back to workspace`.
- No dedicated panel is also rendered: owner dashboard, staff home, admin dashboard, kanban, finance, inventory, offers, team, settings, the dashboard summary line, or a record table.

Customer and rider screens are not listed. They do not render `Back to workspace`.

**Real fields** are copied only when the catalog `requirements` text is a comma-separated list of labels. A parenthetical example stays inside its label. Anything else is **TBD**.

**Page template** is `list`, `form`, or `dashboard` only when the catalog `family` is that value, and `detail` only when the title contains "detail". Otherwise **TBD**.

**Needed for the demo** is `yes` only when `docs/demo-walkthrough.md` names the screen, or names the vendor sidebar label whose module opens it. The walkthrough does not say the other screens are out of the demo, so those stay **unknown** rather than a guessed `no`.

| Screen | Role | Real fields | Page template | Needed for the demo |
| --- | --- | --- | --- | --- |
| Admin sign-in | admin | TBD | TBD | yes |
| Buffer rules | admin | TBD | form | unknown |
| Complaint detail | admin | TBD | detail | unknown |
| Partner details and status log | admin | TBD | detail | unknown |
| Partner fleets | admin | TBD | form | unknown |
| Rating review | admin | TBD | form | unknown |
| Responsive admin layouts | admin | TBD | TBD | unknown |
| Suspend user | admin | TBD | TBD | unknown |
| Verification queue | admin | TBD | list | unknown |
| Something went wrong | shared | TBD | form | unknown |
| Sync conflict message | shared | TBD | TBD | unknown |
| Add expense | vendor | Category, amount, date | TBD | unknown |
| Add or edit staff | vendor | Name, employee ID, duty set | list | unknown |
| Application status | vendor | TBD | TBD | unknown |
| Bulk BOM entry | vendor | TBD | form | unknown |
| Combo builder | vendor | TBD | form | unknown |
| Custom order review | vendor | TBD | form | unknown |
| Dish BOM | vendor | TBD | form | unknown |
| Flag discrepancy | vendor | TBD | TBD | unknown |
| Intake paused | vendor | TBD | TBD | unknown |
| Live utilisation | vendor | TBD | form | yes |
| New order alert | vendor | TBD | TBD | unknown |
| No access | vendor | TBD | TBD | unknown |
| Notification panel | vendor | TBD | TBD | unknown |
| Nutrition and allergen review | vendor | TBD | form | unknown |
| Operating hours and open/closed | vendor | TBD | form | unknown |
| Remove item | vendor | TBD | TBD | unknown |
| Report a problem | vendor | Order, category, description | TBD | unknown |
| Reset password | vendor | TBD | TBD | unknown |
| Temporary capacity change | vendor | TBD | TBD | unknown |
| Vendor application 1: business details | vendor | Business name, type, contact, area | TBD | unknown |
| Vendor application 2: documents | vendor | TBD | TBD | unknown |
| Vendor application 3: bank details | vendor | TBD | TBD | unknown |
| Voice commands | vendor | TBD | TBD | unknown |
