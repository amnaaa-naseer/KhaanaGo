# QA report

Report date: 3 November 2026. This records what has actually been run. It does not accept the current screens as complete.

## Checks that passed earlier

| Check | Result |
| --- | --- |
| `flutter analyze` on `packages/khaana_design`, `apps/customer`, `apps/rider`, `apps/portal` | No issues, after the customer payment control was moved to `RadioGroup` and the design library name was removed |
| `flutter test` on those four projects | One smoke test each. Design package checks intake bands 59, 60, 84, and 85. Customer expects the login UI ID. Rider expects its sign-in ID. Portal expects vendor sign-in and the staff action |
| Customer debug APK | `assembleDebug` succeeded after Android SDK Platform 36 and NDK 28.2.13676358 were present |

## Checks that failed or were not done

| Check | Result |
| --- | --- |
| Install on the Medium Phone emulator | Failed. `adb` timed out on force-stop and uninstall, then the streamed install returned exit code 1. The phone was left on the launcher. The install error text from `adb` was not captured |
| Visual comparison with the design system | Not done. No accepted screenshots |
| Journey from customer to kitchen to rider | Not possible. The apps do not share an order |
| Empty, loading, offline, and server-error states | Not implemented on the scaffolds, so not tested |
| Small phone, large phone, tablet, desktop | Not reviewed |
| WCAG contrast on rendered screens | Not measured. The button rule in code is charcoal on orange |
| 393 Chapter 2 tests | None passed. Coverage file lists every test as open |
| 189 inventory IDs | 44 scaffolds, 145 not started, 0 accepted |

## Rule for later milestones

A milestone is not done because `flutter analyze` is clean. For each module the next QA note has to include the route exercised, the viewport, the story IDs checked, and the tests that remain backend-only.
