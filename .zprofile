. "$HOME/.cargo/env"

export EDITOR='nvim'
export VISUAL='nvim'


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH="$PATH:/opt/jmeter/bin"
export PATH=$PATH:/usr/local/go/bin
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
. "$HOME/.cargo/env"

# ghcup-env
GHCUP_ENV_PATH="$HOME/.ghcup/env"
[ -f "$GHCUP_ENV_PATH" ] && source "$GHCUP_ENV_PATH"

# fzf
FZF_BIN_PATH="$HOME/.fzf/bin"
if [[ ! "$PATH" == *"$FZF_BIN_PATH"* ]]; then
  PATH="${PATH:+${PATH}:}$FZF_BIN_PATH"
fi

export PATH=${PATH}:`go env GOPATH`/bin

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
