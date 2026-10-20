# Lesson 3 — Blog collections and reader-focused layouts

## What we added

- A `blog` collection in `src/content.config.ts`, separate from the project collection.
- `src/pages/blog/index.astro`, which builds an article archive from blog metadata.
- `src/pages/blog/[slug].astro`, which uses `getStaticPaths()` to generate a page for each published article.
- `src/layouts/ArticleLayout.astro`, which provides a reading-first presentation and reuses `BaseLayout` for the site shell.
- A compact list of article links on the homepage. The homepage does not contain the full articles.
- `scripts/import-legacy-blog.sh`, a one-time importer for the existing four Markdown posts and image assets.

## The mental model

Projects and blog posts are both content, but they have different metadata and reading needs. That's why they have separate collections and templates rather than being forced into one generic page shape.

### 1. Two collections, two schemas

`src/content.config.ts` now exports both `projects` and `blog`. Each has its own schema.

- Project schema includes status, technologies, homepage selection and evidence URLs.
- Blog schema includes publication date, optional update date, article tags, a draft flag and an optional hero image.

The schema acts as a contract. For instance, `publishDate` is parsed as a date, `draft` must be boolean, and `tags` must be a list of strings. A bad entry should be caught during Astro content sync/build rather than producing inconsistent output.

### 2. Markdown files don't make routes by themselves

Content lives under `src/content/blog/`, outside `src/pages/`. Astro stores the entries in the content collection, but the route is defined by the matching file under `src/pages/blog/`.

The file `src/pages/blog/[slug].astro` has a dynamic segment: `[slug]`. Its `getStaticPaths()` function returns the article IDs that Astro should turn into real, statically generated URLs. An entry named `apache-iceberg.md` becomes `/blog/apache-iceberg/` (with the configured site base path added during a repository-site deployment).

### 3. `render(post)` turns Markdown into a component

The route retrieves a post from the collection, then calls `render(post)`. Astro returns a `Content` component representing the Markdown body. The page passes that component into `ArticleLayout`.

This is the key separation:

- Markdown owns the article's actual words and examples.
- Frontmatter owns title/date/description/tags.
- `ArticleLayout.astro` owns the article's visual reading experience.
- `BaseLayout.astro` owns shared site structure such as the header, HTML metadata and footer.

A change to the typography of blog posts can therefore be made in one layout without rewriting the article text.

### 4. How the reading layout stays distraction-free

The article layout uses a narrow column, generous line spacing, clear heading hierarchy, responsive images, horizontally scrollable tables/code blocks, and no sidebar. Long technical posts need readable line lengths more than decorative card treatments.

The hero image and body illustrations are ordinary public assets. The migrated content keeps references relative to the article URL, e.g. `./images/iceberg-arch.png`. Because an article route ends in `/`, that relative URL resolves under `/blog/<slug>/images/` even when the site is hosted under a GitHub Pages repository base path.

### 5. Migrating the old articles

Run `npm run import:legacy` after dependencies are installed. The script:

1. Clones the old public repository in a temporary directory using sparse checkout; it does not commit or modify anything in that repository.
2. Copies the four Markdown source files: Apache Iceberg, AWS Glue, AWS IAM, and S3 bucket types.
3. Copies each post's hero image and the supporting illustrations from the old `public/blog/` tree.
4. Rewrites the old `/analytics-engineer/` prefix to a route-relative image path and normalizes the old comma-separated tags into a proper YAML list.
5. Cleans up the temporary clone.

Existing target articles are skipped by default to protect later edits. Use `npm run import:legacy -- --force` only if you explicitly want to replace them with the versions from the old portfolio.

### 6. Add or edit articles later

To edit an article, edit its Markdown file in `src/content/blog/`. You should not need to touch its `.astro` route or layout just to change the prose.

To add a new article:

```text
src/content/blog/my-article.md
public/blog/my-article/hero.png
public/blog/my-article/images/figure.png
```

A minimal frontmatter block is:

```yaml
---
title: "My article title"
publishDate: "2026-10-20"
description: "A short description for search and article listings."
tags:
  - Analytics Engineering
  - SQL
draft: false
---

Write the article here in Markdown.
```

If you reference an illustration in the body, use a path relative to the article URL, such as `![A diagram](./images/figure.png)`.

## Validation note

The content configuration, route wiring, article layout, and migration script were checked statically. A full Astro build was not run because this authoring environment cannot reach the package registry and its installed Node.js version is below the project's declared minimum. The import command also needs network access to GitHub, so the source package contains the importer rather than claiming the four articles and their binary images were already copied locally.
