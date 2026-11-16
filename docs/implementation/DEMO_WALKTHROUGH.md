# Demo walkthrough

Two different things are described here. The first is what can be opened today. The second is the university walkthrough after Phase 3. They are not the same system.

## What runs today

Start the mock API first (`node server.js` in `services\mock-api`), then use a separate terminal for each app.

Customer, in Chrome:

```powershell
cd C:\FYP\KhaanaGo\apps\customer_flutter
flutter run -d chrome
```

Vendor and kitchen, in the browser at http://localhost:5173:

```powershell
cd C:\FYP\KhaanaGo\apps\vendor_portal
npm run dev
```

Admin, in the browser at http://localhost:5174:

```powershell
cd C:\FYP\KhaanaGo\apps\admin_portal
npm run dev
```

Rider, on an Android emulator or device:

```powershell
cd C:\FYP\KhaanaGo\apps\rider_flutter
flutter run
```

## University walkthrough after Phase 3

Reset the demo broker, then follow `USER_JOURNEYS.md` Journey A on the customer app, the vendor and admin portals, and the rider phone.

Say these limits out loud if a supervisor asks:

- Payment, maps, nutrition lookup, sound, and the assistant are simulated and labelled.
- Password storage, atomic booking, gateway callbacks, and audit immutability are not proved by the screens.
- Provisional numbers on screen are awaiting review. They are not Chapter 2 text.
- Android’s minimum version is not decided. The generated Flutter floor is API 24 and is not the requirement.

## Still not a full GUI

Phases 4 to 8 are the rest of the 189 designs. The tracker is the list. Nothing in this walkthrough marks those as done.
