## Exports

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR="hx"
export GOPATH="/Users/aurels/Dev/golang"

# Settings

# set -Ux fish_user_paths /opt/homebrew/bin $fish_user_paths
set -U fish_greeting ""

## Aliases

alias sublime="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias sublime=subl
alias gitdiff="git icdiff"
alias dc="docker compose"
alias wezterm=/Applications/WezTerm.app/Contents/MacOS/wezterm
alias utm="/Applications/UTM.app/Contents/MacOS/utm"
alias utmctl="/Applications/UTM.app/Contents/MacOS/utmctl"

## SSH

# ssh-add /Users/aurels/.ssh/id_rsa >&/dev/null
# ssh-add /Users/aurels/.ssh/cloud.pem >&/dev/null
# ssh-add /Users/aurels/.ssh/reprtoir.pem >&/dev/null
# ssh-add /Users/aurels/.ssh/rvd-server-pilot.pem >&/dev/null

## zoxide/eza

zoxide init fish | source
alias cd=z
alias ls="eza -ali"

## Mise

/opt/homebrew/bin/mise activate fish | source
