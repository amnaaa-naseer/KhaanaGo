# KhaanaGo — Requirements-Linked GUI Prototype

This is a **front-end GUI prototype**, built from **KhaanaGo_Chapter2_MIS_Template_Aligned(1).docx** and **KhaanaGo Design System(1).html**, with the **KhaanaGo Screen Inventory.docx** used as the authoritative screen list.

## Open the GUI

1. Open `KhaanaGo_GUI_Standalone.html` in any modern browser. This preview has **zero build-step dependencies** and uses demo data. Internet access is not needed; the font falls back to the system font when offline.
2. Alternatively, open `index.html` in this extracted folder. The code is split across `scripts/` and `styles/` for editing.
3. Use the left-hand **Customer / Rider / Vendor / Admin** switcher. Open **All 189 designs** to search by title, Chapter 2 ID, or module.
4. For local development, run `python -m http.server 8000` from the extracted folder and open `http://localhost:8000`.

## Scope and coverage

| Interface | Total | Full screens | Overlays | Responsive layout sets |
|---|---:|---:|---:|---:|
| Shared | 4 | 2 | 2 | 0 |
| Customer | 48 | 34 | 13 | 1 |
| Rider | 43 | 32 | 11 | 0 |
| Vendor | 69 | 52 | 16 | 1 |
| Admin | 25 | 19 | 5 | 1 |
| **Total** | **189** | **139** | **47** | **3** |

**44 P1**, **118 P2**, and **27 P3** design IDs are included. They map to **84 stories** and **22 epics**. Every inventory ID is discoverable, and each ID displays its original “Must show” specification.

**Important maturity distinction:** This is an **interactive architecture and GUI prototype, not a production app**. The main customer journey, rider fulfilment, vendor ordering/mini-ERP, and admin controls have tailored visual layouts and demo interactions. Secondary screens and overlays are rendered from reusable, requirements-backed modules and may still need final bespoke layout, validation, empty/error/loading states, accessibility review, and UX sign-off before implementation. No live backend, login, payment, maps, GPS, AI, inventory service, notification provider, or dispatch engine is connected. All data and state are in the current browser session; reloading resets the demo.

## Tested walkthroughs

**Customer:** Home → Vendor menu → Item details → Customization → Cart → Pooled/Express delivery → Capacity-based slot → Payment method → Review → Order confirmation → Live tracking.

**Rider:** Home → Online availability → Delivery offer → Kitchen-aware pickup → At store → Pickup handover → Drop-off route → Delivery code (`1234` in the prototype) → Completed delivery → Earnings.

**Vendor:** Owner dashboard → Menu → Capacity setup / live utilization → Dark kitchen board (New → Preparing → Ready → Handed Over) → Private recipes → Nutrition review → Inventory / BOM / MRP → Invoices → Finance → Offers.

**Admin:** Live operations dashboard → Vendor/rider verification → Weather/peak buffer rules → User management → Complaint queue → Audit/safety modules.

The catalogue contains all remaining screen/overlay references, including P2 and P3 design IDs.

## Deliverable structure

```text
KhaanaGo_GUI/
├── index.html                      # Modular browser entry point
├── KhaanaGo_GUI_Standalone.html    # Single-file, offline GUI preview
├── scripts/
│   ├── app.js                      # Rendering, state, navigation and interactions
│   └── manifest.js                 # Auto-generated requirements metadata
├── styles/app.css                  # Screens, responsive layouts, components
├── data/
│   ├── screens.json                # 189 design IDs and acceptance prompts
│   ├── epics.json                  # 22 Chapter 2 epics
│   └── stories.json                # 84 Chapter 2 user stories
├── docs/
│   ├── UI_Traceability.csv         # ID → story → epic → role → priority
│   ├── IMPLEMENTATION_ROADMAP.md   # Production conversion guide
│   └── API_CONTRACTS_DRAFT.md      # Candidate API and realtime contracts
├── handoff/
│   ├── react/                      # React portal design tokens + data types
│   └── flutter/                    # Flutter mobile theme + screen registries
├── tests/                           # Browser and manifest verification scripts
└── build_manifest.py              # Rebuild metadata from source docs (developer-only)
```

`build_manifest.py` expects the source DOCX files at their local paths and is **not needed to open the GUI**. The included JSON and JavaScript manifest files are already generated.

## Production architecture recommendation

Follow the approved project stack: **Flutter (Dart)** for customer/rider apps, **React.js** for vendor/admin portals, and **Node.js / Express / TypeScript**, PostgreSQL, Redis, HTTPS REST, JWT/RBAC and Socket.IO for the backend. The vendor and admin modules may share a React workspace while preserving role permissions, per Chapter 1.

This browser prototype is a disposable GUI shell. Keep the **screen IDs, design tokens, UX rules, acceptance criteria and traceability metadata** as lasting contracts. Implement actual Flutter widgets and React components on those contracts rather than embedding this standalone HTML into the finished apps.

## Safety and realism

- Prices, restaurants, orders, addresses, reports, ratings, analytics, and times are sample data for presentation.
- All buttons that look like financial, registration, or safety actions are simulations; they do **not** trigger real-world transactions or emergency responses.
- Owner-only recipe and finance access is described visually. Actual restrictions must be enforced on backend endpoints (not only hidden navigation).
- The UI adheres to the supplied **Zesty Orange & Charcoal** system. Real food photography is intentionally replaced with locally rendered illustrations/emoji to keep the demo portable.
- Target screen fidelity, authentication, reliability and accessibility should be validated against acceptance criteria before release.
