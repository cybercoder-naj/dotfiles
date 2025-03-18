if status is-interactive
  # Commands to run in interactive sessions can go here
end

# Disable greeting
set -g fish_greeting ""

set -gx EDITOR nvim
set -gx BROWSER zen-browser
set -gx BUN_INSTALL "$HOME/.bun"
set -gx JAVA_HOME ~/.jdks/corretto-21.0.6

fish_add_path -P "$BUN_INSTALL/bin" "$JAVA_HOME/bin"
