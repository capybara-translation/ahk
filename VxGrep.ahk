CleanQuery(query)
{
   ; Replace linefeed characters and tabs with white-space characters.
   query := RegExReplace(query, "\r\n|\r|\n|\t", " ")
   ; Remove double quotes.
   query := RegExReplace(query, "\x22", "")
   ; Remove all leading and trailing white-space characters from the query.
   query := Trim(query)
   Return query
}
;--- Search for the selected text with VXGrep. ---;
vk1Dsc07B & p::
   ClipSaved := ClipboardAll
   Clipboard =
   Send, ^c
   ClipWait, 2, 1
   Clipboard := CleanQuery(Clipboard)
   ; Close all windows of VxGrep if any are open.
   GroupAdd, Group1, ahk_class TGrepFindForm
   GroupAdd, Group1, ahk_class TGrepMainForm
   WinClose, ahk_group Group1
   ; Supply the query to VxGrep. 
   ; Modify the VxGrep executable path and the search folder path to your liking.
   Run, "D:\Application\VXE100\VxEditor\VxGrep.exe" "C:\Users\junya\Desktop\searchfolder" /f"%Clipboard%"
   Sleep 300 ; Should be adjusted.
   Send, {Enter}
   Clipboard := ClipSaved
   ClipSaved =
   Return

