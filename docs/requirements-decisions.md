# KhaanaGo requirements decisions

Recorded 1 November 2026 for the prototype. These notes do not change `KhaanaGo_Chapter2_Deduplicated_Complete_Coverage.docx` or `KhaanaGo_Screen_Register.xlsx`.

Numeric prototype values live in `config/prototype-assumptions.json`. Screens must read those values instead of hard-coding them. Every provisional value still needs team and supervisor review before it is written into Chapter 2.

Status meanings:

- **Source requirement.** The behaviour is already in Chapter 2 or the screen register. The GUI follows it.
- **Provisional assumption.** The source names the rule but not the number, or two sources disagree. The value below is for the prototype only.
- **Unresolved.** No prototype value is adopted. The GUI must not pretend the question is settled.

Flutter compatibility below is taken from the Flutter 3.47 supported-platforms page and the Flutter 3.47 release notes (minimum Android API 24, compile and target API 36). Recheck those pages when the SDK is installed.

## D01. Password length

| | |
| --- | --- |
| Kind | Provisional assumption |
| Source | `KhaanaGo_Chapter2_Deduplicated_Complete_Coverage.docx`, E1-US1 AC1 (“a password that meets the strength rule”). E1-US1 boundary test uses a placeholder minimum length N and does not set N. |
| Prototype rule | Minimum 8 characters, maximum 128. Show a clear client-side message for too short, too long, and empty. |
| Still open | The final backend password policy is pending review. Hashing, lockout, and expiry stay backend tests. A screenshot of the form does not verify them. |
| GUI impact | Registration `E1-US1-UI1` and reset `E1-US1-UI5` show the 8–128 rule and the checklist. Any other password field uses the same messages. |
| Confirmation | Yes. Team and supervisor, especially before the backend policy is written. |

## D02. Customization instructions

| | |
| --- | --- |
| Kind | Provisional assumption |
| Source | E4-US2 AC1 (instructions are attached to the order). The matching boundary test uses a placeholder character limit N. Screen `E4-US2-UI1` already asks for a counter and upload errors. |
| Prototype rule | Maximum 500 characters. Show a live counter and a validation message at the limit. |
| GUI impact | Overlay `E4-US2-UI1`. The counter reads `customizationInstructions.maxCharacters` from the config. |
| Confirmation | Yes. |

## D03. Reference image

| | |
| --- | --- |
| Kind | Provisional assumption, aligned with the design system |
| Source | E4-US2 AC1 and AC2 (JPG or PNG within “the size limit”; reject unsupported or oversized files and state the allowed formats and size). The test rejects an EXE and a 15 MB file and still uses placeholder M MB. Design-system microcopy says “Only JPG or PNG files up to 5 MB are allowed.” That sentence is not a Chapter 2 requirement. |
| Prototype rule | JPG and PNG only. Maximum 5 MB per image. Show an unsupported-format state and an oversized-file state. |
| GUI impact | `E4-US2-UI1`, and the vendor ticket `E7-US1-UI2` only displays an image that passed those checks. |
| Confirmation | Yes. 5 MB matches the design system, not Chapter 2. |

## D04. Delivery slot hold

| | |
| --- | --- |
| Kind | Provisional assumption |
| Source | E5-US4 AC2 (release the place when “the hold time” expires). `E5-US4-UI2` is the expiry dialog and returns to the selector. `E3-US2-UI2` shows the countdown. Chapter 2 does not give a duration. The design-system sample countdown of 4:32 is an illustration, not the rule. |
| Prototype rule | Simulated hold of 5 minutes (300 seconds). On expiry, show the slot-released message and return the customer to slot selection. |
| GUI impact | `E5-US3-UI1`, `E5-US4-UI2`, `E3-US2-UI2`. The timer reads `deliverySlot.holdSeconds`. |
| Confirmation | Yes. |

## D05. Slot availability bands

| | |
| --- | --- |
| Kind | Provisional assumption |
| Source | E5-US3 AC1 and AC2 speak of available and full slots. E5-US2 AC3 pauses intake when the queue exceeds a “safe threshold” and does not define the percentage. The screen register requires Available, Limited, and Full on `E5-US3-UI1`. The design system uses 60% and 85% on the kitchen meter. |
| Prototype rule | Available below 60%. Limited from 60% up to but not including 85%. Full, and closed for new bookings, at 85% or above. Thresholds are configurable. The label means an intake rule. It does not mean the kitchen is physically full. |
| GUI impact | Slot grid `E5-US3-UI1`, vendor meter `E5-US1-UI3`, intake pause `E5-US2-UI1`, and any capacity badge that uses the same three states. Copy near the meter should say the band is an intake limit. |
| Confirmation | Yes. |

## D06. Delivery verification code

| | |
| --- | --- |
| Kind | Provisional assumption |
| Source | `E13-US3-UI2` says the code format follows “configured verification rules.” Chapter 2 does not specify the format. |
| Prototype rule | A 6-digit numeric code. |
| GUI impact | Rider entry `E13-US3-UI2` (six digits, wrong-code retry). Customer tracking `E17-US1-UI1` shows the same code. |
| Confirmation | Yes. |

## D07. Rider check-in grace period

| | |
| --- | --- |
| Kind | Provisional assumption |
| Source | E16-US1 AC6 (escalate when the grace period passes). Admin screen `E16-US1-UI3` lists missed check-ins past that period. Chapter 2 does not set the length. |
| Prototype rule | 2 minutes. |
| GUI impact | Voice check-in `E16-US1-UI1` and safety escalations `E16-US1-UI3`. The escalation clock reads `riderCheckIn.gracePeriodSeconds`. |
| Confirmation | Yes. |

## D08. Second-pickup hold

| | |
| --- | --- |
| Kind | Provisional assumption |
| Source | E14-US1 describes a configured hold limit at the second pickup, then uncoupling. `E14-US1-UI2` shows a countdown and “Order uncoupled, continue with the first.” A Chapter 2 test input uses 5 minutes; the story itself does not fix the number. |
| Prototype rule | Maximum hold of 5 minutes, then the uncoupling state. |
| GUI impact | `E14-US1-UI2`. |
| Confirmation | Yes. |

## D09. Waiting pay

| | |
| --- | --- |
| Kind | Provisional assumption for the threshold. The rate is unresolved. |
| Source | E15-US2: a waiting fee after dwell exceeds “8 to 10 minutes.” No fee at or below the threshold. The rupee rate is not specified. `E13-US4-UI1` shows the timer and says the fee applies only to excess minutes. |
| Prototype rule | Free waiting threshold of 8 minutes, at the low end of the source range. Show waiting pay only for time beyond 8 minutes. The rate per minute stays null in config until a value is chosen. Do not invent an amount on screen. |
| GUI impact | `E13-US4-UI1`, earnings lines on `E13-US3-UI4`, `E15-US3-UI1`, and `E15-US3-UI2`. Show excess minutes. If the rate is still null, say the rate is not set rather than showing Rs 0 as if it were the rule. |
| Confirmation | Yes. The 8-minute threshold and the missing rate both need review. |

## D10. Pooled delivery offer

| | |
| --- | --- |
| Kind | Provisional assumption inside a source range |
| Source | E14-US2: pooled delivery “may take 10 to 15 minutes longer” for a “30 to 40 percent” delivery-fee discount. Express is never pooled. |
| Prototype rule | Show a 30% discount on the delivery fee and an estimated extra 10–15 minutes. The extra time is an estimate, not a guaranteed delivery time. |
| GUI impact | `E14-US2-UI1` and the pooled sequence on `E17-US1-UI1`. Wording must not promise a clock time from the 10–15 minute range alone. |
| Confirmation | Yes. 30% and 10–15 minutes are the low ends of the source ranges. |

## D11. Maps and live tracking

| | |
| --- | --- |
| Kind | Provisional assumption for the prototype shell |
| Source | E15-US1 AC4: if the maps service is unavailable, use a defined fallback and flag it for review. The fallback itself is not defined. Address entry `E1-US5-UI3` includes a map pin and a typed address line. Rider navigation `E13-US5` allows an external map or an in-app map. |
| Prototype rule | Maps and live tracking are simulated until a maps provider is integrated. If the map cannot be shown, show a readable text address and a retry action. Allow manual address entry on address and drop-off screens. Label simulated maps so they are not presented as live navigation. |
| GUI impact | `E1-US5-UI3`, `E17-US1-UI1`, `E13-US1-UI1`, `E13-US3-UI1`, `E13-US5-UI1`, `E16-US3-UI1`, and `E15-US1-UI1` / `E15-US1-UI2`. |
| Confirmation | Yes, before any real maps SDK is chosen. The simulated label can ship with the prototype. |

## D12. Android support

| | |
| --- | --- |
| Kind | Unresolved |
| Source | Conflict, recorded and not resolved. E16-US3 and the rider survey say “Android 10 or older.” The design system role table and the screen inventory say the rider app is “Flutter, Android 10 and up.” |
| Flutter 3.47 facts the team must use | Supported Android API levels are 24 through 37. API 23 and earlier are unsupported. The default `flutter.minSdkVersion` is API 24 (Android 7.0). Default compile and target SDK are API 36. The 3.47 Android toolchain cited in the release notes is Java 17, Android Gradle Plugin 9.1.0, Gradle 9.3.1, and Kotlin Gradle Plugin 2.4.0. Customer iOS, if built on the same SDK, has a Flutter floor of iOS 15. That iOS floor is separate from the Android conflict. |
| What this means | “Android 10 and up” can be implemented by setting minSdk to API 29, which drops Android 7, 8, and 9 even though Flutter still supports them. “Android 10 or older” cannot be met in full on current Flutter, because Android 6.0 (API 23) and earlier are unsupported. Android 7.0 through 10 remain possible only if minSdk stays at 24 or another level at or below API 29. |
| What the team must decide | 1. The minimum API the prototype claims: 24 (Flutter floor), 29 (Android 10), or a level in between. 2. Whether phones older than Android 10 are in scope for riders. 3. That Android 6 and earlier are out of reach on Flutter 3.47. 4. The minSdk of each plugin actually added (maps, location, camera, speech, notifications, background location). A plugin can raise the floor above API 24. 5. That target SDK 36 is a store requirement and is not the same decision as the oldest phone. |
| GUI impact | Do not print a minimum Android version on `E16-US3-UI1`, store screens, or the report until this is decided. `E22-US1-UI1` can still show layout breakpoints. Device-lab testing waits on the decision. |
| Confirmation | Yes. Do not declare the minimum version resolved. |

## D13. Fragile items

| | |
| --- | --- |
| Kind | Source requirement. Wording issue recorded for a future Chapter 2 correction. |
| Source | E4-US3 AC3 and AC4. The story is written for the vendor, while AC3 and AC4 say “Given my cart,” which is the customer’s voice. The behaviour is still specified: a fragile custom item disables pooled delivery and applies express; changing the item to non-fragile makes pooled delivery available again. |
| Prototype rule | Keep that behaviour. A fragile item forces express. After it is removed, pooled delivery returns only if the rest of the order still meets the pooling rules (distance, hold limits, spillable exclusions, and the other E14-US1 checks). Do not rewrite Chapter 2 in this task. |
| GUI impact | `E14-US2-UI1` disables pooled while a fragile item is in the cart and offers it again only after a full eligibility check. `E4-US3-UI1` remains the vendor review of the custom order. |
| Confirmation | The behaviour does not need a new product decision. The pronoun wording needs a future Chapter 2 edit, with supervisor agreement. |

## D14. Current requirement IDs

| | |
| --- | --- |
| Kind | Source requirement |
| Source | Current Chapter 2, confirmed by the screen inventory’s ID-move note. The inventory says it did not modify Chapter 2. |
| IDs to use | Reorder: E17-US2 (`E17-US2-UI1`, `E17-US2-UI2`, `E17-US2-UI3`). Rating highlights: E17-US3, shown on Home `E3-US1-UI1`. Storage rules: E9-US4 (`E9-US4-UI1`, and storage type on `E9-US1-UI1` / `E9-US1-UI2`). |
| GUI impact | Do not revive the retired IDs E17-US4 or E9-US5 in routes, labels, or the traceability notes. |
| Confirmation | No new decision. Use these IDs unless Chapter 2 is revised later. |

## D15. Test-to-screen traceability

| | |
| --- | --- |
| Kind | Source process rule, still open screen by screen |
| Source | Screen-register guide and the `Mapping review` column: candidate tests are copied at story level and each one must be reviewed. Section 2.5 marks every UI cell `Pending – Section 2.4`. The inventory says API authorization, atomic holds, hashing, immutable logs, timing, external services, and device performance cannot be proved by a mockup. |
| Prototype rule | Review each test against one screen state or mark it as a backend, security, or integration test. GUI-visible examples include validation messages, slot badges, the hold-expired dialog, and the fragile-item delivery choice. Backend examples include password hashing, the atomic slot lock, audit immutability, and payment-gateway settlement. |
| GUI impact | A screenshot may be evidence for a visible state. It must not be cited as proof of a backend rule. Leave register statuses unchanged until a screen exists and a test has been reviewed. |
| Confirmation | Yes, as an ongoing review. It does not block drawing the first screens. |

## D16. Chapter 2, Section 2.4

| | |
| --- | --- |
| Kind | Unresolved documentation gap |
| Source | Chapter 2, Section 2.4 is a placeholder: wireframes will be inserted later. Section 2.5 therefore leaves the UI column pending. The design system text-field note says “Field limits are listed in Chapter 2, Section 2.4.2.” That subsection does not exist. This decision log does not invent it. |
| Prototype rule | Build from the screen register, the screen inventory, and `KhaanaGo Design System.html`. Field limits used by the prototype are the provisional values in `config/prototype-assumptions.json`, not a fictional Section 2.4.2. |
| GUI impact | No screen is blocked. When Section 2.4 is written, replace the design-system pointer to Section 2.4.2 and fill the traceability UI column with the real IDs. |
| Confirmation | Yes. Flag the design-system reference for review. Do not add a Section 2.4.2 as part of GUI work. |

## Brand assets

The attached logos are stored for later screens. They are not a requirements change.

- Mark and wordmark: `assets/brand/khaanago-logo.png`
- Wordmark: `assets/brand/khaanago-wordmark.png`

Use them on launch and sign-in screens. The orange ground in the files is the logo artwork. Interface orange remains the design-system token `#F97316`.

The logo files stay in `assets/brand/`. They are not copied into the Flutter apps, because a Flutter asset has to live inside its package and the originals must stay untouched.

## D17. Vendor and admin portal platform

| | |
| --- | --- |
| Kind | Provisional implementation decision |
| Source | The design system role table and the screen register say the vendor portal is a React PWA and the admin portal is React for desktop. The build instruction for this prototype is one Flutter web app for both. |
| Prototype rule | `apps/portal` is that Flutter web app. Vendor owner, kitchen staff, and admin each have their own navigation. Staff routes omit finance and recipe screens. A direct route to an owner-only page shows “You do not have access to this page.” |
| GUI impact | Do not start a separate React app for the portal. Customer and rider stay separate Flutter apps. Customer also keeps responsive web, which the screen register already asks for. |
| Confirmation | Yes. Update the report’s platform wording when the supervisor accepts this change. The design-system HTML is not edited. |
