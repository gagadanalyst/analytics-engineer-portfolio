# Lesson 8 — GitHub Pages deployment

## Current deployment path

The site is a static Astro build. The `Deploy Astro site to GitHub Pages` workflow builds `dist/` and publishes it when a commit reaches `main`, or when the workflow is manually dispatched. It does not touch the existing project repositories.

## Before the first push

1. Use Node.js `22.22.0` or newer, matching `.nvmrc` and `package.json`.
2. Run `npm install` once to generate `package-lock.json`; commit the lockfile. Subsequent CI runs use `npm ci`.
3. Run `npm run import:legacy` to migrate the four existing Markdown posts and associated image assets from the original public portfolio repository. Review the result and image paths.
4. Replace illustrative Toronto dashboard/dbt preview graphics with authentic screenshots before treating those evidence links as final.
5. Run `npm run build`, then `npm run preview` and check home, project pages, the blog archive and articles, 404 handling, light/dark toggle, and responsive layouts.

## Create the publishing repository

Create a new repository under `gagadanalyst` for the new portfolio. If the repository is named `gagadanalyst.github.io`, the site deploys at the account root. A repository with any other name deploys under `/<repository-name>/`; `astro.config.mjs` derives this base path automatically in GitHub Actions. Keep the existing `analytics-engnieer` repository and other project repositories unchanged.

Copy the project files into the new repository, commit the lockfile and source, and push to `main`. In the new repository, open **Settings → Pages** and select **GitHub Actions** as the build/deployment source if it is not already selected. The workflow will build and deploy. Check the workflow run and then verify the published URL in a private browser window at desktop and mobile widths.

## Current evidence limitations

The build environment used to prepare this bundle had no package-registry access and could not run the production build. Do not report a passing local build until `npm run build` completes successfully in the supported Node environment and the remote workflow passes. The four blog posts are imported locally by the provided read-only script; they are not committed in the starter bundle. The two flagship evidence preview images are illustrative placeholders until replaced with real screenshots.
