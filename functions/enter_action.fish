function enter_action
	[ -n $argv ]; and return 0
	echo
	echo (set_color yellow)"----- list files -----"(set_color normal)
	ls -alG

	set -l file_changed (git rev-parse --is-inside-work-tree 2> /dev/null)
	if [ $file_changed = 'true' ]
		echo
		echo (set_color yellow)"----- git status -----"(set_color normal)
		git status --short --branch
		echo
	end

	set -l user_name (git config --get --local user.name)

	[ -z $user_name ]; and return 0
	[ -z (git log -n 1 --oneline --author=$user_name) ]; return 0

	echo (set_color yellow)"----- last commit -----"(set_color normal)
	git log -n 1 --oneline --author=$user_name
	return 0
end
