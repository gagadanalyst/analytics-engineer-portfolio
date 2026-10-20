# Lesson 2 — Astro Content Collections

## What we added

- `src/content.config.ts`: tells Astro where project Markdown files live and what metadata each project must provide.
- `src/content/projects/*.md`: the source content. Each file is a project entry with YAML frontmatter followed by ordinary Markdown.
- `src/pages/projects/[slug].astro`: one reusable template for every project detail page.
- `src/pages/projects/index.astro`: an automatically generated project archive.

## The mental model

A content collection is a set of related entries with a shared shape. Here, all project files have fields such as `title`, `description`, `status`, and `technologies`. The schema validates the metadata so a typo or missing required field can be caught during development/build rather than quietly producing a broken page.

### 1. Frontmatter is metadata

A project's Markdown begins with YAML between `---` markers. For example:

```yaml
---
title: Example project
description: One sentence about the project.
status: supporting
technologies:
  - Python
  - SQL
showOnHome: true
sortOrder: 10
---
```

Below the closing `---`, write the page's regular Markdown content. Metadata controls listings and reusable page elements; the body tells the full story.

### 2. `src/content.config.ts` defines a contract

- `defineCollection()` registers the collection with Astro.
- `glob()` tells Astro to find Markdown files under `src/content/projects`.
- `z.object()` defines the fields and validation rules.
- `z.string().url()` requires a valid URL for supplied resource links.
- `z.enum()` restricts `status` to our allowed values.

We are using Astro's current Content Layer API: `src/content.config.ts` plus the `glob()` loader. This is the current approach in the official Astro documentation, rather than older examples using the previous collection configuration format.

### 3. A content file is not automatically a page

Astro stores collection entries separately from `src/pages/`. The dynamic route file `[slug].astro` is what turns the entries into URLs.

`getStaticPaths()` reads all project entries and returns one route per entry. For example, `toronto-housing-bottleneck-analytics.md` becomes `/projects/toronto-housing-bottleneck-analytics/` (with the configured site base applied during deployment).

`render(project)` compiles the Markdown into a `Content` component. The same template can render every project's body without copying the page layout.

### 4. The archive is data-driven too

`src/pages/projects/index.astro` uses `getCollection('projects')` and sorts the entries by `sortOrder`. The page does not contain a manually maintained list of project titles.

### 5. How to add a project later

1. Create a new Markdown file in `src/content/projects/`, such as `my-new-project.md`.
2. Copy the frontmatter structure from an existing project and update its fields.
3. Write the case study below the closing `---` using headings such as `Summary`, `Approach`, `What to review`, and `Limitations`.
4. Set `showOnHome: true` only if it deserves a homepage slot. Set `sortOrder` to control its order in the archive.
5. Run the development server or build and fix any schema errors Astro reports.

The route is generated automatically; you do not create a new `.astro` detail page for each project.

## Design choice

The content model deliberately separates metadata from prose. This lets the homepage display a title and short description, the archive list all projects, and the detail page provide the full explanation—all from one Markdown file.

## Current validation caveat

A full Astro build was not available in the authoring environment because dependencies were not installed and the package registry was unreachable. Source and frontmatter consistency checks have been performed; the first real dependency install and production build remain required before deployment.
