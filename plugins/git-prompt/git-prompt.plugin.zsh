# ZSH Git Prompt Plugin from:
# http://github.com/olivierverdier/zsh-git-prompt

__GIT_PROMPT_DIR="${0:A:h}"

## Hook function definitions
function chpwd_update_git_vars() {
    update_current_git_vars
}

function preexec_update_git_vars() {
    case "$2" in
        git*|hub*|gh*|stg*)
        __EXECUTED_GIT_COMMAND=1
        ;;
    esac
}

function precmd_update_git_vars() {
    if [ -n "$__EXECUTED_GIT_COMMAND" ] || [ ! -n "$ZSH_THEME_GIT_PROMPT_CACHE" ]; then
        update_current_git_vars
        unset __EXECUTED_GIT_COMMAND
    fi
}

chpwd_functions+=(chpwd_update_git_vars)
precmd_functions+=(precmd_update_git_vars)
preexec_functions+=(preexec_update_git_vars)


## Function definitions
function update_current_git_vars() {
    unset __CURRENT_GIT_STATUS

    local gitstatus="$__GIT_PROMPT_DIR/gitstatus.py"
    _GIT_STATUS=$(python ${gitstatus} 2>/dev/null)
     __CURRENT_GIT_STATUS=("${(@s: :)_GIT_STATUS}")
    GIT_BRANCH=$__CURRENT_GIT_STATUS[1]
    GIT_AHEAD=$__CURRENT_GIT_STATUS[2]
    GIT_BEHIND=$__CURRENT_GIT_STATUS[3]
    GIT_STAGED=$__CURRENT_GIT_STATUS[4]
    GIT_CONFLICTS=$__CURRENT_GIT_STATUS[5]
    GIT_CHANGED=$__CURRENT_GIT_STATUS[6]
    GIT_UNTRACKED=$__CURRENT_GIT_STATUS[7]
}

git_super_status() {
    precmd_update_git_vars
    if [ -n "$__CURRENT_GIT_STATUS" ]; then
      STATUS=" %{$fg_no_bold[yellow]%}⚡%{$fg_no_bold[magenta]%} $GIT_BRANCH%{${reset_color}%}"
      if [ "$GIT_BEHIND" -ne "0" ]; then
          STATUS="$STATUS %{↓%G%}$GIT_BEHIND%{${reset_color}%}"
      fi
      if [ "$GIT_AHEAD" -ne "0" ]; then
          STATUS="$STATUS %{↑%G%}$GIT_AHEAD%{${reset_color}%}"
      fi
      STATUS="$STATUS"
      if [ "$GIT_STAGED" -ne "0" ]; then
          STATUS="$STATUS %{$fg[red]%}%{●%G%}$GIT_STAGED%{${reset_color}%}"
      fi
      if [ "$GIT_CONFLICTS" -ne "0" ]; then
          STATUS="$STATUS %{$fg[red]%}%{✖%G%}$GIT_CONFLICTS%{${reset_color}%}"
      fi
      if [ "$GIT_CHANGED" -ne "0" ]; then
          STATUS="$STATUS %{$fg[cyan]%}%{✚%G%}$GIT_CHANGED%{${reset_color}%}"
      fi
      if [ "$GIT_UNTRACKED" -ne "0" ]; then
          STATUS="$STATUS %{…%G%}%{${reset_color}%}"
      fi
      if [ "$GIT_CHANGED" -eq "0" ] && [ "$GIT_CONFLICTS" -eq "0" ] && [ "$GIT_STAGED" -eq "0" ] && [ "$GIT_UNTRACKED" -eq "0" ]; then
          STATUS="$STATUS %{$fg_no_bold[green]%}%{✔%G%}"
      fi
      STATUS="$STATUS%{${reset_color}%}"
      echo "$STATUS"
    fi
}
