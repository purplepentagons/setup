NOTES_FOLDER=~/.dmenu/notes

if [ -d $NOTES_FOLDER ]; then
	mkdir -p $NOTES_FOLDER
fi

LS_RESULT=$(ls -1 $NOTES_FOLDER)
FUZZEL_RESULT=$(printf "$LS_RESULT" | fuzzel -d)

if echo "$LS_RESULT" | grep -wq "$FUZZEL_RESULT"; then
	codium "$NOTES_FOLDER/$FUZZEL_RESULT"
elif [[ "$FUZZEL_RESULT" != "" ]]; then 
	touch "$NOTES_FOLDER/$FUZZEL_RESULT" && codium "$NOTES_FOLDER/$FUZZEL_RESULT"
fi
# switch to a better notes editor


