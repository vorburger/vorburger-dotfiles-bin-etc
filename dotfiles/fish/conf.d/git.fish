function gcl --description 'Clones a GitHub repository and cds into it.'
  if test (count $argv) -ne 1
    echo "Usage: gcl <owner/repo>" >&2
    return 1
  end

  set -l repo $argv[1]
  set -l script_path (realpath (status --current-filename))
  set -l script_dir (dirname "$script_path")
  set -l repo_root (realpath "$script_dir/../../../")
  set -l target_dir ($repo_root/git-clone.sh "$repo")
  if test $status -eq 0 && test -d "$target_dir"
    cd "$target_dir"
  else
    echo "Failed to clone or find directory for $repo: $target_dir" >&2
    return 1
  end
end

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
