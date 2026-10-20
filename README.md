# Analytics Engineer Portfolio

The source code for my personal Analytics Engineer portfolio, built with Astro. The website presents data projects, technical writing, and implementation evidence in a lightweight, responsive interface.

**Portfolio website:** [Analytics Engineer Portfolio](https://gagadanalyst.github.io/analytics-engineer-portfolio/)

## About the site

The homepage puts **Toronto Housing Bottleneck Analytics** first, with links to its source code, dbt documentation, and dashboard. Supporting projects and technical articles have dedicated pages, allowing visitors to explore the work in more detail.

The design is intentionally minimal. It prioritizes clear writing, inspectable project evidence, and accessible navigation rather than decorative elements or embedded applications.

## Features

- Markdown-driven project and blog collections with validated metadata.
- Reusable layouts and automatically generated project and article pages.
- Theme-aware project thumbnails, with light and dark variants.
- Persistent light/dark theme selection.
- Responsive layouts, keyboard focus styles, and a custom 404 page.
- Static site generation with Astro.
- GitHub Actions workflows for build validation and GitHub Pages deployment.

## Featured work

### Toronto Housing Bottleneck Analytics

An end-to-end Analytics Engineering project examining active-permit aging, observed lifecycle durations, and source-data quality using City of Toronto building-permit data.

- [Source code](https://github.com/gagadanalyst/toronto-housing-bottleneck-analytics)
- [dbt documentation](https://gagadanalyst.github.io/toronto-housing-bottleneck-analytics/)
- [Dashboard](https://toronto-housing-bottleneck.streamlit.app/)

The project uses observed SCD Type 2 history and keeps its interpretation descriptive: ingestion observations do not prove exact real-world status-transition times or the causes of permit delays.

The site also includes supporting projects in energy-price analytics and lead-conversion modelling, along with technical writing on Apache Iceberg, AWS Glue, AWS IAM, and Amazon S3.

## Technology

- Astro and TypeScript
- Markdown content collections
- CSS and responsive layouts
- Node.js and npm
- GitHub Actions and GitHub Pages

## Run locally

Requirements: Node.js `22.23.1` and npm.

```bash
npm install
npm run dev
```

To generate and preview the static site:

```bash
npm run build
npm run preview
```

Astro prints the development or preview URL in the terminal. The production build is generated in `dist/`.

## Content and project structure

Project descriptions and case studies live in `src/content/projects/`. Technical articles live in `src/content/blog/`, with their public images under `public/blog/`.

```text
src/
  components/       Reusable Astro components
  content/
    projects/       Project metadata and case studies
    blog/           Technical articles
  layouts/          Shared site and article layouts
  pages/            Homepage, archives, detail pages, and 404
  styles/           Global styling
public/
  blog/             Article images and public assets
.github/workflows/  Build validation and Pages deployment
```

New projects and articles can be added through Markdown content files and rendered by the existing templates without creating individual page components.

## Design

The visual system uses three core colours: Lavender Fog `#E3E0ED`, Graphite `#282B37`, and Sea Glass `#82B5AA`. Both themes use tinted surfaces rather than flat white or black backgrounds. The persistent theme toggle and theme-aware thumbnails help maintain contrast across the site.

The homepage preview graphics for the source code, dbt documentation, and dashboard are illustrative representations, not screenshots of those live applications.

## Hosting

The site is configured for GitHub Pages at the repository URL above. The Astro configuration derives the repository base path in GitHub Actions, while internal navigation uses `import.meta.env.BASE_URL` so it can work locally and under the deployed repository path.

The GitHub Actions workflows validate the static build and publish the generated `dist/` directory to GitHub Pages. The repository's Pages source should be configured as **GitHub Actions**.
