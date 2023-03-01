hs.hotkey.alertDuration = 0
hs.window.animationDuration = 0
hs.hints.style = "vimperator"
hs.hints.showTitleThresh = 4
hs.hints.titleMaxSize = 10
hs.hints.fontSize = 30

-- ensure CLI installed
require "hs.ipc"
hs.ipc.cliInstall()

-- ModalMgr Spoon must be loaded explicitly, because this repository heavily relies upon it.
hs.loadSpoon("ModalMgr")

-- Load WinWin Spoons
hs.loadSpoon("WinWin")

-------------------------------------------------------------

-- resizeM modal environment
spoon.ModalMgr:new("resizeM")
local cmodal = spoon.ModalMgr.modal_list["resizeM"]
cmodal:bind('',      'escape',  'Deactivate resizeM',  function() spoon.ModalMgr:deactivate({"resizeM"})        end)
cmodal:bind('',      'Q',       'Deactivate resizeM',  function() spoon.ModalMgr:deactivate({"resizeM"})        end)
cmodal:bind('',      'tab',     'Toggle cheatsheet',   function() spoon.ModalMgr:toggleCheatsheet({"resizeM"})  end, nil,  function() spoon.ModalMgr:toggleCheatsheet()     end)
cmodal:bind('',      'A', 'Move Leftward',             function() spoon.WinWin:stepMove("left")                 end, nil,  function() spoon.WinWin:stepMove("left")         end)
cmodal:bind('',      'D', 'Move Rightward',            function() spoon.WinWin:stepMove("right")                end, nil,  function() spoon.WinWin:stepMove("right")        end)
cmodal:bind('',      'W', 'Move Upward',               function() spoon.WinWin:stepMove("up")                   end, nil,  function() spoon.WinWin:stepMove("up")           end)
cmodal:bind('',      'S', 'Move Downward',             function() spoon.WinWin:stepMove("down")                 end, nil,  function() spoon.WinWin:stepMove("down")         end)
cmodal:bind('',      'H', 'Lefthalf of Screen',        function() spoon.WinWin:moveAndResize("halfleft")        end)
cmodal:bind('',      'L', 'Righthalf of Screen',       function() spoon.WinWin:moveAndResize("halfright")       end)
cmodal:bind('',      'K', 'Uphalf of Screen',          function() spoon.WinWin:moveAndResize("halfup")          end)
cmodal:bind('',      'J', 'Downhalf of Screen',        function() spoon.WinWin:moveAndResize("halfdown")        end)
cmodal:bind('',      'Y', 'NorthWest Corner',          function() spoon.WinWin:moveAndResize("cornerNW")        end)
cmodal:bind('',      'O', 'NorthEast Corner',          function() spoon.WinWin:moveAndResize("cornerNE")        end)
cmodal:bind('',      'U', 'SouthWest Corner',          function() spoon.WinWin:moveAndResize("cornerSW")        end)
cmodal:bind('',      'I', 'SouthEast Corner',          function() spoon.WinWin:moveAndResize("cornerSE")        end)
cmodal:bind('',      'F', 'Fullscreen',                function() spoon.WinWin:moveAndResize("maximize")      end)
cmodal:bind('',      'C', 'Center Window',             function() spoon.WinWin:moveAndResize("center")          end)
cmodal:bind('',      '=', 'Stretch Outward',           function() spoon.WinWin:moveAndResize("expand")          end, nil, function() spoon.WinWin:moveAndResize("expand")   end)
cmodal:bind('',      '-', 'Shrink Inward',             function() spoon.WinWin:moveAndResize("shrink")          end, nil, function() spoon.WinWin:moveAndResize("shrink")   end)
cmodal:bind('shift', 'H', 'Resize Leftward',           function() spoon.WinWin:stepResize("left")               end, nil, function() spoon.WinWin:stepResize("left")        end)
cmodal:bind('shift', 'L', 'Resize Rightward',          function() spoon.WinWin:stepResize("right")              end, nil, function() spoon.WinWin:stepResize("right")       end)
cmodal:bind('shift', 'K', 'Resize Upward',             function() spoon.WinWin:stepResize("up")                 end, nil, function() spoon.WinWin:stepResize("up")          end)
cmodal:bind('shift', 'J', 'Resize Downward',           function() spoon.WinWin:stepResize("down")               end, nil, function() spoon.WinWin:stepResize("down")        end)
cmodal:bind('ctrl',  'H', 'Move to Left Monitor',      function() spoon.WinWin:moveToScreen("left")             end)
cmodal:bind('ctrl',  'L', 'Move to Right Monitor',     function() spoon.WinWin:moveToScreen("right")            end)
cmodal:bind('ctrl',  'K', 'Move to Above Monitor',     function() spoon.WinWin:moveToScreen("up")               end)
cmodal:bind('ctrl',  'J', 'Move to Below Monitor',     function() spoon.WinWin:moveToScreen("down")             end)
cmodal:bind('',      '[', 'Undo Window Manipulation',  function() spoon.WinWin:undo()                           end)
cmodal:bind('',      '`', 'Center Cursor',             function() spoon.WinWin:centerCursor()                   end)
cmodal:bind('',      'M', 'Move Mouse',
function()
  local screen = hs.mouse.getCurrentScreen()
	local nextScreen = screen:next()
	local rect = nextScreen:fullFrame()
	local center = hs.geometry.rectMidPoint(rect)

	hs.mouse.absolutePosition(center)
end)

-- Register resizeM with modal supervisor
local hyper={"ctrl", "alt", "cmd"}
local hsresizeM_keys = {hyper, "space"}
if string.len(hsresizeM_keys[2]) > 0 then
    spoon.ModalMgr.supervisor:bind(hsresizeM_keys[1], hsresizeM_keys[2], "Enter Control", function()
        -- Deactivate some modal environments or not before activating a new one
        spoon.ModalMgr:deactivateAll()
        -- Show an status indicator so we know we're in some modal environment now
        spoon.ModalMgr:activate({"resizeM"}, nil, false)
    end)
end

----------------------------------------------------------------------------------------------------
-- Finally we initialize ModalMgr supervisor
spoon.ModalMgr.supervisor:enter()
