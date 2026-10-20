# Lesson 7 — Build validation with GitHub Actions

## What changed

- Added `.github/workflows/validate.yml` to install project dependencies and run the Astro production build on pushes, pull requests, and manual workflow dispatches.
- Configured the workflow to use the Node.js version declared in `.nvmrc`, avoiding a second hard-coded Node version in CI.
- Limited the workflow token to read-only repository contents.
- Kept deployment out of this workflow: it validates the build but does not publish a site or change GitHub Pages settings.

## The mental model: CI before CD

**Continuous integration (CI)** checks that the source can still build when changes are proposed or pushed. Here, the important signal is whether `npm run build` can generate the static site, including the project routes, blog routes, image processing, and custom 404 page.

**Continuous deployment (CD)** would publish the generated output to a hosting target. That is deliberately separate for now. The project still needs a successful local build, imported articles, replacement of illustrative dashboard/dbt preview images with genuine screenshots, and a final responsive review before automatic publishing should be enabled.

## Why use `.nvmrc` in CI

The local project declares Node.js `22.22.0` in `.nvmrc` and `package.json`. The workflow reads `.nvmrc`, so local and CI instructions have a single version source. If the project later upgrades Node, update `.nvmrc` and validate the new version rather than changing two independent values.

## Dependency lockfile follow-up

This source bundle currently has no `package-lock.json` because dependencies could not be installed in the authoring environment. The workflow therefore uses `npm install`, which can run without an existing lockfile. On the first network-connected local install, keep the generated `package-lock.json` with the project and change the workflow install command to `npm ci`. That makes CI use the recorded dependency tree instead of resolving it afresh.

Do not treat the workflow itself as proof of a passing build. It has not run yet because this project has not been pushed to a GitHub repository.

## How to verify later

1. From a supported Node.js environment, run `npm install`, keep `package-lock.json`, and run `npm run build` locally.
2. Change the workflow install command from `npm install --no-audit --no-fund` to `npm ci` once the lockfile exists.
3. Create the new repository only when ready, add this source, and push it.
4. Open the repository's Actions tab and inspect the `Validate Astro site` run. A successful CI run is the first remote evidence that the static build works; it is still not a substitute for browser checks.
