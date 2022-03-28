hs.hints.showTitleThresh = 0
-- hs.hints.style="vimperator"

-- Windows Hints
local hswhints_keys = {{"alt"}, "tab"}
if string.len(hswhints_keys[2]) > 0 then
    spoon.ModalMgr.supervisor:bind(hswhints_keys[1], hswhints_keys[2], 'Show Window Hints', function()
        spoon.ModalMgr:deactivateAll()
        hs.hints.windowHints()
    end)
end

-- Move mouse to each screen
local hsmouse_keys = {{"ctrl", "alt", "cmd"}, "M"}
if string.len(hsmouse_keys[2]) > 0 then
	spoon.ModalMgr.supervisor:bind(hsmouse_keys[1], hsmouse_keys[2], "Move Mouse", function()
		local screen = hs.mouse.getCurrentScreen()
		local nextScreen = screen:next()
		local rect = nextScreen:fullFrame()
		local center = hs.geometry.rectMidPoint(rect)

		hs.mouse.absolutePosition(center)
	end)
end

