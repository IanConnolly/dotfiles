#!/usr/bin/env bash

music=$(osascript ~/dotfiles/applescripts/spotify.scpt)
weather=$(~/dotfiles/bin/ansiweather -a false -u metric -l "San Francisco,CA"  | cut -f1 -d "-" | sed 's/Current weather in //g' | sed 's/=> //' | sed 's/San Francisco //g')

if [[ $music ]]; then
  echo "$music |$weather"
else
  echo "$weather"
fi;
