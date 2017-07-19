#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

function usage {
				echo "${bold}usage:${normal} $0 [option] [name]"
				echo "where option is one of:"
				echo -e "\t${bold}-f${normal}\t\tFollow log output."
				echo -e "\t${bold}-t [number]${normal}\ttail - show only last [number] of lines."
				echo -e "\t${bold}-s [duration]${normal}\tsince - show logs since a certain duration. [duration] is a go duration string in the format of 1h or 1m (for hours and minutes)."
				echo -e "${bold}[name]${normal}\toptional container name. if not given will be taken from container.name local file"
				exit	
}

while (( $# > 0 ))
do
	key="$1"
	case $key in 
		-f)
			ARG="-f"
		;;
		-t)
			if [[ $# > 1 ]]; then
				ARG="--tail $2"
				shift
			else
				usage
			fi
		;;
		-s)
			if [[ $# > 1 ]]; then
				ARG="--since $2"
				shift
			else
				usage
			fi
		;;
		*)
			if [ $# -eq 1 ]; then
				NAME="$1"
			else
				usage
			fi
		;;
	esac
	shift
done


if [[ -z "$NAME" ]]; then
        if [ -f container.name ]; then
                NAME=$(<container.name)
        else
                usage
        fi
fi

docker logs $ARG $NAME


