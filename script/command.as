on run argv

    if count of argv is equal to 0 then
        set command to "toggle"
    else
        set command to item 1 of argv
    end if 

    set spotify_active to false

    tell application "Finder"
        if (get name of every process) contains "Spotify" then set spotify_active to true
    end tell

    if spotify_active then
        if command is equal to "toggle" then 
            tell application "Spotify"
                playpause
            end tell
        else if command is equal to "next" then
            tell application "Spotify" to next track
        else if command is equal to "prev" then
            tell application "Spotify" to previous track
        end if
    else
        tell application "Spotify" to activate
    end if

end run
