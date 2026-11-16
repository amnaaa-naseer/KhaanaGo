"""Optional smoke tests. Requires Playwright + local Chromium. Run: python tests/test_ui_flow.py"""
from pathlib import Path
from playwright.sync_api import sync_playwright
ROOT=Path(__file__).resolve().parents[1]
html=(ROOT/'KhaanaGo_GUI_Standalone.html').read_text()
with sync_playwright() as p:
    browser=p.chromium.launch(headless=True)
    page=browser.new_page(viewport={"width":1440,"height":900})
    errors=[]
    page.on('pageerror',lambda e: errors.append(str(e)))
    page.set_content(html,wait_until='domcontentloaded')
    assert page.evaluate('KhaanaGoPrototype.stats().total')==189
    for design_id in page.evaluate('KHAANAGO_SCREENS.map(s=>s.id)'):
        page.evaluate('(design_id)=>KhaanaGoPrototype.navigate(design_id)',design_id)
    page.evaluate('KhaanaGoPrototype.switchRole("Customer")')
    page.locator('[data-action="menu"]').first.click()
    page.locator('[data-item="1"]').first.click()
    page.locator('[data-action="add-item"]').first.click()
    for action in ('delivery','slot','payment','review','place-order','track'):
        page.locator(f'[data-action="{action}"]').first.click()
    assert page.evaluate('KhaanaGoPrototype.getCurrent().screen')=='E17-US1-UI1'
    page.evaluate('KhaanaGoPrototype.switchRole("Rider")')
    for action in ('toggle-online','offer','accept-offer','rider-store','rider-handover','confirm-pickup','delivery-code'):
        page.locator(f'[data-action="{action}"]').first.click()
    page.locator('[data-field="code"]').fill('1234')
    page.locator('[data-action="verify-code"]').first.click()
    assert page.evaluate('KhaanaGoPrototype.getCurrent().screen')=='E13-US3-UI4'
    assert not errors, errors
    print('PASS: All 189 routes render, customer checkout, rider delivery')
    browser.close()
