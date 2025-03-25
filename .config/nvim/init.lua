local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load("user.settings")
load("user.keybindings")
require("user.plugins")

