function push {
	remote="origin"
	branch="master"
	etc=""

	if [[ ! -z "$1" ]]; then
		remote=$1
	fi

	if [[ ! -z "$2" ]]; then
		branch=$2
	fi

	for arg in "${@:3}"; do
		etc+=$arg
	done

	git push $remote $branch $3
}

function pull {
	remote="origin"
	branch="master"
	etc=""

	if [[ ! -z "$1" ]]; then
		remote=$1
	fi

	if [[ ! -z "$2" ]]; then
		branch=$2
	fi

	for arg in "${@:3}"; do
		etc+=$arg
	done

	git pull $remote $branch $etc
}

