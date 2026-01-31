# OpenCode

## Configuration Modes

## Quick Reference

- **OpenCode Docs:** https://opencode.ai/docs/
- **oh-my-opencode GitHub:** https://github.com/code-yeongyu/oh-my-opencode
- **Provider Setup:** https://opencode.ai/docs/providers/
- **Configuration:** https://opencode.ai/docs/config/

## Configuration Modes

Switch between work and personal provider configs:

```bash
# Work (GitHub Copilot)
ln -sf "$DOTFILES/opencode/oh-my-opencode-work.json" ~/.config/opencode/oh-my-opencode.json && opencode

# Personal (Google Antigravity)
ln -sf "$DOTFILES/opencode/oh-my-opencode-personal.json" ~/.config/opencode/oh-my-opencode.json && opencode
```

See [oh-my-opencode.json](./oh-my-opencode-personal.json) for configuration examples.
