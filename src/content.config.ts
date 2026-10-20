import { defineCollection } from 'astro:content';
import { z } from 'astro/zod';
import { glob } from 'astro/loaders';

// A collection is a group of content files with the same expected metadata.
// Astro validates every Markdown entry against this schema when it builds the site.
const projects = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/projects' }),
  schema: ({ image }) => z.object({
    title: z.string(),
    description: z.string(),
    status: z.enum(['flagship', 'supporting', 'backlog']),
    technologies: z.array(z.string()).default([]),
    thumbnail: image().optional(),
    thumbnailDark: image().optional(),
    thumbnailAlt: z.string().optional(),
    showOnHome: z.boolean().default(false),
    sortOrder: z.number().int().default(100),
    repositoryUrl: z.string().url().optional(),
    notebookUrl: z.string().url().optional(),
    dbtDocsUrl: z.string().url().optional(),
    dashboardUrl: z.string().url().optional(),
    reportUrl: z.string().url().optional(),
  }).refine((project) => !project.thumbnail || Boolean(project.thumbnailAlt?.trim()), {
    message: 'thumbnailAlt is required when a project thumbnail is provided.',
    path: ['thumbnailAlt'],
  }),
});


// Blog posts use the same content-first pattern as projects, but have a
// different metadata contract and a reader-focused layout.
const blog = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/blog' }),
  schema: z.object({
    title: z.string(),
    publishDate: z.coerce.date(),
    updatedDate: z.coerce.date().optional(),
    description: z.string(),
    tags: z.array(z.string()).default([]),
    language: z.string().default('English'),
    draft: z.boolean().default(false),
    heroImage: z.object({ src: z.string(), color: z.string().optional() }).optional(),
    comment: z.boolean().optional(),
  }),
});

export const collections = { projects, blog };
