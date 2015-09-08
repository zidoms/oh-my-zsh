_icons=("⚞" "🎩" "🐳" "🐥" "⛵" "🚀" "🌁" "🎪" "🌠" "🎵" "👽" "🐉" "🐧")

_random_icon() {
	dayindex=$(date +"%d")
	echo $_icons[$dayindex%$#_icons+1]
}

PROMPT='%{$fg_bold[green]%}$(_random_icon)%b %{$fg_no_bold[blue]%}%n@%m $FG[186]%2~%{$reset_color%}$(git_super_status)
 → '
