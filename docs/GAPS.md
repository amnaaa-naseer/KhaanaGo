# Gaps

- Chapter 2 Section 2.4 is empty. The design system mentions a Section 2.4.2 that does not exist.
- `docs/reference/` was not in the repository. The audit used `docs/KhaanaGo_Chapter2_Deduplicated_Complete_Coverage.docx` through the existing extract, `docs/KhaanaGo_Screen_Register.xlsx` through the CSV, `docs/KhaanaGo_Design_System_v2.html`, and `KhaanaGo_Complete_GUI_Prototype/KhaanaGo_GUI`.
- Chapter 1 and the updated project-details document are not in the repository.
- The older HTML prototype mentions 84 stories. Chapter 2 has 82. Screen IDs come from the register, not from that older count.
- A screenshot cannot pass hashing, atomic slot booking, gateway callbacks, push delivery, or audit immutability. Those 393 tests stay open. `docs/implementation/REQUIREMENTS_COVERAGE.md` lists each one.
- Visual review of all 189 rendered screens is not done.
- The earlier Flutter apps `apps/customer`, `apps/rider`, and `apps/portal` were removed. Vendor and admin are the React apps.
