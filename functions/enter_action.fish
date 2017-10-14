function enter_action
  function is_exist_exa
    type exa > /dev/null 2>&1
    echo $status
  end

  [ -n $argv ]; and return 0
  echo
  echo (set_color yellow)"----- list files -----"(set_color normal)
  [ (is_exist_exa) -eq 0 ]; and exa -ahlG --git --sort Name --time-style long-iso; or ls -alG

  if [ (git rev-parse --is-inside-work-tree 2> /dev/null) = 'true' ]
    echo
    echo (set_color yellow)"----- git status -----"(set_color normal)
    git status --short --branch
  echo

  [ -z (git config --get --local user.name 2> /dev/null) ]; and return 0
  [ -z (git log -n 1 --oneline --author=$user_name 2> /dev/null) ]; and return 0
  echo (set_color yellow)"----- last commit -----"(set_color normal)
  git log -n 1 --oneline --author=$user_name

  return 0
end
