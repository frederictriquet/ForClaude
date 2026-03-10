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
on run argv
    display notification (item 3 of argv) with title (item 1 of argv) subtitle (item 2 of argv)
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
