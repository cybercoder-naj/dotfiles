function hyprscreenshot -d "Takes a screenshot and annotates it";
  hyprshot -m region --raw | satty --filename -
end
