#!/bin/zsh
set -uxo pipefail

{{ if eq .chezmoi.os "darwin" -}}
{{ if eq .chezmoi.arch "arm64" -}}
eval $(/opt/homebrew/bin/brew shellenv)
{{- end -}}
{{- end -}}

# Install followings so that `source ~/.zshenv` does not fail
export XDG_DATA_HOME="${HOME}/.local/share"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"

rustup default stable

if [ ! $(command -v sheldon) ]; then
	cargo install sheldon --locked
fi

if [ ! $(command -v starship) ]; then
	cargo install starship --locked
fi
