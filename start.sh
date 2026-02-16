#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

cd "$(dirname "${BASH_SOURCE[0]}")"
command -v cowsay &> /dev/null && cowsay -e 00 $USER has cowsay

ERROR(){
    printf "${RED}$1${NC}\n"
	for arg in "${@:2}"; do
		printf "\t${RED}$arg${NC}\n"
	done
}

if [[ -d "$1" ]] && [[ ! -z $1 ]] || [[ -f ./.opencvdirname ]]; then
    echo "opencv dir provided"
	if [[ ! -z $1 ]]; then
		echo -DCMAKE_PREFIX_PATH=$1 > ./.opencvdirname
	fi
else 
    ERROR "OPENCV DIR IS NOT PROVIDED" "OR PREFIX IS WRONG!"\
		"example ./start.sh ~/opencv4.13.0"
fi

DISTRO=$(lsb_release -i -s)
VERSION=$(lsb_release -r -s)
if [ $DISTRO != "Ubuntu" ] && [ $VERSION != "22.04" ]; then
	ERROR "Current version of ubuntu is not 22.04." \
		"Some things may broke. Skipping installation part." \
		"Is it endless?$"
else
	echo "Checking packages"
	packages_to_install=()
	REQQ="g++ cmake curl python3.10-venv"
	for pkg in $REQQ; do
		status=$(dpkg-query -W -f='${db:Status-Status}' "$pkg" 2>/dev/null)
		if [ "$status" != "installed" ]; then
			packages_to_install+=("$pkg")
		fi
	done
	if [ "${packages_to_install[*]}" != "" ]; then
		echo "The following packages are not installed: ${packages_to_install[*]}"
		read -p "Do you want to install them? (y/N) " ANS
		
		case "$ANS" in [yY]|[yY][eE][sS])
				sudo apt update && sudo apt install "${packages_to_install[@]}"
				;;
			*)
				echo "Installation cancelled"
				;;
		esac
	else
		echo "all packages already installed"
	fi
fi



./tools/simpbuild.sh
ls yolohw &>/dev/null || ln -s .build/yolohw yolohw
build_status=$?

echo loading model and video
./tools/load_env.sh

[ $build_status -eq 0 ] && echo "$(pwd)/yolohw was build" || ERROR "something gone wrong while building binary!!!" "READ THE LOGS OR BUILD BY YOURSELF"
