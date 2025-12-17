import { defineConfig, devices } from "@playwright/test";

const PORT = process.env.PORT || 4000;
const baseURL = process.env.BASE_URL || `http://localhost:${PORT}`;
const useServer = !process.env.PLAYWRIGHT_SKIP_SERVER;

export default defineConfig({
  testDir: "./tests",
  timeout: 60000,
  retries: process.env.CI ? 1 : 0,
  reporter: [["list"]],
  use: {
    baseURL,
  },
  projects: [
    {
      name: "chromium-mobile",
      use: {
        ...devices["iPhone 12"],
        viewport: { width: 390, height: 844 },
      },
    },
  ],
  webServer: useServer
    ? {
        command: `bash -c "bundle exec jekyll build && ruby -run -e httpd _site -p ${PORT}"`,
        url: baseURL,
        reuseExistingServer: !process.env.CI,
        timeout: 120000,
        env: {
          JEKYLL_ENV: process.env.JEKYLL_ENV || "production",
        },
      }
    : undefined,
});
