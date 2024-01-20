#!/bin/zsh
set -uxo pipefail

# Install followings so that `source ~/.zshenv` does not fail
export XDG_DATA_HOME="${HOME}/.local/share"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"

if [ ! $(command -v rustup) ]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
