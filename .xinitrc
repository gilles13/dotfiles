# vim:ft=conf
[[ -f ~/.Xresources ]] && xrdb -I$HOME ~/.Xresources &
xset +fp /usr/share/fonts/local &
~/.fehbg &
numlockx &
synclient VertTwoFingerScroll=1 &
synclient HorizTwoFingerScroll=1 &
synclient TapButton1=1 &
setxkbmap 'fr(latin9)' &
picom &
dunst &
export BROWSER=firefox
# pulseaudio --start &
while true; do
	xsetroot -name "$(date "+%a %d %b %H:%M")"
	sleep 2
done &
exec dwm & wmpid=$!
/home/gilles/scripts/notifremind &
wait $wmpid
