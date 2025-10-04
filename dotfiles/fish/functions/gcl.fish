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
