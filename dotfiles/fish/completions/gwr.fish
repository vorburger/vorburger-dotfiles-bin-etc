complete -e gwr
complete -c gwr -f -a '(if test -d .worktrees; for i in .worktrees/*; string replace ".worktrees/" "" $i; end; end)'
