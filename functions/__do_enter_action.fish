function __do_enter_action
  function is_exist_exa
    type exa > /dev/null 2>&1
    echo $status
  end

  function list_files
    echo
    echo (set_color yellow)"----- list files -----"(set_color normal)
    [ (is_exist_exa) -eq 0 ]; and exa -ahlG --git --sort Name --time-style long-iso; or command ls -alG
  end

  function git_status
    set --local is_git_repository (git rev-parse --is-inside-work-tree 2> /dev/null)
    [ -z $is_git_repository ]; and return 0
    [ $is_git_repository != 'true' ]; and return 0
    echo
    echo (set_color yellow)"----- git status -----"(set_color normal)
    git status --short --branch
    echo
  end

  function latest_git_commit
    [ -z (git config --get --local user.name 2> /dev/null) ]; and return 0
    [ -z (git log -n 1 --oneline --author=$user_name 2> /dev/null) ]; and return 0
    echo (set_color yellow)"----- last commit -----"(set_color normal)
    git log -n 1 --oneline --author=$user_name
  end

  [ -n $argv ]; and return 0
  list_files
  git_status
  latest_git_commit
  return 0
end
