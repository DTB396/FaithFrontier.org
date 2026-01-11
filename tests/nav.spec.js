import { expect, test } from "@playwright/test";

const NAV_SELECTOR = "#premium-nav-mobile";

test.describe("mobile navigation drawer", () => {
  test("opens via toggle and closes via backdrop", async ({ page }) => {
    await page.setViewportSize({ width: 375, height: 667 });
    await page.goto("/");

    // Wait for nav toggle to be attached before asserting visibility
    await page.waitForSelector('.premium-nav-toggle', { state: 'attached', timeout: 7000 });

    const nav = page.locator(NAV_SELECTOR);
    const toggle = page.locator(".premium-nav-toggle");

    await expect(toggle).toBeVisible();
    await expect(nav).not.toHaveClass(/is-open/);

    await toggle.click();

    await expect(nav).toHaveClass(/is-open/);

    const backdrop = page.locator(".premium-nav-overlay");
    await expect(backdrop).toBeAttached();
    await expect(backdrop).toHaveClass(/is-visible/);

    // Click backdrop to close (use coordinates to click on visible overlay area)
    await page.mouse.click(50, 400);

    await expect(nav).not.toHaveClass(/is-open/);
    await expect(backdrop).not.toHaveClass(/is-visible/);
  });
});
