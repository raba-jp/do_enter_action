function enter_action
	test -n $argv; and return 0
	echo
	echo (set_color yellow)"----- list files -----"(set_color normal)
	type exa > /dev/null 2>&1
	if test $status -eq 0
		exa -ahl --git --sort Name --time-style long-iso
	else
		ls -alG
	end

	set -l file_changed (git rev-parse --is-inside-work-tree 2> /dev/null)
	if test "$file_changed" = 'true'
		echo
		echo (set_color yellow)"----- git status -----"(set_color normal)
		git status --short --branch
		echo

		test -z (git config --get --local user.name 2> /dev/null); and return 0
		test -z (git log -n 1 --oneline --author=$user_name 2> /dev/null); and return 0
		echo (set_color yellow)"----- last commit -----"(set_color normal)
		git log -n 1 --oneline --author=$user_name
	end

	return 0
end
