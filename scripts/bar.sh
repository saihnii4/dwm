#!/bin/sh

_truncate() {
	str="${@}"

	if [ "${#str}" -gt 14 ]; then
		printf "%.14s..." "$str" 
	else
		printf "$str"
	fi
}

now() {
	printf "$(date +'%Y-%m-%d %H:%M:%S')"
}

mpd() {
	IFS=- read -r artist title <<< $(mpc current)
	printf " $(_truncate "$artist") - $(_truncate "$title")"
}

battery() {
	printf " $(cat /sys/class/power_supply/BAT1/status) - $(cat /sys/class/power_supply/BAT1/capacity)%%"
}

while [ true ]; do
	xsetroot -name "$(mpd) | $(now) | $(battery) "
	sleep 1;
done
