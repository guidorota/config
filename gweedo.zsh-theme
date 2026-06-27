#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
#
# Pure - A minimal and beautiful theme for oh-my-zsh
# Customized by Guido Rota (2016)
#
# Based on the custom Zsh-prompt of the same name by Sindre Sorhus. A huge
# thanks goes out to him for designing the fantastic Pure prompt in the first
# place! I'd also like to thank Julien Nicoulaud for his "nicoulaj" theme from
# which I've borrowed both some ideas and some actual code. You can find out
# more about both of these fantastic two people here:
#
# Sindre Sorhus
#   Github:   https://github.com/sindresorhus
#   Twitter:  https://twitter.com/sindresorhus
#
# Julien Nicoulaud
#   Github:   https://github.com/nicoulaj
#   Twitter:  https://twitter.com/nicoulaj
#
# ------------------------------------------------------------------------------

# Set required options
#
setopt prompt_subst

# Load required modules
#
autoload -Uz vcs_info
zmodload zsh/datetime # Provides $EPOCHSECONDS and the strftime builtin

# Set vcs_info parameters
#
zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' formats "%s/%b" "%%u%c"
zstyle ':vcs_info:*:*' actionformats "$FX[bold]%r$FX[no-bold]/%S" "%s/%b" "%u%c (%a)"

# Fastest possible way to check if repo is dirty
#
git_dirty() {
    # Check if we're in a git repo
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    # Check if it's dirty
    command git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo "*"
}

# Display information about the current repository
#
repo_information() {
    echo "%F{blue}${vcs_info_msg_0_%%/.}%F{8}$vcs_info_msg_1_`git_dirty` $vcs_info_msg_2_%f"
}

# Display information about the current folder
#
folder_info() {
    echo "$FX[bold]$FG[028]%~%f$FX[no-bold]"
}

# Convert a duration in seconds into a compact human readable string
# (e.g. 3725 -> "1h 2m 5s")
#
human_time() {
    local total=$1 human=""
    local days=$(( total / 86400 ))
    local hours=$(( total / 3600 % 24 ))
    local minutes=$(( total / 60 % 60 ))
    local seconds=$(( total % 60 ))
    (( days > 0 ))    && human+="${days}d "
    (( hours > 0 ))   && human+="${hours}h "
    (( minutes > 0 )) && human+="${minutes}m "
    human+="${seconds}s"
    echo "$human"
}

# Record when the current command starts executing
#
preexec() {
    cmd_timestamp=$EPOCHSECONDS
}

# Output additional information about paths, repos and exec time
#
precmd() {
    vcs_info # Get version control info before we start outputting stuff

    # Build the right-hand side: <time taken> @ <time command started>.
    # Only shown once a command has actually been run.
    local rprompt=""
    if (( cmd_timestamp )); then
        local elapsed=$(( EPOCHSECONDS - cmd_timestamp ))
        rprompt="%F{8}$(human_time $elapsed) @ $(strftime '%H:%M:%S' $cmd_timestamp)%f"
    fi
    unset cmd_timestamp # Reset so a bare <Enter> doesn't repeat stale timing

    # The folder/repo line is the first line of PROMPT so that RPROMPT, which
    # zsh aligns to the first prompt line, lines up with the pwd output.
    PROMPT="%F{yellow}%n@%m%f
$(folder_info) $(repo_information)
%(?.%F{magenta}.%F{red})❯%f " # Display a red prompt char on failure
    RPROMPT="$rprompt"

    print "" # Blank separator line above each prompt
}

# ------------------------------------------------------------------------------
#
# List of vcs_info format strings:
#
# %b => current branch
# %a => current action (rebase/merge)
# %s => current version control system
# %r => name of the root directory of the repository
# %S => current path relative to the repository root directory
# %m => in case of Git, show information about stashes
# %u => show unstaged changes in the repository
# %c => show staged changes in the repository
#
# List of prompt format strings:
#
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)
#
# ------------------------------------------------------------------------------
