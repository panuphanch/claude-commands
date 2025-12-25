#!/bin/bash

# Claude Commands Installation Script
# Creates symlinks from this repository to ~/.claude/commands/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMANDS_DIR="$HOME/.claude/commands"

echo "Claude Commands Installer"
echo "========================="
echo ""

# Check if ~/.claude/commands exists
if [ ! -d "$COMMANDS_DIR" ]; then
    echo "Creating $COMMANDS_DIR..."
    mkdir -p "$COMMANDS_DIR"
fi

# Create sessions directory for session management commands
SESSIONS_DIR="$HOME/.claude/sessions"
if [ ! -d "$SESSIONS_DIR" ]; then
    echo "Creating $SESSIONS_DIR..."
    mkdir -p "$SESSIONS_DIR"
    touch "$SESSIONS_DIR/.current-session"
fi

# Create symlinks for all .md files (except README)
echo "Creating symlinks..."
for file in "$SCRIPT_DIR"/*.md; do
    filename=$(basename "$file")

    # Skip README.md
    if [ "$filename" = "README.md" ]; then
        continue
    fi

    target="$COMMANDS_DIR/$filename"

    # Remove existing file/symlink if exists
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "  Removing existing: $filename"
        rm "$target"
    fi

    # Create symlink
    echo "  Linking: $filename"
    ln -s "$file" "$target"
done

echo ""
echo "Installation complete!"
echo ""
echo "Available commands:"
for file in "$SCRIPT_DIR"/*.md; do
    filename=$(basename "$file" .md)
    if [ "$filename" != "README" ] && [ "$filename" != "SLASH-COMMAND-GUIDE" ]; then
        echo "  /$filename"
    fi
done
echo ""
echo "To update commands, run: git pull && ./install.sh"
