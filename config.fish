set -x DENO_INSTALL /Users/subbu.alagappan/.deno
set -x PATH $PATH "$HOME/.volta/bin"
set -x PATH $PATH "/usr/local/bin"
set -x PATH $PATH "/opt/homebrew/bin"
set -x PATH $PATH "$HOME/.cargo/bin"
set -x PATH $PATH "/opt/homebrew/opt/coreutils/libexec/gnubin"
set -x PATH $PATH "$HOME/.local/bin"
set -x PATH $PATH "$DENO_INSTALL/bin" 
set -x PATH $PATH "$HOME/go/bin" 
set -x BUN_INSTALL "$HOME/.bun"
set -x PATH $BUN_INSTALL/bin $PATH

set -x NPM_TOKEN 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

set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -x PATH $PATH:$ANDROID_HOME/emulator
set -x PATH $PATH:$ANDROID_HOME/platform-tools

set --global hydro_symbol_prompt 🔥
set --global hydro_multiline true
set --global hydro_color_pwd $fish_color_param 

set -x DOCKER_HOST unix:///$HOME/.docker/run/docker.sock

set -x DBT_ENV_SF_ACCOUNT eqt.west-europe.azure

set -gx EDITOR nvim

# set --global ZELLIJ_AUTO_ATTACH true
# set --global ZELLIJ_AUTO_EXIT true

zoxide init fish | source
alias c=clear
alias cat=bat
alias ll="exa -lh"
alias grep=rg
alias icat="kitty +kitten icat"
alias vim="nvim"
alias v="nvim"
alias tmux="tmux -f \"$HOME/.config/tmux/tmux.conf\""
alias cloud-proxy-staging="~/scripts/cloud-proxy-staging/cloud-proxy-staging.sh"
alias cloud-proxy-prod="~/scripts/cloud-proxy-prod/cloud-proxy-prod.sh"
alias cloud-cluster-test="~/scripts/cloud-cluster-test.sh"
alias cloud-cluster-prod="~/scripts/cloud-cluster-prod.sh"
alias cloud-proxy-conveyor-stage="~/scripts/cloud-proxy-conveyor-staging/cloud-proxy-conveyor-staging.sh"
alias cloud-proxy-conveyor-prod="~/scripts/cloud-proxy-conveyor-prod/cloud-proxy-conveyor-prod.sh"

source $HOME/.config/fish/docker-aliases.fish

string match -q "$TERM_PROGRAM" "vscode"
and . (code --locate-shell-integration-path fish)

# Binds option-up
bind \e\[1\;5A history-token-search-backward
# Binds super-up (for emacs vterm integration, where there is no "option"
bind \e\[1\;2A history-token-search-backward

# option-down
bind \e\[1\;5B history-token-search-forward
# super-down
bind \e\[1\;2B history-token-search-forward

# Make C-t transpose characters :)
bind \ct transpose-chars

# Make C-s accept autocompletion and submit :))
bind \cs accept-autosuggestion execute

test -e ~/.profile && source ~/.profile
test -e ~/.fish_abbrs.fish && source ~/.fish_abbrs.fish

source ~/.config/fish/functions/post-exec-newline.fish

# if status is-interactive
#   # Commands to run in interactive sessions can go here
#   eval (zellij setup --generate-auto-start fish | string collect)
# end

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/subbu.alagappan/google-cloud-sdk/path.fish.inc' ]; 
  . '/Users/subbu.alagappan/google-cloud-sdk/path.fish.inc';
  source /Users/subbu.alagappan/google-cloud-sdk/path.fish.inc
end

exit 0

