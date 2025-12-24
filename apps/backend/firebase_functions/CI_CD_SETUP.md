# CI/CD Setup for Firebase Functions

This document explains how to set up GitHub Actions CI/CD for Firebase Functions.

## Overview

The CI/CD pipeline is configured in `.github/workflows/firebase-functions-ci.yml` and includes:

1. **Change Detection**: Only runs when files in `apps/firebase_functions/**` change
2. **Testing**: Runs linting, builds, and tests on every push/PR
3. **Deployment**: Automatically deploys to Firebase on pushes to `main` branch

## Required GitHub Secrets

To enable deployment, you need to set up the following secret in your GitHub repository:

### FIREBASE_TOKEN

This token is used to authenticate with Firebase during deployment.

#### How to generate:

1. **Install Firebase CLI** (if not already installed):

   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase**:

   ```bash
   firebase login
   ```

3. **Generate a CI token**:

   ```bash
   firebase login:ci
   ```

4. **Copy the token** that's displayed

5. **Add to GitHub Secrets**:
   - Go to your GitHub repository
   - Navigate to: **Settings** → **Secrets and variables** → **Actions**
   - Click **New repository secret**
   - Name: `FIREBASE_TOKEN`
   - Value: Paste the token from step 4
   - Click **Add secret**

## Workflow Jobs

### 1. Changes Detection

- Detects if any files in `apps/firebase_functions/**` were modified
- Only runs subsequent jobs if changes are detected

### 2. Test Job

Runs on every push/PR when Firebase Functions code changes:

- ✅ Linting (`npm run lint`)
- ✅ Build (`npm run build`)
- ✅ Unit tests (`npm run test:unit`)
- ✅ Coverage report (`npm run test:coverage`)

### 3. Deploy Job

Runs only when:

- ✅ Changes detected in Firebase Functions
- ✅ Tests pass
- ✅ Push to `main` branch (not PRs)

Deploys functions to Firebase project: `productive-78c0e`

## Manual Deployment

If you need to deploy manually:

```bash
cd apps/firebase_functions
npm run deploy
```

Or using Firebase CLI directly:

```bash
cd apps/firebase_functions
firebase deploy --only functions --project productive-78c0e
```

## Testing the Workflow

1. Make a change to any file in `apps/firebase_functions/`
2. Commit and push to a branch
3. Open a Pull Request
4. Check the **Actions** tab in GitHub to see the workflow run
5. The test job should run automatically
6. After merging to `main`, the deploy job will run

## Troubleshooting

### Deployment fails with "Authentication error"

- Verify `FIREBASE_TOKEN` secret is set correctly
- Regenerate token using `firebase login:ci`
- Ensure the token hasn't expired (tokens can expire)

### Tests fail in CI but pass locally

- Check Node.js version (CI uses Node 20)
- Ensure all dependencies are in `package.json` (not just `package-lock.json`)
- Check for environment-specific issues

### Build fails

- Verify TypeScript compilation works locally: `npm run build`
- Check for type errors: `npx tsc --noEmit`

## Project Configuration

- **Project ID**: `productive-78c0e`
- **Region**: `us-central1`
- **Node Version**: 20 (as specified in `package.json`)

To change the project, update:

1. `.firebaserc` file
2. `.github/workflows/firebase-functions-ci.yml` (project_id in deploy step)
