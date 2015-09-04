_icons=("⚞" "🎩" "🐳" "🐥" "⛵" "🚀" "🌁" "🎪" "🌠" "🎵" "👽" "🐉" "🐧")

_random_icon() {
	dayindex=$(date +"%d")
	echo $_icons[$dayindex%$#_icons+1]
}

PROMPT='%{$fg_no_bold[green]%}$(_random_icon) %{$fg_no_bold[blue]%}%2~%{$reset_color%}$(git_super_status)
 → '
