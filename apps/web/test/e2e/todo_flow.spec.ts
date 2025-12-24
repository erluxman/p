import { expect, test } from "@playwright/test";

test.describe("Todo App E2E", () => {
  test.beforeEach(async ({ page }) => {
    await page.goto("/");
    await page.evaluate(() => localStorage.clear());
    await page.reload();
  });

  test("should create a new todo", async ({ page }) => {
    await page.click("button:has-text('Add Todo')");

    await page.getByRole("textbox", { name: /title/i }).fill("E2E Test Todo");
    await page
      .getByRole("textbox", { name: /description/i })
      .fill("E2E Test Description");
    await page.click('button:has-text("Create")');

    await expect(page.getByText("E2E Test Todo")).toBeVisible();
    await expect(page.getByText("E2E Test Description")).toBeVisible();
  });

  test("should toggle todo completion", async ({ page }) => {
    await page.click("button:has-text('Add Todo')");
    await page
      .getByRole("textbox", { name: /title/i })
      .fill("Toggle Test Todo");
    await page.click('button:has-text("Create")');

    const checkbox = page.locator('input[type="checkbox"]').first();
    await checkbox.click();

    await expect(checkbox).toBeChecked();
  });

  test("should edit a todo", async ({ page }) => {
    await page.click("button:has-text('Add Todo')");
    await page.getByRole("textbox", { name: /title/i }).fill("Original Todo");
    await page.click('button:has-text("Create")');

    await page.waitForSelector("text=Original Todo");
    const editButtons = page
      .locator('button[aria-label*="edit"], button:has(svg)')
      .first();
    await editButtons.click();

    await page.waitForSelector('button:has-text("Update")');
    const titleInput = page.getByRole("textbox", { name: /title/i });
    await titleInput.clear();
    await titleInput.fill("Updated Todo");
    await page.click('button:has-text("Update")');

    await expect(page.getByText("Updated Todo")).toBeVisible();
    await expect(page.getByText("Original Todo")).not.toBeVisible();
  });

  test("should delete a todo", async ({ page }) => {
    await page.click("button:has-text('Add Todo')");
    await page.getByRole("textbox", { name: /title/i }).fill("Todo to Delete");
    await page.click('button:has-text("Create")');

    await expect(page.getByText("Todo to Delete")).toBeVisible();

    const deleteButtons = page.locator("button:has(svg)").nth(1);
    await deleteButtons.click();

    await page.waitForSelector('button:has-text("Delete")');
    await page.click('button:has-text("Delete")');

    await expect(page.getByText("Todo to Delete")).not.toBeVisible();
  });

  test("should validate required fields", async ({ page }) => {
    await page.click("button:has-text('Add Todo')");

    const createButton = page.locator('button:has-text("Create")');
    await expect(createButton).toBeDisabled();

    await page.getByRole("textbox", { name: /title/i }).fill("Valid Todo");
    await expect(createButton).toBeEnabled();
  });
});
