xrdb ~/.Xresources
# xmodmap ~/.Xmodmap
~/.fehbg

while true; do
	BATT=$(cat /sys/class/power_supply/BAT1/capacity)
	BATTSTAT=""
	MEM=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')
	TEMP=$(sensors | awk '/^temp1/ {print $2}' | awk NR==1)
	UPD="0"
	DISK=$(df -h | awk '/^\/dev\/sda3/ {print $3 "/" $2 " ("$5")"}')

	[ "$(checkupdates | wc -l)" ] && UPD=$(checkupdates | wc -l)

	[ "$(cat /sys/class/power_supply/BAT1/status)" = "Charging" ] && BATTSTAT=" ^"

	#xsetroot -name "UPDT: $UPD | SSD: $DISK | CPU: $TEMP | MEM: $MEM | $(date '+%D, %R') | BATT: $BATT%$BATTSTAT"
	xsetroot -name "󰇚 $UPD | 󰨣 $DISK |  $TEMP |  $MEM |  $(date '+%D, %R') |  $BATT%$BATTSTAT"

	sleep 30
done &
exec dwm
