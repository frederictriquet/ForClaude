#!/bin/bash

SOUNDS_DIR="$HOME/.claude/sounds"

case "$1" in
    permission_prompt)
        afplay "$SOUNDS_DIR/question.mp3" >/dev/null 2>&1 &
        ;;
    idle_prompt)
        afplay "$SOUNDS_DIR/done.mp3" >/dev/null 2>&1 &
        ;;
    auth_success)
        afplay "$SOUNDS_DIR/success.mp3" >/dev/null 2>&1 &
        ;;
    elicitation_dialog)
        afplay "$SOUNDS_DIR/question.mp3" >/dev/null 2>&1 &
        ;;
    *)
        afplay "$SOUNDS_DIR/done.mp3" >/dev/null 2>&1 &
        ;;
esac