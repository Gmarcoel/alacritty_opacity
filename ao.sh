#!/bin/bash



n=$( grep -n background_opacity ~/.alacritty.yml | awk '{print $2}')
if [ $# -eq 0 ]; then
	echo "need an argument: u for increase opacity d to decrease number 0-1.0 to specific opacity"
	new=$n

elif [ $1 == '-h' ]
then
	echo "Script to change alacritty terminal opacity"
	echo "only one argument:"
	echo "	u: increase 0.1 opacity"
	echo "	d: decrease 0.1 opacity"
	echo "	n: any number from 0 to 1 to give a specific opacity"
	echo "		ex: 0.7"
elif [ $1 == 'u' ]
then
	new=$(echo $n 0.1 | awk '{print $1 + $2}')
	if [[ (( $new > '1.0' )) ]]
	then
	new=1
	fi
elif [ $1 == 'd' ]
then
	new=$(echo $n 0.1 | awk '{print $1 - $2}')
	if [[ (( $new == '-0.1' )) ]]
	then
		new=0
	fi
elif [[ (( $1 < '1.0' )) ]]
then
	new=$1
elif [[ (( $1 == '1' )) ]]
then
	new=$1
else
	new=$n
fi


sed "s/background_opacity:\s$n/background_opacity: $new/" -i ~/.alacritty.yml
