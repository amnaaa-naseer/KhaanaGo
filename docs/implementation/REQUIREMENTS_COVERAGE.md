# Requirements coverage

Source of requirements: `docs/KhaanaGo_Chapter2_Deduplicated_Complete_Coverage.docx`, read through `docs/planning/KhaanaGo_Chapter2_Requirements.md`.
Source of screens: `docs/KhaanaGo_Screen_Register.xlsx`, read through `docs/planning/KhaanaGo_Screen_Register.csv`.

Candidate tests in the workbook are attached at story level. This file does not treat that attachment as a reviewed test-to-screen link.
Nothing below is marked passed. `Scaffold` means a related P1 mock exists. A mock does not pass a security, payment, concurrency, or persistence test.

Epics: 22. Stories parsed: 82. Acceptance criteria parsed: 256. Tests parsed: 393.

## E1

### E1-US1: Customer Registration, Login and Account Security

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I am on the registration screen and enter a valid name, unique mobile number, valid email and a password that meets the strength rule, When I submit the form, Then my account is created, a verification step is completed and I am signed in to the customer app.
- AC2. Given I enter a mobile number or email that is already registered, When I submit the form, Then registration is rejected with a clear message and no duplicate account is created.
- AC3. Given I have forgotten my password, When I request a reset using my registered email or mobile number, Then I receive a time-limited reset link or code and can set a new password.
- AC4. Given my session token has expired, When I make a request, Then I am redirected to sign in again and no protected data is returned.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E1-US1-TC1 | Verify that a new customer can register with valid details. Expected: Account is created, customer is signed in and lands on the home screen. | UI can show the outcome | E1-US1-UI6 (Customer App, not started); E1-US1-UI1 (Customer App, not started); E1-US1-UI2 (Customer App, not started); E1-US1-UI3 (Customer App, scaffold); E1-US1-UI4 (Customer App, not started); E1-US1-UI5 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E1-US1-TC2 | Verify that duplicate accounts are blocked. Expected: Registration is rejected with a 'number already registered' message and no new account is created. | Not provable by a screen alone | E1-US1-UI6 (Customer App, not started); E1-US1-UI1 (Customer App, not started); E1-US1-UI2 (Customer App, not started); E1-US1-UI3 (Customer App, scaffold); E1-US1-UI4 (Customer App, not started); E1-US1-UI5 (Customer App, not started) | None | Open. A screen cannot pass this test. |
| E1-US1-TC3 | Verify that a user can reset a forgotten password. Expected: Password is changed and old password no longer works. | UI can show the outcome | E1-US1-UI6 (Customer App, not started); E1-US1-UI1 (Customer App, not started); E1-US1-UI2 (Customer App, not started); E1-US1-UI3 (Customer App, scaffold); E1-US1-UI4 (Customer App, not started); E1-US1-UI5 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E1-US1-TC4 | Verify that expired sessions are rejected. Expected: Request returns 401 and user is redirected to sign in; no data is returned. | Not provable by a screen alone | E1-US1-UI6 (Customer App, not started); E1-US1-UI1 (Customer App, not started); E1-US1-UI2 (Customer App, not started); E1-US1-UI3 (Customer App, scaffold); E1-US1-UI4 (Customer App, not started); E1-US1-UI5 (Customer App, not started) | None | Open. A screen cannot pass this test. |
| E1-US1-TC5 | Negative scenario: Reject invalid or reused verification code. Expected: Account remains unverified; no session created. | UI can show the outcome | E1-US1-UI6 (Customer App, not started); E1-US1-UI1 (Customer App, not started); E1-US1-UI2 (Customer App, not started); E1-US1-UI3 (Customer App, scaffold); E1-US1-UI4 (Customer App, not started); E1-US1-UI5 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E1-US1-TC6 | Boundary scenario: Password-strength boundary. Expected: Shorter password is rejected; exactly minimum is accepted if all other rules hold. | UI can show the outcome | E1-US1-UI6 (Customer App, not started); E1-US1-UI1 (Customer App, not started); E1-US1-UI2 (Customer App, not started); E1-US1-UI3 (Customer App, scaffold); E1-US1-UI4 (Customer App, not started); E1-US1-UI5 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |

### E1-US2: Rider Registration and Verification Profile

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I open the rider registration form, When I enter my details, select a vehicle type and upload the required documents, Then my profile is created in a pending-verification state and is not assignable to orders until an administrator approves it.
- AC2. Given my profile is approved, When I sign in to the rider app, Then I see my vehicle type, availability toggle and delivery history.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E1-US2-TC1 | Verify that a new rider profile is created in pending state. Expected: Profile is stored as Pending; rider cannot receive assignments until approved. | UI can show the outcome | E1-US2-UI1 (Rider App, not started); E1-US2-UI2 (Rider App, scaffold); E1-US2-UI3 (Rider App, not started); E1-US2-UI4 (Rider App, not started); E1-US2-UI5 (Rider App, not started); E1-US2-UI6 (Rider App, not started); E1-US2-UI7 (Rider App, not started); E1-US2-UI8 (Rider App, not started); E1-US2-UI9 (Rider App, not started); E1-US2-UI10 (Rider App, not started); E1-US2-UI11 (Rider App, not started); E1-US2-UI12 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E1-US2-TC2 | Verify that an approved rider sees profile and availability toggle. Expected: Rider app shows vehicle type, availability toggle and delivery history. | UI can show the outcome | E1-US2-UI1 (Rider App, not started); E1-US2-UI2 (Rider App, scaffold); E1-US2-UI3 (Rider App, not started); E1-US2-UI4 (Rider App, not started); E1-US2-UI5 (Rider App, not started); E1-US2-UI6 (Rider App, not started); E1-US2-UI7 (Rider App, not started); E1-US2-UI8 (Rider App, not started); E1-US2-UI9 (Rider App, not started); E1-US2-UI10 (Rider App, not started); E1-US2-UI11 (Rider App, not started); E1-US2-UI12 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E1-US2-TC3 | Negative scenario: Reject incomplete rider verification. Expected: Field errors displayed; unapproved profile cannot receive dispatches. | UI can show the outcome | E1-US2-UI1 (Rider App, not started); E1-US2-UI2 (Rider App, scaffold); E1-US2-UI3 (Rider App, not started); E1-US2-UI4 (Rider App, not started); E1-US2-UI5 (Rider App, not started); E1-US2-UI6 (Rider App, not started); E1-US2-UI7 (Rider App, not started); E1-US2-UI8 (Rider App, not started); E1-US2-UI9 (Rider App, not started); E1-US2-UI10 (Rider App, not started); E1-US2-UI11 (Rider App, not started); E1-US2-UI12 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E1-US2-TC4 | Boundary scenario: Rider approval-state boundary. Expected: Only approved and eligible rider can receive assignments. | UI can show the outcome | E1-US2-UI1 (Rider App, not started); E1-US2-UI2 (Rider App, scaffold); E1-US2-UI3 (Rider App, not started); E1-US2-UI4 (Rider App, not started); E1-US2-UI5 (Rider App, not started); E1-US2-UI6 (Rider App, not started); E1-US2-UI7 (Rider App, not started); E1-US2-UI8 (Rider App, not started); E1-US2-UI9 (Rider App, not started); E1-US2-UI10 (Rider App, not started); E1-US2-UI11 (Rider App, not started); E1-US2-UI12 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |

### E1-US3: Vendor Role-Based Sign-in and Owner-Only Data

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I hold valid vendor credentials, When I sign in, Then I am taken to the dashboard that matches my role (owner or kitchen staff).
- AC2. Given I enter an incorrect password five consecutive times, When I attempt a sixth sign-in, Then the account is temporarily locked and the owner is informed.
- AC3. Given I am signed in as a kitchen staff member, When I try to open financial dashboards, bank details, commission deductions or recipe details, Then access is denied with a permission message and no data is returned by the API.
- AC4. Given I am signed in as the vendor owner, When I open the same screens, Then all of them are accessible and editable.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E1-US3-TC1 | Verify that owner and staff are routed to role-specific dashboards. Expected: Owner sees full dashboard; staff sees kitchen-operation view only. | UI can show the outcome | E1-US3-UI1 (Vendor Portal, scaffold); E1-US3-UI2 (Vendor Portal, not started); E1-US3-UI4 (Vendor Portal, not started); E1-US3-UI3 (Vendor Portal, not started); E1-US3-UI5 (Vendor Portal, scaffold); E1-US3-UI6 (Vendor Portal, not started); E1-US3-UI7 (Vendor Portal, not started); E1-US3-UI8 (Admin Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E1-US3-TC2 | Verify lockout after five failed sign-ins. Expected: Account is locked temporarily, sixth attempt is denied and the owner is notified. Consolidated expected result: Lock enforced at stated fifth failure; sixth denied until unlock window expires. | Not provable by a screen alone | E1-US3-UI1 (Vendor Portal, scaffold); E1-US3-UI2 (Vendor Portal, not started); E1-US3-UI4 (Vendor Portal, not started); E1-US3-UI3 (Vendor Portal, not started); E1-US3-UI5 (Vendor Portal, scaffold); E1-US3-UI6 (Vendor Portal, not started); E1-US3-UI7 (Vendor Portal, not started); E1-US3-UI8 (Admin Portal, scaffold) | None | Open. A screen cannot pass this test. |
| E1-US3-TC3 | Verify that staff cannot access financial or recipe data. Expected: Access is denied (403) with a permission message and no restricted data is returned. Consolidated expected result: 403; response and logs contain no secret fields. | UI can show the outcome | E1-US3-UI1 (Vendor Portal, scaffold); E1-US3-UI2 (Vendor Portal, not started); E1-US3-UI4 (Vendor Portal, not started); E1-US3-UI3 (Vendor Portal, not started); E1-US3-UI5 (Vendor Portal, scaffold); E1-US3-UI6 (Vendor Portal, not started); E1-US3-UI7 (Vendor Portal, not started); E1-US3-UI8 (Admin Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E1-US3-TC4 | Verify that the owner can open all owner-only screens. Expected: All screens load and are editable. | UI can show the outcome | E1-US3-UI1 (Vendor Portal, scaffold); E1-US3-UI2 (Vendor Portal, not started); E1-US3-UI4 (Vendor Portal, not started); E1-US3-UI3 (Vendor Portal, not started); E1-US3-UI5 (Vendor Portal, scaffold); E1-US3-UI6 (Vendor Portal, not started); E1-US3-UI7 (Vendor Portal, not started); E1-US3-UI8 (Admin Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

### E1-US4: Staff Account, Duties and Deactivation

Story status: Not started.

Acceptance criteria:
- AC1. Given I am signed in as the owner, When I create a staff account with a name, employee ID and a selected duty set, Then the staff member can sign in and can access only the assigned duties.
- AC2. Given a staff member leaves the business, When I deactivate the account, Then the account can no longer sign in and its historical audit entries are retained.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E1-US4-TC1 | Verify that the owner can create staff with assigned duties. Expected: Staff can access only the 'Prepare orders' duty. | UI can show the outcome | E1-US4-UI1 (Vendor Portal, not started); E1-US4-UI2 (Vendor Portal, not started); E1-US4-UI3 (Vendor Portal, not started) | None | Open. Not started. |
| E1-US4-TC2 | Verify that deactivated staff cannot sign in and history remains. Expected: Sign-in is refused; previous audit entries remain intact. | Not provable by a screen alone | E1-US4-UI1 (Vendor Portal, not started); E1-US4-UI2 (Vendor Portal, not started); E1-US4-UI3 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |
| E1-US4-TC3 | Negative scenario: Deny revoked staff permission. Expected: Operation denied immediately; revocation is audited. | Not provable by a screen alone | E1-US4-UI1 (Vendor Portal, not started); E1-US4-UI2 (Vendor Portal, not started); E1-US4-UI3 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |
| E1-US4-TC4 | Boundary scenario: Duty and employee ID boundary. Expected: Invalid configurations rejected; valid unique identity receives only assigned duties. | UI can show the outcome | E1-US4-UI1 (Vendor Portal, not started); E1-US4-UI2 (Vendor Portal, not started); E1-US4-UI3 (Vendor Portal, not started) | None | Open. Not started. |

### E1-US5: Customer Profile and Saved Addresses

Story status: Not started.

Acceptance criteria:
- AC1. Given I am signed in, When I add, edit or delete a delivery address with a map pin, Then the address is stored and offered at checkout.
- AC2. Given I update my phone number, When I save the profile, Then the new number is used for order notifications and rider contact.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E1-US5-TC1 | Verify that a customer can save an address with a map pin. Expected: Address is stored and offered at checkout. | UI can show the outcome | E1-US5-UI6 (Customer App, not started); E1-US5-UI1 (Customer App, not started); E1-US5-UI4 (Customer App, not started); E1-US5-UI2 (Customer App, not started); E1-US5-UI3 (Customer App, not started); E1-US5-UI5 (Customer App, not started) | None | Open. Not started. |
| E1-US5-TC2 | Negative scenario: Reject invalid or unserviceable map pin. Expected: Invalid pin rejected or address marked unserviceable; no false delivery quote. | UI can show the outcome | E1-US5-UI6 (Customer App, not started); E1-US5-UI1 (Customer App, not started); E1-US5-UI4 (Customer App, not started); E1-US5-UI2 (Customer App, not started); E1-US5-UI3 (Customer App, not started); E1-US5-UI5 (Customer App, not started) | None | Open. Not started. |
| E1-US5-TC3 | Boundary scenario: Saved address boundary. Expected: Correct current address selected; deleted address never used for delivery fees. | UI can show the outcome | E1-US5-UI6 (Customer App, not started); E1-US5-UI1 (Customer App, not started); E1-US5-UI4 (Customer App, not started); E1-US5-UI2 (Customer App, not started); E1-US5-UI3 (Customer App, not started); E1-US5-UI5 (Customer App, not started) | None | Open. Not started. |

## E2

### E2-US1: Vendor Business Profile Setup

Story status: Not started.

Acceptance criteria:
- AC1. Given I am an approved vendor, When I enter my profile details and select business type (restaurant, cloud kitchen or home baker/chef), Then the profile is saved and becomes visible in the customer app.
- AC2. Given I select bike or car as my preferred delivery transport, When dispatch is requested for my orders, Then only riders with a matching vehicle type are offered the delivery.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E2-US1-TC1 | Verify that a vendor can create a complete profile. Expected: Profile is saved and visible in the customer app. | UI can show the outcome | E2-US1-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E2-US1-TC2 | Verify that vendor transport preference filters riders. Expected: Only the motorbike rider is offered the delivery. | UI can show the outcome | E2-US1-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E2-US1-TC3 | Negative scenario: Reject incomplete business listing. Expected: Publication denied; no public listing. | UI can show the outcome | E2-US1-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E2-US1-TC4 | Boundary scenario: Opening-time and area boundary. Expected: Edge location handled consistently; outside location excluded. | UI can show the outcome | E2-US1-UI1 (Vendor Portal, not started) | None | Open. Not started. |

### E2-US2: Menu Catalogue and Live Item Availability

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I am on the menu management screen, When I add an item with name, price, category and add-ons, Then the item is saved and appears in the customer app with the same details.
- AC2. Given I enter a negative or non-numeric price, When I try to save, Then validation prevents saving and shows an error.
- AC3. Given an item is available, When I mark it unavailable, Then the item is hidden or disabled in the customer app within five seconds.
- AC4. Given a customer already has the item in the cart, When I mark it unavailable, Then checkout is blocked for that item and the customer is told it is no longer available.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E2-US2-TC1 | Verify that a new item is created and visible. Expected: Item appears in the customer app with the same details. | UI can show the outcome | E3-US1-UI2 (Customer App, scaffold); E3-US2-UI1 (Customer App, scaffold); E2-US2-UI1 (Vendor Portal, scaffold); E2-US2-UI2 (Vendor Portal, scaffold); E2-US2-UI3 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E2-US2-TC2 | Verify price validation. Expected: Save is blocked with a validation error for each. | Not provable by a screen alone | E3-US1-UI2 (Customer App, scaffold); E3-US2-UI1 (Customer App, scaffold); E2-US2-UI1 (Vendor Portal, scaffold); E2-US2-UI2 (Vendor Portal, scaffold); E2-US2-UI3 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |
| E2-US2-TC3 | Verify real-time menu sync. Expected: Item is hidden or disabled in the customer app within five seconds. | Not provable by a screen alone | E3-US1-UI2 (Customer App, scaffold); E3-US2-UI1 (Customer App, scaffold); E2-US2-UI1 (Vendor Portal, scaffold); E2-US2-UI2 (Vendor Portal, scaffold); E2-US2-UI3 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |
| E2-US2-TC4 | Verify checkout is blocked for items made unavailable. Expected: Checkout is blocked for that item and the customer is told it is unavailable. | Not provable by a screen alone | E3-US1-UI2 (Customer App, scaffold); E3-US2-UI1 (Customer App, scaffold); E2-US2-UI1 (Vendor Portal, scaffold); E2-US2-UI2 (Vendor Portal, scaffold); E2-US2-UI3 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |
| E2-US2-TC5 | Boundary scenario: Menu availability sync boundary. Expected: Menu status agrees within five seconds; no unavailable item purchased. | Not provable by a screen alone | E3-US1-UI2 (Customer App, scaffold); E3-US2-UI1 (Customer App, scaffold); E2-US2-UI1 (Vendor Portal, scaffold); E2-US2-UI2 (Vendor Portal, scaffold); E2-US2-UI3 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |

### E2-US3: Operating Hours and Open/Closed Control

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given my operating hours are 10:00 to 22:00, When a customer opens the app at 23:00, Then my vendor card shows Closed and ordering is disabled.
- AC2. Given I manually close the kitchen during operating hours, When a customer views my vendor card, Then the card shows Closed until I reopen.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E2-US3-TC1 | Verify automatic closed status. Expected: Vendor card shows Closed and ordering is disabled. | UI can show the outcome | E3-US1-UI1 (Customer App, scaffold); E3-US2-UI2 (Customer App, scaffold); E2-US3-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E2-US3-TC2 | Verify manual override. Expected: Status changes to Closed then back to Open in the customer app. | UI can show the outcome | E3-US1-UI1 (Customer App, scaffold); E3-US2-UI2 (Customer App, scaffold); E2-US3-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E2-US3-TC3 | Negative scenario: Block purchases at exact closing time. Expected: Configured opening and closing boundary applied consistently; closed orders rejected. | Not provable by a screen alone | E3-US1-UI1 (Customer App, scaffold); E3-US2-UI2 (Customer App, scaffold); E2-US3-UI1 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |
| E2-US3-TC4 | Boundary scenario: Manual closure versus schedule. Expected: Manual Closed override persists until vendor reopens. | UI can show the outcome | E3-US1-UI1 (Customer App, scaffold); E3-US2-UI2 (Customer App, scaffold); E2-US3-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |

### E2-US4: Item Customization Option Configuration

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I open an item's customization settings, When I enable sizes, flavours and custom text with price differences and a lead time, Then those options appear in the customer customization builder with the configured prices.
- AC2. Given I mark an item as fragile, When pooled deliveries are being planned, Then the item is automatically excluded from pooled multi-stop batches.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E2-US4-TC1 | Verify that vendor options appear in the builder. Expected: Builder shows exactly the configured options with price differences. | UI can show the outcome | E4-US1-UI1 (Customer App, scaffold); E14-US2-UI1 (Customer App, scaffold); E2-US4-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E2-US4-TC2 | Verify that fragile items are never pooled. Expected: The fragile item is excluded from the pooled batch. | UI can show the outcome | E4-US1-UI1 (Customer App, scaffold); E14-US2-UI1 (Customer App, scaffold); E2-US4-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E2-US4-TC3 | Negative scenario: Reject impossible option pricing. Expected: Invalid configuration rejected with field-level errors. | UI can show the outcome | E4-US1-UI1 (Customer App, scaffold); E14-US2-UI1 (Customer App, scaffold); E2-US4-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E2-US4-TC4 | Boundary scenario: Customization limit boundary. Expected: At-limit values accepted; over-limit values rejected. | UI can show the outcome | E4-US1-UI1 (Customer App, scaffold); E14-US2-UI1 (Customer App, scaffold); E2-US4-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |

## E3

### E3-US1: Vendor Discovery and Menu Details

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I am signed in with a saved address, When I open the home screen, Then I see vendors serving my area with their open/closed status.
- AC2. Given I apply cuisine and dietary-tag filters, When the list refreshes, Then only vendors matching all selected filters are shown.
- AC3. Given I open a vendor, When I select an item, Then I see its price, description, add-ons, nutrition badge and allergen warning where available.
- AC4. Given an item is unavailable, When I view the menu, Then the item is shown as unavailable and cannot be added to the cart.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E3-US1-TC1 | Verify area-based vendor listing with live status. Expected: Vendors serving the area are listed with open/closed status. | UI can show the outcome | E3-US1-UI1 (Customer App, scaffold); E3-US1-UI4 (Customer App, not started); E3-US1-UI5 (Customer App, not started); E3-US1-UI2 (Customer App, scaffold); E3-US1-UI6 (Customer App, not started); E3-US1-UI3 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E3-US1-TC2 | Verify filter combination. Expected: Only vendors matching both filters appear. | UI can show the outcome | E3-US1-UI1 (Customer App, scaffold); E3-US1-UI4 (Customer App, not started); E3-US1-UI5 (Customer App, not started); E3-US1-UI2 (Customer App, scaffold); E3-US1-UI6 (Customer App, not started); E3-US1-UI3 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E3-US1-TC3 | Verify item detail content. Expected: Price, add-ons, nutrition badge and allergen warning are shown. | UI can show the outcome | E3-US1-UI1 (Customer App, scaffold); E3-US1-UI4 (Customer App, not started); E3-US1-UI5 (Customer App, not started); E3-US1-UI2 (Customer App, scaffold); E3-US1-UI6 (Customer App, not started); E3-US1-UI3 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E3-US1-TC4 | Verify unavailable item behaviour. Expected: Item is displayed as unavailable and cannot be added. | UI can show the outcome | E3-US1-UI1 (Customer App, scaffold); E3-US1-UI4 (Customer App, not started); E3-US1-UI5 (Customer App, not started); E3-US1-UI2 (Customer App, scaffold); E3-US1-UI6 (Customer App, not started); E3-US1-UI3 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E3-US1-TC5 | Negative scenario: Reject unavailable or out-of-area vendor items. Expected: Correct unavailable response; checkout cannot bypass controls. | UI can show the outcome | E3-US1-UI1 (Customer App, scaffold); E3-US1-UI4 (Customer App, not started); E3-US1-UI5 (Customer App, not started); E3-US1-UI2 (Customer App, scaffold); E3-US1-UI6 (Customer App, not started); E3-US1-UI3 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E3-US1-TC6 | Boundary scenario: Search boundary. Expected: Empty state for zero; one exact eligible result for one. | UI can show the outcome | E3-US1-UI1 (Customer App, scaffold); E3-US1-UI4 (Customer App, not started); E3-US1-UI5 (Customer App, not started); E3-US1-UI2 (Customer App, scaffold); E3-US1-UI6 (Customer App, not started); E3-US1-UI3 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

### E3-US2: Cart Management and Itemised Checkout Bill

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given my cart contains items from one vendor, When I change quantities or remove an item, Then the subtotal updates immediately.
- AC2. Given my cart contains items from vendor A, When I add an item from vendor B, Then the system warns me and asks whether to start a new cart.
- AC3. Given I proceed to checkout, When the bill summary is displayed, Then food cost, delivery charge (with base fare and distance component), surcharges, discount and final total are listed as separate lines.
- AC4. Given my delivery address is further than the standard radius, When the bill is calculated, Then the distance surcharge is shown as a labelled line before I confirm payment.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E3-US2-TC1 | Verify subtotal recalculation. Expected: Subtotal updates immediately and correctly. | UI can show the outcome | E3-US2-UI1 (Customer App, scaffold); E3-US2-UI3 (Customer App, not started); E3-US2-UI2 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E3-US2-TC2 | Verify single-vendor cart rule. Expected: App warns and asks whether to start a new cart. | UI can show the outcome | E3-US2-UI1 (Customer App, scaffold); E3-US2-UI3 (Customer App, not started); E3-US2-UI2 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E3-US2-TC3 | Verify billing lines. Expected: Food cost, delivery charge, discount and total (1,250) are shown as separate lines. | UI can show the outcome | E3-US2-UI1 (Customer App, scaffold); E3-US2-UI3 (Customer App, not started); E3-US2-UI2 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E3-US2-TC4 | Verify that surcharge is labelled. Expected: Distance surcharge is shown as a labelled line before payment. | UI can show the outcome | E3-US2-UI1 (Customer App, scaffold); E3-US2-UI3 (Customer App, not started); E3-US2-UI2 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E3-US2-TC5 | Negative scenario: Reject zero or excessive cart quantity. Expected: Validation rejects invalid values; existing subtotal remains correct. | UI can show the outcome | E3-US2-UI1 (Customer App, scaffold); E3-US2-UI3 (Customer App, not started); E3-US2-UI2 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E3-US2-TC6 | Boundary scenario: Recalculate financial boundary. Expected: Line items and total match configured currency rounding rules. | UI can show the outcome | E3-US2-UI1 (Customer App, scaffold); E3-US2-UI3 (Customer App, not started); E3-US2-UI2 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

### E3-US3: Supported Local Payment Methods

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I am on the payment step, When I choose JazzCash, Easypaisa or a card and complete the gateway flow, Then the payment is confirmed and the order is placed.
- AC2. Given I choose cash on delivery, When I confirm the order, Then the order is placed with payment status 'Pending – COD'.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E3-US3-TC1 | Verify online payment success. Expected: Payment is confirmed and the order is placed. | UI can show the outcome | E3-US3-UI1 (Customer App, scaffold); E3-US3-UI2 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E3-US3-TC2 | Verify COD placement. Expected: Order is placed with payment status Pending – COD. | UI can show the outcome | E3-US3-UI1 (Customer App, scaffold); E3-US3-UI2 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E3-US3-TC3 | Negative scenario: Handle unsuccessful or duplicate gateway callback. Expected: Declined payment does not confirm order; repeat callback does not duplicate payment/order. | Not provable by a screen alone | E3-US3-UI1 (Customer App, scaffold); E3-US3-UI2 (Customer App, not started) | None | Open. A screen cannot pass this test. |
| E3-US3-TC4 | Boundary scenario: Payment state boundary. Expected: Only properly confirmed payments marked Paid; COD remains pending. | UI can show the outcome | E3-US3-UI1 (Customer App, scaffold); E3-US3-UI2 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |

### E3-US4: Order Placement and Automatic Offers

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given an active offer applies to my cart, When I reach checkout, Then the discount is applied automatically and shown as a separate line.
- AC2. Given I enter an invalid or expired voucher code, When I apply it, Then the code is rejected with a reason and the total is unchanged.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E3-US4-TC1 | Verify auto-applied discount. Expected: Discount is applied automatically and shown separately. | UI can show the outcome | E3-US4-UI1 (Customer App, not started); E3-US4-UI2 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E3-US4-TC2 | Negative scenario: Reject ineligible and expired promotions. Expected: Discount not applied; reason displayed; total unchanged. Consolidated expected result: Code is rejected with a reason; total unchanged. | UI can show the outcome | E3-US4-UI1 (Customer App, not started); E3-US4-UI2 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E3-US4-TC3 | Boundary scenario: Promotion window boundary. Expected: Only orders within configured inclusive/exclusive validity rule receive discount. | UI can show the outcome | E3-US4-UI1 (Customer App, not started); E3-US4-UI2 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

## E4

### E4-US1: Custom Options and Dietary Requests

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I open a customizable item, When I choose size, flavour, add-ons and enter custom text, Then the price and preparation time update to reflect my selections.
- AC2. Given I leave a mandatory option unselected, When I try to add to cart, Then the app highlights the missing option and blocks the action.
- AC3. Given the vendor allows swaps for an item, When I select an exclusion such as no nuts or a swap such as sugar-free, Then the selection is attached to the order and shown on the vendor's kitchen ticket.
- AC4. Given an exclusion is not offered by the vendor, When I view the options, Then the unsupported exclusion is not selectable.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E4-US1-TC1 | Verify builder updates price and preparation time. Expected: Price and preparation time update with selections. | UI can show the outcome | E4-US1-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E4-US1-TC2 | Verify exclusions flow to the kitchen. Expected: Exclusion and swap are stored and shown on kitchen ticket. | UI can show the outcome | E4-US1-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E4-US1-TC3 | Verify only vendor-allowed exclusions appear. Expected: Unsupported exclusions are not selectable. | UI can show the outcome | E4-US1-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E4-US1-TC4 | Negative scenario: Reject unsupported ingredient swap. Expected: Unsupported swap rejected; vendor-approved options unchanged. | UI can show the outcome | E4-US1-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E4-US1-TC5 | Boundary scenario: Required-option boundary. Expected: Missing case blocked; complete case accepted with correct revised quote. Consolidated expected result: Missing option is highlighted and action blocked. | Not provable by a screen alone | E4-US1-UI1 (Customer App, scaffold) | None | Open. A screen cannot pass this test. |

### E4-US2: Reference Images and Special Instructions

Story status: Not started.

Acceptance criteria:
- AC1. Given I am customizing a bespoke cake, When I upload a JPG or PNG within the size limit and add instructions, Then the image and note are attached to the order and visible to the vendor.
- AC2. Given I upload an unsupported or oversized file, When I submit, Then the upload is rejected with a message stating allowed formats and size.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E4-US2-TC1 | Verify valid upload. Expected: Image and note are attached and visible to vendor. | UI can show the outcome | E4-US2-UI1 (Customer App, not started) | None | Open. Not started. |
| E4-US2-TC2 | Negative scenario: Reject unsafe file upload. Expected: Unsupported content rejected; no file served or stored as trusted media. Consolidated expected result: Each is rejected with allowed formats and size message. | UI can show the outcome | E4-US2-UI1 (Customer App, not started) | None | Open. Not started. |
| E4-US2-TC3 | Boundary scenario: Special-instruction length boundary. Expected: Maximum accepted; over-limit value blocked without truncation. | Not provable by a screen alone | E4-US2-UI1 (Customer App, not started) | None | Open. A screen cannot pass this test. |

### E4-US3: Vendor Review and Fragile-Order Handling

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given a customer submits a custom order, When I open it in the portal, Then I can accept, propose a revised price or time, or decline with a reason.
- AC2. Given I propose a revised price, When the customer is notified, Then the order stays pending until the customer approves or cancels.
- AC3. Given my cart contains a fragile custom item, When I reach the delivery options, Then pooled delivery is disabled and express single delivery is applied.
- AC4. Given the item is later changed to a non-fragile item, When I return to delivery options, Then pooled delivery becomes available again.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E4-US3-TC1 | Verify revision workflow. Expected: Customer is notified and order stays pending until approved or cancelled. | UI can show the outcome | E4-US3-UI1 (Customer App, not started); E14-US2-UI1 (Customer App, scaffold); E4-US3-UI2 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E4-US3-TC2 | Verify decline with reason. Expected: Customer is notified with the reason and order is closed. | UI can show the outcome | E4-US3-UI1 (Customer App, not started); E14-US2-UI1 (Customer App, scaffold); E4-US3-UI2 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E4-US3-TC3 | Verify delivery options for fragile cart. Expected: Pooled delivery is disabled and express single delivery is applied. Consolidated expected result: Fragile order always single-delivery even when distance qualifies. | UI can show the outcome | E4-US3-UI1 (Customer App, not started); E14-US2-UI1 (Customer App, scaffold); E4-US3-UI2 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E4-US3-TC4 | Negative scenario: Reject unapproved or incompatible custom request. Expected: Invalid/unfulfillable order is declined with a clear reason. | UI can show the outcome | E4-US3-UI1 (Customer App, not started); E14-US2-UI1 (Customer App, scaffold); E4-US3-UI2 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |

## E5

### E5-US1: Kitchen Capacity Setup and Live Utilisation

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I open Kitchen Capacity Setup, When I enter hourly capacity and per-item preparation times, Then the values are saved and used by the throttling engine immediately.
- AC2. Given I enter zero or a negative capacity, When I try to save, Then validation rejects the value with an error.
- AC3. Given current capacity is 12 orders per hour, When I reduce it to 6 for the next two hours, Then slot availability recalculates immediately and already-confirmed orders are not cancelled.
- AC4. Given the temporary period ends, When the time elapses, Then capacity returns to the default value automatically.
- AC5. Given a custom cake order with a long preparation time is accepted, When the engine updates load, Then it consumes proportionally more capacity than a standard item.
- AC6. Given I open the dashboard, When I view utilization, Then I see current load, remaining capacity and upcoming slot occupancy.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E5-US1-TC1 | Verify capacity configuration. Expected: Values are saved and used immediately by the engine. | UI can show the outcome | E5-US1-UI1 (Vendor Portal, scaffold); E5-US1-UI2 (Vendor Portal, not started); E5-US1-UI3 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E5-US1-TC2 | Verify capacity validation. Expected: Validation rejects both values. Consolidated expected result: Validation or authorization fails; previous configuration remains. | UI can show the outcome | E5-US1-UI1 (Vendor Portal, scaffold); E5-US1-UI2 (Vendor Portal, not started); E5-US1-UI3 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E5-US1-TC3 | Verify temporary change and auto-restore. Expected: Slots recalculate immediately; confirmed orders remain; capacity restores to 12 afterwards. | UI can show the outcome | E5-US1-UI1 (Vendor Portal, scaffold); E5-US1-UI2 (Vendor Portal, not started); E5-US1-UI3 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E5-US1-TC4 | Verify weighting. Expected: Custom cake consumes proportionally more capacity. | UI can show the outcome | E5-US1-UI1 (Vendor Portal, scaffold); E5-US1-UI2 (Vendor Portal, not started); E5-US1-UI3 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E5-US1-TC5 | Verify live load view. Expected: Current load, remaining capacity and upcoming occupancy are shown. | UI can show the outcome | E5-US1-UI1 (Vendor Portal, scaffold); E5-US1-UI2 (Vendor Portal, not started); E5-US1-UI3 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E5-US1-TC6 | Boundary scenario: Capacity threshold boundary. Expected: At-capacity state never accepts extra load; over-capacity slot unavailable. | UI can show the outcome | E5-US1-UI1 (Vendor Portal, scaffold); E5-US1-UI2 (Vendor Portal, not started); E5-US1-UI3 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

### E5-US2: Order Throttling and Automatic Capacity Pauses

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given a slot has reached its capacity, When a customer attempts to order into that slot, Then the order is not accepted for that slot and alternative slots are offered.
- AC2. Given capacity frees up because an order is cancelled, When the engine recalculates, Then the slot becomes available again.
- AC3. Given the live queue exceeds the safe threshold, When a new order arrives, Then intake is paused automatically and the vendor is notified.
- AC4. Given I review the queue and choose to resume, When I tap Resume, Then intake continues within the capacity limits I have set.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E5-US2-TC1 | Verify throttling. Expected: Order is not accepted for that slot and alternatives are offered. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold); E5-US2-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E5-US2-TC2 | Verify recalculation. Expected: Slot becomes available again. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold); E5-US2-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E5-US2-TC3 | Verify auto-pause. Expected: Intake pauses automatically and vendor is notified. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold); E5-US2-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E5-US2-TC4 | Verify resume. Expected: Intake continues within capacity limits. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold); E5-US2-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E5-US2-TC5 | Boundary scenario: Automatic pause threshold. Expected: System pauses exactly when exhausted and reopens when capacity available. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold); E5-US2-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

### E5-US3: Customer Delivery Slot Selection

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I am at checkout, When I open the slot selector, Then I see available and full slots with live availability for today and upcoming days.
- AC2. Given the kitchen is at full capacity now, When I view the selector, Then the order is not accepted for immediate delivery and the next available windows are shown.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E5-US3-TC1 | Verify slot list. Expected: Available and full slots are displayed correctly. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E5-US3-TC2 | Verify behaviour at full capacity. Expected: Immediate delivery is not offered and the next windows are shown. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E5-US3-TC3 | Negative scenario: Reject stale or full selected slot. Expected: Fresh capacity check rejects stale slot and shows alternatives. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E5-US3-TC4 | Boundary scenario: Slot opening/closing boundary. Expected: Earliest valid slot shown; too-soon slot hidden. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

### E5-US4: Atomic Slot Reservation and Double-Booking Prevention

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given one place remains in a slot, When two customers confirm at the same moment, Then only the first confirmed order is accepted and the second customer is asked to choose another slot.
- AC2. Given a customer holds a slot but does not complete payment, When the hold time expires, Then the place is released back to availability.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E5-US4-TC1 | Verify no double-booking. Expected: Only one is accepted; the other is asked to choose another slot. Consolidated expected result: One succeeds and one receives unavailable-slot response; utilization not over limit. Consolidated expected result: At most one committed reservation; totals remain consistent. | UI can show the outcome | E5-US4-UI1 (Customer App, scaffold); E5-US4-UI2 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E5-US4-TC2 | Verify hold release. Expected: Place is released back to availability. | UI can show the outcome | E5-US4-UI1 (Customer App, scaffold); E5-US4-UI2 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E5-US4-TC3 | Boundary scenario: Retry reservation boundary. Expected: One reservation and one order created, never two. | UI can show the outcome | E5-US4-UI1 (Customer App, scaffold); E5-US4-UI2 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |

## E6

### E6-US1: Preparation-Time and Delivery ETA Calculation

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given an order contains items with defined preparation times and the kitchen has active orders, When I place the order, Then the ready time equals baseline preparation time adjusted for queue and conditions.
- AC2. Given the queue grows after I place my order, When the ready time changes, Then my estimate is updated and I am notified.
- AC3. Given preparation time and distance are known, When the app shows my estimate, Then it displays an arrival window derived from all four factors.
- AC4. Given rain is detected in the delivery area, When the estimate is generated, Then extra travel time is added accordingly.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E6-US1-TC1 | Verify estimate composition. Expected: Ready time equals baseline plus queue delay. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold); E17-US1-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E6-US1-TC2 | Verify recalculation and notification. Expected: Customer's estimate updates and a notification is sent. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold); E17-US1-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E6-US1-TC3 | Verify four-factor estimate. Expected: Arrival window reflects all factors. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold); E17-US1-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E6-US1-TC4 | Verify weather factor. Expected: Extra travel time is included. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold); E17-US1-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E6-US1-TC5 | Negative scenario: Reject missing or invalid preparation-time inputs. Expected: Invalid inputs flagged; no impossible negative ETA published. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold); E17-US1-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E6-US1-TC6 | Boundary scenario: Queue-timing boundary. Expected: ETA reflects zero versus queued workload and never predates current time. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold); E17-US1-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

### E6-US2: Weather, Ramadan and Peak-Time Buffering

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given severe weather is reported for my area, When the engine evaluates capacity, Then hourly capacity is reduced by the configured buffer percentage and slots are recalculated.
- AC2. Given severe weather ends, When the weather status clears, Then normal capacity is restored automatically.
- AC3. Given a peak-period buffer is active, When slots are generated, Then each slot includes the additional buffer time.
- AC4. Given I disagree with the buffer for a given day, When I override or reduce it for my kitchen, Then the override is applied and recorded in the audit log.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E6-US2-TC1 | Verify automatic buffering. Expected: Capacity reduces to 9 and slots are recalculated. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold); E6-US2-UI1 (Vendor Portal, not started); E21-US2-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E6-US2-TC2 | Verify restoration. Expected: Normal capacity is restored automatically. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold); E6-US2-UI1 (Vendor Portal, not started); E21-US2-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E6-US2-TC3 | Verify peak buffer. Expected: Each slot includes the additional buffer. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold); E6-US2-UI1 (Vendor Portal, not started); E21-US2-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E6-US2-TC4 | Verify override and audit. Expected: Override applied and logged in audit trail. | Not provable by a screen alone | E5-US3-UI1 (Customer App, scaffold); E6-US2-UI1 (Vendor Portal, not started); E21-US2-UI1 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |
| E6-US2-TC5 | Negative scenario: Handle unavailable weather signal safely. Expected: Fallback policy used and communicated; invalid zero buffer not silently assumed. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold); E6-US2-UI1 (Vendor Portal, not started); E21-US2-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E6-US2-TC6 | Boundary scenario: Peak-window boundary. Expected: Buffer applied only within configured period including documented boundaries. | UI can show the outcome | E5-US3-UI1 (Customer App, scaffold); E6-US2-UI1 (Vendor Portal, not started); E21-US2-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |

### E6-US3: Administrator Buffer Rule Configuration

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I open buffer configuration, When I create a rule with period, affected area and buffer percentage, Then the rule is saved and applied to affected vendors.
- AC2. Given I edit or delete a rule, When I save, Then slot calculations reflect the change within one minute.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E6-US3-TC1 | Verify rule management. Expected: Rule applies to affected vendors. | UI can show the outcome | E6-US3-UI1 (Admin Portal, scaffold); E6-US3-UI2 (Admin Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E6-US3-TC2 | Verify update timing. Expected: Slot calculations update within one minute. | UI can show the outcome | E6-US3-UI1 (Admin Portal, scaffold); E6-US3-UI2 (Admin Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E6-US3-TC3 | Negative scenario: Reject unauthorized global buffer change. Expected: 403 and published configuration unchanged. | UI can show the outcome | E6-US3-UI1 (Admin Portal, scaffold); E6-US3-UI2 (Admin Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E6-US3-TC4 | Boundary scenario: Buffer configuration limits. Expected: Invalid bounds rejected; permitted maximum saved and audited. | Not provable by a screen alone | E6-US3-UI1 (Admin Portal, scaffold); E6-US3-UI2 (Admin Portal, scaffold) | None | Open. A screen cannot pass this test. |

### E6-US4: Customer-Facing Delay Explanations

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given my estimated time increases by more than ten minutes, When the change is applied, Then I receive a notification stating the reason, such as kitchen load or weather.
- AC2. Given the reason is weather-related, When the notification is shown, Then it names the weather condition.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E6-US4-TC1 | Verify explanation. Expected: Customer receives a notification stating the reason. | UI can show the outcome | E6-US4-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E6-US4-TC2 | Verify weather reason. Expected: Reason names the weather condition. | UI can show the outcome | E6-US4-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E6-US4-TC3 | Negative scenario: Do not display fabricated delay reason. Expected: Clearly states estimate uncertainty and verified available reason only. | UI can show the outcome | E6-US4-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E6-US4-TC4 | Boundary scenario: ETA revision boundary. Expected: Customer sees consistent new estimate and a suitable delay explanation. | UI can show the outcome | E6-US4-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

## E7

### E7-US1: Real-Time Order Intake and Ticket Details

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given the kitchen board is open, When a customer places an order, Then the order appears within five seconds with an audible alert.
- AC2. Given the board is on another tab, When an order arrives, Then the browser shows a notification and the tab title flashes.
- AC3. Given an order has custom text, swaps and a reference image, When I open the ticket, Then all details and the image are displayed.
- AC4. Given the order has an allergen exclusion, When I view the ticket, Then the exclusion is highlighted prominently.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E7-US1-TC1 | Verify intake and alert. Expected: Order appears within five seconds with audible alert. | Not provable by a screen alone | E7-US1-UI1 (Vendor Portal, scaffold); E7-US1-UI2 (Vendor Portal, scaffold) | None | Open. A screen cannot pass this test. |
| E7-US1-TC2 | Verify notification when tab not active. Expected: Browser notification appears and tab title flashes. | UI can show the outcome | E7-US1-UI1 (Vendor Portal, scaffold); E7-US1-UI2 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E7-US1-TC3 | Verify ticket details. Expected: All details and image are displayed. | UI can show the outcome | E7-US1-UI1 (Vendor Portal, scaffold); E7-US1-UI2 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E7-US1-TC4 | Verify prominence. Expected: Exclusion is highlighted prominently. | UI can show the outcome | E7-US1-UI1 (Vendor Portal, scaffold); E7-US1-UI2 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E7-US1-TC5 | Negative scenario: Prevent order ticket cross-vendor access. Expected: Access denied; no order details or image leaked. | UI can show the outcome | E7-US1-UI1 (Vendor Portal, scaffold); E7-US1-UI2 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E7-US1-TC6 | Boundary scenario: Real-time intake latency boundary. Expected: Each new order appears once with complete item customizations. | UI can show the outcome | E7-US1-UI1 (Vendor Portal, scaffold); E7-US1-UI2 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

### E7-US2: Order Acceptance and Rejection

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given a new order is displayed, When I accept it, Then the order moves to Preparing and the customer is notified.
- AC2. Given I reject an order, When I select a reason, Then the customer is notified, any online payment is flagged for refund and the rejection is logged with my identity.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E7-US2-TC1 | Verify acceptance. Expected: Order moves to Preparing and customer is notified. | UI can show the outcome | E7-US1-UI2 (Vendor Portal, scaffold); E7-US2-UI1 (Vendor Portal, not started); E7-US3-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E7-US2-TC2 | Verify rejection audit and refund flag. Expected: Customer is notified, payment flagged for refund and rejection is logged with staff identity. | Not provable by a screen alone | E7-US1-UI2 (Vendor Portal, scaffold); E7-US2-UI1 (Vendor Portal, not started); E7-US3-UI1 (Vendor Portal, scaffold) | None | Open. A screen cannot pass this test. |
| E7-US2-TC3 | Negative scenario: Reject duplicate or expired order decision. Expected: No illegal transition or duplicate acceptance; reason recorded. | UI can show the outcome | E7-US1-UI2 (Vendor Portal, scaffold); E7-US2-UI1 (Vendor Portal, not started); E7-US3-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E7-US2-TC4 | Boundary scenario: Mandatory rejection reason boundary. Expected: Empty reason blocked; valid reason stored and reflected to customer. | Not provable by a screen alone | E7-US1-UI2 (Vendor Portal, scaffold); E7-US2-UI1 (Vendor Portal, not started); E7-US3-UI1 (Vendor Portal, scaffold) | None | Open. A screen cannot pass this test. |

### E7-US3: Live Kitchen Board and Preparation Milestones

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given there are orders in different states, When I open the board, Then each order appears in the correct column with elapsed time.
- AC2. Given I move an order to the next stage, When I tap the status button, Then the board and the customer app update in real time.
- AC3. Given an order is in Preparing, When I mark it 80% prepared, Then the dispatch engine is signalled to begin rider assignment.
- AC4. Given I mark the order Ready/Bagged, When the status changes, Then the assigned rider receives a pickup alert.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E7-US3-TC1 | Verify board layout. Expected: Each order appears in the correct column with elapsed time. | UI can show the outcome | E7-US3-UI1 (Vendor Portal, scaffold); E7-US3-UI2 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E7-US3-TC2 | Verify real-time sync. Expected: Board and customer app update in real time. | UI can show the outcome | E7-US3-UI1 (Vendor Portal, scaffold); E7-US3-UI2 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E7-US3-TC3 | Verify dispatch trigger. Expected: Dispatch engine begins rider assignment. | UI can show the outcome | E7-US3-UI1 (Vendor Portal, scaffold); E7-US3-UI2 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E7-US3-TC4 | Verify pickup alert. Expected: Rider receives pickup alert. | UI can show the outcome | E7-US3-UI1 (Vendor Portal, scaffold); E7-US3-UI2 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E7-US3-TC5 | Negative scenario: Block invalid preparation status transitions. Expected: Invalid transitions denied; kitchen board unchanged. | Not provable by a screen alone | E7-US3-UI1 (Vendor Portal, scaffold); E7-US3-UI2 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |
| E7-US3-TC6 | Boundary scenario: Eighty-percent preparation boundary. Expected: Assignment begins at required threshold once; Ready triggers pickup alert. | UI can show the outcome | E7-US3-UI1 (Vendor Portal, scaffold); E7-US3-UI2 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |

### E7-US4: Voice-Assisted Kitchen Updates

Story status: Not started.

Acceptance criteria:
- AC1. Given the voice feature is enabled, When I say 'Order 123 ready', Then the system confirms the command and sets order 123 to Ready.
- AC2. Given the command is not recognised, When I speak, Then the system asks me to repeat and makes no status change.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E7-US4-TC1 | Verify voice update. Expected: System confirms and sets order 123 to Ready. | UI can show the outcome | E7-US4-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E7-US4-TC2 | Negative scenario: Reject unrecognised or wrong-order voice command. Expected: System asks for clarification; no unauthorized order modified. Consolidated expected result: System asks to repeat; no status change. | UI can show the outcome | E7-US4-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E7-US4-TC3 | Boundary scenario: Voice confidence boundary. Expected: Only threshold-meeting recognised command proceeds after confirmation. | UI can show the outcome | E7-US4-UI1 (Vendor Portal, not started) | None | Open. Not started. |

## E8

### E8-US1: Confidential Recipe Creation and Access Control

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I am the owner on a dish's recipe screen, When I enter ingredients and quantities, Then they are saved and visible only to me.
- AC2. Given I leave the quantity blank or enter an invalid unit, When I save, Then validation requires a valid quantity and unit.
- AC3. Given a customer or administrator calls any public or admin API for a dish, When the response is returned, Then it contains nutrition and allergen results but not ingredient quantities.
- AC4. Given a staff member without recipe permission opens the dish, When they view the details, Then the recipe section is not displayed.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E8-US1-TC1 | Verify private recipe saving. Expected: Recipe is saved and visible only to the owner. | UI can show the outcome | E8-US1-UI1 (Vendor Portal, not started); E8-US1-UI2 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E8-US1-TC2 | Verify validation. Expected: Validation requires a valid quantity and unit. | UI can show the outcome | E8-US1-UI1 (Vendor Portal, not started); E8-US1-UI2 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E8-US1-TC3 | Verify confidentiality. Expected: Responses contain nutrition and allergens only, no ingredient quantities. Consolidated expected result: No proprietary quantities returned without recipe-owner permission. | UI can show the outcome | E8-US1-UI1 (Vendor Portal, not started); E8-US1-UI2 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E8-US1-TC4 | Verify recipe hiding. Expected: Recipe section is not displayed. | UI can show the outcome | E8-US1-UI1 (Vendor Portal, not started); E8-US1-UI2 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E8-US1-TC5 | Boundary scenario: Recipe input boundary. Expected: Only valid positive numeric quantity with recognized unit saved. | UI can show the outcome | E8-US1-UI1 (Vendor Portal, not started); E8-US1-UI2 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

### E8-US2: Nutrition Computation and Customer Badges

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given a recipe is saved, When the nutrition API responds, Then calculated values per serving are stored for review.
- AC2. Given the nutrition API is unreachable, When I save a recipe, Then the dish is saved without a nutrition badge and flagged for retry, and ordering is not blocked.
- AC3. Given a dish has calculated nutrition, When I view the item, Then a badge shows calories, macronutrients and allergens.
- AC4. Given a dish has no nutrition data, When I view the item, Then no misleading values are shown.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E8-US2-TC1 | Verify API result storage. Expected: Calories, macros and allergens per serving are stored for review. | Not provable by a screen alone | E3-US1-UI3 (Customer App, scaffold); E8-US2-UI1 (Vendor Portal, scaffold) | None | Open. A screen cannot pass this test. |
| E8-US2-TC2 | Verify customer view. Expected: Badge shows calories, macronutrients and allergens. | UI can show the outcome | E3-US1-UI3 (Customer App, scaffold); E8-US2-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E8-US2-TC3 | Verify absent data. Expected: No nutrition values are shown. | UI can show the outcome | E3-US1-UI3 (Customer App, scaffold); E8-US2-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E8-US2-TC4 | Negative scenario: Handle nutrition API partial failure. Expected: Recipe persists; no misleading badge; retry state visible. Consolidated expected result: Dish is saved without badge, flagged for retry; ordering not blocked. | Not provable by a screen alone | E3-US1-UI3 (Customer App, scaffold); E8-US2-UI1 (Vendor Portal, scaffold) | None | Open. A screen cannot pass this test. |
| E8-US2-TC5 | Boundary scenario: Nutrition per-serving boundary. Expected: Per-serving calculations correct with supported rounding and no division by zero. | UI can show the outcome | E3-US1-UI3 (Customer App, scaffold); E8-US2-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

### E8-US3: Dynamic Allergen Warnings

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given a recipe contains eggs, soy, nuts, dairy or gluten, When I open the dish description, Then a warning states that the dish contains or may contain those ingredients.
- AC2. Given the vendor edits the recipe to remove an allergen, When the recipe is saved, Then the warning updates automatically.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E8-US3-TC1 | Verify warning text. Expected: Warning states dish contains or may contain eggs and soy. | UI can show the outcome | E3-US1-UI3 (Customer App, scaffold); E8-US2-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E8-US3-TC2 | Verify refresh. Expected: Warning no longer lists eggs. | UI can show the outcome | E3-US1-UI3 (Customer App, scaffold); E8-US2-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E8-US3-TC3 | Negative scenario: Reject false allergen-free statement. Expected: Tag blocked or corrected; egg warning persists. | Not provable by a screen alone | E3-US1-UI3 (Customer App, scaffold); E8-US2-UI1 (Vendor Portal, scaffold) | None | Open. A screen cannot pass this test. |
| E8-US3-TC4 | Boundary scenario: Allergen update boundary. Expected: Warning disappears only after valid removal and reappears on reintroduction. | UI can show the outcome | E3-US1-UI3 (Customer App, scaffold); E8-US2-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

### E8-US4: Recipe Changes and BOM/Nutrition Consistency

Story status: Not started.

Acceptance criteria:
- AC1. Given I change an ingredient quantity, When I save the recipe, Then nutrition values are recalculated and the BOM for the dish is updated.
- AC2. Given there are active orders under the old recipe, When I save, Then active orders keep their original BOM deduction and new orders use the new one.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E8-US4-TC1 | Verify consistency. Expected: Nutrition recalculated and BOM updated. | UI can show the outcome | E8-US4-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E8-US4-TC2 | Verify in-flight orders. Expected: Active order keeps original deduction; new orders use the new BOM. Consolidated expected result: Old order uses frozen snapshot; new order uses revised quantities. | UI can show the outcome | E8-US4-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E8-US4-TC3 | Boundary scenario: Recalculation failure boundary. Expected: BOM revision consistent; nutrition flagged pending rather than stale. | UI can show the outcome | E8-US4-UI1 (Vendor Portal, not started) | None | Open. Not started. |

## E9

### E9-US1: Ingredient Master Data and BOM Setup

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I open Inventory, When I add an ingredient with unit, quantity and reorder level, Then the item is saved and appears in the stock list.
- AC2. Given I record a stock intake from a purchase, When I save it, Then the quantity increases and the entry is logged with my identity.
- AC3. Given a dish exists, When I link ingredients and quantities per serving, Then the BOM is saved for that dish.
- AC4. Given I add many dishes, When I use bulk entry, Then multiple BOMs can be created without re-entering shared ingredients.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E9-US1-TC1 | Verify ingredient creation and intake logging. Expected: Stock becomes 30 and the intake is logged with the user's identity. | UI can show the outcome | E9-US1-UI1 (Vendor Portal, scaffold); E9-US1-UI2 (Vendor Portal, not started); E9-US1-UI3 (Vendor Portal, not started); E9-US1-UI4 (Vendor Portal, scaffold); E9-US1-UI5 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E9-US1-TC2 | Verify BOM saving. Expected: BOM is saved for the dish. | UI can show the outcome | E9-US1-UI1 (Vendor Portal, scaffold); E9-US1-UI2 (Vendor Portal, not started); E9-US1-UI3 (Vendor Portal, not started); E9-US1-UI4 (Vendor Portal, scaffold); E9-US1-UI5 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E9-US1-TC3 | Verify multiple BOM creation. Expected: All BOMs are created without re-entering shared ingredients. | UI can show the outcome | E9-US1-UI1 (Vendor Portal, scaffold); E9-US1-UI2 (Vendor Portal, not started); E9-US1-UI3 (Vendor Portal, not started); E9-US1-UI4 (Vendor Portal, scaffold); E9-US1-UI5 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E9-US1-TC4 | Negative scenario: Reject invalid stock unit and duplicate ingredient. Expected: Input rejected; no ambiguous stock item created. | UI can show the outcome | E9-US1-UI1 (Vendor Portal, scaffold); E9-US1-UI2 (Vendor Portal, not started); E9-US1-UI3 (Vendor Portal, not started); E9-US1-UI4 (Vendor Portal, scaffold); E9-US1-UI5 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E9-US1-TC5 | Boundary scenario: Stock master boundary. Expected: Zero is permitted if configured; negative forbidden; balance calculated precisely. | UI can show the outcome | E9-US1-UI1 (Vendor Portal, scaffold); E9-US1-UI2 (Vendor Portal, not started); E9-US1-UI3 (Vendor Portal, not started); E9-US1-UI4 (Vendor Portal, scaffold); E9-US1-UI5 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |

### E9-US2: Automated Stock Movement and Low-Stock Controls

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given a dish with a BOM is ordered, When the order is confirmed, Then stock for each BOM ingredient is reduced by quantity multiplied by dish count.
- AC2. Given the order is cancelled before preparation, When the cancellation is recorded, Then the deducted stock is restored.
- AC3. Given an ingredient falls below its reorder level, When stock is updated, Then an alert is shown in the portal and sent as a notification.
- AC4. Given stock for an ingredient reaches zero, When customers view dishes that need it, Then those dishes are marked unavailable until restocked.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E9-US2-TC1 | Verify stock reduction. Expected: Flour reduces by 1.0 kg and other BOM ingredients reduce likewise. | UI can show the outcome | E3-US2-UI1 (Customer App, scaffold); E10-US1-UI1 (Customer App, not started); E9-US1-UI1 (Vendor Portal, scaffold); E9-US2-UI1 (Vendor Portal, not started); E9-US2-UI2 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E9-US2-TC2 | Verify restoration. Expected: Deducted stock is restored. | UI can show the outcome | E3-US2-UI1 (Customer App, scaffold); E10-US1-UI1 (Customer App, not started); E9-US1-UI1 (Vendor Portal, scaffold); E9-US2-UI1 (Vendor Portal, not started); E9-US2-UI2 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E9-US2-TC3 | Verify alert threshold. Expected: Alert shown in portal and notification sent. | UI can show the outcome | E3-US2-UI1 (Customer App, scaffold); E10-US1-UI1 (Customer App, not started); E9-US1-UI1 (Vendor Portal, scaffold); E9-US2-UI1 (Vendor Portal, not started); E9-US2-UI2 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E9-US2-TC4 | Verify stock-out protection. Expected: Those dishes are marked unavailable until restocked. | UI can show the outcome | E3-US2-UI1 (Customer App, scaffold); E10-US1-UI1 (Customer App, not started); E9-US1-UI1 (Vendor Portal, scaffold); E9-US2-UI1 (Vendor Portal, not started); E9-US2-UI2 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E9-US2-TC5 | Negative scenario: Prevent stock double deduction. Expected: Stock deducted once; single auditable movement. | Not provable by a screen alone | E3-US2-UI1 (Customer App, scaffold); E10-US1-UI1 (Customer App, not started); E9-US1-UI1 (Vendor Portal, scaffold); E9-US2-UI1 (Vendor Portal, not started); E9-US2-UI2 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |
| E9-US2-TC6 | Boundary scenario: Stockout threshold boundary. Expected: Exact availability accepted; inadequate stock blocks next order. | Not provable by a screen alone | E3-US2-UI1 (Customer App, scaffold); E10-US1-UI1 (Customer App, not started); E9-US1-UI1 (Vendor Portal, scaffold); E9-US2-UI1 (Vendor Portal, not started); E9-US2-UI2 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |

### E9-US3: Wastage, Yield and Variance Analysis

Story status: Not started.

Acceptance criteria:
- AC1. Given I open the wastage form, When I select an ingredient, quantity and reason (spoilage, expiry, preparation error), Then stock reduces and the loss is recorded with date and my identity.
- AC2. Given I enter a quantity larger than current stock, When I submit, Then validation rejects the entry.
- AC3. Given orders and physical stock counts exist for a period, When I open the variance report, Then expected usage, actual usage and variance are displayed per ingredient.
- AC4. Given variance exceeds my configured threshold, When the report is generated, Then the ingredient is highlighted.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E9-US3-TC1 | Verify wastage entry. Expected: Stock reduces by 2 L and loss is recorded with date and identity. | UI can show the outcome | E9-US3-UI1 (Vendor Portal, not started); E9-US3-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E9-US3-TC2 | Verify validation. Expected: Entry is rejected. Consolidated expected result: Validation prevents negative stock and saves no loss entry. | UI can show the outcome | E9-US3-UI1 (Vendor Portal, not started); E9-US3-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E9-US3-TC3 | Verify variance computation. Expected: Expected usage, actual usage and variance per ingredient are shown. | UI can show the outcome | E9-US3-UI1 (Vendor Portal, not started); E9-US3-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E9-US3-TC4 | Verify highlighting. Expected: Ingredient is highlighted. | UI can show the outcome | E9-US3-UI1 (Vendor Portal, not started); E9-US3-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E9-US3-TC5 | Boundary scenario: Variance alert boundary. Expected: Correct boundary and alert severity applied. | UI can show the outcome | E9-US3-UI1 (Vendor Portal, not started); E9-US3-UI2 (Vendor Portal, not started) | None | Open. Not started. |

### E9-US4: Rule-Based Material Requirements Planning and Ingredient Storage Rules

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I select a look-back period (for example daily for high-volume kitchens or weekly/monthly for small kitchens), When I run MRP, Then the system lists required quantity, current stock and shortfall for each ingredient.
- AC2. Given there is no sales history for the period, When I run MRP, Then the system states that there is not enough data and does not show misleading figures.
- AC3. Given an ingredient is marked perishable, When MRP runs, Then its requirement is based on confirmed upcoming orders rather than long-term stock levels.
- AC4. Given an ingredient is marked non-perishable, When MRP runs, Then its requirement uses the stock-holding buffer and historical sales.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E9-US4-TC1 | Verify forecast. Expected: Required quantity, current stock and shortfall are listed per ingredient. | UI can show the outcome | E9-US1-UI1 (Vendor Portal, scaffold); E9-US1-UI2 (Vendor Portal, not started); E9-US4-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E9-US4-TC2 | Verify insufficient-data message. Expected: System states there is insufficient data and shows no misleading figures. | UI can show the outcome | E9-US1-UI1 (Vendor Portal, scaffold); E9-US1-UI2 (Vendor Portal, not started); E9-US4-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E9-US4-TC3 | Negative scenario: Reject unsupported or missing historical period. Expected: Clear insufficient-data message; no fabricated demand. | UI can show the outcome | E9-US1-UI1 (Vendor Portal, scaffold); E9-US1-UI2 (Vendor Portal, not started); E9-US4-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E9-US4-TC4 | Boundary scenario: Shortfall computation boundary. Expected: No purchase needed at equality; shortfall exactly one unit otherwise. | UI can show the outcome | E9-US1-UI1 (Vendor Portal, scaffold); E9-US1-UI2 (Vendor Portal, not started); E9-US4-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E9-US4-TC5 | Verify perishable logic. Expected: Requirement is based on confirmed upcoming orders. | UI can show the outcome | E9-US1-UI1 (Vendor Portal, scaffold); E9-US1-UI2 (Vendor Portal, not started); E9-US4-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E9-US4-TC6 | Verify non-perishable logic. Expected: Requirement uses stock-holding buffer and historical sales. | UI can show the outcome | E9-US1-UI1 (Vendor Portal, scaffold); E9-US1-UI2 (Vendor Portal, not started); E9-US4-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E9-US4-TC7 | Negative scenario: Exclude expired stock from usable projection. Expected: Expired quantity cannot offset required material. | UI can show the outcome | E9-US1-UI1 (Vendor Portal, scaffold); E9-US1-UI2 (Vendor Portal, not started); E9-US4-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E9-US4-TC8 | Boundary scenario: Stock-buffer rule boundary. Expected: Only eligible orders/stock counted with correct category buffer. | UI can show the outcome | E9-US1-UI1 (Vendor Portal, scaffold); E9-US1-UI2 (Vendor Portal, not started); E9-US4-UI1 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |

## E10

### E10-US1: Order-to-ERP Invoicing and Customer Invoice Access

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given an order is confirmed, When the order is saved, Then an invoice with a unique number, itemised lines, discounts, delivery charge and total is generated.
- AC2. Given an order is modified before preparation, When the change is saved, Then the invoice is revised and the previous version is retained.
- AC3. Given my order has been paid, When I open Order History, Then I can view and download the invoice.
- AC4. Given I open another customer's invoice URL, When the request is processed, Then access is denied.
- AC5. Given a customer places and pays for an order, When the order is confirmed, Then stock is deducted by BOM, an invoice is created, the payment is recorded and revenue appears in the financial dashboard without any manual step.
- AC6. Given an order is cancelled before preparation, When the cancellation is saved, Then stock is restored, the invoice is voided and the financial entries are reversed.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E10-US1-TC1 | Verify invoice generation. Expected: Invoice with unique number, itemised lines, discount, delivery and total is created. | UI can show the outcome | E10-US1-UI1 (Customer App, not started); E17-US2-UI2 (Customer App, not started); E9-US1-UI1 (Vendor Portal, scaffold); E10-US1-UI2 (Vendor Portal, not started); E10-US1-UI3 (Vendor Portal, scaffold); E12-US1-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E10-US1-TC2 | Verify versioning. Expected: Invoice is revised and previous version retained. | UI can show the outcome | E10-US1-UI1 (Customer App, not started); E17-US2-UI2 (Customer App, not started); E9-US1-UI1 (Vendor Portal, scaffold); E10-US1-UI2 (Vendor Portal, not started); E10-US1-UI3 (Vendor Portal, scaffold); E12-US1-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E10-US1-TC3 | Verify access. Expected: Invoice can be viewed and downloaded. | UI can show the outcome | E10-US1-UI1 (Customer App, not started); E17-US2-UI2 (Customer App, not started); E9-US1-UI1 (Vendor Portal, scaffold); E10-US1-UI2 (Vendor Portal, not started); E10-US1-UI3 (Vendor Portal, scaffold); E12-US1-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E10-US1-TC4 | Verify authorization. Expected: Access is denied. | UI can show the outcome | E10-US1-UI1 (Customer App, not started); E17-US2-UI2 (Customer App, not started); E9-US1-UI1 (Vendor Portal, scaffold); E10-US1-UI2 (Vendor Portal, not started); E10-US1-UI3 (Vendor Portal, scaffold); E12-US1-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E10-US1-TC5 | Verify end-to-end flow. Expected: Stock deducted, invoice created, payment recorded and revenue shown with no manual step. | UI can show the outcome | E10-US1-UI1 (Customer App, not started); E17-US2-UI2 (Customer App, not started); E9-US1-UI1 (Vendor Portal, scaffold); E10-US1-UI2 (Vendor Portal, not started); E10-US1-UI3 (Vendor Portal, scaffold); E12-US1-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E10-US1-TC6 | Verify reversal. Expected: Stock restored, invoice voided, financial entries reversed. | UI can show the outcome | E10-US1-UI1 (Customer App, not started); E17-US2-UI2 (Customer App, not started); E9-US1-UI1 (Vendor Portal, scaffold); E10-US1-UI2 (Vendor Portal, not started); E10-US1-UI3 (Vendor Portal, scaffold); E12-US1-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E10-US1-TC7 | Reject invoice download using an expired, revoked or missing authentication token. Expected: Each request is rejected with 401; invoice content is never disclosed. | Not provable by a screen alone | E10-US1-UI1 (Customer App, not started); E17-US2-UI2 (Customer App, not started); E9-US1-UI1 (Vendor Portal, scaffold); E10-US1-UI2 (Vendor Portal, not started); E10-US1-UI3 (Vendor Portal, scaffold); E12-US1-UI1 (Vendor Portal, scaffold) | None | Open. A screen cannot pass this test. |
| E10-US1-TC8 | Boundary scenario: Invoice idempotency boundary. Expected: One invoice number issued; revisions versioned without duplicate revenue. | UI can show the outcome | E10-US1-UI1 (Customer App, not started); E17-US2-UI2 (Customer App, not started); E9-US1-UI1 (Vendor Portal, scaffold); E10-US1-UI2 (Vendor Portal, not started); E10-US1-UI3 (Vendor Portal, scaffold); E12-US1-UI1 (Vendor Portal, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

### E10-US2: Payment Posting Against Invoices

Story status: Not started.

Acceptance criteria:
- AC1. Given a customer pays online, When the gateway confirms, Then the invoice is marked Paid with method and transaction reference.
- AC2. Given a rider delivers a COD order, When the rider confirms cash collected, Then the invoice is recorded as Paid – Cash and appears in the COD reconciliation list.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E10-US2-TC1 | Verify payment status. Expected: Invoice is marked Paid with method and reference. | UI can show the outcome | E10-US2-UI2 (Rider App, not started); E10-US2-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E10-US2-TC2 | Verify COD recording. Expected: Invoice is Paid – Cash and listed in COD reconciliation. | UI can show the outcome | E10-US2-UI2 (Rider App, not started); E10-US2-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E10-US2-TC3 | Negative scenario: Reject duplicated online transaction reference. Expected: One invoice payment and one ledger entry; replay safely acknowledged. | UI can show the outcome | E10-US2-UI2 (Rider App, not started); E10-US2-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E10-US2-TC4 | Boundary scenario: Partial-payment boundary. Expected: Correct remaining, paid or overpayment flag; no false fully paid state. | UI can show the outcome | E10-US2-UI2 (Rider App, not started); E10-US2-UI1 (Vendor Portal, not started) | None | Open. Not started. |

### E10-US3: Failed Payments and Refund Tracking

Story status: Not started.

Acceptance criteria:
- AC1. Given a gateway payment fails, When the failure is returned, Then the order is not confirmed and I can retry or choose another method.
- AC2. Given a vendor rejects a prepaid order, When the rejection is saved, Then the payment is flagged for refund with a status visible to me.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E10-US3-TC1 | Verify failure handling. Expected: Order is not confirmed; customer can retry or switch method. | UI can show the outcome | E10-US3-UI1 (Customer App, not started); E10-US3-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E10-US3-TC2 | Verify refund flag. Expected: Payment is flagged for refund with status visible to customer. | UI can show the outcome | E10-US3-UI1 (Customer App, not started); E10-US3-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E10-US3-TC3 | Negative scenario: Reject late or unauthorized refund change. Expected: No paid-to-refunded change without matching authorized event. | UI can show the outcome | E10-US3-UI1 (Customer App, not started); E10-US3-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E10-US3-TC4 | Boundary scenario: Gateway timeout boundary. Expected: Order not marked Paid; retry avoids duplicate charge. | Not provable by a screen alone | E10-US3-UI1 (Customer App, not started); E10-US3-UI2 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |

### E10-US4: Cash-on-Delivery Reconciliation

Story status: Not started.

Acceptance criteria:
- AC1. Given several COD orders were delivered, When I open reconciliation, Then I see collected cash per rider and unmatched differences.
- AC2. Given a discrepancy exists, When I flag it, Then an entry is created for administrator review.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E10-US4-TC1 | Verify totals. Expected: Collected cash per rider and differences are shown. | UI can show the outcome | E10-US4-UI1 (Vendor Portal, not started); E10-US4-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E10-US4-TC2 | Verify escalation. Expected: Entry is created for administrator review. | UI can show the outcome | E10-US4-UI1 (Vendor Portal, not started); E10-US4-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E10-US4-TC3 | Negative scenario: Reject nonexistent rider COD settlement. Expected: Mismatch flagged and not automatically reconciled. | UI can show the outcome | E10-US4-UI1 (Vendor Portal, not started); E10-US4-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E10-US4-TC4 | Boundary scenario: COD discrepancy boundary. Expected: Exact match closed; both discrepancies recorded with correct signs. | UI can show the outcome | E10-US4-UI1 (Vendor Portal, not started); E10-US4-UI2 (Vendor Portal, not started) | None | Open. Not started. |

## E11

### E11-US1: Discount, Voucher and Scheduled Promotion Rules

Story status: Not started.

Acceptance criteria:
- AC1. Given I open the Marketing module, When I create a 15% voucher with expiry and usage limit, Then the voucher is saved and becomes redeemable.
- AC2. Given I set an end date earlier than the start date, When I save, Then validation rejects the offer.
- AC3. Given a promotion is scheduled for a start and end time, When the start time arrives, Then the promotion becomes active without manual action.
- AC4. Given the end time passes, When a customer checks out, Then the promotion is no longer applied.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E11-US1-TC1 | Verify voucher creation. Expected: Voucher is saved and redeemable. | UI can show the outcome | E11-US1-UI1 (Vendor Portal, not started); E11-US1-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E11-US1-TC2 | Verify validation. Expected: Save is rejected. | UI can show the outcome | E11-US1-UI1 (Vendor Portal, not started); E11-US1-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E11-US1-TC3 | Verify scheduling. Expected: Promotion becomes active automatically. | UI can show the outcome | E11-US1-UI1 (Vendor Portal, not started); E11-US1-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E11-US1-TC4 | Verify expiry. Expected: Promotion is not applied. | UI can show the outcome | E11-US1-UI1 (Vendor Portal, not started); E11-US1-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E11-US1-TC5 | Negative scenario: Reject stacked unauthorized offers. Expected: Exclusivity policy enforced; no unintended double deduction. | UI can show the outcome | E11-US1-UI1 (Vendor Portal, not started); E11-US1-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E11-US1-TC6 | Boundary scenario: Voucher usage boundary. Expected: Exactly allowed redemptions accepted; next rejected. | UI can show the outcome | E11-US1-UI1 (Vendor Portal, not started); E11-US1-UI2 (Vendor Portal, not started) | None | Open. Not started. |

### E11-US2: Combo Offer Setup and Availability

Story status: Not started.

Acceptance criteria:
- AC1. Given I select items and set a bundle price, When I publish the combo, Then customers see the combo as a single menu entry.
- AC2. Given a combo item becomes unavailable, When customers view the combo, Then the combo is marked unavailable.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E11-US2-TC1 | Verify combo display. Expected: Combo shows as a single menu entry. | UI can show the outcome | E11-US2-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E11-US2-TC2 | Verify propagation. Expected: Combo is marked unavailable. Consolidated expected result: Combo blocked with clear reason. | Not provable by a screen alone | E11-US2-UI1 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |
| E11-US2-TC3 | Boundary scenario: Combo price boundary. Expected: Price validation and configured pricing rule applied. | UI can show the outcome | E11-US2-UI1 (Vendor Portal, not started) | None | Open. Not started. |

### E11-US3: Offer Redemption and Performance Reports

Story status: Not started.

Acceptance criteria:
- AC1. Given offers have been redeemed, When I open the offer report, Then uses, discount given and resulting sales are displayed per offer.
- AC2. Given no offer has been redeemed, When I open the report, Then zero values are shown rather than errors.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E11-US3-TC1 | Verify analytics. Expected: Uses, discount given and sales are shown per offer. | UI can show the outcome | E11-US3-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E11-US3-TC2 | Verify empty state. Expected: Zeros are displayed with no error. | UI can show the outcome | E11-US3-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E11-US3-TC3 | Negative scenario: Prevent offer report cross-vendor access. Expected: Vendor-specific isolation enforced. | UI can show the outcome | E11-US3-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E11-US3-TC4 | Boundary scenario: Empty/report period boundary. Expected: Zero metrics displayed for empty period; qualifying boundary event counted once. | UI can show the outcome | E11-US3-UI1 (Vendor Portal, not started) | None | Open. Not started. |

## E12

### E12-US1: Revenue, Expense and Payout Dashboard

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I open Expenses, When I add an expense with category, amount and date, Then it is saved and reflected in the dashboard.
- AC2. Given an order is paid, When the payment is confirmed, Then revenue is recorded automatically without manual input.
- AC3. Given orders and expenses exist for a period, When I open the dashboard, Then revenue, commission deducted, payouts and expenses are shown for that period.
- AC4. Given I filter by date range, When I apply the filter, Then all figures update for that range.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E12-US1-TC1 | Verify expense entry. Expected: Expense appears in dashboard. | UI can show the outcome | E12-US1-UI1 (Vendor Portal, scaffold); E12-US1-UI2 (Vendor Portal, not started); E12-US1-UI3 (Vendor Portal, not started); E12-US1-UI4 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E12-US1-TC2 | Verify auto revenue. Expected: Revenue recorded without manual input. | UI can show the outcome | E12-US1-UI1 (Vendor Portal, scaffold); E12-US1-UI2 (Vendor Portal, not started); E12-US1-UI3 (Vendor Portal, not started); E12-US1-UI4 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E12-US1-TC3 | Verify aggregates. Expected: Revenue, commission, payouts and expenses are shown. | Not provable by a screen alone | E12-US1-UI1 (Vendor Portal, scaffold); E12-US1-UI2 (Vendor Portal, not started); E12-US1-UI3 (Vendor Portal, not started); E12-US1-UI4 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |
| E12-US1-TC4 | Verify filtering. Expected: All figures reflect the range. | UI can show the outcome | E12-US1-UI1 (Vendor Portal, scaffold); E12-US1-UI2 (Vendor Portal, not started); E12-US1-UI3 (Vendor Portal, not started); E12-US1-UI4 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E12-US1-TC5 | Negative scenario: Block duplicate revenue on repeated payment event. Expected: Revenue and payout counted once. | Not provable by a screen alone | E12-US1-UI1 (Vendor Portal, scaffold); E12-US1-UI2 (Vendor Portal, not started); E12-US1-UI3 (Vendor Portal, not started); E12-US1-UI4 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |
| E12-US1-TC6 | Boundary scenario: Date-range boundary. Expected: Transaction counted only for documented range; sum reconciles to invoices. | UI can show the outcome | E12-US1-UI1 (Vendor Portal, scaffold); E12-US1-UI2 (Vendor Portal, not started); E12-US1-UI3 (Vendor Portal, not started); E12-US1-UI4 (Vendor Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |

### E12-US2: Net Profit and Dish-Level Margins

Story status: Not started.

Acceptance criteria:
- AC1. Given revenue, commission and costs are recorded, When I view net profit, Then the system displays revenue minus commission and recorded costs for the selected period.
- AC2. Given a dish's BOM cost is known, When I view dish margin, Then the dish-level margin is displayed.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E12-US2-TC1 | Verify calculation. Expected: Net profit equals 30,000. | UI can show the outcome | E12-US2-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E12-US2-TC2 | Verify margin. Expected: Margin of 250 is displayed. | UI can show the outcome | E12-US2-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E12-US2-TC3 | Negative scenario: Prevent false margin from missing BOM cost. Expected: Cost/margin shown as unavailable or provisional, not invented. | UI can show the outcome | E12-US2-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E12-US2-TC4 | Boundary scenario: Profit sign boundary. Expected: Shows zero, negative and positive margins correctly. | UI can show the outcome | E12-US2-UI1 (Vendor Portal, not started) | None | Open. Not started. |

### E12-US3: Financial Export and Access Restrictions

Story status: Not started.

Acceptance criteria:
- AC1. Given a period contains data, When I choose Export, Then a downloadable file containing invoices, payments, expenses and commission is produced.
- AC2. Given I am kitchen staff, When I try to export, Then access is denied.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E12-US3-TC1 | Verify export. Expected: File with invoices, payments, expenses and commission downloads. | UI can show the outcome | E12-US3-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E12-US3-TC2 | Verify access. Expected: Access is denied. | UI can show the outcome | E12-US3-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E12-US3-TC3 | Negative scenario: Prevent staff accessing financial export via URL. Expected: 403; no file or financial rows exposed. | UI can show the outcome | E12-US3-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E12-US3-TC4 | Boundary scenario: Export size boundary. Expected: Produces clear empty result and complete bounded report without truncation. | UI can show the outcome | E12-US3-UI1 (Vendor Portal, not started) | None | Open. Not started. |

## E13

### E13-US1: Preparation-Synchronised Dispatch and Pickup Alerts

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given an order is placed, When the order is accepted by the kitchen, Then no rider is assigned until the 80% prepared or Ready signal is received.
- AC2. Given the 80% signal is received, When dispatch runs, Then the nearest suitable available rider is offered the delivery.
- AC3. Given I have accepted an assignment, When the kitchen marks the order Ready/Bagged, Then I receive a push and audio alert to begin approach.
- AC4. Given I arrive at the vendor, When the order is already bagged, Then I collect the parcel within one to two minutes.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E13-US1-TC1 | Verify dispatch timing. Expected: No rider is assigned. Consolidated expected result: No assignment made until 80% or Ready threshold. | UI can show the outcome | E13-US1-UI4 (Rider App, not started); E13-US1-UI1 (Rider App, scaffold); E13-US1-UI2 (Rider App, scaffold); E13-US1-UI3 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E13-US1-TC2 | Verify trigger. Expected: Nearest suitable available rider is offered the delivery. | UI can show the outcome | E13-US1-UI4 (Rider App, not started); E13-US1-UI1 (Rider App, scaffold); E13-US1-UI2 (Rider App, scaffold); E13-US1-UI3 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E13-US1-TC3 | Verify alert. Expected: Rider receives push and audio alert. | UI can show the outcome | E13-US1-UI4 (Rider App, not started); E13-US1-UI1 (Rider App, scaffold); E13-US1-UI2 (Rider App, scaffold); E13-US1-UI3 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E13-US1-TC4 | Verify synchronization. Expected: Parcel is handed over within one to two minutes. | UI can show the outcome | E13-US1-UI4 (Rider App, not started); E13-US1-UI1 (Rider App, scaffold); E13-US1-UI2 (Rider App, scaffold); E13-US1-UI3 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E13-US1-TC5 | Boundary scenario: Pickup readiness boundary. Expected: Offer begins no earlier than 80%; pickup alert when Ready. | UI can show the outcome | E13-US1-UI4 (Rider App, not started); E13-US1-UI1 (Rider App, scaffold); E13-US1-UI2 (Rider App, scaffold); E13-US1-UI3 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

### E13-US2: Rider Assignment Responses and Shift Availability

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I receive an offer, When I accept it within the response window, Then the assignment is confirmed and the pickup and drop-off details are shown.
- AC2. Given I decline or do not respond in time, When the window expires, Then the offer is passed to the next suitable rider.
- AC3. Given I toggle Online, When I am within a service area, Then I begin to receive offers.
- AC4. Given I finish a shift, When I open the shift summary, Then completed deliveries, distances, waiting time and earnings are shown.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E13-US2-TC1 | Verify acceptance. Expected: Assignment confirmed with pickup and drop-off details. | UI can show the outcome | E13-US2-UI1 (Rider App, not started); E13-US2-UI2 (Rider App, scaffold); E13-US2-UI3 (Rider App, not started); E13-US2-UI4 (Rider App, scaffold); E13-US2-UI5 (Rider App, not started); E13-US2-UI6 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E13-US2-TC2 | Verify reassignment. Expected: Offer is passed to next suitable rider. | UI can show the outcome | E13-US2-UI1 (Rider App, not started); E13-US2-UI2 (Rider App, scaffold); E13-US2-UI3 (Rider App, not started); E13-US2-UI4 (Rider App, scaffold); E13-US2-UI5 (Rider App, not started); E13-US2-UI6 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E13-US2-TC3 | Verify availability. Expected: Rider begins receiving offers. | UI can show the outcome | E13-US2-UI1 (Rider App, not started); E13-US2-UI2 (Rider App, scaffold); E13-US2-UI3 (Rider App, not started); E13-US2-UI4 (Rider App, scaffold); E13-US2-UI5 (Rider App, not started); E13-US2-UI6 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E13-US2-TC4 | Verify summary. Expected: Deliveries, distance, waiting time and earnings are shown. | UI can show the outcome | E13-US2-UI1 (Rider App, not started); E13-US2-UI2 (Rider App, scaffold); E13-US2-UI3 (Rider App, not started); E13-US2-UI4 (Rider App, scaffold); E13-US2-UI5 (Rider App, not started); E13-US2-UI6 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E13-US2-TC5 | Negative scenario: Reject late response or unavailable rider. Expected: Assignment is not claimed; next eligible rider offered. | UI can show the outcome | E13-US2-UI1 (Rider App, not started); E13-US2-UI2 (Rider App, scaffold); E13-US2-UI3 (Rider App, not started); E13-US2-UI4 (Rider App, scaffold); E13-US2-UI5 (Rider App, not started); E13-US2-UI6 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E13-US2-TC6 | Boundary scenario: Assignment response boundary. Expected: Deterministic response-window rule; only one rider owns delivery. | UI can show the outcome | E13-US2-UI1 (Rider App, not started); E13-US2-UI2 (Rider App, scaffold); E13-US2-UI3 (Rider App, not started); E13-US2-UI4 (Rider App, scaffold); E13-US2-UI5 (Rider App, not started); E13-US2-UI6 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |

### E13-US3: Delivery Status and Customer Verification

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I am on an active delivery, When I tap the next status button, Then the status updates and is visible to the vendor and customer.
- AC2. Given I tap a status out of sequence, When the app validates, Then the action is blocked with a clear prompt.
- AC3. Given I arrive at the drop-off, When I enter or confirm the customer's code, Then the order is marked Delivered.
- AC4. Given the code is wrong, When I submit it, Then delivery is not confirmed and I can retry or contact support.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E13-US3-TC1 | Verify buttons. Expected: Status updates and is visible to vendor and customer. | UI can show the outcome | E13-US3-UI1 (Rider App, scaffold); E13-US3-UI2 (Rider App, scaffold); E13-US3-UI3 (Rider App, not started); E13-US3-UI4 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E13-US3-TC2 | Verify validation. Expected: Action is blocked with a prompt. | Not provable by a screen alone | E13-US3-UI1 (Rider App, scaffold); E13-US3-UI2 (Rider App, scaffold); E13-US3-UI3 (Rider App, not started); E13-US3-UI4 (Rider App, scaffold) | None | Open. A screen cannot pass this test. |
| E13-US3-TC3 | Verify verification. Expected: Order marked Delivered. | UI can show the outcome | E13-US3-UI1 (Rider App, scaffold); E13-US3-UI2 (Rider App, scaffold); E13-US3-UI3 (Rider App, not started); E13-US3-UI4 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E13-US3-TC4 | Negative scenario: Reject invalid proof-of-delivery code. Expected: Not delivered; retry/support enabled; reuse blocked. Consolidated expected result: Delivery not confirmed; retry or support offered. | Not provable by a screen alone | E13-US3-UI1 (Rider App, scaffold); E13-US3-UI2 (Rider App, scaffold); E13-US3-UI3 (Rider App, not started); E13-US3-UI4 (Rider App, scaffold) | None | Open. A screen cannot pass this test. |
| E13-US3-TC5 | Boundary scenario: Delivery transition boundary. Expected: Only permitted ordered transitions accepted and visible. | UI can show the outcome | E13-US3-UI1 (Rider App, scaffold); E13-US3-UI2 (Rider App, scaffold); E13-US3-UI3 (Rider App, not started); E13-US3-UI4 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

### E13-US4: Pickup Waiting-Time Tracking

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I arrive at the pickup location, When the app detects arrival by GPS or my status tap, Then the arrival time is stored.
- AC2. Given the parcel is handed over, When I mark Picked Up, Then dwell time equals handover minus arrival.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E13-US4-TC1 | Verify capture. Expected: Dwell time of 14 minutes is stored. | UI can show the outcome | E13-US4-UI1 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E13-US4-TC2 | Negative scenario: Avoid incorrect charge for pre-arrival waiting. Expected: No fabricated dwell time; missing-event exception flagged. | UI can show the outcome | E13-US4-UI1 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E13-US4-TC3 | Boundary scenario: Pickup dwell boundary. Expected: Dwell is non-negative; zero/positive calculated accurately. | UI can show the outcome | E13-US4-UI1 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

### E13-US5: Delivery Navigation Preferences

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I choose automatic redirect, When I begin a delivery, Then the external maps app opens with the pickup or drop-off pre-filled.
- AC2. Given I choose the embedded map, When I begin a delivery, Then the in-app map shows the route.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E13-US5-TC1 | Verify external navigation. Expected: External maps app opens with destination pre-filled. | UI can show the outcome | E13-US2-UI1 (Rider App, not started); E13-US1-UI1 (Rider App, scaffold); E13-US3-UI1 (Rider App, scaffold); E13-US5-UI1 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E13-US5-TC2 | Verify in-app navigation. Expected: In-app map shows route. | UI can show the outcome | E13-US2-UI1 (Rider App, not started); E13-US1-UI1 (Rider App, scaffold); E13-US3-UI1 (Rider App, scaffold); E13-US5-UI1 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E13-US5-TC3 | Negative scenario: Respect withdrawn location permission. Expected: Graceful fallback; no crash or invented live location. | UI can show the outcome | E13-US2-UI1 (Rider App, not started); E13-US1-UI1 (Rider App, scaffold); E13-US3-UI1 (Rider App, scaffold); E13-US5-UI1 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E13-US5-TC4 | Boundary scenario: Route coordinate boundary. Expected: Invalid pins rejected, same-point safe, map opens only with valid target. | UI can show the outcome | E13-US2-UI1 (Rider App, not started); E13-US1-UI1 (Rider App, scaffold); E13-US3-UI1 (Rider App, scaffold); E13-US5-UI1 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |

## E14

### E14-US1: Pool Eligibility, Item Exclusions and Hold Limits

Story status: Not started.

Acceptance criteria:
- AC1. Given two orders are ready for dispatch, When they meet the distance, corridor and 2-order limit, Then they may be offered to one rider as a pooled trip.
- AC2. Given a third order is considered, When the 2-order cap is checked, Then it is not added to the trip.
- AC3. Given I am at the second pickup, When the order is not ready within the configured hold limit, Then the second order is uncoupled and reassigned to another rider.
- AC4. Given the first order is on my bike, When the second is uncoupled, Then I proceed immediately with the first order.
- AC5. Given an order contains a fragile custom cake or spillable gravy, When pooling is evaluated, Then the order is excluded from pooling.
- AC6. Given both orders in a candidate pool are non-fragile, When pooling is evaluated, Then the pool is allowed.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E14-US1-TC1 | Verify rules allow pooling. Expected: Trip is offered as a pooled trip. | UI can show the outcome | E14-US1-UI1 (Rider App, not started); E14-US1-UI2 (Rider App, not started) | None | Open. Not started. |
| E14-US1-TC2 | Verify 2-order cap. Expected: Third order is not added. Consolidated expected result: Never exceeds two parcels; fragile cake routed separately. | UI can show the outcome | E14-US1-UI1 (Rider App, not started); E14-US1-UI2 (Rider App, not started) | None | Open. Not started. |
| E14-US1-TC3 | Verify hold limit. Expected: Second order is uncoupled and reassigned. | UI can show the outcome | E14-US1-UI1 (Rider App, not started); E14-US1-UI2 (Rider App, not started) | None | Open. Not started. |
| E14-US1-TC4 | Verify proceed behaviour. Expected: Rider proceeds immediately with first order. | UI can show the outcome | E14-US1-UI1 (Rider App, not started); E14-US1-UI2 (Rider App, not started) | None | Open. Not started. |
| E14-US1-TC5 | Verify exclusion. Expected: Order is excluded from pooling. | UI can show the outcome | E14-US1-UI1 (Rider App, not started); E14-US1-UI2 (Rider App, not started) | None | Open. Not started. |
| E14-US1-TC6 | Verify permitted pool. Expected: Pool is allowed. | UI can show the outcome | E14-US1-UI1 (Rider App, not started); E14-US1-UI2 (Rider App, not started) | None | Open. Not started. |
| E14-US1-TC7 | Boundary scenario: Second-pickup hold boundary. Expected: At documented threshold, second parcel uncouples without delaying first. | UI can show the outcome | E14-US1-UI1 (Rider App, not started); E14-US1-UI2 (Rider App, not started) | None | Open. Not started. |

### E14-US2: Customer Pooling Choice and Parcel Visibility

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given my order is eligible for pooling, When I reach delivery options, Then I see pooled (with discount and delay) and express options with prices.
- AC2. Given I choose express, When I confirm, Then the order is never pooled.
- AC3. Given my order is part of a pooled trip, When I track it, Then the app shows my position in the sequence and an updated estimate.
- AC4. Given I am the rider with two parcels, When I view the trip, Then each parcel shows an order label that I must match at drop-off.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E14-US2-TC1 | Verify options and pricing. Expected: Pooled option with discount and delay and express option are shown. | UI can show the outcome | E14-US2-UI1 (Customer App, scaffold); E17-US1-UI1 (Customer App, scaffold); E14-US2-UI2 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E14-US2-TC2 | Verify opt-out. Expected: Order is never pooled. Consolidated expected result: Order is never pooled; express promise preserved. | UI can show the outcome | E14-US2-UI1 (Customer App, scaffold); E17-US1-UI1 (Customer App, scaffold); E14-US2-UI2 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E14-US2-TC3 | Verify tracking clarity. Expected: Position in sequence and updated estimate are shown. | UI can show the outcome | E14-US2-UI1 (Customer App, scaffold); E17-US1-UI1 (Customer App, scaffold); E14-US2-UI2 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E14-US2-TC4 | Verify label matching. Expected: Each parcel shows a label to match at drop-off. | UI can show the outcome | E14-US2-UI1 (Customer App, scaffold); E17-US1-UI1 (Customer App, scaffold); E14-US2-UI2 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E14-US2-TC5 | Boundary scenario: Pooled tracking boundary. Expected: Sequence labels and ETAs update; no cross-customer parcel data. | UI can show the outcome | E14-US2-UI1 (Customer App, scaffold); E17-US1-UI1 (Customer App, scaffold); E14-US2-UI2 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |

### E14-US3: Vendor Hybrid-Fleet Selection

Story status: Not started.

Acceptance criteria:
- AC1. Given I open Delivery Settings, When I select one or more fleet options, Then dispatch uses only the selected options.
- AC2. Given no rider from my selected fleet is available, When dispatch runs, Then the system falls back to another enabled option or notifies me.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E14-US3-TC1 | Verify fleet configuration. Expected: Dispatch uses only selected options. | UI can show the outcome | E14-US3-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E14-US3-TC2 | Verify fallback. Expected: Fallback to enabled option or vendor notified. | UI can show the outcome | E14-US3-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E14-US3-TC3 | Negative scenario: Reject dispatch to disabled fleet. Expected: Disabled provider no longer receives new dispatches. | UI can show the outcome | E14-US3-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E14-US3-TC4 | Boundary scenario: Fleet fallback boundary. Expected: Clear unavailable state or allowed fallback; no silent forbidden fleet. | UI can show the outcome | E14-US3-UI1 (Vendor Portal, not started) | None | Open. Not started. |

### E14-US4: Partner Fleet API and IVR Status Exchange

Story status: Not started.

Acceptance criteria:
- AC1. Given a delivery is assigned to a partner, When the partner API receives the request, Then the partner acknowledges and status updates flow back into the order.
- AC2. Given a partner rider confirms by IVR phone call, When the call is completed, Then the status is recorded in the order timeline.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E14-US4-TC1 | Verify integration. Expected: Partner acknowledges and status flows back. | UI can show the outcome | E14-US4-UI1 (Admin Portal, not started); E14-US4-UI2 (Admin Portal, not started) | None | Open. Not started. |
| E14-US4-TC2 | Verify handshake. Expected: Status recorded in order timeline. | UI can show the outcome | E14-US4-UI1 (Admin Portal, not started); E14-US4-UI2 (Admin Portal, not started) | None | Open. Not started. |
| E14-US4-TC3 | Negative scenario: Reject spoofed external status callback. Expected: Unauthorized callbacks rejected; duplicates idempotent. | Not provable by a screen alone | E14-US4-UI1 (Admin Portal, not started); E14-US4-UI2 (Admin Portal, not started) | None | Open. A screen cannot pass this test. |
| E14-US4-TC4 | Boundary scenario: Partner handoff timeout boundary. Expected: Retries/fallback follow defined cutoff without duplicate rider assignments. | UI can show the outcome | E14-US4-UI1 (Admin Portal, not started); E14-US4-UI2 (Admin Portal, not started) | None | Open. Not started. |

## E15

### E15-US1: Tariff Configuration and Road-Distance Pricing

Story status: Not started.

Acceptance criteria:
- AC1. Given I open Tariff Settings, When I enter a base fare and per-kilometre rate, Then the values are saved and used in delivery pricing.
- AC2. Given I enter a negative rate, When I save, Then validation rejects the value.
- AC3. Given a delivery route is calculated by the maps service, When the fee is computed, Then the distance used is the routed road distance.
- AC4. Given the maps service is unavailable, When the fee is computed, Then the system uses a defined fallback and flags it for review.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E15-US1-TC1 | Verify configuration. Expected: Values saved and used in pricing. | UI can show the outcome | E15-US1-UI1 (Rider App, not started); E15-US1-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E15-US1-TC2 | Verify validation. Expected: Save is rejected. | UI can show the outcome | E15-US1-UI1 (Rider App, not started); E15-US1-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E15-US1-TC3 | Verify distance basis. Expected: Fee is based on 6.2 km. | UI can show the outcome | E15-US1-UI1 (Rider App, not started); E15-US1-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E15-US1-TC4 | Verify fallback. Expected: Defined fallback used and flagged for review. | UI can show the outcome | E15-US1-UI1 (Rider App, not started); E15-US1-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E15-US1-TC5 | Negative scenario: Reject tampered distance or negative tariff. Expected: Server-validated route applied and invalid fare config rejected. | UI can show the outcome | E15-US1-UI1 (Rider App, not started); E15-US1-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E15-US1-TC6 | Boundary scenario: Distance pricing boundary. Expected: Correct minimum/base rate and per-km addition at boundary. | UI can show the outcome | E15-US1-UI1 (Rider App, not started); E15-US1-UI2 (Vendor Portal, not started) | None | Open. Not started. |

### E15-US2: Waiting and Weather/Peak Surcharges

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given my dwell time exceeds the threshold, When I mark Picked Up, Then a per-minute waiting fee for the excess time is added to my earnings.
- AC2. Given my dwell time is below the threshold, When I mark Picked Up, Then no waiting fee is applied.
- AC3. Given heavy rain or peak conditions are active, When a delivery is completed, Then the surcharge appears as its own earnings line.
- AC4. Given conditions are normal, When a delivery is completed, Then no surcharge line is added.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E15-US2-TC1 | Verify threshold behaviour. Expected: Fee for 10 excess minutes (50) is added. | UI can show the outcome | E13-US4-UI1 (Rider App, scaffold); E13-US3-UI4 (Rider App, scaffold); E15-US3-UI1 (Rider App, not started); E15-US3-UI2 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E15-US2-TC2 | Verify no fee. Expected: No waiting fee. Consolidated expected result: No idle surcharge before threshold. | UI can show the outcome | E13-US4-UI1 (Rider App, scaffold); E13-US3-UI4 (Rider App, scaffold); E15-US3-UI1 (Rider App, not started); E15-US3-UI2 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E15-US2-TC3 | Verify visibility. Expected: Surcharge appears as own line. | UI can show the outcome | E13-US4-UI1 (Rider App, scaffold); E13-US3-UI4 (Rider App, scaffold); E15-US3-UI1 (Rider App, not started); E15-US3-UI2 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E15-US2-TC4 | Verify absence. Expected: No surcharge line. | UI can show the outcome | E13-US4-UI1 (Rider App, scaffold); E13-US3-UI4 (Rider App, scaffold); E15-US3-UI1 (Rider App, not started); E15-US3-UI2 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E15-US2-TC5 | Boundary scenario: Surcharge boundary. Expected: Each surcharge activates exactly per documented thresholds, once only. | UI can show the outcome | E13-US4-UI1 (Rider App, scaffold); E13-US3-UI4 (Rider App, scaffold); E15-US3-UI1 (Rider App, not started); E15-US3-UI2 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |

### E15-US3: Transparent Rider Shift Earnings Invoice

Story status: Not started.

Acceptance criteria:
- AC1. Given my shift has ended, When I open the invoice, Then each earning component is listed per delivery and totalled.
- AC2. Given a pooled trip was completed, When I view the invoice, Then earnings for both orders are shown separately.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E15-US3-TC1 | Verify components. Expected: Base fee, per-km, waiting fee, surcharges listed per delivery with totals. | UI can show the outcome | E15-US3-UI1 (Rider App, not started); E15-US3-UI2 (Rider App, not started) | None | Open. Not started. |
| E15-US3-TC2 | Verify pooled lines. Expected: Earnings for both orders shown separately. | UI can show the outcome | E15-US3-UI1 (Rider App, not started); E15-US3-UI2 (Rider App, not started) | None | Open. Not started. |
| E15-US3-TC3 | Negative scenario: Reject duplicate shift line item. Expected: One earning line and correct grand total. | UI can show the outcome | E15-US3-UI1 (Rider App, not started); E15-US3-UI2 (Rider App, not started) | None | Open. Not started. |
| E15-US3-TC4 | Boundary scenario: Zero-work shift boundary. Expected: Zero amount shown for no work; one valid fare item for first delivery. | UI can show the outcome | E15-US3-UI1 (Rider App, not started); E15-US3-UI2 (Rider App, not started) | None | Open. Not started. |

## E16

### E16-US1: Hands-Free Voice and IVR Rider Check-Ins

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I am connected to a headset and near the drop-off, When the app prompts 'Confirm arrival at customer', Then I say 'Confirm' or press the headset button and the status is updated.
- AC2. Given I do not respond, When the prompt times out, Then the app repeats once and then leaves the status unchanged without error.
- AC3. Given the kitchen marks an order Ready, When my assignment is active, Then I hear the audio alert through my headset or speaker.
- AC4. Given audio alerts are muted, When a status changes, Then a vibration and on-screen alert are used instead.
- AC5. Given I am on an active delivery, When the system places an IVR call, Then I confirm by keypad or voice and the check-in is recorded.
- AC6. Given a scheduled safety check-in is missed, When the grace period passes, Then the case is escalated to the administrator dashboard.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E16-US1-TC1 | Verify voice check-in. Expected: Status updates to Arrived at Drop-off. | UI can show the outcome | E13-US1-UI2 (Rider App, scaffold); E16-US1-UI1 (Rider App, not started); E16-US2-UI1 (Rider App, not started); E14-US4-UI2 (Admin Portal, not started); E16-US1-UI3 (Admin Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E16-US1-TC2 | Verify timeout handling. Expected: Prompt repeats once; status unchanged; no error. | UI can show the outcome | E13-US1-UI2 (Rider App, scaffold); E16-US1-UI1 (Rider App, not started); E16-US2-UI1 (Rider App, not started); E14-US4-UI2 (Admin Portal, not started); E16-US1-UI3 (Admin Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E16-US1-TC3 | Verify audio alert. Expected: Alert 'Kitchen has marked order bagged, begin approach' is heard. | UI can show the outcome | E13-US1-UI2 (Rider App, scaffold); E16-US1-UI1 (Rider App, not started); E16-US2-UI1 (Rider App, not started); E14-US4-UI2 (Admin Portal, not started); E16-US1-UI3 (Admin Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E16-US1-TC4 | Verify non-audio alert. Expected: Vibration and on-screen alert are used. | UI can show the outcome | E13-US1-UI2 (Rider App, scaffold); E16-US1-UI1 (Rider App, not started); E16-US2-UI1 (Rider App, not started); E14-US4-UI2 (Admin Portal, not started); E16-US1-UI3 (Admin Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E16-US1-TC5 | Verify IVR flow. Expected: Check-in is recorded. | UI can show the outcome | E13-US1-UI2 (Rider App, scaffold); E16-US1-UI1 (Rider App, not started); E16-US2-UI1 (Rider App, not started); E14-US4-UI2 (Admin Portal, not started); E16-US1-UI3 (Admin Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E16-US1-TC6 | Verify escalation. Expected: Case appears on administrator dashboard. | UI can show the outcome | E13-US1-UI2 (Rider App, scaffold); E16-US1-UI1 (Rider App, not started); E16-US2-UI1 (Rider App, not started); E14-US4-UI2 (Admin Portal, not started); E16-US1-UI3 (Admin Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E16-US1-TC7 | Negative scenario: Ignore ambiguous spoken order identity. Expected: Clarification requested; no incorrect order state changed. | UI can show the outcome | E13-US1-UI2 (Rider App, scaffold); E16-US1-UI1 (Rider App, not started); E16-US2-UI1 (Rider App, not started); E14-US4-UI2 (Admin Portal, not started); E16-US1-UI3 (Admin Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E16-US1-TC8 | Boundary scenario: IVR timeout/replay boundary. Expected: Exactly one authenticated valid transition saved; interrupted call safe. | UI can show the outcome | E13-US1-UI2 (Rider App, scaffold); E16-US1-UI1 (Rider App, not started); E16-US2-UI1 (Rider App, not started); E14-US4-UI2 (Admin Portal, not started); E16-US1-UI3 (Admin Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |

### E16-US2: Glare-Resistant Low-Distraction Interface

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I open the rider app outdoors, When high-contrast mode is on, Then text and map labels remain legible.
- AC2. Given water droplets cause multiple touches, When a critical button is tapped accidentally, Then a hold-to-confirm or confirmation step prevents unintended status changes.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E16-US2-TC1 | Verify legibility. Expected: Text and map labels remain legible. | UI can show the outcome | E13-US1-UI3 (Rider App, scaffold); E13-US3-UI2 (Rider App, scaffold); E16-US2-UI1 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E16-US2-TC2 | Verify accidental-tap prevention. Expected: Hold-to-confirm or confirmation step prevents status change. | UI can show the outcome | E13-US1-UI3 (Rider App, scaffold); E13-US3-UI2 (Rider App, scaffold); E16-US2-UI1 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E16-US2-TC3 | Negative scenario: Prevent unsafe multi-tap interaction. Expected: Interaction blocked or deferred in safety mode. | Not provable by a screen alone | E13-US1-UI3 (Rider App, scaffold); E13-US3-UI2 (Rider App, scaffold); E16-US2-UI1 (Rider App, not started) | None | Open. A screen cannot pass this test. |
| E16-US2-TC4 | Boundary scenario: Display visibility boundary. Expected: Targets remain legible and do not overlap. | UI can show the outcome | E13-US1-UI3 (Rider App, scaffold); E13-US3-UI2 (Rider App, scaffold); E16-US2-UI1 (Rider App, not started) | None | Open. A related scaffold exists and has not been accepted. |

### E16-US3: Low-Bandwidth App Compatibility

Story status: Not started.

Acceptance criteria:
- AC1. Given I use a budget Android 10 device, When I work a full shift, Then the app remains responsive without crashes.
- AC2. Given GPS disconnects, When the signal returns, Then tracking resumes automatically and the trip continues without data loss.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E16-US3-TC1 | Verify stability. Expected: No crashes; app responsive; battery and data use within agreed limits. | UI can show the outcome | E16-US3-UI1 (Rider App, not started) | None | Open. Not started. |
| E16-US3-TC2 | Verify tracking resumes. Expected: Tracking resumes automatically with no data loss. | UI can show the outcome | E16-US3-UI1 (Rider App, not started) | None | Open. Not started. |
| E16-US3-TC3 | Negative scenario: Handle low-memory or offline app session. Expected: No crash; critical order detail cached and queued actions safe. | UI can show the outcome | E16-US3-UI1 (Rider App, not started) | None | Open. Not started. |
| E16-US3-TC4 | Boundary scenario: Device support boundary. Expected: Unsupported OS receives clear message; minimum version usable. | UI can show the outcome | E16-US3-UI1 (Rider App, not started) | None | Open. Not started. |

### E16-US4: Hands-Free Communication and Precise Drop-Off

Story status: Not started.

Acceptance criteria:
- AC1. Given I am on an active delivery, When I need to inform the customer of my arrival or a delay, Then I send a preset message with one tap or by voice.
- AC2. Given the customer's pin is inaccurate, When I request a corrected location, Then the customer is prompted to confirm a new pin and the route updates.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E16-US4-TC1 | Verify one-tap communication. Expected: Message is sent to customer without typing. | UI can show the outcome | E16-US4-UI1 (Customer App, not started); E16-US4-UI2 (Rider App, not started); E16-US4-UI3 (Rider App, not started) | None | Open. Not started. |
| E16-US4-TC2 | Verify pin correction. Expected: Customer is prompted to confirm new pin and route updates. | UI can show the outcome | E16-US4-UI1 (Customer App, not started); E16-US4-UI2 (Rider App, not started); E16-US4-UI3 (Rider App, not started) | None | Open. Not started. |
| E16-US4-TC3 | Negative scenario: Reject malformed or other-order drop-off pin. Expected: Invalid/inaccessible destination blocked with no leak. | Not provable by a screen alone | E16-US4-UI1 (Customer App, not started); E16-US4-UI2 (Rider App, not started); E16-US4-UI3 (Rider App, not started) | None | Open. A screen cannot pass this test. |
| E16-US4-TC4 | Boundary scenario: Hands-free note boundary. Expected: Complete permitted text available; excess handled with clear feedback. | UI can show the outcome | E16-US4-UI1 (Customer App, not started); E16-US4-UI2 (Rider App, not started); E16-US4-UI3 (Rider App, not started) | None | Open. Not started. |

## E17

### E17-US1: Real-Time Tracking, ETA and Notifications

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given my order is out for delivery, When I open tracking, Then I see the rider's live location and status timeline.
- AC2. Given the order is still being prepared, When I open tracking, Then I see the preparation stage and the ready-time estimate.
- AC3. Given the kitchen queue changes, When the estimate is recalculated, Then my estimate updates within one minute.
- AC4. Given the estimate changes, When the new value is shown, Then the previous value is not retained as the main display.
- AC5. Given order status changes, When the change is saved, Then I receive a push notification for that stage.
- AC6. Given notifications are disabled on my device, When status changes, Then updates remain available in the app.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E17-US1-TC1 | Verify map and timeline. Expected: Rider's live location and status timeline are shown. | UI can show the outcome | E17-US1-UI3 (Customer App, not started); E17-US1-UI1 (Customer App, scaffold); E17-US1-UI2 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E17-US1-TC2 | Verify pre-dispatch view. Expected: Preparation stage and ready-time estimate are shown. | UI can show the outcome | E17-US1-UI3 (Customer App, not started); E17-US1-UI1 (Customer App, scaffold); E17-US1-UI2 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E17-US1-TC3 | Verify refresh. Expected: Customer's estimate updates within one minute. | UI can show the outcome | E17-US1-UI3 (Customer App, not started); E17-US1-UI1 (Customer App, scaffold); E17-US1-UI2 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E17-US1-TC4 | Verify push for each stage. Expected: Push notification received for each stage. | UI can show the outcome | E17-US1-UI3 (Customer App, not started); E17-US1-UI1 (Customer App, scaffold); E17-US1-UI2 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E17-US1-TC5 | Verify in-app fallback. Expected: Updates remain visible in app. | UI can show the outcome | E17-US1-UI3 (Customer App, not started); E17-US1-UI1 (Customer App, scaffold); E17-US1-UI2 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E17-US1-TC6 | Negative scenario: Prevent another customer tracking the order. Expected: 403 or 404; no rider location leakage. | UI can show the outcome | E17-US1-UI3 (Customer App, not started); E17-US1-UI1 (Customer App, scaffold); E17-US1-UI2 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E17-US1-TC7 | Boundary scenario: Update lag boundary. Expected: Events applied once and ETA never regresses due to stale message. | UI can show the outcome | E17-US1-UI3 (Customer App, not started); E17-US1-UI1 (Customer App, scaffold); E17-US1-UI2 (Customer App, not started) | None | Open. A related scaffold exists and has not been accepted. |

### E17-US2: Customer Order History and One-Tap Reordering

Story status: Not started.

Acceptance criteria:
- AC1. Given I have completed orders, When I open Order History, Then orders are listed newest first with details.
- AC2. Given I have no orders, When I open Order History, Then an empty-state message is shown.
- AC3. Given an earlier order exists, When I tap Reorder, Then the same items and options are added to the cart with current prices.
- AC4. Given an earlier item is now unavailable, When I tap Reorder, Then available items are added and I am told which items were skipped.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E17-US2-TC1 | Verify listing. Expected: Orders listed newest first with details. | UI can show the outcome | E17-US2-UI1 (Customer App, not started); E17-US2-UI2 (Customer App, not started); E17-US2-UI3 (Customer App, not started) | None | Open. Not started. |
| E17-US2-TC2 | Verify empty state. Expected: Empty-state message shown. | UI can show the outcome | E17-US2-UI1 (Customer App, not started); E17-US2-UI2 (Customer App, not started); E17-US2-UI3 (Customer App, not started) | None | Open. Not started. |
| E17-US2-TC3 | Negative scenario: Block access to a deleted/foreign order. Expected: Only own legitimate order records visible. | Not provable by a screen alone | E17-US2-UI1 (Customer App, not started); E17-US2-UI2 (Customer App, not started); E17-US2-UI3 (Customer App, not started) | None | Open. A screen cannot pass this test. |
| E17-US2-TC4 | Boundary scenario: History date-boundary. Expected: Order included per documented date boundaries, no duplication. | UI can show the outcome | E17-US2-UI1 (Customer App, not started); E17-US2-UI2 (Customer App, not started); E17-US2-UI3 (Customer App, not started) | None | Open. Not started. |
| E17-US2-TC5 | Verify cart rebuild. Expected: Same items and options added at current prices. | UI can show the outcome | E17-US2-UI1 (Customer App, not started); E17-US2-UI2 (Customer App, not started); E17-US2-UI3 (Customer App, not started) | None | Open. Not started. |
| E17-US2-TC6 | Verify partial reorder. Expected: Available items added; skipped items listed. Consolidated expected result: Revalidation occurs; customer confirms new price; invalid item blocked. | Not provable by a screen alone | E17-US2-UI1 (Customer App, not started); E17-US2-UI2 (Customer App, not started); E17-US2-UI3 (Customer App, not started) | None | Open. A screen cannot pass this test. |
| E17-US2-TC7 | Boundary scenario: Reorder quantity boundary. Expected: Current maximum enforced without silent over-ordering. | UI can show the outcome | E17-US2-UI1 (Customer App, not started); E17-US2-UI2 (Customer App, not started); E17-US2-UI3 (Customer App, not started) | None | Open. Not started. |

### E17-US3: Rating-Based Vendor Highlights

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given vendors have ratings, When I open the home screen, Then top-rated vendors are surfaced using a rule-based ranking.
- AC2. Given a vendor has too few ratings, When ranking is computed, Then it is not highlighted as top-rated.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E17-US3-TC1 | Verify ranking. Expected: Top-rated vendors surfaced by rule-based ranking. | UI can show the outcome | E3-US1-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E17-US3-TC2 | Verify minimum count rule. Expected: Vendor not highlighted as top-rated. | UI can show the outcome | E3-US1-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E17-US3-TC3 | Negative scenario: Reject manipulated rating highlight. Expected: Only eligible customer ratings used; invalid payload rejected. | UI can show the outcome | E3-US1-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E17-US3-TC4 | Boundary scenario: Low-review boundary. Expected: Not enough data handled explicitly; eligible threshold shows correct rating. | UI can show the outcome | E3-US1-UI1 (Customer App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

## E18

### E18-US1: Restaurant, Item and Rider Ratings

Story status: Not started.

Acceptance criteria:
- AC1. Given my order is delivered, When I open the rating prompt, Then I can rate the restaurant and items from 1 to 5 with an optional comment.
- AC2. Given I try to rate an order I did not place, When the request is sent, Then it is rejected.
- AC3. Given my order is delivered, When I rate, Then the rider rating and restaurant rating are stored independently.
- AC4. Given I give a low rider rating, When I submit, Then my restaurant rating is unaffected.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E18-US1-TC1 | Verify rating submission. Expected: Ratings and comment are saved. | UI can show the outcome | E18-US1-UI1 (Customer App, not started) | None | Open. Not started. |
| E18-US1-TC2 | Verify separate storage. Expected: Both ratings are stored independently. Consolidated expected result: Restaurant rating unaffected. | UI can show the outcome | E18-US1-UI1 (Customer App, not started) | None | Open. Not started. |
| E18-US1-TC3 | Negative scenario: Reject review from non-customer or incomplete order. Expected: Review rejected; no impact on scores. Consolidated expected result: Request is rejected. | UI can show the outcome | E18-US1-UI1 (Customer App, not started) | None | Open. Not started. |
| E18-US1-TC4 | Boundary scenario: Rating-range boundary. Expected: Only 1–5 accepted; separate vendor/rider values retained. | UI can show the outcome | E18-US1-UI1 (Customer App, not started) | None | Open. Not started. |

### E18-US2: Rider Feedback and Vendor Product Insights

Story status: Not started.

Acceptance criteria:
- AC1. Given I have received ratings, When I open Ratings, Then my average and recent comments are shown.
- AC2. Given a rating was caused by a vendor delay, When an administrator marks it as vendor-attributed, Then it is excluded from my average.
- AC3. Given items have ratings, When I open the feedback dashboard, Then each item shows average rating, count and recent comments.
- AC4. Given I filter by date range, When I apply the filter, Then figures update for that range.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E18-US2-TC1 | Verify display. Expected: Average and recent comments are shown. | UI can show the outcome | E18-US2-UI1 (Rider App, not started); E18-US2-UI2 (Vendor Portal, not started); E18-US2-UI3 (Admin Portal, not started) | None | Open. Not started. |
| E18-US2-TC2 | Verify exclusion. Expected: Rating excluded from rider average. | UI can show the outcome | E18-US2-UI1 (Rider App, not started); E18-US2-UI2 (Vendor Portal, not started); E18-US2-UI3 (Admin Portal, not started) | None | Open. Not started. |
| E18-US2-TC3 | Verify aggregation. Expected: Each item shows average, count and recent comments. | UI can show the outcome | E18-US2-UI1 (Rider App, not started); E18-US2-UI2 (Vendor Portal, not started); E18-US2-UI3 (Admin Portal, not started) | None | Open. Not started. |
| E18-US2-TC4 | Verify filtering. Expected: Figures update for the range. | UI can show the outcome | E18-US2-UI1 (Rider App, not started); E18-US2-UI2 (Vendor Portal, not started); E18-US2-UI3 (Admin Portal, not started) | None | Open. Not started. |
| E18-US2-TC5 | Negative scenario: Hide private customer information from vendor. Expected: Only permitted aggregated/product feedback fields returned. | UI can show the outcome | E18-US2-UI1 (Rider App, not started); E18-US2-UI2 (Vendor Portal, not started); E18-US2-UI3 (Admin Portal, not started) | None | Open. Not started. |
| E18-US2-TC6 | Boundary scenario: Rating aggregation boundary. Expected: Empty state then exact single review stats; no divide-by-zero. | UI can show the outcome | E18-US2-UI1 (Rider App, not started); E18-US2-UI2 (Vendor Portal, not started); E18-US2-UI3 (Admin Portal, not started) | None | Open. Not started. |

### E18-US3: Customer Complaints and Resolution Requests

Story status: Not started.

Acceptance criteria:
- AC1. Given I have a delivered or failed order, When I submit a complaint with category and description, Then a complaint ticket is created and linked to the order.
- AC2. Given I try to raise a complaint on an order that is not mine, When the request is sent, Then it is rejected.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E18-US3-TC1 | Verify ticket creation. Expected: Ticket created and linked to the order. | UI can show the outcome | E18-US3-UI1 (Customer App, not started); E18-US3-UI2 (Customer App, not started); E18-US3-UI3 (Rider App, not started); E18-US3-UI4 (Vendor Portal, not started) | None | Open. Not started. |
| E18-US3-TC2 | Verify authorization. Expected: Request is rejected. | UI can show the outcome | E18-US3-UI1 (Customer App, not started); E18-US3-UI2 (Customer App, not started); E18-US3-UI3 (Rider App, not started); E18-US3-UI4 (Vendor Portal, not started) | None | Open. Not started. |
| E18-US3-TC3 | Negative scenario: Reject duplicate or unauthorized complaint update. Expected: Case stays unchanged; event audited. | Not provable by a screen alone | E18-US3-UI1 (Customer App, not started); E18-US3-UI2 (Customer App, not started); E18-US3-UI3 (Rider App, not started); E18-US3-UI4 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |
| E18-US3-TC4 | Boundary scenario: Complaint attachment boundary. Expected: Within-limit evidence accepted; extra/oversize evidence rejected. | UI can show the outcome | E18-US3-UI1 (Customer App, not started); E18-US3-UI2 (Customer App, not started); E18-US3-UI3 (Rider App, not started); E18-US3-UI4 (Vendor Portal, not started) | None | Open. Not started. |

## E19

### E19-US1: Assistant Natural-Language Search and Order Status

Story status: Not started.

Acceptance criteria:
- AC1. Given I open the assistant, When I enter a natural-language request, Then I receive matching vendors or items that respect the stated exclusions.
- AC2. Given nothing matches, When the search completes, Then the assistant says so and suggests alternatives.
- AC3. Given I have an active order, When I ask about it, Then the assistant returns the current status and estimated time.
- AC4. Given I have no active order, When I ask, Then the assistant says so and offers my recent orders.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E19-US1-TC1 | Verify understanding and filtering. Expected: Matching items respecting exclusion returned. | UI can show the outcome | E19-US1-UI1 (Customer App, not started) | None | Open. Not started. |
| E19-US1-TC2 | Verify empty handling. Expected: Assistant says nothing matched and suggests alternatives. | UI can show the outcome | E19-US1-UI1 (Customer App, not started) | None | Open. Not started. |
| E19-US1-TC3 | Verify answer. Expected: Assistant returns status and estimated time. | UI can show the outcome | E19-US1-UI1 (Customer App, not started) | None | Open. Not started. |
| E19-US1-TC4 | Verify fallback. Expected: Assistant says so and offers recent orders. | UI can show the outcome | E19-US1-UI1 (Customer App, not started) | None | Open. Not started. |
| E19-US1-TC5 | Negative scenario: Reject requests for another customer order. Expected: No protected order data exposed. | UI can show the outcome | E19-US1-UI1 (Customer App, not started) | None | Open. Not started. |
| E19-US1-TC6 | Boundary scenario: Search ambiguity boundary. Expected: Assistant handles no result, direct result and clarification correctly. | UI can show the outcome | E19-US1-UI1 (Customer App, not started) | None | Open. Not started. |

### E19-US2: Voice-Based Customer Ordering

Story status: Not started.

Acceptance criteria:
- AC1. Given I speak an order for an available item, When the assistant understands, Then it reads the order back and asks for explicit confirmation before placing it.
- AC2. Given I say 'cancel', When the assistant is awaiting confirmation, Then no order is placed.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E19-US2-TC1 | Verify read-back. Expected: Order read back and placed only after explicit confirmation. | UI can show the outcome | E19-US2-UI1 (Customer App, not started) | None | Open. Not started. |
| E19-US2-TC2 | Verify cancellation. Expected: No order placed. | UI can show the outcome | E19-US2-UI1 (Customer App, not started) | None | Open. Not started. |
| E19-US2-TC3 | Negative scenario: Require explicit confirmation before voice checkout. Expected: No payment or order created. | UI can show the outcome | E19-US2-UI1 (Customer App, not started) | None | Open. Not started. |
| E19-US2-TC4 | Boundary scenario: Voice confidence boundary. Expected: Ambiguous speech clarified; high-confidence selection confirmed with user. | UI can show the outcome | E19-US2-UI1 (Customer App, not started) | None | Open. Not started. |

### E19-US3: Vendor and Rider Operational Assistance

Story status: Not started.

Acceptance criteria:
- AC1. Given I am signed in as a vendor, When I ask 'How many orders are pending?', Then the assistant returns the live count.
- AC2. Given I am kitchen staff and ask for profit, When the assistant processes the request, Then it refuses because the data is owner-only.
- AC3. Given I have an assignment, When I ask 'What is my next pickup?', Then the assistant states vendor, address and readiness.
- AC4. Given I say 'Confirm', When a check-in is pending, Then the check-in is completed.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E19-US3-TC1 | Verify live data. Expected: Live count returned. | UI can show the outcome | E19-US3-UI1 (Rider App, not started); E19-US3-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E19-US3-TC2 | Verify RBAC. Expected: Assistant refuses (owner-only). | UI can show the outcome | E19-US3-UI1 (Rider App, not started); E19-US3-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E19-US3-TC3 | Verify answer. Expected: Vendor, address and readiness stated. | UI can show the outcome | E19-US3-UI1 (Rider App, not started); E19-US3-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E19-US3-TC4 | Verify check-in via assistant. Expected: Check-in completed. | UI can show the outcome | E19-US3-UI1 (Rider App, not started); E19-US3-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E19-US3-TC5 | Negative scenario: Reject rider assistant action on vendor settings. Expected: Role-restricted action refused with no write. | UI can show the outcome | E19-US3-UI1 (Rider App, not started); E19-US3-UI2 (Vendor Portal, not started) | None | Open. Not started. |
| E19-US3-TC6 | Boundary scenario: Operational command boundary. Expected: Current legitimate state reported; no hallucinated pickup confirmation. | UI can show the outcome | E19-US3-UI1 (Rider App, not started); E19-US3-UI2 (Vendor Portal, not started) | None | Open. Not started. |

### E19-US4: AI Assistant Permissions and Safety Guardrails

Story status: Not started.

Acceptance criteria:
- AC1. Given a user asks for an unsupported action such as a live video call, When the assistant processes the request, Then it explains the limitation and directs the user to the complaint process.
- AC2. Given a user of one role requests another role's data, When the request is made, Then it is refused.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E19-US4-TC1 | Verify scope limit. Expected: Assistant explains limitation and points to complaint process. | UI can show the outcome | E19-US1-UI1 (Customer App, not started); E19-US3-UI1 (Rider App, not started); E19-US3-UI2 (Vendor Portal, not started); E19-US4-UI1 (Admin Portal, not started) | None | Open. Not started. |
| E19-US4-TC2 | Verify isolation. Expected: Request is refused. | UI can show the outcome | E19-US1-UI1 (Customer App, not started); E19-US3-UI1 (Rider App, not started); E19-US3-UI2 (Vendor Portal, not started); E19-US4-UI1 (Admin Portal, not started) | None | Open. Not started. |
| E19-US4-TC3 | Negative scenario: Protect against instruction injection in item text. Expected: Untrusted text never overrides permissions or reveals secrets. | UI can show the outcome | E19-US1-UI1 (Customer App, not started); E19-US3-UI1 (Rider App, not started); E19-US3-UI2 (Vendor Portal, not started); E19-US4-UI1 (Admin Portal, not started) | None | Open. Not started. |
| E19-US4-TC4 | Boundary scenario: Unsupported capability boundary. Expected: Out-of-scope tasks refused; supported query succeeds. | UI can show the outcome | E19-US1-UI1 (Customer App, not started); E19-US3-UI1 (Rider App, not started); E19-US3-UI2 (Vendor Portal, not started); E19-US4-UI1 (Admin Portal, not started) | None | Open. Not started. |

## E20

### E20-US1: Vendor, Rider and Fleet Verification

Story status: Not started.

Acceptance criteria:
- AC1. Given a vendor has submitted an application with required documents, When I review it, Then I can approve, reject with a reason, or request more information.
- AC2. Given a vendor is approved, When the approval is saved, Then the vendor can complete profile setup and publish menus.
- AC3. Given a rider has registered, When I review the documents, Then I can approve or reject the rider.
- AC4. Given a rider is rejected, When the decision is saved, Then the rider cannot receive assignments.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E20-US1-TC1 | Verify review actions. Expected: Vendor can complete profile and publish menus. | UI can show the outcome | E20-US1-UI1 (Vendor Portal, not started); E20-US1-UI2 (Vendor Portal, not started); E20-US1-UI3 (Vendor Portal, not started); E20-US1-UI4 (Vendor Portal, not started); E20-US1-UI5 (Admin Portal, not started); E20-US1-UI6 (Admin Portal, not started); E20-US1-UI7 (Admin Portal, not started); E20-US1-UI9 (Admin Portal, not started); E20-US1-UI8 (Admin Portal, not started) | None | Open. Not started. |
| E20-US1-TC2 | Verify rejection. Expected: Vendor receives the reason and cannot publish. | UI can show the outcome | E20-US1-UI1 (Vendor Portal, not started); E20-US1-UI2 (Vendor Portal, not started); E20-US1-UI3 (Vendor Portal, not started); E20-US1-UI4 (Vendor Portal, not started); E20-US1-UI5 (Admin Portal, not started); E20-US1-UI6 (Admin Portal, not started); E20-US1-UI7 (Admin Portal, not started); E20-US1-UI9 (Admin Portal, not started); E20-US1-UI8 (Admin Portal, not started) | None | Open. Not started. |
| E20-US1-TC3 | Verify rider approval. Expected: Rider can receive assignments. | UI can show the outcome | E20-US1-UI1 (Vendor Portal, not started); E20-US1-UI2 (Vendor Portal, not started); E20-US1-UI3 (Vendor Portal, not started); E20-US1-UI4 (Vendor Portal, not started); E20-US1-UI5 (Admin Portal, not started); E20-US1-UI6 (Admin Portal, not started); E20-US1-UI7 (Admin Portal, not started); E20-US1-UI9 (Admin Portal, not started); E20-US1-UI8 (Admin Portal, not started) | None | Open. Not started. |
| E20-US1-TC4 | Verify rider rejection. Expected: Rider cannot receive assignments. | UI can show the outcome | E20-US1-UI1 (Vendor Portal, not started); E20-US1-UI2 (Vendor Portal, not started); E20-US1-UI3 (Vendor Portal, not started); E20-US1-UI4 (Vendor Portal, not started); E20-US1-UI5 (Admin Portal, not started); E20-US1-UI6 (Admin Portal, not started); E20-US1-UI7 (Admin Portal, not started); E20-US1-UI9 (Admin Portal, not started); E20-US1-UI8 (Admin Portal, not started) | None | Open. Not started. |
| E20-US1-TC5 | Negative scenario: Reject unverified account activation. Expected: Approval blocked or explicit rejection reason logged. | Not provable by a screen alone | E20-US1-UI1 (Vendor Portal, not started); E20-US1-UI2 (Vendor Portal, not started); E20-US1-UI3 (Vendor Portal, not started); E20-US1-UI4 (Vendor Portal, not started); E20-US1-UI5 (Admin Portal, not started); E20-US1-UI6 (Admin Portal, not started); E20-US1-UI7 (Admin Portal, not started); E20-US1-UI9 (Admin Portal, not started); E20-US1-UI8 (Admin Portal, not started) | None | Open. A screen cannot pass this test. |
| E20-US1-TC6 | Boundary scenario: Verification transition boundary. Expected: Only allowed state changes; approved-only account may transact. | UI can show the outcome | E20-US1-UI1 (Vendor Portal, not started); E20-US1-UI2 (Vendor Portal, not started); E20-US1-UI3 (Vendor Portal, not started); E20-US1-UI4 (Vendor Portal, not started); E20-US1-UI5 (Admin Portal, not started); E20-US1-UI6 (Admin Portal, not started); E20-US1-UI7 (Admin Portal, not started); E20-US1-UI9 (Admin Portal, not started); E20-US1-UI8 (Admin Portal, not started) | None | Open. Not started. |

### E20-US2: Platform Commission Rule Management

Story status: Not started.

Acceptance criteria:
- AC1. Given I open Commission Settings, When I set a rate within the allowed range, Then it is applied to new orders.
- AC2. Given I set a rate outside the allowed range, When I save, Then validation rejects the value.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E20-US2-TC1 | Verify rule setting. Expected: Rate applied to new orders. | UI can show the outcome | E20-US2-UI1 (Admin Portal, not started) | None | Open. Not started. |
| E20-US2-TC2 | Verify validation. Expected: Value is rejected. | UI can show the outcome | E20-US2-UI1 (Admin Portal, not started) | None | Open. Not started. |
| E20-US2-TC3 | Negative scenario: Reject commission configuration by vendor. Expected: 403; no change or disclosure. | UI can show the outcome | E20-US2-UI1 (Admin Portal, not started) | None | Open. Not started. |
| E20-US2-TC4 | Boundary scenario: Commission effective-date boundary. Expected: Rate version applied according to transaction time; old invoices unchanged. | UI can show the outcome | E20-US2-UI1 (Admin Portal, not started) | None | Open. Not started. |

### E20-US3: User Administration and Dispute Resolution

Story status: Not started.

Acceptance criteria:
- AC1. Given I search for a user, When I suspend the account, Then the user can no longer sign in and active sessions end.
- AC2. Given I reactivate the account, When the change is saved, Then the user can sign in again.
- AC3. Given a complaint is raised, When I open it, Then I see the order, timeline and parties involved.
- AC4. Given I resolve it, When I enter an outcome, Then all parties are notified and the case is closed.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E20-US3-TC1 | Verify enforcement. Expected: User cannot sign in; active sessions end. | UI can show the outcome | E20-US3-UI1 (Admin Portal, not started); E20-US3-UI2 (Admin Portal, not started); E20-US3-UI3 (Admin Portal, not started); E20-US3-UI4 (Admin Portal, not started); E20-US3-UI5 (Admin Portal, not started); E20-US3-UI6 (Admin Portal, not started) | None | Open. Not started. |
| E20-US3-TC2 | Verify reversal. Expected: User can sign in again. | UI can show the outcome | E20-US3-UI1 (Admin Portal, not started); E20-US3-UI2 (Admin Portal, not started); E20-US3-UI3 (Admin Portal, not started); E20-US3-UI4 (Admin Portal, not started); E20-US3-UI5 (Admin Portal, not started); E20-US3-UI6 (Admin Portal, not started) | None | Open. Not started. |
| E20-US3-TC3 | Verify detail view. Expected: Order, timeline and parties are shown. | UI can show the outcome | E20-US3-UI1 (Admin Portal, not started); E20-US3-UI2 (Admin Portal, not started); E20-US3-UI3 (Admin Portal, not started); E20-US3-UI4 (Admin Portal, not started); E20-US3-UI5 (Admin Portal, not started); E20-US3-UI6 (Admin Portal, not started) | None | Open. Not started. |
| E20-US3-TC4 | Verify closure. Expected: All parties notified and case closed. | UI can show the outcome | E20-US3-UI1 (Admin Portal, not started); E20-US3-UI2 (Admin Portal, not started); E20-US3-UI3 (Admin Portal, not started); E20-US3-UI4 (Admin Portal, not started); E20-US3-UI5 (Admin Portal, not started); E20-US3-UI6 (Admin Portal, not started) | None | Open. Not started. |
| E20-US3-TC5 | Negative scenario: Reject unauthorized account suspension. Expected: 403 with audit; user remains active. | Not provable by a screen alone | E20-US3-UI1 (Admin Portal, not started); E20-US3-UI2 (Admin Portal, not started); E20-US3-UI3 (Admin Portal, not started); E20-US3-UI4 (Admin Portal, not started); E20-US3-UI5 (Admin Portal, not started); E20-US3-UI6 (Admin Portal, not started) | None | Open. A screen cannot pass this test. |
| E20-US3-TC6 | Boundary scenario: Case assignment boundary. Expected: No duplicate resolution and traceable responsible administrator. | UI can show the outcome | E20-US3-UI1 (Admin Portal, not started); E20-US3-UI2 (Admin Portal, not started); E20-US3-UI3 (Admin Portal, not started); E20-US3-UI4 (Admin Portal, not started); E20-US3-UI5 (Admin Portal, not started); E20-US3-UI6 (Admin Portal, not started) | None | Open. Not started. |

### E20-US4: Platform Performance Monitoring and Reports

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given a date range contains activity, When I open Reports, Then orders, revenue, commission and slot utilization are shown.
- AC2. Given I open the live dashboard, When orders are in progress, Then active orders, delayed orders and online riders are displayed.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E20-US4-TC1 | Verify report content. Expected: Orders, revenue, commission and slot utilization displayed. | UI can show the outcome | E20-US4-UI1 (Admin Portal, scaffold); E20-US4-UI2 (Admin Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E20-US4-TC2 | Verify live dashboard. Expected: Active orders, delayed orders and online riders displayed. | UI can show the outcome | E20-US4-UI1 (Admin Portal, scaffold); E20-US4-UI2 (Admin Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E20-US4-TC3 | Negative scenario: Exclude private fields from platform export. Expected: Only authorized fields included; no proprietary recipe contents. | UI can show the outcome | E20-US4-UI1 (Admin Portal, scaffold); E20-US4-UI2 (Admin Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |
| E20-US4-TC4 | Boundary scenario: Reporting period boundary. Expected: Correct zeros and no double-counted edge transactions. | UI can show the outcome | E20-US4-UI1 (Admin Portal, scaffold); E20-US4-UI2 (Admin Portal, not started) | None | Open. A related scaffold exists and has not been accepted. |

## E21

### E21-US1: Immutable Audit Events and User Attribution

Story status: Not started.

Acceptance criteria:
- AC1. Given any of those events occurs, When the action is performed, Then an audit entry is written automatically.
- AC2. Given an audit entry exists, When anyone attempts to edit or delete it, Then the action is not permitted.
- AC3. Given a staff member edits stock, When the audit entry is created, Then it contains timestamp, employee ID or name, and task type such as editing stock.
- AC4. Given a staff member rejects an order, When the entry is created, Then it records the same details and the rejection reason.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E21-US1-TC1 | Verify automatic logging. Expected: Audit entry written for each action. | Not provable by a screen alone | E21-US2-UI1 (Vendor Portal, not started); E21-US3-UI1 (Admin Portal, not started) | None | Open. A screen cannot pass this test. |
| E21-US1-TC2 | Verify no edit or delete. Expected: Actions not permitted. Consolidated expected result: Rejected; original event and actor intact. | UI can show the outcome | E21-US2-UI1 (Vendor Portal, not started); E21-US3-UI1 (Admin Portal, not started) | None | Open. Not started. |
| E21-US1-TC3 | Verify identity and task fields. Expected: Contains timestamp, employee ID or name and task 'editing stock'. | UI can show the outcome | E21-US2-UI1 (Vendor Portal, not started); E21-US3-UI1 (Admin Portal, not started) | None | Open. Not started. |
| E21-US1-TC4 | Verify rejection logging. Expected: Records same details and reason. | UI can show the outcome | E21-US2-UI1 (Vendor Portal, not started); E21-US3-UI1 (Admin Portal, not started) | None | Open. Not started. |
| E21-US1-TC5 | Boundary scenario: Timestamp/identity boundary. Expected: Both separate immutable events stored with correct actor and sequence. | Not provable by a screen alone | E21-US2-UI1 (Vendor Portal, not started); E21-US3-UI1 (Admin Portal, not started) | None | Open. A screen cannot pass this test. |

### E21-US2: Vendor Owner Audit Viewer

Story status: Not started.

Acceptance criteria:
- AC1. Given I open the audit log, When I filter by employee and date, Then only matching entries are shown.
- AC2. Given I am kitchen staff, When I try to open the log, Then access is denied.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E21-US2-TC1 | Verify filtering. Expected: Only matching entries shown. | UI can show the outcome | E21-US2-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E21-US2-TC2 | Verify RBAC. Expected: Access denied. | UI can show the outcome | E21-US2-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E21-US2-TC3 | Negative scenario: Prevent cross-vendor log browsing. Expected: No rows for other vendor or unauthorized tenant. | UI can show the outcome | E21-US2-UI1 (Vendor Portal, not started) | None | Open. Not started. |
| E21-US2-TC4 | Boundary scenario: Audit filter boundary. Expected: Matching boundary entries returned once and sorted correctly. | Not provable by a screen alone | E21-US2-UI1 (Vendor Portal, not started) | None | Open. A screen cannot pass this test. |

### E21-US3: Administrator Audit Investigations and Exports

Story status: Not started.

Acceptance criteria:
- AC1. Given a dispute is open, When I view the vendor's audit log, Then entries are shown without exposing recipe quantities.
- AC2. Given I export the log, When I select export, Then a file is generated and the export itself is logged.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E21-US3-TC1 | Verify privacy of recipes. Expected: Entries shown without recipe quantities. | UI can show the outcome | E21-US3-UI1 (Admin Portal, not started); E21-US3-UI2 (Admin Portal, not started) | None | Open. Not started. |
| E21-US3-TC2 | Verify export auditing. Expected: File generated and export event itself logged. | Not provable by a screen alone | E21-US3-UI1 (Admin Portal, not started); E21-US3-UI2 (Admin Portal, not started) | None | Open. A screen cannot pass this test. |
| E21-US3-TC3 | Negative scenario: Audit and restrict bulk export. Expected: Authorized export logged; unauthorized download refused. | Not provable by a screen alone | E21-US3-UI1 (Admin Portal, not started); E21-US3-UI2 (Admin Portal, not started) | None | Open. A screen cannot pass this test. |
| E21-US3-TC4 | Boundary scenario: Large audit-query boundary. Expected: No overlap or omitted events; pagination bounds enforced. | Not provable by a screen alone | E21-US3-UI1 (Admin Portal, not started); E21-US3-UI2 (Admin Portal, not started) | None | Open. A screen cannot pass this test. |

## E22

### E22-US1: Customer and Rider Mobile/Web Access

Story status: Partial scaffold.

Acceptance criteria:
- AC1. Given I install the app on a supported Android or iOS device, When I sign in, Then all customer or rider features are available.
- AC2. Given I use an older supported device, When I open the app, Then it runs without layout failure.
- AC3. Given I open the customer web link on a mobile browser, When I browse and checkout, Then I can complete an order with the same billing and slot rules as the app.
- AC4. Given I use a desktop browser, When I open the link, Then the layout adapts.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E22-US1-TC1 | Verify cross-platform apps. Expected: All role features available. | UI can show the outcome | E22-US1-UI2 (Shared Screens, not started); E22-US1-UI1 (Customer App, not started); E1-US2-UI2 (Rider App, scaffold); E13-US2-UI2 (Rider App, scaffold); E13-US3-UI1 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E22-US1-TC2 | Verify layout. Expected: Runs without layout failure. | UI can show the outcome | E22-US1-UI2 (Shared Screens, not started); E22-US1-UI1 (Customer App, not started); E1-US2-UI2 (Rider App, scaffold); E13-US2-UI2 (Rider App, scaffold); E13-US3-UI1 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E22-US1-TC3 | Verify web checkout. Expected: Order completes with same billing and slot rules. | UI can show the outcome | E22-US1-UI2 (Shared Screens, not started); E22-US1-UI1 (Customer App, not started); E1-US2-UI2 (Rider App, scaffold); E13-US2-UI2 (Rider App, scaffold); E13-US3-UI1 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E22-US1-TC4 | Verify responsive layout. Expected: Layout adapts. | UI can show the outcome | E22-US1-UI2 (Shared Screens, not started); E22-US1-UI1 (Customer App, not started); E1-US2-UI2 (Rider App, scaffold); E13-US2-UI2 (Rider App, scaffold); E13-US3-UI1 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E22-US1-TC5 | Negative scenario: Deny unsupported device/OS gracefully. Expected: Clear compatibility message; no blank/unsafe screen. | UI can show the outcome | E22-US1-UI2 (Shared Screens, not started); E22-US1-UI1 (Customer App, not started); E1-US2-UI2 (Rider App, scaffold); E13-US2-UI2 (Rider App, scaffold); E13-US3-UI1 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |
| E22-US1-TC6 | Boundary scenario: Responsive breakpoint boundary. Expected: No clipped controls; task flows remain usable. | UI can show the outcome | E22-US1-UI2 (Shared Screens, not started); E22-US1-UI1 (Customer App, not started); E1-US2-UI2 (Rider App, scaffold); E13-US2-UI2 (Rider App, scaffold); E13-US3-UI1 (Rider App, scaffold) | None | Open. A related scaffold exists and has not been accepted. |

### E22-US2: Vendor and Admin Browser/PWA Compatibility

Story status: Not started.

Acceptance criteria:
- AC1. Given I open the portal on Chrome, Edge, Safari or Firefox, When I sign in, Then all features work and the layout adapts to my screen.
- AC2. Given I install the portal as a PWA, When I launch it, Then it opens in standalone mode.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E22-US2-TC1 | Verify browser support. Expected: All features work; layout adapts. | UI can show the outcome | E22-US2-UI1 (Vendor Portal, not started); E22-US2-UI2 (Admin Portal, not started) | None | Open. Not started. |
| E22-US2-TC2 | Verify PWA. Expected: Opens in standalone mode. | UI can show the outcome | E22-US2-UI1 (Vendor Portal, not started); E22-US2-UI2 (Admin Portal, not started) | None | Open. Not started. |
| E22-US2-TC3 | Negative scenario: Reject insecure browser origin. Expected: HTTPS enforced; secure headers/session prevent credential disclosure. | UI can show the outcome | E22-US2-UI1 (Vendor Portal, not started); E22-US2-UI2 (Admin Portal, not started) | None | Open. Not started. |
| E22-US2-TC4 | Boundary scenario: Browser compatibility boundary. Expected: Supported version works; unsupported version clearly reported. | UI can show the outcome | E22-US2-UI1 (Vendor Portal, not started); E22-US2-UI2 (Admin Portal, not started) | None | Open. Not started. |

### E22-US3: Connectivity Recovery, Security and Live Updates

Story status: Not started.

Acceptance criteria:
- AC1. Given connectivity drops, When I perform a status update, Then the action is queued and shown as pending.
- AC2. Given connectivity returns, When the queue is flushed, Then queued actions sync in order and conflicts are resolved with a clear message.
- AC3. Given I use any client, When a request is sent, Then it is transmitted over HTTPS and passwords are stored hashed.
- AC4. Given a status or slot changes, When the change is saved, Then connected clients receive the update within five seconds.

| Test | What it checks | How it can be proved | Screens | Automated test | Status |
| --- | --- | --- | --- | --- | --- |
| E22-US3-TC1 | Verify queuing. Expected: Action queued and shown as pending. | UI can show the outcome | E22-US3-UI1 (Shared Screens, not started); E22-US3-UI2 (Shared Screens, not started); E22-US3-UI3 (Shared Screens, not started) | None | Open. Not started. |
| E22-US3-TC2 | Verify sync. Expected: Queued actions sync in order; conflicts reported clearly. | UI can show the outcome | E22-US3-UI1 (Shared Screens, not started); E22-US3-UI2 (Shared Screens, not started); E22-US3-UI3 (Shared Screens, not started) | None | Open. Not started. |
| E22-US3-TC3 | Verify security basics. Expected: Traffic over HTTPS; passwords stored hashed. | Not provable by a screen alone | E22-US3-UI1 (Shared Screens, not started); E22-US3-UI2 (Shared Screens, not started); E22-US3-UI3 (Shared Screens, not started) | None | Open. A screen cannot pass this test. |
| E22-US3-TC4 | Verify live updates. Expected: Connected clients receive update within five seconds. | Not provable by a screen alone | E22-US3-UI1 (Shared Screens, not started); E22-US3-UI2 (Shared Screens, not started); E22-US3-UI3 (Shared Screens, not started) | None | Open. A screen cannot pass this test. |
| E22-US3-TC5 | Negative scenario: Avoid duplicate replay after network recovery. Expected: At most one server-side status change, consistent ordering. | UI can show the outcome | E22-US3-UI1 (Shared Screens, not started); E22-US3-UI2 (Shared Screens, not started); E22-US3-UI3 (Shared Screens, not started) | None | Open. Not started. |
| E22-US3-TC6 | Boundary scenario: Real-time and session boundary. Expected: Timely updates for authenticated clients; expired session receives no protected data. | UI can show the outcome | E22-US3-UI1 (Shared Screens, not started); E22-US3-UI2 (Shared Screens, not started); E22-US3-UI3 (Shared Screens, not started) | None | Open. Not started. |

## Parse checks

Stories with no parsed tests: none.
Tests whose story heading was not found: none.

