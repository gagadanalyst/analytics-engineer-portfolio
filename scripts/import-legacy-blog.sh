#!/usr/bin/env bash
set -euo pipefail

# Read-only import from the old public portfolio repository. It does not modify GitHub.
legacy_repo="https://github.com/gagadanalyst/analytics-engnieer.git"
force="${1:-}"
slugs=(apache-iceberg aws-glue aws-iam s3-bucket-types)
root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

for required in git python3; do
  if ! command -v "$required" >/dev/null 2>&1; then
    echo "$required is required for the legacy blog import." >&2
    exit 1
  fi
done

echo "Fetching the four existing Markdown articles and image assets (read-only sparse clone)..."
git clone --depth 1 --filter=blob:none --sparse "$legacy_repo" "$tmp_dir/legacy" >/dev/null
git -C "$tmp_dir/legacy" sparse-checkout set src/content/blog public/blog

for slug in "${slugs[@]}"; do
  source_dir="$tmp_dir/legacy/src/content/blog/$slug"
  source_assets="$tmp_dir/legacy/public/blog/$slug"
  target_file="$root_dir/src/content/blog/$slug.md"
  target_assets="$root_dir/public/blog/$slug"

  if [[ ! -f "$source_dir/index.md" ]]; then
    echo "Expected source article not found: $source_dir/index.md" >&2
    exit 1
  fi
  if [[ -f "$target_file" && "$force" != "--force" ]]; then
    echo "Skipping existing $target_file (pass --force to replace the article)."
    continue
  fi

  mkdir -p "$(dirname "$target_file")" "$target_assets"
  cp "$source_dir/index.md" "$target_file"

  # Legacy hero images sit beside index.md; body illustrations live in public/blog/<slug>.
  for item in "$source_dir"/*; do
    [[ -e "$item" ]] || continue
    [[ "$(basename "$item")" == "index.md" ]] && continue
    cp -R "$item" "$target_assets/"
  done
  if [[ -d "$source_assets" ]]; then
    cp -R "$source_assets"/. "$target_assets/"
  fi

  # Keep the article source readable, but remove the old repo's hard-coded base path.
  python3 - "$target_file" "$slug" <<'PY'
from pathlib import Path
import re
import sys

path = Path(sys.argv[1])
slug = sys.argv[2]
text = path.read_text(encoding="utf-8")
text = text.replace(f"/analytics-engineer/blog/{slug}/images/", "./images/")
text = text.replace(f"/analytics-engineer/blog/{slug}/", "./")

# The old posts store comma-separated tags in a single YAML list item. Split them
# into individual strings so the new collection can display clear topic labels.
frontmatter_match = re.match(r"\A---\s*\n(.*?)\n---\s*(\n.*)?\Z", text, flags=re.S)
if frontmatter_match:
    frontmatter, body = frontmatter_match.group(1), frontmatter_match.group(2) or "\n"
    tag_match = re.search(r"(?m)^tags:\s*\n((?:[ \t]+-[^\n]*\n?)+)", frontmatter)
    if tag_match:
        values = re.findall(r"(?m)^[ \t]+-[ \t]*(.*?)\s*$", tag_match.group(1))
        tags = [tag.strip().strip("'\" ").rstrip(".") for value in values for tag in value.split(",") if tag.strip()]
        def yaml_quote(value: str) -> str:
            return '"' + value.replace('\\', '\\\\').replace('"', '\\"') + '"'
        replacement = "tags:\n" + "".join(f"  - {yaml_quote(tag)}\n" for tag in tags)
        frontmatter = frontmatter[:tag_match.start()] + replacement + frontmatter[tag_match.end():]
    text = "---\n" + frontmatter.strip("\n") + "\n---" + body

path.write_text(text, encoding="utf-8")
PY
  echo "Imported $slug"
done

echo "Blog import complete. Review the articles and image paths before publishing."
