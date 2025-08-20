#!/usr/bin/env zsh

set -eo pipefail

PROJECT_DIR="$HOME/Dev/ruby/reprtoir/core"

alias wezterm=/Applications/WezTerm.app/Contents/MacOS/wezterm

run_command() {
    local pane_id
    local command_to_run
    pane_id="$1"
    command_to_run="$2"

    # https://github.com/wez/wezterm/discussions/2202#discussioncomment-3052321
    echo -e "$command_to_run\n" | wezterm cli send-text --no-paste --pane-id "$pane_id"
}

foreman_pane=$(wezterm cli spawn --cwd "$PROJECT_DIR")
log_pane=$(wezterm cli spawn --cwd "$PROJECT_DIR")
sidekiq_pane=$(wezterm cli split-pane --right --pane-id "$log_pane")
console_pane=$(wezterm cli spawn --cwd "$PROJECT_DIR")
git_pane=$(wezterm cli spawn --cwd "$PROJECT_DIR")

run_command "$foreman_pane" 'foreman start -f Procfile.dev'
run_command "$log_pane" 'tail -f log/development.log'
run_command "$sidekiq_pane" 'touch tmp/restart.txt && bundle exec sidekiq -c 1'
run_command "$console_pane" 'bundle exec rails console'
run_command "$git_pane" 'git status'

wezterm cli set-tab-title --pane-id "$foreman_pane" "foreman + docker"
wezterm cli set-tab-title --pane-id "$log_pane" "logs + sidekiq"
wezterm cli set-tab-title --pane-id "$console_pane" "rails console"
wezterm cli set-tab-title --pane-id "$git_pane" "git"

echo "Reprtoir launched"

wezterm cli kill-pane
