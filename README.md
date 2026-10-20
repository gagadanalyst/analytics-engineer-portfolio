# Astro Analytics Engineer Portfolio

A small learning-oriented Astro site for an Analytics Engineer portfolio. The homepage stays minimal, uses **“Review the evidence”** as its primary action, and puts Toronto Housing Bottleneck Analytics first. Full blog articles have their own reading-focused pages.

## Current milestone

**Lesson 8: GitHub Pages deployment setup.** The site has typed project and blog collections, reusable routes, content-managed thumbnails, responsive refinements, keyboard focus styles, a custom not-found page, the three-colour Lavender Fog / Graphite / Sea Glass palette, a persistent light/dark theme toggle, and separate CI/CD workflows. The production build and browser viewport check still must pass in a supported Node.js environment before deployment.

Read the lessons in order:

1. [`docs/LESSON_01_ASTRO_FOUNDATION.md`](docs/LESSON_01_ASTRO_FOUNDATION.md) — the project structure and Astro component mental model.
2. [`docs/LESSON_02_CONTENT_COLLECTIONS.md`](docs/LESSON_02_CONTENT_COLLECTIONS.md) — project metadata, Markdown entries and dynamic routes.
3. [`docs/LESSON_03_BLOG_COLLECTION.md`](docs/LESSON_03_BLOG_COLLECTION.md) — blog metadata, article layouts, route generation and legacy content migration.
4. [`docs/LESSON_04_IMAGES_AND_THUMBNAILS.md`](docs/LESSON_04_IMAGES_AND_THUMBNAILS.md) — image assets, the content `image()` helper, and reusable thumbnail component.
5. [`docs/LESSON_05_STATIC_READINESS_REVIEW.md`](docs/LESSON_05_STATIC_READINESS_REVIEW.md) — route/base-path review, responsive refinements, and what still needs a real build.
6. [`docs/LESSON_06_CUSTOM_404.md`](docs/LESSON_06_CUSTOM_404.md) — the Astro 404 route, shared layouts, and GitHub Pages behavior.
7. [`docs/LESSON_07_BUILD_CI.md`](docs/LESSON_07_BUILD_CI.md) — build-validation CI and Node version consistency.
8. [`docs/LESSON_08_GITHUB_PAGES_DEPLOYMENT.md`](docs/LESSON_08_GITHUB_PAGES_DEPLOYMENT.md) — Pages deployment setup and release checks.

## Requirements

- Node.js `22.22.0` or newer (see `.nvmrc`)
- npm
- Git and Python 3 for the one-time legacy blog import

## Start locally

```bash
npm install
npm run import:legacy
npm run dev
```

`npm run import:legacy` makes a read-only sparse clone of the old public portfolio repository and copies the four original Markdown articles plus their images into this project. It normalizes the old base-path references and splits the comma-separated topic tags into individual items. It does **not** modify the old repository. If you deliberately want to overwrite imported articles later, use `npm run import:legacy -- --force`.

The migration command needs internet access to GitHub. If your environment is offline, the article layout can still be reviewed, but the four article pages won't be populated until the importer runs successfully.

## Useful commands

```bash
npm run dev
npm run build
npm run preview
npm run import:legacy -- --force
```

- `dev` starts the local development server.
- `build` generates the production site in `dist/`.
- `preview` serves the last generated build locally.
- `import:legacy` imports the existing articles and their assets; it skips article files already present unless `--force` is supplied.

## Content workflow

### Add a project

1. Create a Markdown file in `src/content/projects/`.
2. Copy frontmatter from an existing entry and update the fields.
3. Write the case study under the closing `---` marker.
4. Set `showOnHome: true` only if it should appear in the supporting-work list.
5. Astro generates the detail page and archive entry through the shared templates.

### Add a blog post

1. Create a Markdown file in `src/content/blog/`, for example `my-article.md`.
2. Add the required blog frontmatter: `title`, `publishDate`, and `description`. `tags`, `language`, `draft`, `updatedDate`, and `heroImage` are optional or have defaults.
3. Put article illustrations under `public/blog/my-article/`. Since article URLs end in `/`, a body image can use `./image-name.png` for files directly in that folder, or `./images/figure.png` for files in an `images/` subfolder.
4. Keep the prose in Markdown. Astro renders it inside the reader-focused article layout.

## Design principles

- Three core colours: Lavender Fog `#E3E0ED`, Graphite `#282B37`, and Sea Glass `#82B5AA`. Dark mode uses a tinted charcoal background and light text while retaining Sea Glass as the accent. The theme choice persists in the browser.
- Cards reuse the page background rather than adding a fourth surface colour.

- Personal portfolio, not a corporate service site.
- Sparse homepage; concrete work does the proving.
- One flagship project, with thumbnails/links rather than embedded applications. The dashboard and dbt resource preview graphics are explicitly illustrative placeholders until real screenshots are captured.
- Reader-focused article pages, without sidebars or distracting cards.
- No database, CMS, backend, or client-side framework is needed for the current scope.

## Publishing and validation

The GitHub Pages base path is derived from the repository name when running in GitHub Actions; page links use `import.meta.env.BASE_URL` to avoid hardcoded repository paths. `.github/workflows/validate.yml` validates builds and `.github/workflows/deploy.yml` publishes `dist/` from `main`. Follow the deployment runbook before the first push.

Before publishing, run `npm install` once in a supported Node.js environment and commit the generated `package-lock.json`; both GitHub Actions workflows use `npm ci` afterward. Then run `npm run import:legacy`, `npm run build`, and `npm run preview`. Check the homepage, custom 404 page, four migrated articles and images, project pages, internal links, and light/dark toggle. Verify the header and project/archive layouts at 320, 375, 768, and 1280 px, and test the repository-site base path rather than only the local root path. The authoring environment used for this source bundle has no package-registry access and only Node.js 22.16.0, below the required 22.22.0, so the production build has **not** been verified here.

The later GitHub repository clean sweep is a separate task. No original project or portfolio repository has been changed by this source package.
