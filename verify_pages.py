from playwright.sync_api import sync_playwright

def run(playwright):
    browser = playwright.chromium.launch()
    page = browser.new_page()

    pages_to_verify = [
        "about-us.html",
        "achievements.html",
        "blog.html",
        "contact-us.html",
        "contribute.html",
        "policies.html",
        "post-details.html",
        "school-listing.html",
        "school-registration.html",
        "school_page.html",
        "student-registration.html",
        "teacher-registration.html",
    ]

    for page_path in pages_to_verify:
        url = f"http://localhost:8000/pages/{page_path}"
        page.goto(url)
        screenshot_path = f"/home/jules/verification/{page_path.replace('.html', '.png')}"
        page.screenshot(path=screenshot_path)
        print(f"Captured screenshot for {page_path}")

    browser.close()

with sync_playwright() as playwright:
    run(playwright)
