import { expect, test } from "@playwright/test";

const NAV_SELECTOR = "#site-nav, .site-nav";

test.describe("mobile navigation drawer", () => {
  test("opens via toggle and closes via backdrop", async ({ page }) => {
    await page.goto("/");

    const nav = page.locator(NAV_SELECTOR).first();
    const toggle = page.locator(".nav-toggle");

    await expect(toggle).toBeVisible();
    await expect(nav).not.toHaveClass(/is-open/);

    await toggle.click();

    await expect(nav).toHaveClass(/is-open/);

    const backdrop = page.locator(".nav-backdrop");
    await expect(backdrop).toBeAttached();
    await expect(backdrop).toHaveClass(/is-visible/);

    await backdrop.click();

    await expect(nav).not.toHaveClass(/is-open/);
    await expect(backdrop).not.toHaveClass(/is-visible/);
  });
});
