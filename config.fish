# conf.d/ is auto-sourced before this file. See:
#   conf.d/aliases.fish          user aliases
#   conf.d/bindings.fish         keybindings
#   conf.d/postexec_handlers.fish  fish_postexec event handlers

# -----------------------------------------------------------------------------
# Profile & secrets
# -----------------------------------------------------------------------------
test -e ~/.config/fish/secrets.fish; and source ~/.config/fish/secrets.fish
test -e ~/.profile; and source ~/.profile
test -e ~/.fish_abbrs.fish; and source ~/.fish_abbrs.fish

# -----------------------------------------------------------------------------
# Prompt (hydro)
# -----------------------------------------------------------------------------
set --global hydro_symbol_prompt 🔥
set --global hydro_multiline true
set --global hydro_color_pwd $fish_color_param

# -----------------------------------------------------------------------------
# Editor
# -----------------------------------------------------------------------------
set -gx EDITOR nvim

# -----------------------------------------------------------------------------
# Language / tool env
# -----------------------------------------------------------------------------
set -x JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
set -x ANDROID_HOME $HOME/Library/Android/sdk
set -x DENO_INSTALL $HOME/.deno
set -x BUN_INSTALL $HOME/.bun
set -gx PNPM_HOME "$HOME/Library/pnpm"

# dbt
set -x DBT_PROFILES_DIR ~/.dbt
set -x DBT_ENV_SF_ACCOUNT eqt.west-europe.azure
set -x DBT_SALESFORCE_SCHEMA salesforce
set -x DBT_EBX_LAKE_SCHEMA ebx_public

# Docker
set -x DOCKER_HOST unix:///$HOME/.docker/run/docker.sock

# Dynamic linker
set -x DYLD_LIBRARY_PATH $DYLD_LIBRARY_PATH:/usr/local/lib

# -----------------------------------------------------------------------------
# PATH
# -----------------------------------------------------------------------------
# fish_add_path dedupes, skips missing dirs, and is idempotent.
#   -g  session (global) scope — config.fish is the source of truth
#   -P  write directly to $PATH instead of $fish_user_paths
#   -m  move already-present paths to the declared position (enforce order)
#   -a  append (fallback priority) instead of prepend
# Multiple args per call: first arg = highest priority.

# Prepend (take precedence over system PATH)
fish_add_path -gPm \
    $HOME/.local/bin \
    $HOME/.cargo/bin \
    $BUN_INSTALL/bin \
    $PNPM_HOME \
    /opt/homebrew/opt/coreutils/libexec/gnubin \
    /opt/homebrew/opt/postgresql@15/bin \
    /opt/homebrew/opt/fzf/bin \
    /Library/Frameworks/Python.framework/Versions/3.12/bin \
    /opt/homebrew/bin \
    /usr/local/bin

# Append (fallbacks — won't shadow tools above)
fish_add_path -gPam \
    $HOME/go/bin \
    $DENO_INSTALL/bin \
    $ANDROID_HOME/emulator \
    $ANDROID_HOME/platform-tools \
    "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

# Google Cloud SDK (provides its own PATH snippet)
if test -f "$HOME/google-cloud-sdk/path.fish.inc"
    source "$HOME/google-cloud-sdk/path.fish.inc"
end

# -----------------------------------------------------------------------------
# VS Code shell integration
# -----------------------------------------------------------------------------
string match -q "$TERM_PROGRAM" vscode
and . (code --locate-shell-integration-path fish)
