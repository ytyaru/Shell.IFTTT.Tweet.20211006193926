#!/usr/bin/env bash
set -Ceu
#---------------------------------------------------------------------------
# IFTTTでTweetするAPIを作りそれをCURLで実行する。
# CreatedAt: 2021-10-02
#---------------------------------------------------------------------------
Run() {
	THIS="$(realpath "${BASH_SOURCE:-0}")"; HERE="$(dirname "$THIS")"; PARENT="$(dirname "$HERE")"; THIS_NAME="$(basename "$THIS")"; APP_ROOT="$PARENT";
	THIS_NAME=`basename "$BASH_SOURCE"`
	VERSION=0.0.1
	MESSAGE=
	IMAGE_URL=
	cd "$HERE"
	ParseCommand() {
		Help() { eval "echo -e \"$(cat help_ansi.txt)\""; }
		Version() { echo "$VERSION"; }
		[ -f 'error.sh' ] && . error.sh
		while getopts ":hvi:" OPT; do
		case $OPT in
			h) Help; exit 0;;
			v) Version; exit 0;;
			i) IMAGE_URL=$OPTARG; ;;
		esac
		done
		shift $(($OPTIND - 1))
		case $1 in
		-h|--help|help) Help; exit 0;;
		-v|--version|version) Version; exit 0;;
		esac
		for m in "$@"; do MESSAGE+="$m\n"; done
		MESSAGE="$(echo -e "$MESSAGE" | sed -e 's/[\r\n]\+//g')"
		[ $# -eq 0 ] && { Help; exit 1; } || :;
	}
	ParseCommand "$@"
	[ -f 'secret.sh' ] || Error 'secret.shファイルがありません。用意してください。'
	. secret.sh
	Tweet() { curl -X POST -H "Content-Type: application/json" -d '{"value1":"'"$MESSAGE"'"}' https://maker.ifttt.com/trigger/$IFTTT_EVENT_TWEET/with/key/$IFTTT_KEY; }
	TweetImg() { curl -X POST -H "Content-Type: application/json" -d '{"value1":"'"$MESSAGE"'", "value2":"'"$IMAGE_URL"'"}' https://maker.ifttt.com/trigger/$IFTTT_EVENT_TWEET_IMG/with/key/$IFTTT_KEY; }
	[ -z "$IMAGE_URL" ] && Tweet || TweetImg;
}
Run "$@"
