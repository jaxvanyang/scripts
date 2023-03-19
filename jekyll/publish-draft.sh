#!/usr/bin/env bash
#
# Publish Jekyll draft post.
#
# Usage:
#		publish-draft _drafts/<draft_file>
#
# Example:
# 	publish-draft _drafts/hello.md
# 	# is equivalent to
# 	mv _drafts/hello.md "_posts/$(date +%Y-%m-%d)-hello.md"

publish-draft() {
	draft_name="$(basename "$1")"
	post_name="_posts/$(date +%Y-%m-%d)-${draft_name}"

	mv "$1" "${post_name}"
}

main() {
	if [ $# -ne 1 ]; then
		echo 'You must specify the draft file argument!' >&2
		exit 1
	fi

	if [ ! -f "$1" ]; then
		echo "Draft file - $1 not found!" >&2
		exit 1
	fi

	publish-draft "$@"
}

main "$@"
