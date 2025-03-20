function hyprss -d "My screenshot tool";
  set -l timestamp (date +'%y-%m-%d-%H%M%S')

  hyprshot --mode region --raw | satty --early-exit --copy-command "fish_clipboard_copy" --action-on-enter save-to-file -f - -o "$HOME/Pictures/Screenshots/$timestamp.png"
end
