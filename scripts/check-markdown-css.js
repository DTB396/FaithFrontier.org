import { readdir, readFile } from "fs/promises";
import path from "path";

const root = process.cwd();
const markdownExtensions = new Set([".md", ".markdown"]);
const ignoreDirs = new Set([
  ".git",
  "node_modules",
  "_site",
  ".jekyll-cache",
  ".cache",
]);

async function collectMarkdownFiles(dir) {
  const entries = await readdir(dir, { withFileTypes: true });
  const files = [];
  for (const entry of entries) {
    if (ignoreDirs.has(entry.name)) continue;
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      files.push(...(await collectMarkdownFiles(fullPath)));
      continue;
    }
    const ext = path.extname(entry.name).toLowerCase();
    if (markdownExtensions.has(ext)) {
      files.push(fullPath);
    }
  }
  return files;
}

function stripCodeBlocks(content) {
  return content
    .replace(/```[\s\S]*?```/g, "")
    .replace(/~~~[\s\S]*?~~~/g, "")
    .replace(/<style[\s\S]*?>[\s\S]*?<\/style>/gi, "");
}

function findMatches(content) {
  const checks = [
    { label: ":root {", regex: /:root\s*\{/g },
    { label: "html {", regex: /^\s*html\s*\{/gim },
    { label: "CSS custom property (--var:)", regex: /--[a-zA-Z0-9_-]+\s*:/g },
  ];

  const violations = [];
  for (const check of checks) {
    const matches = [...content.matchAll(check.regex)];
    for (const match of matches) {
      const before = content.slice(0, match.index || 0);
      const line = before.split(/\r?\n/).length;
      violations.push({ label: check.label, line });
    }
  }
  return violations;
}

async function main() {
  const markdownFiles = await collectMarkdownFiles(root);
  const failures = [];

  for (const file of markdownFiles) {
    const raw = await readFile(file, "utf8");
    const scrubbed = stripCodeBlocks(raw);
    const matches = findMatches(scrubbed);
    if (matches.length) {
      failures.push({ file: path.relative(root, file), matches });
    }
  }

  if (failures.length) {
    console.error(
      "CSS guard failed: detected CSS blocks inside markdown files.",
    );
    for (const failure of failures) {
      console.error(`- ${failure.file}`);
      for (const match of failure.matches) {
        console.error(`  • ${match.label} (line ${match.line})`);
      }
    }
    process.exit(1);
  }

  console.log("CSS guard passed: no inline CSS detected in markdown files.");
}

main().catch((err) => {
  console.error("CSS guard failed unexpectedly:", err);
  process.exit(1);
});
