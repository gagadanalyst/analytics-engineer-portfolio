# Lesson 4 — Images and reusable thumbnails

## What changed

- Added `src/components/ProjectThumbnail.astro`, a reusable image component.
- Added local thumbnail art for the Toronto flagship, European Energy Price prototype, and lead-scoring notebook.
- Recoloured the thumbnail artwork with distinct light palettes and stronger complementary accents, plus coordinated dark-theme variants. Toronto pipeline art uses warm clay, energy prices uses amber, lead scoring uses rose, the dashboard preview uses sky blue, and dbt docs use periwinkle.
- Added illustrated preview cards for the Toronto source-code repository, dashboard and dbt documentation links.
- Updated the homepage evidence area, supporting-project list, project archive, and project detail pages to use thumbnails where they help.
- Added thumbnail metadata to the project content schema.

The three Toronto evidence previews are **illustrations, not screenshots**. They are explicitly labelled as such. Replace them with authentic screenshots captured from the real repository, dashboard and dbt documentation before final publication if actual interface previews are preferable. This keeps the current source honest and gives us a visually complete draft while network access is unavailable here.

## Foundational concept 1: `src/` versus `public/`

Astro treats assets in these folders differently:

- `src/` is for assets Astro can discover, validate, bundle, and potentially optimize as part of the build.
- `public/` is for files you want copied unchanged to the generated site, such as a favicon or a report that should be downloadable as-is.

Project thumbnails are stored at `src/content/projects/images/` because they are local content assets that we want Astro to know about. The SVG source files are retained beside their PNG renderings so the diagram artwork can be edited later.

## Foundational concept 2: the collection `image()` helper

In `src/content.config.ts`, the project schema declares:

```ts
thumbnail: image().optional(),
thumbnailDark: image().optional(),
thumbnailAlt: z.string().optional(),
```

The `image()` helper validates and resolves the thumbnail file referenced in the Markdown frontmatter. That means a typo in the path is caught during content validation rather than silently producing a broken image at runtime.

For example, in `european-energy-prices.md`:

```yaml
thumbnail: ./images/energy-price-workflow.png
thumbnailAlt: A diagram of the local energy price workflow, from collection to Power BI reporting.
```

The path is relative to the Markdown file. This is the same pattern as article metadata: content owns the information that describes that specific project.

## Foundational concept 3: a reusable component

`ProjectThumbnail.astro` accepts three important props:

- `src`: resolved image metadata from the content collection or an imported image.
- `alt`: a text description for people using assistive technologies, and for cases where an image cannot be seen.
- `loading`: whether the browser should load an image eagerly or lazily.

The component uses Astro's `<Image />` component from `astro:assets`. Astro can generate the final image URL and dimensions as part of the build. We do not need to repeat image markup or its common styling throughout the pages.

The calls look like this:

```astro
<ProjectThumbnail src={project.data.thumbnail} alt={project.data.thumbnailAlt} />
```

The parent page decides where the thumbnail appears; the component owns how the thumbnail itself is rendered. That's a small example of separation of concerns.

## Why keep both SVG and PNG?

The SVG is the editable source drawing; the PNG is the raster asset referenced by the content collection and image pipeline. This is convenient for the current hand-authored illustrations. If we replace a thumbnail with a genuine screenshot, we can update the Markdown image path and alt text without changing the component or the page template.

## How to add a thumbnail to another project

1. Place the image under `src/content/projects/images/`.
2. Reference it from that project's Markdown frontmatter with a path relative to the Markdown file.
3. Add a useful `thumbnailAlt` description.
4. Use the existing `ProjectThumbnail.astro` component where the thumbnail adds information.

The schema rejects an image without corresponding alt text. A project without a thumbnail remains valid, so the component does not force every archive entry to have an illustration.

## Validation note

The image files were generated and visually inspected, and the references were checked against the files on disk. The complete Astro build still needs to be run with a compatible Node.js version and installed dependencies. This workspace's Node.js version is below the project's declared minimum, and the package registry is not reachable from the build environment.
