NOTES_FOLDER=~/.dmenu/notes

if [ -d $NOTES_FOLDER ]; then
	mkdir -p $NOTES_FOLDER
fi

LS_RESULT=$(ls -1 $NOTES_FOLDER)
FUZZEL_RESULT=$(printf "%s" "$LS_RESULT" | fuzzel -d)

FILE_LOCATION="$NOTES_FOLDER/$FUZZEL_RESULT"
DEFAULT_TEXT="Hello, this is a note!"

if echo "$LS_RESULT" | grep -wq "$FUZZEL_RESULT"; then
	xdg-open "$FILE_LOCATION"
elif [[ "$FUZZEL_RESULT" != "" ]]; then 
	touch "$FILE_LOCATION" && printf "%s" "$DEFAULT_TEXT" >> "$FILE_LOCATION" && xdg-open "$FILE_LOCATION"
fi


