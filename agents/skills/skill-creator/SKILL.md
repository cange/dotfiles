---
name: skill-creator
description: Use when creating new OpenCode skills. Covers frontmatter spec, file structure, section conventions, invocation methods, and a copy-paste SKILL.md template.
compatibility: opencode
metadata:
  scope: project
  stack: opencode-skills
---

## Purpose

Teach AI agents to create high-quality OpenCode skills for project-specific automation and guidance.

## When to use

- Creating a new project-level skill in `.agents/skills/`
- Standardizing agent behavior for a specific domain or toolset
- Documenting internal project conventions for AI consumption

## Required patterns

### 1) Frontmatter spec

Each `SKILL.md` must start with YAML frontmatter. Only these fields are recognized:

- `name` (regex `^[a-z0-9]+(-[a-z0-9]+)*$`, 1-64 chars, required)
- `description` (drives agent selection, 1-1024 chars per spec; aim for 80-160 for best agent selection, required)
- `license` (optional)
- `compatibility` (optional)
- `metadata` (optional, string-to-string map)

Unknown frontmatter fields are ignored.

### 2) File structure

Skills reside in directories matching the `name` field. Standard location is `.agents/skills/<name>/SKILL.md`. Agents search Project (`.agents/`, `.opencode/`, `.claude/`) and Global (`~/.config/opencode/`, `~/.claude/`, `~/.agents/`) paths.

### 3) Section structure

Recommended order (project convention — the spec does not mandate section names): `Purpose`, `When to use`, `Required patterns` (numbered `### N)`), and `Do not`.

### 4) Invocation methods

1. `skill({ name: "name" })` tool call
2. `/name` slash command in chat
3. `load_skills: ["name"]` in task delegation

### 5) Creation checklist

1. Define clear scope
2. Create directory using kebab-case
3. Write SKILL.md with frontmatter
4. Define Purpose and When to use
5. Add numbered Required patterns
6. Add Do not anti-patterns

### 6) Template skeleton

**Template** (copy-paste this):

```markdown
---
name: [kebab-case-name]
description: [specific-trigger-scenario]
compatibility: opencode
metadata:
  scope: project
  stack: [area]
---

## Purpose

[One line]

## When to use

- [bullet]

## Required patterns

### 1) [Name]

[rule]

## Do not

- Do not [anti-pattern]
```

**Example** (from the official spec):

```markdown
---
name: git-release
description: Create consistent releases and changelogs
license: MIT
compatibility: opencode
metadata:
  audience: maintainers
  workflow: github
---

## What I do

- Draft release notes from merged PRs
- Propose a version bump
- Provide a copy-pasteable `gh release create` command

## When to use me

Use this when you are preparing a tagged release.
Ask clarifying questions if the target versioning scheme is unclear.
```

## Do not

- Do not use CamelCase or underscores in the skill name — only lowercase kebab-case (e.g. `my-skill`)
- Do not exceed ~100 lines in SKILL.md — keep content focused and scannable (aspirational guideline, not a spec rule)
- Do not skip the YAML frontmatter or omit `name`/`description` — both are required; skills without them silently fail to load
- Prefer the 4 standard sections (Purpose, When to use, Required patterns, Do not) for consistency — the spec allows custom names
- Do not use an `autoload` frontmatter field — it does not exist; description drives agent selection
