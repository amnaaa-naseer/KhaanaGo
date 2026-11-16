from docx import Document
import re,json,csv
from pathlib import Path
root=Path(__file__).parent
D=Document('/mnt/data/khaanago_sources/KhaanaGo Screen Inventory.docx')
sections={
 1:('Shared','Shared utilities'),
 2:('Customer','Account and profile'),3:('Customer','Discovery and customization'),4:('Customer','Cart and checkout'),5:('Customer','Tracking, history and feedback'),6:('Customer','Assistant and web'),
 7:('Rider','Sign-in and registration'),8:('Rider','Home and offers'),9:('Rider','Active delivery'),10:('Rider','Earnings and history'),11:('Rider','Profile and settings'),
 12:('Vendor','Application, sign-in and access'),13:('Vendor','Staff and business setup'),14:('Vendor','Menu'),15:('Vendor','Capacity'),16:('Vendor','Kitchen and orders'),17:('Vendor','Recipes and nutrition'),18:('Vendor','Inventory and planning'),19:('Vendor','Invoices, payments and finance'),20:('Vendor','Marketing'),21:('Vendor','Feedback, assistant and audit'),
 22:('Admin','Access, verification and fleets'),23:('Admin','Rules'),24:('Admin','Users, complaints and ratings'),25:('Admin','Monitoring, safety and audit')
}
screens=[]
for n,table in enumerate(D.tables[1:26],1):
 role,sect=sections[n]
 for row in table.rows[1:]:
  c=[x.text.strip().replace('\n',' ') for x in row.cells]
  if len(c)<5 or not re.match(r'^E\d+-US\d+-UI\d+$',c[0]):continue
  screens.append(dict(id=c[0],title=c[1],kind=c[2],requirements=c[3],priority=c[4],role=role,section=sect,story='-'.join(c[0].split('-')[:2]),epic=c[0].split('-')[0]))
assert len(screens)==189,len(screens)
assert len({x['id'] for x in screens})==189
chapter=Document('/mnt/data/khaanago_sources/KhaanaGo_Chapter2_MIS_Template_Aligned(1).docx')
epics=[];stories=[]
for p in chapter.paragraphs:
 s=p.text.strip()
 if p.style.name=='Heading 3':
  m=re.match(r'^2\.1\.\d+\. (E\d+): (.+)',s)
  if m:epics.append(dict(id=m[1],title=m[2]))
  m2=re.match(r'^2\.2\.\d+\. (E\d+-US\d+): (.+)',s)
  if m2:stories.append(dict(id=m2[1],title=m2[2]))
(root/'data'/'screens.json').write_text(json.dumps(screens,indent=2,ensure_ascii=False))
(root/'data'/'epics.json').write_text(json.dumps(epics,indent=2))
(root/'data'/'stories.json').write_text(json.dumps(stories,indent=2))
(root/'scripts'/'manifest.js').write_text('window.KHAANAGO_SCREENS = '+json.dumps(screens,ensure_ascii=False)+';\nwindow.KHAANAGO_EPICS = '+json.dumps(epics,ensure_ascii=False)+';\nwindow.KHAANAGO_STORIES = '+json.dumps(stories,ensure_ascii=False)+';\n')
with open(root/'docs'/'UI_Traceability.csv','w',newline='',encoding='utf-8-sig') as f:
 w=csv.DictWriter(f,fieldnames=['id','role','section','title','kind','priority','story','epic','requirements'])
 w.writeheader();w.writerows(screens)
from collections import Counter
print(len(screens),Counter(s['role'] for s in screens), Counter(s['kind'] for s in screens),Counter(s['priority'] for s in screens), 'stories',len(stories))
