#!/usr/bin/env bash
#
# Toggle fcitx5

set -e

state=$(fcitx5-remote)

if [ "$state" = '0' ]; then
	echo "fcitx5 is closed"
	fcitx5-remote -e
	fcitx5-remote -r
	# wait fcitx5 to restart
	sleep 0.1
	fcitx5-remote -o
fi

fcitx5-remote -t
