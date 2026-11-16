# Assumptions

These are carried from `config/prototype-assumptions.json` and `docs/requirements-decisions.md`. They are provisional and awaiting review. They are not new Chapter 2 rules.

- Password length on the client is 8–128. Hashing is not implemented. Demo sign-in does not store a password.
- Custom instructions stay within 500 characters where a field is shown.
- Reference images are JPG or PNG up to 5 MB. The upload control records the choice. It does not scan file bytes.
- Slot hold is 5 minutes in the product rules. This build records the chosen slot on the order instead of running a live countdown.
- Intake bands are below 60% Available, 60% up to but not including 85% Limited, and 85% or above Full. Full means an intake rule.
- Delivery code is 6 digits. The mock API derives it from the order number. It is not the old fixed value 482913, and it is not a production secret.
- Pooled delivery is 30% off the delivery fee and an estimated extra 10–15 minutes. It is not a guaranteed time. A fragile line cannot be pooled.
- Waiting-pay rate is unset. The UI must not invent a rupee rate.
- Maps, card and wallet pages, nutrition lookup, sound, and the assistant are simulated and labelled.
- Android minimum version is unresolved. Do not treat Flutter’s generated API 24 as the requirement.
- Vendor staff cannot save or view recipe, finance, nutrition, or bill-of-materials screens. The mock API also hides recipes and finance from the staff role.
