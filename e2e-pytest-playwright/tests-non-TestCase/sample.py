from playwright.sync_api import Page, expect

def test_initial_load(page: Page):
    page.goto("https://lite.datasette.io/")
    loading = page.locator("#loading-indicator")
    expect(loading).to_have_css("display", "block")
    # Give it up to 60s to finish loading
    expect(loading).to_have_css("display", "none", timeout=60 * 1000)

    # Should load faster the second time thanks to cache
    page.goto("https://lite.datasette.io/")
    expect(loading).to_have_css("display", "none", timeout=20 * 1000)
