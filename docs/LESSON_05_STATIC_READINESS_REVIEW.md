# Lesson 5 — Static readiness and responsive review

## What changed

- Added one consistent, visible `:focus-visible` outline for keyboard navigation.
- Added a narrow-screen header rule for viewports up to 380 px so the site name and navigation have more room.
- Reviewed internal links, project IDs, thumbnail references, and the GitHub Pages base-path strategy.
- Updated the README so it distinguishes static checks from a verified production build.

## The mental model

### 1. Why internal links use `BASE_URL`

A user site such as `https://gagadanalyst.github.io/` is served from the domain root. A repository site such as `https://gagadanalyst.github.io/example/` is served beneath a path. Astro exposes the configured base as `import.meta.env.BASE_URL`. The page templates prepend it to internal routes so the same source can work locally and under a GitHub Pages repository path.

The Astro configuration derives the repository path from the standard `GITHUB_REPOSITORY` and `GITHUB_ACTIONS` environment variables in GitHub Actions. `SITE_BASE` remains an explicit override for unusual deployments or testing.

### 2. Content IDs become route slugs

The Markdown files in `src/content/projects/` are the source of project metadata and case-study copy. The project dynamic route uses each collection entry's `id` as the `slug`. The archive, homepage, and detail pages build their internal links from that ID rather than maintaining separate hard-coded paths. The same pattern is used for blog articles.

### 3. Responsive behavior and keyboard focus

Most layouts use CSS grid/flexbox and switch to a single column at defined breakpoints. The narrowest header rule hides the secondary location line and tightens navigation spacing only on very small screens. It does not affect wider layouts.

The `:focus-visible` rule makes keyboard focus easier to see across navigation and content links. It complements—not replaces—semantic elements and the skip-to-content link already in `BaseLayout.astro`.

## Checks performed in this workspace

- Parsed all four project frontmatter blocks and checked every configured thumbnail path and required alt description.
- Confirmed all four project IDs map to the dynamic project route pattern.
- Confirmed no legacy `/analytics-engineer/` base paths remain in Astro, TypeScript, or CSS source.
- Reviewed all internal links to confirm that local route links are based on `import.meta.env.BASE_URL` and collection IDs.
- Checked the source ZIP for archive integrity.

## What is not verified yet

This is a **static review**, not a successful Astro build or visual browser test. The workspace does not contain installed project dependencies, and its Node.js version is `22.16.0`, below the project's declared `22.22.0` minimum. Network/DNS access for the package registry is unavailable here, so `npm install` and the real build cannot be completed in this workspace. No claim is made that generated pages have been browser-tested.

## First local validation run

From the project directory, using Node.js `22.22.0` or newer:

```bash
npm install
npm run import:legacy
npm run build
npm run preview
```

Then check these widths in a browser: **320, 375, 768, and 1280 px**. Inspect the homepage, project archive, all four project detail pages, the writing archive, and each imported article. Verify that local links work both at the root during development and beneath the repository base path in the production build. Check that body images, code blocks, and tables do not cause page-wide horizontal overflow.

The four legacy blog articles are not included in the source package yet; the importer retrieves their Markdown and image assets from the old public repository when run from a network-connected machine.
