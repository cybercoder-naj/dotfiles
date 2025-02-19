if status is-interactive
    # Commands to run in interactive sessions can go here
end

# browser
set --export BROWSER "zen-browser"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# java
set --export JAVA_HOME ~/.jdks/corretto-21.0.6
set --export PATH $JAVA_HOME/bin $PATH
