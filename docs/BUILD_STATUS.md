# Build status

Updated 8 November 2026. The product is not complete.

| Status | Count | Meaning |
| --- | ---: | --- |
| Catalog scaffold | 177 | The design ID renders, but the body is still a shared family layout or a clause form. That is not a completed screen. |
| Interaction-tested | 12 | Customer checkout IDs keep one session across navigation. `checkout_test.dart` places the selected quantity and note at the menu price. |
| Visually-reviewed | 0 | Screenshots were not compared one by one with the design system. |

The per-ID list is `docs/SCREEN_REGISTRY.csv`. Counts: 48 customer, 43 rider, 69 vendor, 25 admin, 4 shared. Kinds: 139 screens, 47 overlays, 3 layout sets.

The 5 November interface pass rebuilt the vendor and admin shell and the owner dashboard from existing demo data. Manual steps are in `docs/MANUAL_TEST_GUIDE.md`. That pass is not a visual acceptance of the 189 designs.

No ID is missing. No ID is marked visually accepted.
