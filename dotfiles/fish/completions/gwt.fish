complete -e gwt
complete -c gwt -f -a '(if test -d .worktrees; for i in .worktrees/*; string replace ".worktrees/" "" $i; end; end)'