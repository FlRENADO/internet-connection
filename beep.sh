#!/bin/bash

if ! which beep > /dev/null; then
  echo "beep package not installed! Please install it by typing sudo apt install beep"
  exit 1;
fi

function check {
  ping -w 1 -c 1 $1;
}


hosts=(`ip route | grep default | awk '{print $3}'` "google.com" "stackoverflow.com")


for (( ; ; )); do
  for item in "${hosts[@]}"; do

    echo " * Checking $item"

    if check $item > /dev/null; then
      echo "Connection is up"
    else
	echo "network is down or host is unreachable!"
	sudo echo -en "\a" > /dev/tty5
	sleep 1
	sudo echo -en "\a" > /dev/tty5
    fi
  done
  sleep 10
done
