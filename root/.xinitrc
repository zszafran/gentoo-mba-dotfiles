xsetroot -cursor_name left_ptr &
xset s off &
xset -dpms &
xrdb -merge ~/.Xdefaults &
compton -b &
nitrogen --restore &
urxvtd --quiet --opendisplay --form &
#/opt/google/chrome/google-chrome --no-startup-window &
synapse &
#pulseaudio --start -D &
exec xmonad
