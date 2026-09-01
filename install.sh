#!/usr/bin/env bash
# Installs the 100m-offers and 100m-leads Agent Skills.
#
#   ./install.sh                 install for every agent detected on this machine
#   ./install.sh claude          install for Claude Code only        (~/.claude/skills)
#   ./install.sh codex           install for Codex CLI only          (~/.agents/skills)
#   ./install.sh cursor          install for Cursor only             (~/.cursor/skills)
#   ./install.sh agents          install to the shared standard dir  (~/.agents/skills)
#   ./install.sh project [PATH]  install into a repo at PATH         (PATH/.claude/skills + PATH/.agents/skills)
#
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/skills"
SKILLS=(100m-offers 100m-leads)

[ -d "$SRC" ] || { echo "error: skills/ not found next to install.sh"; exit 1; }

copy_into() {
  local dest="$1"
  mkdir -p "$dest"
  for s in "${SKILLS[@]}"; do
    rm -rf "${dest:?}/$s"
    cp -R "$SRC/$s" "$dest/$s"
    echo "  installed $s -> $dest/$s"
  done
}

target="${1:-auto}"

case "$target" in
  claude)  copy_into "$HOME/.claude/skills" ;;
  codex|agents) copy_into "$HOME/.agents/skills" ;;
  cursor)  copy_into "$HOME/.cursor/skills" ;;
  project)
    root="${2:-$PWD}"
    [ -d "$root" ] || { echo "error: $root is not a directory"; exit 1; }
    copy_into "$root/.claude/skills"
    copy_into "$root/.agents/skills"
    echo "Commit .claude/skills and .agents/skills so your team gets them on clone."
    ;;
  auto)
    installed=0
    if [ -d "$HOME/.claude" ]; then copy_into "$HOME/.claude/skills"; installed=1; fi
    if [ -d "$HOME/.codex" ] || [ -d "$HOME/.agents" ]; then copy_into "$HOME/.agents/skills"; installed=1; fi
    if [ -d "$HOME/.cursor" ]; then copy_into "$HOME/.cursor/skills"; installed=1; fi
    if [ "$installed" -eq 0 ]; then
      echo "No agent directory detected. Installing to the shared location ~/.agents/skills"
      copy_into "$HOME/.agents/skills"
    fi
    ;;
  -h|--help|help) sed -n '2,10p' "$0" | sed 's/^# \{0,1\}//' ; exit 0 ;;
  *) echo "unknown target: $target (use claude, codex, cursor, agents, project, or no argument)"; exit 1 ;;
esac

echo
echo "Done. Restart your agent, then type /100m-offers or /100m-leads, or just describe an offer or lead-gen problem."
