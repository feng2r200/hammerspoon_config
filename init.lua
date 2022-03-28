require "hs.ipc"

hs.hotkey.alertDuration = 0
hs.window.animationDuration = 0

-- ensure CLI installed
hs.ipc.cliInstall()

-- ModalMgr Spoon must be loaded explicitly, because this repository heavily relies upon it.
hs.loadSpoon("ModalMgr")

-- Load WinWin Spoons
hs.loadSpoon("WinWin")

-------------------------------------------------------------

require("mods/windowhint")
require("mods/basicmode")

----------------------------------------------------------------------------------------------------
-- Finally we initialize ModalMgr supervisor
spoon.ModalMgr.supervisor:enter()
