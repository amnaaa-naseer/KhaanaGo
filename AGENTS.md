# KhaanaGo repository-wide agent instructions

- Read `FULL_UI_BUILD_PROMPT.md` and the latest requirements before changing UI. The target is **all 189 inventory designs** (139 full screens, 47 overlays, 3 responsive layouts): 48 customer, 43 rider, 69 vendor, 25 admin, 4 shared. Never stop at P1/44 screens.
- Current source of truth: `KhaanaGo_Chapter2_Deduplicated_Complete_Coverage.docx` (22 epics, 82 stories, 393 test cases); `KhaanaGo_Screen_Inventory_Verified.docx`; `KhaanaGo Design System(1).html`. Older prototype data may refer to outdated 84 stories.
- Implement real Flutter screens for customer/rider and React TypeScript screens for vendor/admin. Preserve KhaanaGo branding, screen-specific layouts, correct navigation, role-based access, accessibility and responsive layouts.
- Never count a screen as done because it is routed. Every required screen and overlay must have actual content, connected interactions and tested UI states. Avoid generic fallback templates, TODO/Coming Soon buttons, dead ends and alert-only actions.
- Integrate app state through one shared mock API in demo mode; mock external payments, AI, maps and third-party services honestly. Keep adapters ready for real Node/Express/Socket.IO backend integrations.
- Maintain `docs/SCREEN_REGISTRY.*`, `docs/BUILD_STATUS.md` and `docs/REQUIREMENTS_TRACEABILITY.md`. Map design IDs to user story and test IDs. Record ambiguous business rules rather than silently inventing them.
- Implement all P1, P2 and P3, in coherent build-tested batches. After every batch run relevant formatting, static analysis and tests, commit if permitted, update progress and resume next incomplete design.
- Confirm counts, all routes and triggers, no untested screens, E2E shared-order lifecycle, and report explicit evidence and any limitations. Never claim 100% complete without passing acceptance evidence.
