#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.claude"
mkdir -p "$HOME/.claude/skills"
mkdir -p "$HOME/.claude/agents"

# Install Claude Code if missing
if ! command -v claude >/dev/null 2>&1; then
  curl -fsSL https://claude.ai/install.sh | bash
fi

# Copy user-scope Claude config
cp "$ROOT/claude-home/settings.json" "$HOME/.claude/settings.json"
cp "$ROOT/claude-home/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
cp -R "$ROOT/claude-home/skills/." "$HOME/.claude/skills/" 2>/dev/null || true
cp -R "$ROOT/claude-home/agents/." "$HOME/.claude/agents/" 2>/dev/null || true

# Prepare user MCP/state file if absent
if [ ! -f "$HOME/.claude.json" ]; then
  cat > "$HOME/.claude.json" <<'EOM'
{
  "mcpServers": {}
}
EOM
fi

grep -q 'CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=true' "$HOME/.bashrc" || cat >> "$HOME/.bashrc" <<'EOB'
export CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=true
EOB

echo "Claude dotfiles bootstrap finished."
echo "Open a new terminal and run: claude"
