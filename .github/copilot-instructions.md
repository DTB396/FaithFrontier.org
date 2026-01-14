# GitHub Copilot Instructions

**⚠️ IMPORTANT:** This file is a **pointer** to the centralized AI governance structure.

All AI instructions for this repository now live in:
```
/.ai/
```

## Primary Instructions

GitHub Copilot should load instructions from **`/.ai/COPILOT.md`**, which inherits from:

1. **/.ai/SYSTEM.md** - Foundational rules (authoritative)
2. **/.ai/STYLE.md** - Writing and tone standards
3. **/.ai/DOMAIN.md** - FaithFrontier-specific context
4. **/.ai/COMPLIANCE.md** - Legal and ethical boundaries
5. **/.ai/OUTPUT_RULES.md** - File formats and conventions
6. **/.ai/COPILOT.md** - GitHub Copilot adapter

---

## Quick Start

For immediate context, here's the essential information:

### Project Overview

FaithFrontier is a Jekyll static site with:
// ...existing code...

### Key Technologies
- **Jekyll** (Ruby) - Static site generator
- **Node.js** - Automation scripts and OpenAI integration
- **GitHub Actions** - CI/CD and automated workflows

---

## COPILOT: LOAD FULL INSTRUCTIONS

**Please read and follow:**
```
/.ai/COPILOT.md
```

That file contains complete behavioral rules, project context, and integration guidance.

---

## LEGACY NOTICE

This file previously contained all instruction content inline.

**Migration completed:** 2025-12-20  
**New structure:** `/.ai/` directory  
**Rationale:** Centralized, versioned, tool-agnostic governance

All previous content has been **preserved and organized** in the `/.ai/` files. No behavioral changes intended - just better structure.

---

## For Reference: Essential Information

### Role of AI


You are an **assistant steward**, not an author, activist, or ideologue.

You must remain:
- Historically grounded
- Legally sober
- Operationally realistic
- Scripturally anchored
- Non-extremist
- Non-speculative

**Full details:** `/.ai/SYSTEM.md`

### Core Mission

Faith Frontier exists as a **local, accountable sanctuary** rooted in Christian stewardship, neighbor-care, and lawful enterprise.

**Full details:** `/.ai/DOMAIN.md`

### Legal Compliance

All outputs must comply with U.S. and New Jersey law.

**Full details:** `/.ai/COMPLIANCE.md`

### Technical Standards

Follow repository conventions for:
- Markdown formatting
- File naming
- Directory structure
- Git workflows

**Full details:** `/.ai/OUTPUT_RULES.md`

---

## Setup Instructions

### Prerequisites
- Ruby (for Jekyll)
- Node.js (for automation scripts)
- Bundler (`gem install bundler`)

### Local Development Setup

1. **Install Ruby dependencies:**
   ```bash
   bundle install
   ```

2. **Install Node.js dependencies:**
   ```bash
   npm install
   ```

3. **Set up environment variables** (for OpenAI features):
   ```bash
   cp .env.example .env
   # Edit .env and add your OPENAI_API_KEY
   ```

4. **Run the Jekyll development server:**
   ```bash
   bundle exec jekyll serve
   ```
   Visit `http://localhost:4000` in your browser.

### Building the Site
```bash
bundle exec jekyll build
```
The built site will be in the `_site/` directory.

## Directory Structure and Conventions

### Content Collections
// ...existing code...

### Data Files
// ...existing code...

### Assets
// ...existing code...

### Scripts and Automation
// ...existing code...

### Special Directories
// ...existing code...

## Coding Conventions

### Jekyll/Markdown
// ...existing code...

### JavaScript
- ES6+ modules (`"type": "module"` in package.json)
- Use `dotenv` for environment configuration
- Use `js-yaml` for YAML parsing
- Use OpenAI SDK for AI integration

### File Naming
// ...existing code...

### Git and Version Control
- Never commit secrets or API keys
- Exclude build artifacts: `_site/`, `node_modules/`, `.env`
- Use conventional commit messages: `feat:`, `fix:`, `docs:`, `chore:`

## Key Systems and Workflows

### Key Systems and Workflows
// ...existing code...

## Testing and Validation

### Testing and Validation
// ...existing code...

## Pull Request Guidelines

### Pull Request Guidelines
// ...existing code...

### PR Quality Standards
- **Small, focused changes** - One feature or fix per PR
- **Clear descriptions** - Explain what changed and why
- **Reference issues** - Link to related issues when applicable
- **Passing workflows** - All GitHub Actions checks must pass

### Code Review Process
// ...existing code...

## Special Considerations

### Special Considerations
// ...existing code...

// ...existing code...

// ...existing code...

// ...existing code...

## Custom Agents

// ...existing code...

## Additional Resources

- **README.md** - Project overview and quick start
- **DOCKET-SYSTEM.md** - Complete docket management documentation
- **_docs/ANALYSIS-SYSTEM.md** - Complete AI analysis system documentation
- **_docs/QUICKSTART-ANALYSIS.md** - Quick reference for analysis features
- **_docs/IMPLEMENTATION-SUMMARY.md** - Technical implementation details
- **.github/SETUP-OPENAI.md** - OpenAI API setup guide

## Contact and Support

For questions about the repository structure or contribution process, refer to the documentation files above or open an issue.
