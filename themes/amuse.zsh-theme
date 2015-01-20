function {
    if [[ -n "$SSH_CLIENT" ]]; then
        PROMPT_HOST=" ($HOST)"
    else
        PROMPT_HOST=''
    fi
}

# Ξ ⛄ 🙣 🙙 ⛇ ⛏ ⛱ ⛺ ⎰ 𝔉 𝔊 𝔈 ℌ 𝔍 𝔓 𝔗 𝝍 ℥
PROMPT='%{$fg_bold[green]%}⛱ %{$fg[blue]%}${PROMPT_HOST}%{$fg_bold[green]%}%p %{$fg_no_bold[yellow]%}%2~%{$reset_color%}$(git_super_status) → '
