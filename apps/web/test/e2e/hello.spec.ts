import { test, expect } from '@playwright/test';

test.describe('Hello E2E Tests', () => {
  test('should display hello world message', async ({ page }) => {
    await page.goto('/');
    
    const heading = page.getByRole('heading', { name: /hello, world!/i });
    await expect(heading).toBeVisible();
  });

  test('should have hello component visible', async ({ page }) => {
    await page.goto('/');
    
    const component = page.getByTestId('hello-component');
    await expect(component).toBeVisible();
  });
});

