# Lesson 1 — The Astro foundation

## What we built

The first milestone started with a minimal, static Astro site and a shared HTML layout. The current source has added typed Markdown project content and reusable project routes in Lesson 2; it is still not the finished portfolio. Lesson 2 builds on this foundation by moving project information into Markdown, validating its metadata, and generating reusable project pages.

## The project structure

```text
astro-analytics-engineer-portfolio/
├── astro.config.mjs
├── package.json
├── tsconfig.json
├── .nvmrc
├── public/
│   └── favicon.svg
└── src/
    ├── content.config.ts
    ├── content/
    │   └── projects/
    │       └── *.md
    ├── layouts/
    │   └── BaseLayout.astro
    ├── pages/
    │   ├── index.astro
    │   └── projects/
    │       ├── index.astro
    │       └── [slug].astro
    └── styles/
        └── global.css
```

### `src/pages/` creates URLs

Astro uses file-based routing. The file `src/pages/index.astro` becomes the site's home page (`/`). The file `src/pages/projects/index.astro` creates `/projects/`, while `src/pages/projects/[slug].astro` renders one page per project entry.

### `.astro` files have frontmatter and a template

In `index.astro`, the two `---` lines enclose the frontmatter. JavaScript in this area runs as part of rendering/building and prepares data for the page.

After the closing `---` is the template: HTML mixed with Astro expressions. For example:

```astro
---
const person = 'Gagandeep Singh';
---
<h1>{person}</h1>
```

Astro evaluates `{person}` and sends the resulting HTML to the browser. This is not a React component and does not automatically ship the frontmatter JavaScript to the browser.

### A layout avoids repeating page scaffolding

`src/layouts/BaseLayout.astro` owns the document-level elements: `<!doctype html>`, `<html>`, `<head>`, the common header and footer. The `<slot />` marks where an individual page's content is inserted.

The page supplies `title` and `description` as props. This separates shared site structure from page-specific content.

### Data-driven template sections

The home page queries a project collection and renders the resource links with `.map()`. The supporting-project rows are also generated from project entries. Rather than duplicating markup and project descriptions by hand, the data is kept in Markdown and a template renders it consistently. See Lesson 2 for the collection and route mechanics.

### `global.css` owns the visual rules

The page uses a small set of CSS variables for colours, text and maximum content width. Variables provide one place to adjust a visual rule. There is no CSS framework or client-side JavaScript framework because the site does not currently need one.

### `astro.config.mjs` handles site URLs

A GitHub Pages repository site is usually published under a prefix such as `/analytics-engineer-portfolio/`, while local development uses `/`. Configuration manages that difference centrally instead of hard-coding the prefix throughout page content. This reduces the likelihood of the broken base-path issue seen in the old portfolio.

### What are `package.json`, `.nvmrc` and `tsconfig.json`?

- `package.json` declares Astro, TypeScript and the common commands for local development/building.
- `.nvmrc` records the Node version selected for this project.
- `tsconfig.json` opts into Astro's strict TypeScript defaults, helping editors catch some mistakes.
- `.gitignore` keeps dependencies and generated build files out of Git.

## How the page renders

```text
index.astro (page content + resource data)
             │
             ▼
BaseLayout.astro (shared HTML head, navigation, footer)
             │
             ▼
Astro renders static HTML + global.css
             │
             ▼
Browser displays the page
```

## What is deliberately not done yet

- The blog collection and reading-focused article template are not built yet.
- Existing blog articles and their image assets have not been migrated yet.
- No deployment configuration or GitHub repository changes yet.
- The dashboard and dbt docs currently have direct resource links. Genuine screenshots will be added as thumbnails in a later step; we will not substitute invented imagery for screenshots of the real sites.

## Next lesson

Read [`LESSON_02_CONTENT_COLLECTIONS.md`](LESSON_02_CONTENT_COLLECTIONS.md) to see how Markdown project entries, the collection schema, `getCollection()`, `render()`, and `getStaticPaths()` work together. The next implementation milestone is the blog collection and article layout.
