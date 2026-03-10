# Hooks Claude Code

Les hooks sont des scripts shell déclenchés par des événements Claude Code. Ils permettent d'ajouter des comportements automatiques sans modifier le workflow de Claude.

## Événements disponibles

| Événement | Déclencheur |
|-----------|-------------|
| `PreToolUse` | Avant chaque appel d'outil (Bash, Write, Edit…) |
| `PostToolUse` | Après chaque appel d'outil |
| `Stop` | Quand Claude termine sa réponse |
| `Notification` | Événements système : permission demandée, idle, auth… |

## Format d'entrée

Tous les hooks reçoivent un JSON via **stdin** (pas d'arguments `$1`). Champs communs à tous les événements :

```json
{
  "session_id": "abc123",
  "hook_event_name": "Notification",
  "cwd": "/current/working/dir"
}
```

## Configuration

Dans `.claude/settings.json` (projet) ou `~/.claude/settings.json` (global) :

```json
{
  "hooks": {
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/notify.sh"
          }
        ]
      }
    ],
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/notify.sh"
          }
        ]
      }
    ]
  }
}
```

## Exemple : notifications audio + écran

Le script `~/.claude/hooks/notify.sh` affiche une notification système et joue un son. Il est portable Linux/macOS sans modification.

```bash
#!/bin/bash

SOUNDS_DIR="$HOME/.claude/sounds"

input=$(cat)
event=$(echo "$input" | jq -r '.hook_event_name // empty')
cwd=$(echo "$input" | jq -r '.cwd // empty')
session=$(echo "$input" | jq -r '.session_id // empty')
context="${cwd##*/} [${session:0:8}]"

notify() {
    local title="$1" subtitle="$2" body="$3"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        osascript - "$title" "$subtitle" "$body" <<'EOF'
on run {title, subtitle, body}
    display notification body with title title subtitle subtitle
end run
EOF
    elif command -v notify-send &> /dev/null; then
        notify-send "$title" "$subtitle\n$body"
    fi
}

play() {
    local file="$1"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        afplay "$file" >/dev/null 2>&1 &
    elif command -v mpg123 &> /dev/null; then
        mpg123 -q "$file" &
    elif command -v ffplay &> /dev/null; then
        ffplay -nodisp -autoexit -loglevel quiet "$file" &
    fi
}

case "$event" in
    Notification)
        notify "Claude Code" "Action requise" "$context"
        play "$SOUNDS_DIR/question.mp3"
        ;;
    Stop)
        notify "Claude Code" "Réponse terminée" "$context"
        play "$SOUNDS_DIR/done.mp3"
        ;;
    *)
        play "$SOUNDS_DIR/done.mp3"
        ;;
esac
```

La notification affiche le nom du dossier courant et les 8 premiers caractères du session ID :

```
Claude Code
Réponse terminée
ForClaude [d441c612]
```

**Prérequis :**
- `jq` — parsing JSON (`apt install jq` / `brew install jq`)
- Linux audio : `mpg123` (`apt install mpg123`) ou `ffplay` (ffmpeg) — `aplay`/`paplay` ne supportent pas le MP3
- Linux notifs : `notify-send` (`apt install libnotify-bin`)
- macOS : `afplay` et `osascript` sont natifs

**Note osascript :** les variables sont passées comme arguments `on run` pour éviter tout risque d'injection.

## Bonnes pratiques

Voir [bonnes-pratiques.md — section Hooks](bonnes-pratiques.md#hooks--checkpoint-naturel-pas-surveillance-continue) pour les règles d'usage (quand utiliser `PreToolUse`, pourquoi éviter `PostToolUse` en milieu de refactoring, etc.).
