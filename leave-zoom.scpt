tell application "zoom.us"
  activate
  tell application "System Events"
    keystroke "w" using {command down}
  end tell
  tell application "System Events"
    tell front window of (first application process whose frontmost is true)
      click button 1
    end tell
  end tell
end tell
