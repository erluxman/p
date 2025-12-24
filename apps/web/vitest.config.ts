import { defineConfig } from 'vitest/config';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  test: {
    environment: 'jsdom',
    setupFiles: ['./src/test/setup.ts'],
    globals: true,
    include: ['test/unit/**/*.test.tsx', 'test/unit/**/*.test.ts'],
    exclude: ['test/e2e/**', 'node_modules/**', 'dist/**'],
  },
});

