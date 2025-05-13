#!/usr/bin/env bash
#
# Toggle fcitx5

state=$(fcitx5-remote)

if [ "$state" = '0' ]; then
	echo "fcitx5 is closed"
	exit 1
elif [ "$state" = '1' ]; then
	fcitx5-remote -t
else
	fcitx5-remote -T
fi
