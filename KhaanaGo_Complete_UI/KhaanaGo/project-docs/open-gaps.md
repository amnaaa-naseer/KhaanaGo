# Gaps found while building the P1 prototype

These are not new product requirements. They record what this mock cannot decide or prove.

1. Android minimum version is still unresolved (decision D12). Flutter wrote `minSdk = flutter.minSdkVersion` into the customer and rider Gradle files. In Flutter 3.47 that property is 24. That number is not an approved KhaanaGo requirement, and the Gradle files were left as generated.

2. Password length, hashing, and lockout duration are not on the P1 sign-in screens. Registration and reset are P2 (`E1-US1-UI1`, `E1-US1-UI4`, `E1-US1-UI5`). The admin lockout message can be previewed locally. It does not lock a real account or notify an owner.

3. The 500-character instruction counter and the 5 MB image checks belong on `E4-US2-UI1`, which is P2 and not built.

4. The slot-taken dialog can be previewed. Two customers confirming at the same moment is a backend test. The 5-minute hold is provisional.

5. Payment methods are stored locally. JazzCash, Easypaisa, and card pages belong to the gateway.

6. Maps, rider position, nutrition calculation, stock posting, invoices, and finance totals are sample or simulated. Waiting pay shows minutes only, because the rupee rate is empty.

7. Kitchen sound and vibration are named on `E13-US1-UI2` and `E7-US1-UI1`. No sound asset was specified, so the mock shows the visual alert and, on the web portal, changes the tab title.

8. Push notification text is not sent. The delay reason is shown in the app, which is the screen. The inventory already treats the push body as outside the screen list.

9. Staff have no separate P1 dashboard. `E1-US3` AC1 is met by sending staff to the kitchen board. Finance, recipes, nutrition, the owner dashboard, and the dish bill of materials are refused for staff. Invoices stay available because the register’s finance module says invoices are the exception.

10. A different-restaurant cart dialog is `E3-US2-UI3`, P2. The cart blocks a second restaurant with a message instead of that dialog.

11. Logos remain in `assets/brand/` and are not bundled inside the Flutter packages.

12. Offer amounts, invoice lines, dashboard counts, and recipe quantities on screen are sample data so the layout can be reviewed. They are not calculated by the engines in Chapter 2.
