function escape()
	local inputSource = hs.keycodes.currentSourceID()
    local inputEnglish = "com.apple.keylayout.UnicodeHexInput"

	if not (inputSource == inputEnglish) then
		hs.keycodes.currentSourceID(inputEnglish)
	end
	hs.eventtap.keyStroke({}, 'escape')
end

--- 현재 사용중인 키보드 이름 표시
hs.hotkey.bind({'cmd', 'control'}, 'i', function()
    local input_source = hs.keycodes.currentSourceID()
    print(input_source)
end)

--- ctrl + [ 키를 esc로 매핑 및 입력소스 변경
hs.hotkey.bind({'control'}, 33, escape)
hs.hotkey.bind({'cmd', 'control'}, 'delete', function()
    hs.eventtap.keyStroke({'shift'}, 'end')
    hs.eventtap.keyStroke({}, 'delete')
end)

function open_app(name)
    return function()
        hs.application.launchOrFocus(name)
    end
end

--- quick open applications
--- https://zhiye.li/hammerspoon-use-the-keyboard-shortcuts-to-launch-apps-a7c59ab3d92
hs.hotkey.bind({"alt", "shift"}, ";", open_app("Finder"))
hs.hotkey.bind({"alt", "shift"}, "space", open_app("Iterm"))

hs.hotkey.bind({"alt", "shift"}, "I", open_app("Intellij IDEA"))
hs.hotkey.bind({"alt", "shift"}, "V", open_app("Visual Studio Code"))
hs.hotkey.bind({"alt", "shift"}, "F", open_app("Figma"))

hs.hotkey.bind({"alt", "shift"}, "A", open_app("AnyDesk"))

hs.hotkey.bind({"alt", "shift"}, "G", open_app("Google Chrome"))

hs.hotkey.bind({"alt", "shift"}, "Y", open_app("Youtube"))
hs.hotkey.bind({"alt", "shift"}, ".", open_app("Youtube Music"))

hs.hotkey.bind({"alt", "shift"}, "E", open_app("Microsoft Excel"))
hs.hotkey.bind({"alt", "shift"}, "N", open_app("Notion"))
--- hs.hotkey.bind({"alt", "shift"}, "H", open_app("HwpMac2014VIEWER.app"))
hs.hotkey.bind({"alt", "shift"}, "W", open_app("Microsoft Word"))
hs.hotkey.bind({"alt", "shift"}, "R", open_app("Preview"))
hs.hotkey.bind({"alt", "shift"}, "P", open_app("Microsoft PowerPoint"))

hs.hotkey.bind({"alt", "shift"}, "K", open_app("KakaoTalk"))
hs.hotkey.bind({"alt", "shift"}, "D", open_app("Discord"))
hs.hotkey.bind({"alt", "shift"}, "O", open_app("Docker"))
hs.hotkey.bind({"alt", "shift"}, "T", open_app("Telegram"))
hs.hotkey.bind({"alt", "shift"}, "S", open_app("Slack"))
hs.hotkey.bind({"alt", "shift"}, "M", open_app("Messages"))

hs.hotkey.bind({"alt", "shift"}, "C", open_app("Calendar"))
hs.hotkey.bind({"alt", "shift"}, "'", open_app("TickTick"))

hs.hotkey.bind({"alt", "shift"}, ",", open_app("System Preferences"))
hs.hotkey.bind({"alt", "shift"}, "h", open_app("Hammerspoon"))
hs.hotkey.bind({"alt", "shift"}, "B", open_app("Be Focused"))

function setVolumeZero()
    hs.audiodevice.defaultOutputDevice():setVolume(0)
end

wifiWatcher = hs.wifi.watcher.new(setVolumeZero)
wifiWatcher:start()

hs.audiodevice.defaultOutputDevice():setVolume(0)
