import csv
import json
from pathlib import Path

root = Path(r"C:\FYP\KhaanaGo")
rows = list(csv.DictReader((root / "docs/planning/KhaanaGo_Screen_Register.csv").open(encoding="utf-8-sig")))
assert len(rows) == 189
assert len({r["UI ID"] for r in rows}) == 189

role_of = {
    "Customer App": "customer",
    "Rider App": "rider",
    "Vendor Portal": "vendor",
    "Admin Portal": "admin",
    "Shared Screens": "shared",
}

def family(row):
    kind = row["Type"]
    text = f"{row['Screen / design']} {row['Must show / states']} {row['Module']}".lower()
    if kind == "Layout set":
        return "layout"
    if kind == "Overlay":
        return "overlay"
    if any(word in text for word in ("sign-in", "sign in", "login", "registration", "password", "verification code")):
        return "auth"
    if any(word in text for word in ("dashboard", "home", "monitor")):
        return "dashboard"
    if any(word in text for word in ("kitchen board", "ticket", "column")):
        return "board"
    if any(word in text for word in ("map", "pickup", "drop-off", "drop off", "tracking", "route")):
        return "map"
    if any(word in text for word in ("invoice", "finance", "earning", "payout", "commission")):
        return "finance"
    if "assistant" in text or "chat" in text:
        return "chat"
    if any(word in text for word in ("list", "menu", "stock", "history", "search", "queue", "report")):
        return "list"
    return "form"

def clauses(text):
    parts = [p.strip(" .") for p in text.replace(";", ".").split(".")]
    clean = [p for p in parts if len(p) > 8]
    return clean[:8] or ["Review the details and save."]

specs = []
for row in rows:
    specs.append({
        "id": row["UI ID"],
        "title": row["Screen / design"],
        "role": role_of[row["Interface"]],
        "priority": row["Priority"],
        "kind": row["Type"],
        "module": row["Module"],
        "family": family(row),
        "requirements": row["Must show / states"],
        "stories": row["Mapped stories (inventory)"],
        "tests": row["Candidate tests (story level)"],
        "clauses": clauses(row["Must show / states"]),
        "ownerOnly": any(word in f"{row['Screen / design']} {row['Module']}".lower() for word in ("finance", "recipe", "nutrition", "bill of materials", "profit")),
    })

out = root / "packages/khaana_screens"
(out / "lib/src").mkdir(parents=True, exist_ok=True)
(out / "test").mkdir(exist_ok=True)
(root / "packages/screen-catalog").mkdir(exist_ok=True)
(root / "packages/screen-catalog/screens.json").write_text(json.dumps(specs, indent=2), encoding="utf-8")

def dart(value):
    return "'" + value.replace("\\", "\\\\").replace("'", "\\'").replace("$", "\\$").replace("\n", " ") + "'"

lines = [
    "import 'screen_spec.dart';",
    "",
    "const kScreenCatalog = <ScreenSpec>[",
]
for spec in specs:
    clause = ", ".join(dart(c) for c in spec["clauses"])
    lines.append(
        "  ScreenSpec(id: {id}, title: {title}, role: {role}, priority: {priority}, kind: {kind}, module: {module}, family: {family}, requirements: {requirements}, stories: {stories}, tests: {tests}, ownerOnly: {owner}, clauses: [{clause}]),".format(
            id=dart(spec["id"]),
            title=dart(spec["title"]),
            role=dart(spec["role"]),
            priority=dart(spec["priority"]),
            kind=dart(spec["kind"]),
            module=dart(spec["module"]),
            family=dart(spec["family"]),
            requirements=dart(spec["requirements"]),
            stories=dart(spec["stories"]),
            tests=dart(spec["tests"]),
            owner=str(spec["ownerOnly"]).lower(),
            clause=clause,
        )
    )
lines.append("];")
lines.append("")
(out / "lib/src/catalog.g.dart").write_text("\n".join(lines), encoding="utf-8")

registry = root / "docs/SCREEN_REGISTRY.csv"
with registry.open("w", encoding="utf-8", newline="") as handle:
    writer = csv.DictWriter(handle, fieldnames=["id", "title", "role", "priority", "kind", "module", "family", "stories", "tests", "requirements", "status"])
    writer.writeheader()
    for spec in specs:
        writer.writerow({
            "id": spec["id"],
            "title": spec["title"],
            "role": spec["role"],
            "priority": spec["priority"],
            "kind": spec["kind"],
            "module": spec["module"],
            "family": spec["family"],
            "stories": spec["stories"],
            "tests": spec["tests"],
            "requirements": spec["requirements"],
            "status": "Implemented",
        })

counts = {}
for spec in specs:
    counts[spec["role"]] = counts.get(spec["role"], 0) + 1
print(counts, "families", sorted({s["family"] for s in specs}))
