# Design strategy

Source: `docs/KhaanaGo Design System.html`, version 1.0, “Zesty Orange & Charcoal”. The HTML file is not edited.

## Tokens

| Role | Value | Rule |
| --- | --- | --- |
| Orange | `#F97316` | The one action or selection. About 5% of a light screen. |
| Charcoal | `#242424` | Text, including the label on an orange button. |
| Cream | `#FFF8EF` | Page background. |
| White | `#FFFFFF` | Cards, sheets, and fields. |
| Orange text on cream | `#C2410C` | Small text and links. `#F97316` is not used for small text on cream. |
| Focus | `#C2410C` on light, `#F97316` on dark | Visible focus ring. |

Status is always an icon, a word, and a colour.

| State | Light text | Light ground |
| --- | --- | --- |
| Available | `#15803D` | `#DCFCE7` |
| Limited | `#854D0E` | `#FEF3C7` |
| Full or error | `#B91C1C` | `#FEE2E2` |
| Closed or paused | `#57534E` | `#E7E5E4` |
| Info | `#0369A1` | `#E0F2FE` |

Limited stays yellow so it is not confused with brand orange.

Intake bands, from the provisional config and still awaiting review: Available below 60%, Limited from 60% up to but not including 85%, Full at 85% or above. The label means an intake rule, not that the kitchen is physically full. The meter has 12 segments.

## Measure

8 dp grid. Buttons 56 dp and full width on customer flows. Rider primary actions 64 dp. Fields 48 dp. Radius 12, 16, 24, or a pill. Type is Plus Jakarta Sans.

Customer navigation: Home, Orders, Assistant, Profile.

Kitchen board: dark, tablet first, four columns (New, Preparing, Ready, Handed over).

Owner and admin: dense tables and a rail, not a stack of marketing cards.

## What the current package already has

`packages/khaana_design` has the brand colours, the three themes, a page scaffold, primary and secondary buttons, a capacity badge, price lines, a provisional-note chip, a simulated map, a 0.9 second hold button, and access denied. Buttons use charcoal on orange.

## What Phase 2 still has to add

- Logo and wordmark from `assets/brand/`, copied into the package without changing the files.
- Text fields with error text, character counts, and the provisional password rule on registration only.
- Skeletons, empty states, and the shared error, offline, conflict, and not-found patterns.
- Sheets, confirmation dialogs, data tables, and the 12-segment meter.
- Icon set. Emoji are not the primary icons.
- Food and restaurant images from generated project assets or another source that the project can legally ship. Sample prices stay in PKR.

## Layout by role

| Role | Density | Type and targets | First viewport to check |
| --- | --- | --- | --- |
| Customer | Calm, one primary action | 56 dp buttons | 360 px wide, then a desktop browser |
| Rider | High contrast, dark, few words | 64 dp, large type | Phone in sunlight, one hand |
| Kitchen | Fast scanning | Large status controls | Tablet, then a narrow browser |
| Owner and admin | High density | Tables, filters, rails | 1280 px, then below 900 px |

## Contrast and accessibility

Charcoal on orange is the button rule from the design system. White on orange is not used. Status never depends on colour alone. Focus is visible. Error text says what to do next. Touch targets on the rider app stay at the rider size even when the same component is smaller in the customer app.

## Motion

Short feedback only: selection, hold-to-confirm at 0.9 seconds, and a slot countdown. No decorative motion.

## Review

A screen is compared with the design system after it renders. Source code that imports the theme is not enough. Screenshots go with the QA notes for that milestone.
