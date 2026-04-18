source ~/.config/fish/functions/post-exec-newline.fish

function postexec-source-profile --on-event fish_postexec
    set command_line (echo $argv | string collect | string trim)

    if string match -qr "^$EDITOR " $command_line
        set file (echo $command_line | coln 2 | string replace '~' $HOME)
        for config_file in ~/.profile ~/.config/fish/config.fish
            if test (realpath -- $file) = (realpath $config_file)
                echo -n "Sourcing "(echo $file | unexpand-home-tilde)"... "
                source $file
                echo done.
            end
        end
    end
end

# TODO rewrite this using event emitters
function save-error --on-event fish_postexec
    set exit_status $status
    set cancel_status 130

    if not contains $exit_status 0 $cancel_status && \
      not startswith retry "$argv" && \
      not startswith sudo-retry "$argv"
        set -g failed_command "$argv"
    end
end

function save-edited-file --on-event fish_postexec
    set command_line (echo $argv | string collect | string trim)
    if string match -qr "^($EDITOR|edit) " "$command_line"
        set -g editor_command $argv
    end
end

function try-help-man --on-event fish_postexec
  if startswith man "$argv"
    set command (echo $argv | cut -d ' ' -f 2)
    $command --help
  end
end
