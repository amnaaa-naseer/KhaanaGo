# Requirements gaps

These are unresolved differences and limits. They are not new requirements. Chapter 2, the inventory, and the design system were not changed.

## Documents that are not in the repository

- `docs/reference/` does not exist.
- `KhaanaGo-Chapter1-Updated.docx` is not in the project.
- `KhaanaGo_Project_Details_Updated(1).docx` is not in the project.
- The design-system file on disk is `docs/KhaanaGo Design System.html`, not a “(1)” copy.

Chapter 2 Section 2.4 is still an empty placeholder. The design system mentions a Section 2.4.2 that does not exist. Field limits used by the prototype come from `config/prototype-assumptions.json`. That file is awaiting review. It is not Chapter 2.

## Decisions already recorded

| ID | Topic | Status |
| --- | --- | --- |
| D01 | Password 8–128 on the client | Provisional. Hashing and lockout duration are not specified |
| D02 | Custom instructions, 500 characters | Provisional |
| D03 | JPG or PNG, 5 MB | Provisional. 5 MB comes from the design system, not Chapter 2 |
| D04 | Slot hold, 5 minutes | Provisional |
| D05 | Intake bands 60% and 85% | Provisional. Means intake, not physical fullness |
| D06 | Delivery code, 6 digits | Provisional |
| D07 | Rider check-in grace, 2 minutes | Provisional |
| D08 | Second pickup hold, 5 minutes | Provisional |
| D09 | Free waiting, 8 minutes. Rupee rate empty | Threshold provisional. Rate not decided |
| D10 | Pooled delivery, 30% off the delivery fee, extra 10–15 minutes, not a guaranteed time | Provisional |
| D11 | Maps simulated, with text address and retry | Provisional |
| D12 | Android minimum version | Unresolved. “Android 10 or older” in E16-US3 conflicts with “Android 10 and up” in the design system. Flutter 3.47’s generated floor is API 24. That floor is not an approved requirement |
| D13 | Fragile items force express. Pooled returns only if the order still qualifies | Behaviour stands. The story text uses the customer’s voice inside a vendor story. The chapter is not edited |
| D14 | Current IDs: reorder E17-US2, rating highlights E17-US3, storage E9-US4 | Do not revive retired IDs |
| D15 | Test links in the workbook are story-level | Each test still needs its own review |
| D16 | Section 2.4 empty | Do not invent 2.4.2 |
| D17 | One Flutter web portal for vendor, kitchen, and admin | Approved for this prototype. The design system still says React. Confirm again when this plan is approved |

## What a screen cannot close

A screenshot or a mock click does not pass tests about password hashing, session tokens, duplicate accounts stored in a database, atomic slot booking, payment-gateway callbacks, audit immutability, or a push message actually delivered to a phone.

`REQUIREMENTS_COVERAGE.md` marks those rows “Not provable by a screen alone”. Their status stays open.

## Product behaviour that is specified but not built

Registration, verification, password reset, search, filters, addresses, vouchers, history, reviews, rider documents, vendor onboarding, staff duties, offers, wastage, purchasing, complaints, commission editing, and the assistant screens are in the inventory and are not started.

The assistant is a scripted, labelled demo. Chapter 2 does not define a model, a training set, or a recommendation algorithm. None of those will be invented.

IVR phone calls, the payment provider’s own page, push payloads, and the PWA install prompt are outside the screen list. The prototype shows the in-app result only.

## Current prototype limits that the redesign has to remove

- Three separate sessions, so the cross-role story cannot be demonstrated.
- Logos not shown.
- No photography.
- Most error, empty, loading, and offline states missing.
- Kitchen sound is a tab-title change, not an audio asset. No audio file was specified.
- Invoice and finance numbers are samples, not postings from the order.
