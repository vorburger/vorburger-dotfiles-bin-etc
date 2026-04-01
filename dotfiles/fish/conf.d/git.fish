function gacp --argument-names MESSAGE --wraps git --description 'git add . && git commit -m .. && git push'
  git add .
  git commit -m $MESSAGE
  git push
end

function gac --argument-names MESSAGE --wraps git --description 'git add . && git commit -m'
  git add .
  git commit -m $MESSAGE
end

function gsts --description 'git status on repos in all sub-directories'
  find . -name .git -type d -exec sh -c 'echo -e "\n\n{}" && git --git-dir={} --work-tree={}/.. status' \;
end

function gw --description 'git worktree add into .worktrees/'
  if not test -d .worktrees
    mkdir .worktrees
  end
  git worktree add .worktrees/$argv[1] $argv[2..-1]
end

function gwl --description 'git worktree list'
  git worktree list $argv
end

function gwr --description 'git worktree remove'
  git worktree remove $argv
end