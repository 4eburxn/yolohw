#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"
command -v cowsay &> /dev/null && cowsay -e 00 $USER has cowsay


DISTRO=$(lsb_release -i -s)
VERSION=$(lsb_release -r -s)
if [ $DISTRO != "Ubuntu" ] && [ $VERSION != "22.04" ]; then
    echo "Current version of ubuntu is ont 22.04. Some things may broke. Skipping installation part. Is it endless?"
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
	if [ ${packages_to_install[*]} != "" ]; then
		echo "The following packages are not installed: ${packages_to_install[*]}"
		read -p "Do you want to install them? (y/N) " ANS
		
		case "$answer" in [yY]|[yY][eE][sS])
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

echo loading model and video
./tools/load_env.sh

echo $(pwd)/yolohw was build
