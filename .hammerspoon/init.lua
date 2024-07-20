function escape()
	local inputSource = hs.keycodes.currentSourceID()
	local inputEnglish = "com.apple.keylayout.UnicodeHexInput"

	if not (inputSource == inputEnglish) then
		hs.keycodes.currentSourceID(inputEnglish)
	end
	hs.eventtap.keyStroke({}, "escape")
end

--- 현재 사용중인 키보드 이름 표시
hs.hotkey.bind({ "cmd", "control" }, "i", function()
	local input_source = hs.keycodes.currentSourceID()
	print(input_source)
end)

--- ctrl + [ 키를 esc로 매핑 및 입력소스 변경
hs.hotkey.bind({ "control" }, 33, escape)
hs.hotkey.bind({ "cmd", "control" }, "delete", function()
	hs.eventtap.keyStroke({ "shift" }, "end")
	hs.eventtap.keyStroke({}, "delete")
end)

function appLaunchOrFocus(name)
	return function()
		hs.application.launchOrFocus(name)
	end
end

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "R", function()
	hs.reload()
end)
hs.alert.show("Config loaded")

--- quick open applications
--- https://zhiye.li/hammerspoon-use-the-keyboard-shortcuts-to-launch-apps-a7c59ab3d92
--- hs.hotkey.bind({"alt", "shift"}, "L", appLaunchOrFocus("RunJS"))
hs.hotkey.bind({ "alt", "shift" }, ";", appLaunchOrFocus("Finder"))
hs.hotkey.bind({ "alt", "shift" }, "space", appLaunchOrFocus("Iterm 2"))

hs.hotkey.bind({ "alt", "shift" }, "V", appLaunchOrFocus("Visual Studio Code"))
hs.hotkey.bind({ "alt", "shift" }, "I", appLaunchOrFocus("Intellij IDEA"))
hs.hotkey.bind({ "alt", "shift" }, "W", appLaunchOrFocus("yes24_ebook.app"))
--- hs.hotkey.bind({"alt", "shift"}, "W", appLaunchOrFocus("WebStorm"))
hs.hotkey.bind({ "alt", "shift" }, "F", appLaunchOrFocus("Figma"))
hs.hotkey.bind({ "alt", "shift" }, "X", appLaunchOrFocus("DataGrip"))

hs.hotkey.bind({ "alt", "shift" }, "Q", appLaunchOrFocus("App Store"))
hs.hotkey.bind({ "alt", "shift" }, "A", appLaunchOrFocus("Structured"))
hs.hotkey.bind({ "alt", "shift" }, "/", appLaunchOrFocus("Excalidraw"))
hs.hotkey.bind({ "alt", "shift" }, "U", appLaunchOrFocus("YES24_eBook"))

hs.hotkey.bind({ "alt", "shift" }, "G", appLaunchOrFocus("Arc"))

--- 크롬이랑 가까운키 남는거로
hs.hotkey.bind({ "alt", "shift" }, "T", appLaunchOrFocus("Telegram"))
hs.hotkey.bind({ "alt", "shift" }, "[", appLaunchOrFocus("Postman"))

hs.hotkey.bind({ "alt", "shift" }, "Y", appLaunchOrFocus("Youtube"))
hs.hotkey.bind({ "alt", "shift" }, ".", appLaunchOrFocus("Youtube Music"))
hs.hotkey.bind({ "alt", "shift" }, "E", appLaunchOrFocus("Microsoft Excel"))
hs.hotkey.bind({ "alt", "shift" }, "N", appLaunchOrFocus("Notion"))
--- hs.hotkey.bind({"alt", "shift"}, "H", appLaunchOrFocus("HwpMac2014VIEWER.app"))
hs.hotkey.bind({ "alt", "shift" }, "R", appLaunchOrFocus("Preview"))
hs.hotkey.bind({ "alt", "shift" }, "P", appLaunchOrFocus("Microsoft PowerPoint"))

hs.hotkey.bind({ "alt", "shift" }, "K", appLaunchOrFocus("KakaoTalk"))
hs.hotkey.bind({ "alt", "shift" }, "D", appLaunchOrFocus("Discord"))
hs.hotkey.bind({ "alt", "shift" }, "O", appLaunchOrFocus("Docker"))
--- hs.hotkey.bind({"alt", "shift"}, "T", appLaunchOrFocus("Telegram"))
hs.hotkey.bind({ "alt", "shift" }, "S", appLaunchOrFocus("Slack"))
hs.hotkey.bind({ "alt", "shift" }, "M", appLaunchOrFocus("Messages"))
hs.hotkey.bind({ "alt", "shift" }, "C", appLaunchOrFocus("Calendar"))
hs.hotkey.bind({ "alt", "shift" }, "'", appLaunchOrFocus("TickTick"))

hs.hotkey.bind({ "alt", "shift" }, ",", appLaunchOrFocus("System Preferences"))
hs.hotkey.bind({ "alt", "shift" }, "h", appLaunchOrFocus("Hammerspoon"))
hs.hotkey.bind({ "alt", "shift" }, "B", appLaunchOrFocus("Be Focused"))

hs.hotkey.bind({ "alt", "shift" }, "J", appLaunchOrFocus("Claude"))
