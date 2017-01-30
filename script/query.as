set spotify_active to false
set thePosition to 0
set theDuration to 1
set theTrack to "Not playing"
set theArtist to "Spotify"

tell application "Finder"
    if (get name of every process) contains "Spotify" then set spotify_active to true
end tell

if spotify_active then
    tell application "Spotify"
        if player state is playing then
            set theTrack to name of the current track
            set theArtist to artist of the current track
            set theAlbum to album of the current track
            set theDuration to duration of the current track /1000
            set thePosition to player position
        end if
    end tell
end if

on hex4(n)
    set digit_list to "0123456789abcdef"
    set rv to ""
    repeat until length of rv = 4
        set digit to (n mod 16)
        set n to (n - digit) / 16 as integer
        set rv to (character (1+digit) of digit_list) & rv
    end
    return rv
end

on encodeString(value)
    set rv to ""
    repeat with ch in value
        if id of ch = 34
            set quoted_ch to "\\\""
        else if id of ch = 92 then
            set quoted_ch to "\\\\"
        else if id of ch >= 32 and id of ch < 127
            set quoted_ch to ch
        else
            set quoted_ch to "\\u" & hex4(id of ch)
        end
        set rv to rv & quoted_ch
    end
    return "\"" & rv & "\""
end

return "{ \"progress\": " & thePosition & ", \"duration\": " & theDuration &", \"track\": " & encodeString(theTrack) & ", \"artist\": " & encodeString(theArtist) &" }"
