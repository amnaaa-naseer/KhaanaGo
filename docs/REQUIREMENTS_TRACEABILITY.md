# Requirements traceability

Chapter 2, read from `docs/planning/KhaanaGo_Chapter2_Requirements.md`: 22 epics, 82 stories, 256 acceptance criteria, 393 tests.

Every inventory design is in `docs/SCREEN_REGISTRY.csv` with its story IDs and the story-level candidate tests copied from the workbook. Those candidate links are not a reviewed one-test-to-one-screen map.

`docs/implementation/REQUIREMENTS_COVERAGE.md` lists every test. None is marked passed. A row that says a screen can show the outcome still needs a person to exercise it. A row that says a screen cannot prove the test stays a backend or integration test.

| Interface | Designs | App |
| --- | ---: | --- |
| Customer | 48 | `apps/customer_flutter` |
| Rider | 43 | `apps/rider_flutter` |
| Vendor | 69 | `apps/vendor_portal` |
| Admin | 25 | `apps/admin_portal` |
| Shared | 4 | Included in each app |

Shared order state is `services/mock-api`. Placing an order, accepting it, marking it ready, picking it up, and delivering it with code 482913 updates stock, the invoice, and finance in one store.
