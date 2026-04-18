function gwts --description "Switch to a git worktree"
    set selected (git worktree list | fzf --prompt="worktree> " | awk '{print $1}')
    if test -n "$selected"
        cd $selected
    end
end
