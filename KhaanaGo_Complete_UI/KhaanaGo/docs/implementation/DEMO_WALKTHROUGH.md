# Demo walkthrough

Two different things are described here. The first is what can be opened today. The second is the university walkthrough after Phase 3. They are not the same system.

## What runs today

The scaffolds do not share data. Use a separate terminal for each app, from `C:\FYP\KhaanaGo`.

Customer, in Chrome:

```powershell
cd C:\FYP\KhaanaGo\apps\customer
flutter run -d chrome
```

Sign in with any non-empty email and password. Empty fields show an error. Home lists sample vendors. Open the open bakery, customize the cake, and walk cart, delivery, slots, payment, review, placed, tracking, and the delay screen. Pooled delivery is blocked when the cake is marked fragile. The slot-taken message is a preview button, not two real customers.

Vendor, kitchen, and admin, in Chrome:

```powershell
cd C:\FYP\KhaanaGo\apps\portal
flutter run -d chrome
```

Owner sign-in opens the owner dashboard. Kitchen staff sign-in opens the kitchen board. Finance, recipes, nutrition, and the owner dashboard show access denied for staff. Admin sign-in is the link on the vendor sign-in page. An admin password of `wrong` six times shows a local lockout message. It does not lock a real account.

Rider, on an Android emulator or device:

```powershell
cd C:\FYP\KhaanaGo\apps\rider
flutter run
```

The last install onto the Medium Phone emulator failed after the APK had built. If `flutter run` stops at `adb install`, the rider scaffold is not on the phone. The rider flow itself is sign-in, go online, offer, pickup, a simulated ready alert, wait timer, hold to confirm pickup, drop-off, the code `482913`, then a delivered summary with no rupee waiting rate.

The Java `System::load` lines printed by Gradle are a warning. They are not the install failure.

## University walkthrough after Phase 3

Reset the demo broker, then follow `USER_JOURNEYS.md` Journey A on three windows: customer Chrome or phone, portal Chrome, rider phone.

Say these limits out loud if a supervisor asks:

- Payment, maps, nutrition lookup, sound, and the assistant are simulated and labelled.
- Password storage, atomic booking, gateway callbacks, and audit immutability are not proved by the screens.
- Provisional numbers on screen are awaiting review. They are not Chapter 2 text.
- Android’s minimum version is not decided. The generated Flutter floor is API 24 and is not the requirement.

## Still not a full GUI

Phases 4 to 8 are the rest of the 189 designs. The tracker is the list. Nothing in this walkthrough marks those as done.
