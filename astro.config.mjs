import { defineConfig } from 'astro/config';

// Local development uses `/`. GitHub Pages repository sites need `/<repo>/`.
// Keeping this logic here prevents hard-coded repository paths in page markup.
const repositoryName = process.env.GITHUB_REPOSITORY?.split('/')[1];
const isGitHubActions = process.env.GITHUB_ACTIONS === 'true';

const defaultBase =
  isGitHubActions && repositoryName && repositoryName !== 'gagadanalyst.github.io'
    ? `/${repositoryName}`
    : '/';

export default defineConfig({
  site: 'https://gagadanalyst.github.io',
  base: process.env.SITE_BASE ?? defaultBase,
  trailingSlash: 'always',
});
