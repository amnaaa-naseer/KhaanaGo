# KhaanaGo — Presentation Script & Panel Prep

Audience: SE HOD, faculty panel, industry experts. Total time budget below assumes a ~6–7 minute pitch + Q&A. Adjust pacing to whatever slot you're given, but keep the **baker → survey → industry** arc intact — it is your strongest credibility device and should show up explicitly in your opening line and your closing line.

---

## 0. The one-line pitch (memorize this)

> "KhaanaGo started as a real home baker's problem — order chaos and no tools — we validated it wasn't just her problem across 148 real users, and then an industry partner told us exactly what a production-grade version needs, including a gap even Odoo and SAP haven't closed in Pakistan. That's the idea we're building."

Use this as your opening sentence before Slide 1 even loads, and again as your closing sentence after Slide 3. Panels remember first and last lines most.

---

## Slide 1 — Title (30–40 sec)

**Say:**
"Good [morning/afternoon]. I'm presenting KhaanaGo — an AI-based multi-vendor food ordering platform with capacity-aware logistics and a native kitchen mini-ERP. This project didn't start as a classroom idea — it started with a real home baker who was struggling to manage her own orders, and it grew from there into something validated by real users and refined by an actual industry partner. We're Amna, Adeena, and Esha, supervised by Dr. Farah Haneef."

**Tip:** Don't read the slide. The slide is a backdrop — your job is to say the sentence above while it's on screen and move to Slide 2 quickly.

---

## Slide 2 — Problem + State of the Market (2.5–3 min)

This is your credibility slide. Walk it in the exact order it's designed: **origin → stats → industry validation → market gap.**

**Say (origin):**
"This began with Bakecharm, a working retail food business. She had no digital storefront, no way to manage stock or pricing, and every custom order — a birthday cake, a dietary swap — was negotiated manually over WhatsApp. That's not a hypothetical; that's a real operator telling us her actual daily workflow was broken."

**Say (stats — point at each card):**
"We didn't stop at one person's story. We ran three pilot surveys — 148 respondents total across customers, vendors, and riders. 78.9% of vendors confirmed peak-hour overbooking is a real, recurring problem. 84.2% are still tracking inventory manually — no ERP, no system, just memory or a notebook. And on the delivery side, 82.2% of riders and 76.9% of customers separately confirmed the same reliability and transparency problem from two different vantage points. When two independent groups validate the same gap without prompting each other, that's a strong signal."

**Say (industry validation — this is your strongest card, slow down here):**
"Then we took this to our industry partner, Kasib Tech. They didn't just approve the idea — they issued the functional and technical requirements we're building against, and their ERP consultant gave us a very specific, very concrete gap: ERP systems available in Pakistan — Odoo, SAP — already ship default e-commerce and food-ordering connectors. But actually wiring those up still needs paid developer setup and ongoing technical support. For a home baker or a small cloud kitchen, that's simply not affordable. That single insight is why KhaanaGo isn't just an ordering app — it's an ordering app with a mini-ERP built natively inside it, so there's zero integration burden on the vendor."

**Say (market gap, right column, close it out):**
"On the ordering side, Foodpanda, Careem, and the rest treat the kitchen as a black box — they optimize customer-to-vendor handoff, not what happens once the order lands in the kitchen. Foodpanda alone charges 25–35% commission and offers no inventory or accounting tools at all. So the gap we found is really two gaps that nobody has combined: capacity-aware ordering, and a mini-ERP with zero integration cost. That's the white space KhaanaGo sits in."

---

## Slide 3 — Solution + Features + Tech (2.5–3 min)

**Say (framing):**
"So KhaanaGo does two things at once. For customers and riders, it's capacity-aware — you can't book a delivery slot a kitchen can't actually deliver on, and riders are dispatched when food is actually ready, not just by proximity. For vendors, it's a mini-ERP that's natively wired into the ordering flow — not bolted on."

**Say (walk columns briefly, spend most time on column 2):**
"Consumer app: real delivery slots, structured customization, automatic nutrition badges calculated without exposing the vendor's private recipe, transparent billing, and a conversational assistant.

The vendor portal is where the industry-partner insight lives: kitchen capacity setup, a Bill of Materials for inventory, rule-based MRP that forecasts raw-material needs from sales trends, automatic sales invoicing and payments, and a marketing/offers module — and critically, every single order automatically flows into stock, invoices, and financial records with zero connector setup. That's the direct answer to the ERP-integration gap Kasib Tech flagged.

Rider app: pickup-ready dispatch, delivery pooling, configurable per-kilometre tariffs, and voice-assisted safety check-ins.

Platform admin: vendor governance, weather-aware capacity buffering, a preparation-time engine, and a full audit log."

**Say (tech stack, quick — 20 sec, don't over-explain):**
"On the technology side: React and Flutter for frontend and mobile so one codebase covers Android and iOS, Node.js and Express for the backend, PostgreSQL for relational integrity with Redis for fast-changing data like live slot availability, and Socket.IO for real-time updates like kitchen order boards. This is a deliberately lean, well-supported stack that a three-person team can realistically ship in a 26-week FYP timeline."

**Close (tie back to the arc):**
"So to summarize: the idea came from a real baker's problem, it was validated across 148 independent respondents, and it was sharpened by an actual industry partner into a specific, buildable gap that nobody in the Pakistani market has closed. We believe that makes KhaanaGo a project worth building — and we're ready to take your questions."

---

## Delivery Tips

- **Don't read bullet points aloud verbatim** — the slide shows the fact, your voice should add the *why it matters*. Practice saying each section from memory, glancing at the slide only as a cue.
- **Slow down on the three stat cards and the industry-partner line.** These are your evidence; everything else is context. A panel focused on validation will remember these two moments most.
- **Have one person per section if presenting as a group** — e.g., one teammate does Slide 2 (problem/validation), another does Slide 3 (solution/tech). This visibly reflects the "no single bottleneck" division of labor you describe in your WBS, and gives the panel confidence the whole team understands the project, not just one person.
- **Anticipate the ERP question before it's asked** — say the phrase "zero integration effort" or "no connector required" at least twice across the pitch. It's your most differentiated, industry-anchored claim, and repetition makes it stick.
- **Keep a printed or on-phone version of the stat cheat-sheet below** in case a slide doesn't render well on the projector.

---

## Quick Stat Cheat-Sheet (memorize the numbers, not just the slide)

| Stat | What it means |
|---|---|
| N = 148 (65 customers, 38 vendors, 45 riders) | Total pilot survey respondents, 3 independent surveys |
| 78.9% | Vendors reporting peak-hour overbooking / kitchen delays |
| 84.2% | Vendors still tracking inventory manually (no ERP) |
| 82.2% | Riders reporting unreliable delivery / dispatch-before-ready |
| 76.9% | Customers reporting unreliable delivery / lack of transparency |
| 25–35% | Foodpanda's vendor commission range (cited from Trustpilot review data, ref [1]) |
| 8–12% | KhaanaGo's proposed vendor commission (below incumbents) |
| 26 weeks | Full project timeline (~6 months) |

---

## Anticipated Cross-Questions & Suggested Answers

### From the HOD / Academic Panel — feasibility, scope, rigor

**Q: "This looks like a lot for three people in 26 weeks — how is this scoped realistically for an FYP?"**
> "We deliberately front-loaded the riskiest, most unfamiliar subsystems — the capacity/slot-throttling engine, the BOM/MRP logic, and the AI assistant — into the ERP-and-AI phase, which gets the largest time allocation precisely because it's new territory for us. Everything else — auth, APIs, data modeling — is built first as a stable foundation those subsystems depend on. We've also explicitly scoped out items like demand-forecasting ML, multi-currency support, POS integration, and two-way ERP sync as out-of-scope/future work, specifically to keep the FYP deliverable achievable."

**Q: "What exactly is novel here versus just cloning Foodpanda with extra features?"**
> "Two things aren't offered by any competitor we reviewed, Pakistani or international-in-Pakistan: first, ordering that's constrained by a kitchen's actual real-time capacity rather than accepting orders infinitely; second, a mini-ERP that requires zero technical integration — every other option, including enterprise ERPs like Odoo, still needs a developer to wire up the connector. That second point specifically came from an ERP consultant, not from us guessing."

**Q: "How will you validate this beyond a survey — do you have real usage data?"**
> "The pilot surveys are attitudinal/validation data, not usage data — we're honest about that distinction. The plan is to pilot the finished system with Bakecharm and Kasib Tech's network of vendors during the testing/deployment phase, which gives us a small but real operational test rather than only self-reported intent."

**Q: "Why did you choose this particular tech stack — could you defend it under scrutiny?"**
> "Every choice optimizes for a 3-person team shipping in 6 months on zero budget: PostgreSQL over a NoSQL option because our data — orders, recipes, inventory, ledgers — is inherently relational and needs referential integrity; Redis only for ephemeral fast-changing data like slot availability, not as a primary store; Flutter for one codebase across Android/iOS instead of maintaining two native apps; Socket.IO specifically for the few things that must be real-time, like the kitchen order board, while everything else stays plain REST for simplicity."

### From Industry Experts — market, business model, defensibility

**Q: "Foodpanda and Careem have massive scale advantages. Why would a vendor switch to you?"**
> "We're not positioning against Foodpanda for the same vendor segment — we're targeting the vendors Foodpanda structurally excludes or underserves: home bakers, small cloud kitchens, and custom-order businesses who can't absorb a 25–35% commission and get zero operational tooling in return. Our commission is 8–12%, and we hand them inventory, invoicing, marketing, and finance tools for free as part of the same platform — that's the wedge."

**Q: "This ERP gap you mention — Odoo already has food-delivery connectors. Isn't this a solved problem?"**
> "The connector existing and the connector being usable by a small vendor are two different things. Our industry partner's own ERP consultant — someone actively selling and implementing these systems — told us directly that wiring a connector up still requires paid developer setup and ongoing support. That's the exact claim in our proposal, sourced from their operational experience, not assumed by us. A one- or two-person kitchen simply doesn't have a developer on staff."

**Q: "What's your revenue model, and is it realistic?"**
> "Tiered vendor commission at 8–12% per order — below incumbent aggregators — plus distance-tiered delivery fees, and a premium vendor subscription tier for advanced MRP, finance, and marketing reporting. Cost side is mainly cloud hosting, third-party API costs for maps/nutrition/AI, and payment-gateway fees — a lean cost structure that matches a bootstrapped early-stage product."

**Q: "How do you calculate nutrition information without vendors exposing their recipes?"**
> "Vendors enter ingredient quantities privately into the system — that data never leaves the vendor's account or gets shown to competitors or customers. The platform runs that private recipe data through a nutrition calculation step and only exposes the resulting nutrition badge — calories, macros, allergens — publicly. The formula itself stays private to the vendor."

**Q: "What happens if a kitchen's actual capacity doesn't match what they set in the system?"**
> "Capacity is vendor-defined and adjustable — vendors set how many orders per hour they can realistically handle, and can update it any time, including reactively during a bad day. It's a soft operational control, not a hard guarantee — the system is enforcing discipline on order intake based on the vendor's own stated limits, not predicting the future."

### General / Tricky Questions

**Q: "Isn't 'AI-based' in your title a stretch — where's the actual AI?"**
> "It's intentionally scoped narrowly: a conversational assistant for natural-language search, order-status queries, and voice-driven ordering/check-ins — not predictive ML. We explicitly excluded demand forecasting and recommendation engines from this version because that needs a live dataset we won't have until after launch. We'd rather be honest about scope than overclaim 'AI' broadly."

**Q: "What's your biggest technical risk?"**
> "The capacity/slot-throttling engine and the MRP forecasting logic — both are genuinely new problem domains for our team, which is exactly why they're allocated the most time in our schedule and sequenced after the foundational backend is stable, so we're not debugging authentication and a novel algorithm at the same time."

**Q: "If Kasib Tech is sponsoring this, what do they get out of it?"**
> "KhaanaGo is being built as a working, field-tested reference system against the requirements they issued — it gives them a real implementation of the capacity-aware ordering and mini-ERP concept they specified, which they can evaluate, and potentially build on, rather than a specification sitting on paper."

---

## If You Only Remember Three Things

1. **Lead and close with the arc**: baker → 148-respondent validation → industry partner refinement. Say it explicitly, don't make the panel infer it.
2. **The ERP gap is your most defensible, most specific claim** — it came from an active ERP consultant, not from your own assumption. Repeat "zero integration effort" more than once.
3. **Be honest about scope** — you've already cut ML forecasting, multi-currency, POS integration, and ERP two-way sync from this version. Saying so proactively reads as maturity, not weakness.
