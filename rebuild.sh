#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
ln -sfn "$DIR" ~/.dotfiles

if DARWIN_REBUILD_BIN="$(command -v darwin-rebuild)"; then
  exec sudo -H "$DARWIN_REBUILD_BIN" switch --flake ~/.dotfiles#mac
fi

# `sudo` resets PATH, so if darwin-rebuild is not installed yet (or is not on
# the current shell's PATH), run the pinned nix-darwin tool the same way as the
# first bootstrap switch.
NIX_BIN="$(command -v nix)"
exec sudo -H "$NIX_BIN" run github:nix-darwin/nix-darwin/nix-darwin-26.05#darwin-rebuild -- \
  switch --flake ~/.dotfiles#mac
