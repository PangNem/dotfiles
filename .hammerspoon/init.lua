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

function appLaunchOrFocus(name)
    return function()
        hs.application.launchOrFocus(name)
    end
end

--- quick open applications
--- https://zhiye.li/hammerspoon-use-the-keyboard-shortcuts-to-launch-apps-a7c59ab3d92
hs.hotkey.bind({"alt", "shift"}, "L", appLaunchOrFocus("RunJS"))

hs.hotkey.bind({"alt", "shift"}, ";", appLaunchOrFocus("Finder"))
hs.hotkey.bind({"alt", "shift"}, "space", appLaunchOrFocus("Iterm 2"))

hs.hotkey.bind({"alt", "shift"}, "V", appLaunchOrFocus("Visual Studio Code"))
hs.hotkey.bind({"alt", "shift"}, "I", appLaunchOrFocus("Intellij IDEA"))
hs.hotkey.bind({"alt", "shift"}, "W", appLaunchOrFocus("WebStorm"))
hs.hotkey.bind({"alt", "shift"}, "F", appLaunchOrFocus("Figma"))
--- hs.hotkey.bind({"alt", "shift"}, "X", appLaunchOrFocus("NoSQLBooster for MongoDB"))
hs.hotkey.bind({"alt", "shift"}, "X", appLaunchOrFocus("DataGrip"))
--- hs.hotkey.bind({"alt", "shift"}, "A", appLaunchOrFocus("Sequel Pro"))

--- hs.hotkey.bind({"alt", "shift"}, "A", appLaunchOrFocus("App Store"))
hs.hotkey.bind({"alt", "shift"}, "A", appLaunchOrFocus("Excalidraw"))

hs.hotkey.bind({"alt", "shift"}, "G", appLaunchOrFocus("Google Chrome"))

--- 크롬이랑 가까운키 남는거로
hs.hotkey.bind({"alt", "shift"}, "T", appLaunchOrFocus("Postman"))

hs.hotkey.bind({"alt", "shift"}, "Y", appLaunchOrFocus("Youtube"))
hs.hotkey.bind({"alt", "shift"}, ".", appLaunchOrFocus("Youtube Music"))
--- hs.hotkey.bind({"alt", "shift"}, "/", appLaunchOrFocus("Melon"))

hs.hotkey.bind({"alt", "shift"}, "E", appLaunchOrFocus("Microsoft Excel"))
hs.hotkey.bind({"alt", "shift"}, "N", appLaunchOrFocus("Notion"))
--- hs.hotkey.bind({"alt", "shift"}, "H", appLaunchOrFocus("HwpMac2014VIEWER.app"))
hs.hotkey.bind({"alt", "shift"}, "W", appLaunchOrFocus("WebStorm"))
hs.hotkey.bind({"alt", "shift"}, "R", appLaunchOrFocus("Preview"))
hs.hotkey.bind({"alt", "shift"}, "P", appLaunchOrFocus("Microsoft PowerPoint"))

hs.hotkey.bind({"alt", "shift"}, "K", appLaunchOrFocus("KakaoTalk"))
hs.hotkey.bind({"alt", "shift"}, "D", appLaunchOrFocus("Discord"))
hs.hotkey.bind({"alt", "shift"}, "O", appLaunchOrFocus("Docker"))
--- hs.hotkey.bind({"alt", "shift"}, "T", appLaunchOrFocus("Telegram"))
hs.hotkey.bind({"alt", "shift"}, "S", appLaunchOrFocus("Slack"))
hs.hotkey.bind({"alt", "shift"}, "M", appLaunchOrFocus("Messages"))

hs.hotkey.bind({"alt", "shift"}, "C", appLaunchOrFocus("Calendar"))
hs.hotkey.bind({"alt", "shift"}, "'", appLaunchOrFocus("TickTick"))

hs.hotkey.bind({"alt", "shift"}, ",", appLaunchOrFocus("System Preferences"))
hs.hotkey.bind({"alt", "shift"}, "h", appLaunchOrFocus("Hammerspoon"))
hs.hotkey.bind({"alt", "shift"}, "B", appLaunchOrFocus("Be Focused"))

hs.hotkey.bind({"alt", "shift"}, "J", appLaunchOrFocus("ChatGPT"))

function setVolumeZero()
    local currentNetwork = hs.wifi.currentNetwork()
    print(currentNetwork)

    if (currentNetwork == nil) then
        print('No network')
        return
    end

    -- 집 wifi면
    if currentNetwork == "KT_GiGA_5G_AF33" or currentNetwork == "KT_GiGA_Mesh_AF33" then
        print('집 wifi --------------------------------')
        return
    end

    local currentDevice = hs.audiodevice.defaultOutputDevice()
    if currentDevice:name() == "MacBook Pro 스피커" then
        print('볼륨 0으로 설정')
        print(currentDevice:name())
        print(currentNetwork)
        hs.audiodevice.defaultOutputDevice():setVolume(0)
    end
end

wifiWatcher = hs.wifi.watcher.new(setVolumeZero)
wifiWatcher:start()

-- 무조건 볼륨 0으로 설정
-- hs.audiodevice.defaultOutputDevice():setVolume(0)

