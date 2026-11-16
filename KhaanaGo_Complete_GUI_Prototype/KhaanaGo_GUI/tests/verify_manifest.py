from pathlib import Path
import json
from collections import Counter
ROOT=Path(__file__).resolve().parents[1]
screens=json.loads((ROOT/'data/screens.json').read_text())
assert len(screens)==189
assert len({s['id'] for s in screens})==189
assert Counter(x['kind'] for x in screens)=={'Screen':139,'Overlay':47,'Layout set':3}
assert Counter(x['role'] for x in screens)=={'Shared':4,'Customer':48,'Rider':43,'Vendor':69,'Admin':25}
assert Counter(x['priority'] for x in screens)=={'P1':44,'P2':118,'P3':27}
assert len(json.loads((ROOT/'data/stories.json').read_text()))==84
assert len(json.loads((ROOT/'data/epics.json').read_text()))==22
assert all(s['story'].startswith('E') and s['requirements'] for s in screens)
print('PASS: 189 unique requirements-backed UI IDs / 84 stories / 22 epics')
