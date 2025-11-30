# OpenCode

## Token Optimization

### What's Configured

#### Agents (Switch with `opencode --agent <name>` or Tab key)

- **quick**: `google/gemini-2.5-flash` - Simple edits, fixes (free, fast, **vision support**)
- **deep**: `google/gemini-2.5-pro` - Complex analysis, refactoring (**vision support**)
- **readonly**: `google/gemini-2.5-flash-lite` - Code explanations only (no edits, **vision support**)

**All three agents support image/vision capabilities.** You can:
- Drag and drop images into OpenCode terminal
- Reference images with `@image.png` syntax
- Paste screenshots directly (terminal-dependent)

#### Custom Commands

- `/analyze <query>` - Uses context-filter agent for minimal token usage
- `/search <term>` - Top 5 results, line numbers only
- `/quickfix <issue>` - Fast fixes with Gemini Flash
- `/docs <topic>` - Context7 docs with <500 token summaries
- `/web <task>` - Enables GitHub MCP (session only)
- `/browser <task>` - Enables Chrome DevTools (session only)

#### MCP Servers

**Disabled by default** (40-60% savings): `chrome-devtools`, `github`
**Always enabled**: `brave-search`, `context7`, `fetch`

#### Custom Agent

`agent/context-filter.md` - Optimized code context gathering (70% savings)

### Expected Savings

- **Overall**: 70-85% token reduction
- **Progressive MCP**: 40-60% (GitHub/Chrome disabled)
- **Context Filter**: 70% (code exploration)
- **Agent Selection**: 30-50% (Gemini Flash for simple tasks)

### Usage Tips

- Use **quick** agent for simple tasks (free tier)
- Use **deep** agent for complex problems (included with GitHub Copilot)
- Enable disabled MCPs only when needed with `/web` or `/browser`
- Monitor token usage shown after each interaction

### Re-enable Disabled MCPs Permanently

Edit `config.json`:

```json
{
  "mcp": {
    "github": { "enabled": true }
  }
}
```

Then restart OpenCode.
