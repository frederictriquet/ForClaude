# Claude Code Hooks

Hooks are shell scripts triggered by Claude Code events. They let you add automated behaviors without modifying Claude's workflow.

## Available Events

| Event | Trigger |
|-------|---------|
| `PreToolUse` | Before each tool call (Bash, Write, Edit…) |
| `PostToolUse` | After each tool call |
| `Stop` | When Claude finishes its response |
| `Notification` | System events: permission request, idle, auth… |

## Input Format

All hooks receive JSON via **stdin** (no `$1` arguments). Fields common to all events:

```json
{
  "session_id": "abc123",
  "hook_event_name": "Notification",
  "cwd": "/current/working/dir"
}
```

## Configuration

In `.claude/settings.json` (project) or `~/.claude/settings.json` (global):

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

## Example: Audio + Desktop Notifications

The `~/.claude/hooks/notify.sh` script displays a system notification and plays a sound. It works on Linux and macOS without modification.

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
        notify "Claude Code" "Action required" "$context"
        play "$SOUNDS_DIR/question.mp3"
        ;;
    Stop)
        notify "Claude Code" "Response complete" "$context"
        play "$SOUNDS_DIR/done.mp3"
        ;;
    *)
        play "$SOUNDS_DIR/done.mp3"
        ;;
esac
```

The notification shows the current folder name and the first 8 characters of the session ID:

```
Claude Code
Response complete
ForClaude [d441c612]
```

**Prerequisites:**
- `jq` — JSON parsing (`apt install jq` / `brew install jq`)
- Linux audio: `mpg123` (`apt install mpg123`) or `ffplay` (ffmpeg) — `aplay`/`paplay` do not support MP3
- Linux notifications: `notify-send` (`apt install libnotify-bin`)
- macOS: `afplay` and `osascript` are built-in

**Note on osascript:** variables are passed as `on run` arguments to avoid any injection risk.

## Best Practices

See [best-practices.md — Hooks section](bonnes-pratiques.en.md#hooks-natural-checkpoint-not-continuous-surveillance) for usage rules (when to use `PreToolUse`, why to avoid `PostToolUse` mid-refactoring, etc.).
