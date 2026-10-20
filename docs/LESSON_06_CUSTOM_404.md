# Lesson 6 — A useful 404 page

## What changed

- Added `src/pages/404.astro`, which Astro emits as the static site's `404.html` page.
- Used the shared `BaseLayout` so the missing-page experience inherits the same site identity, navigation, typography, skip link, and footer as the rest of the portfolio.
- Added direct links to the homepage, project archive, and technical-writing archive.
- Used `import.meta.env.BASE_URL` for internal links so they work on both a root site and a GitHub Pages repository site.
- Kept the page simple and responsive, with no JavaScript or extra dependencies.

## The Astro concept

Astro turns files inside `src/pages/` into routes. The file name `404.astro` is a special convention for the not-found page on static hosting. GitHub Pages can serve the generated `404.html` when a visitor requests a path that does not exist.

The page reuses `BaseLayout.astro` rather than duplicating the outer document structure. That is composition: a page supplies its own content while a shared layout owns the HTML shell and common navigation.

## Why base-aware links matter

A project site may be deployed below a repository path such as `/my-portfolio/`, while a user site lives at `/`. Prefixing internal links with `import.meta.env.BASE_URL` lets the same page work in either location without hand-editing routes for a particular repository name.

## How to verify it

After installing dependencies and building the site:

1. Confirm `dist/404.html` exists.
2. Run `npm run preview` and manually open a non-existent path.
3. Confirm the page offers working routes to the homepage, project archive, and writing archive.
4. Repeat against a repository-base build before publishing to GitHub Pages.
5. Check the layout at 320 px and 1280 px and tab through the links using the keyboard.

The page was checked statically in this workspace; a generated `404.html` and browser behavior have **not** been verified because the Astro dependencies are not installed here.
