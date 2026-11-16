# KhaanaGo design system summary

Source: `docs/KhaanaGo Design System.html` (v1.0, “Zesty Orange & Charcoal”). One system covers the customer app, rider app, vendor portal, and admin portal. It is the visual reference for Figma, Flutter, and React, and for the UI figures that Chapter 2, Section 2.4 still needs.

## Principles

1. **Say what the kitchen can do.** Available, Limited, Full, and Paused use the same colours on customer slots, vendor meters, and admin monitors.
2. **Orange asks, charcoal answers.** Orange marks the one action or selection that matters. Charcoal carries text, including labels on orange buttons.
3. **Never colour alone.** Every state pairs colour with an icon and a word.
4. **Same parts, different density.** Riders get 64 dp buttons and 20 sp text. Vendors get dense tables. Both use the same tokens.

## Colour

Brand proportion on a light screen: cream 55%, white 25%, charcoal 15%, orange about 5%. Dark theme swaps the ground to charcoal and the text to cream. Orange stays the “tap here” colour.

### Brand

| Name | Hex | Use |
| --- | --- | --- |
| Orange | `#F97316` | Primary fill, active tab pill, selection borders. Label on it is charcoal, never white. |
| Charcoal | `#242424` | Text on light surfaces, dark-theme cards, secondary button outline, snackbar ground. |
| Cream | `#FFF8EF` | Light page background; text colour in dark theme. |
| White | `#FFFFFF` | Cards, sheets, and fields on cream. |

### Orange scale

500 (`#F97316`) is the brand fill. 700 (`#C2410C`) is the minimum orange for small text on cream or white, and the light-theme focus ring. 400 (`#FB923C`) is orange text on charcoal and the pressed button fill. 100 (`#FFEDD5`) and 200 are selection tints.

### Warm neutrals

| Step | Hex | Role |
| --- | --- | --- |
| Cream | `#FFF8EF` | Page |
| 100 | `#FBF0E2` | Surface 2: disabled, board columns, hover |
| 200 | `#EADBC8` | Dividers and card borders (light) |
| 300 | `#D9C3A5` | Stronger line |
| 400 | `#B8AEA3` | Muted text in dark theme |
| 500 | `#8A7F73` | Field and chip borders on light (about 3:1) |
| 600 | `#6B635B` | Muted text on cream |
| 700 | `#3A3835` | Dark dividers |
| 800 | `#242424` | Charcoal |
| 900 | `#1A1A1A` | Dark page background |

### Capacity and status

State is always icon + word + colour.

| State | Light text | Light tint | Meaning |
| --- | --- | --- | --- |
| Available | `#15803D` | `#DCFCE7` | Open vendor, free slot, delivered, paid |
| Limited | `#854D0E` | `#FEF3C7` | Nearly full, rising estimate, low stock. Yellow, kept apart from brand orange. |
| Full / error | `#B91C1C` | `#FEE2E2` | Slot full, errors, allergen exclusions, failed payment |
| Closed / paused | `#57534E` | `#E7E5E4` | Outside hours, manually closed, intake paused |
| Info / live | `#0369A1` | `#E0F2FE` | Tracking, rider position, estimates, banners |
| Selected | `#7C2D12` | `#FFEDD5` | Chosen chip, slot, address, or payment method, with a 2 px orange border |

Kitchen meter: 12 segments for the hourly limit. Up to 60% Available, up to 85% Limited, above that Full. A long custom cake fills more than one segment.

### Tokens that change with theme

| Token | Light | Dark | Use |
| --- | --- | --- | --- |
| `--bg` | `#FFF8EF` | `#1A1A1A` | Page |
| `--surface` | `#FFFFFF` | `#242424` | Cards, fields, sheets |
| `--surface-2` | `#FBF0E2` | `#2E2E2E` | Disabled, columns, hover |
| `--fg` | `#242424` | `#FFF8EF` | Primary text |
| `--fg-muted` | `#6B635B` | `#B8AEA3` | Secondary text |
| `--line` | `#EADBC8` | `#3A3835` | Dividers |
| `--field` | `#8A7F73` | `#8C8379` | Field and chip borders |
| `--brand` | `#F97316` | `#F97316` | Primary fill |
| `--on-brand` | `#242424` | `#242424` | Text and icons on orange |
| `--brand-text` | `#C2410C` | `#FB923C` | Links and small orange text |
| `--brand-tint` | `#FFEDD5` | `#3A2415` | Selected background |
| `--focus` | `#C2410C` | `#F97316` | Focus ring |
| `--ok` | `#15803D` | `#4ADE80` | Available |
| `--lim` | `#854D0E` | `#FACC15` | Limited |
| `--full` | `#B91C1C` | `#F87171` | Full, error, allergen |
| `--closed` | `#57534E` | `#A8A29E` | Closed, paused |
| `--info` | `#0369A1` | `#38BDF8` | Live, tracking |

Rejected pairings: brand orange `#F97316` as small text on cream (use `--brand-text`), and white labels on orange (use charcoal). Body text, muted text, and badge text target 4.5:1. Field borders and focus rings target 3:1.

## Typography

Face: **Plus Jakarta Sans** (weights 400, 500, 600, 700, 800), already used in the project deck. Prices and times use tabular figures. Currency is `Rs` with thousands separators and no decimals.

| Style | Size / line / weight | Use |
| --- | --- | --- |
| Display | 28 / 36 · 800 | Order total, empty states |
| Title | 22 / 28 · 700 | Screen titles |
| Heading | 18 / 24 · 700 | Vendor names, sheet titles |
| Body | 16 / 24 · 500 | Default text |
| Body small | 14 / 20 · 500 | Bill lines, secondary info |
| Button | 16 / 24 · 700 | All buttons |
| Price | 18 / 24 · 700 tabular | Prices, totals, timers |
| Caption | 12 / 16 · 600 | Metadata, helper text |
| Eyebrow | 12 / 16 · 700, +6% letter-spacing, uppercase | Section labels |

Rider mode: body 20/28, buttons 20/28 at weight 800, status line 28/34. Minimum text anywhere in the rider app is 16 sp. At most three lines of text while a delivery is active.

Vendor and admin: body 14/20, tables 13/18, page title 22/28, section title 18/24. Numbers are right-aligned. Text must scale to 130% without clipping and be tested at 200%.

## Space, shape, and depth

8 dp grid with a 4 dp half step. Separate cards with a 1 px warm line first and a shadow second.

| Token | dp |
| --- | --- |
| space-1 | 4 |
| space-2 | 8 |
| space-3 | 12 |
| space-4 | 16 |
| space-5 | 24 |
| space-6 | 32 |
| space-7 | 48 |
| space-8 | 64 |

Radius: 12 for buttons and fields, 16 for cards, 24 on the top of sheets, pill (999) for chips and badges.

Elevation: Level 0 is a 1 px line. Level 1 is the card shadow (`0 1px 2px` plus `0 4px 12px` at 8% and 6% charcoal). Level 2 is the sheet shadow.

| Layout rule | Value |
| --- | --- |
| Phone artboard | 360 × 800 dp, also checked at 390 × 844 dp |
| Side margin | 16 dp; section gap 24 dp; card padding 16 dp |
| Touch target | 48 × 48 dp for customer and vendor. Rider status buttons 64 dp. Chips look 40 dp tall with a 48 dp hit area. |
| Kitchen board | 4 columns, 16 dp gutters, cards at least 190 dp wide |
| Web breakpoints | Below 600 px phone layout; 600–1024 px two columns; above 1024 px a left rail and content up to 1200 px |
| Icons | 24 dp, 2 dp stroke, rounded caps. Material Symbols Rounded in Flutter. |
| Motion | Tap 120 ms, sheet 220 ms, page 300 ms, easing `cubic-bezier(.2, 0, 0, 1)`. Instant when the system asks to reduce motion. |

## Components

| Component | Rules |
| --- | --- |
| Buttons | One primary button per screen, full width, 56 dp at the bottom. Charcoal label on orange. States: pressed (`#FB923C`), loading, danger (cancel), disabled. Labels name the result, for example `Place order · Rs 1,829`. |
| Text fields | 48 dp, 1.5 px border, 12 px radius. Label above, asterisk for required, error below with an icon. Focus: 2 px orange-700 border and a tint ring. |
| Chips | Filters, sizes, flavours, exclusions, day tabs. Selected: orange tint, orange border, check icon. Unsupported: dashed border, disabled. |
| Capacity badges | Available, Limited, Full, Closed. Same four states on vendor cards, slots, the meter, and the admin monitor. |
| Kitchen capacity meter | Twelve segments, counts such as `5 of 12 orders`, plus the badge. |
| Nutrition and allergen | kcal, protein, carbs, fat per serving. Hide the badge when a dish has no data. Allergen warning updates with the recipe and never shows ingredient quantities. |
| Price lines | Separate lines for food, delivery, surcharge, discount, and total. Discounts in green with a minus sign. |
| Order timeline | Done is green with a check. Current step has a blue ring. Upcoming is a grey outline. Only the current arrival window is large. |
| Vendor card | Monogram tile until a photo exists. Closed vendors are neutral and cannot be opened for ordering. Rating uses a star plus a number. |
| Delivery slot grid | Available, Limited (`2 left`), Full. Full slots are dashed and cannot be selected. A held slot shows a countdown at checkout. |
| Sheet, dialog, snackbar | Sheets slide up in 220 ms and carry one primary action. Snackbars last 4 seconds on a fixed charcoal ground in both themes. |
| Bottom navigation | Four destinations, labels always visible: Home, Orders, Assistant, Profile. Active item gets the orange pill. |
| Hold-to-confirm | Press and hold for 0.9 s. Early release resets. Keyboard Space or Enter held does the same. Used for rider status changes (story E16-US2). |
| Kitchen ticket | Order number, items, custom text, allergen warning as the only red element, and Accept / Reject or a milestone action. Columns: New, Preparing, Ready, Handed over. Audible alert on each new order. |
| Rider high-contrast screen | Near-black ground, cream text, muted address line, preset messages, one large hold button. |

## Role variants

| Interface | Platform | Default theme | Density | Special rules |
| --- | --- | --- | --- | --- |
| Customer | Flutter, Android and iOS; responsive web | Light cream, follows the system | 48 dp targets | Capacity and price visible before payment. Nutrition and allergens sit on the item. |
| Rider | Flutter | High-contrast dark, switchable | One action, 64–72 dp targets, 20 sp text | Hold-to-confirm. Voice check-in overlay. At most 3 text lines while moving. Low-data: no animations, one map tile layer. |
| Vendor | React PWA, tablet first for the kitchen board | Light for owner screens, dark for the kitchen board | Dense tables, 14 sp | Staff never see finance or recipe items in navigation. A direct link shows “You do not have access to this page.” |
| Admin | React, desktop browser | Light | Dense 13 sp tables | Queues first. Audit views never show recipe quantities. |

## Content rules called out for the UI

- Slot taken: “That slot was just taken. Pick another time.”
- Delay: “Your order is running about 15 minutes late because the kitchen is busy.”
- Upload: “Only JPG or PNG files up to 5 MB are allowed.”
- Payment: “Payment did not go through. Your order has not been placed.”
- No access: “You do not have access to this page.”
- Empty orders: “No orders yet.” with a Browse restaurants button.

Sentence case. Say what happened and what to do next. The HTML file also includes starter Flutter `ThemeData`, CSS tokens, and an MUI theme. Those belong in the app projects when implementation starts.
