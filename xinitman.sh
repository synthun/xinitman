#!/bin/sh -e

log() { printf '\033[1;95m%s %b%s\033[m %s\n' "${3:-->}" "\033[m${2:+\033[1;35m}" "$1" "$2" >&2 ; }  
die() { log "$1" "$2" ERROR ; exit "${3:-1}" ; }

new() {
	[ -d "$presetdir"/"$1" ] && die "preset $1 already exists" || \
		mkdir -p "$presetdir"/"$1"
		touch "$presetdir"/"$1"/.xinitrc
		log "created new preset $1 at $presetdir/$1"
}

del() {
	[ ! -d "$presetdir"/"$1" ] && die "preset $1 does not exist" || \
		rm -rfv "$presetdir"/"$1"
		log "deleted preset $1 at $presetdir/$1"
}

edit() {
	[ ! $EDITOR ] && die '$EDITOR not set'
	[ ! -d "$presetdir"/"$1" ] && die "preset $1 does not exist" || \
		$EDITOR "$presetdir"/"$1/.xinitrc"
		log "$EDITOR $presetdir/$1/.xinitrc"
}

sett() {
	[ ! -d "$presetdir"/"$1" ] && die "preset $1 does not exist" || \
		cp -fv "$presetdir"/"$1" "$HOME/.xinitrc"
		log "set preset $1 at ~/.xinitrc"
}

main() {
	presetdir="$HOME/.local/share/xinitman"

	action=$1
    shift "$(($# != 0))"

	case $action in
		d|del) del "$@" ;;
		e|edit) edit "$@" ;;
		l|list) ls -la "$presetdir" ;;
		n|new) new "$@" ;;
		s|set) sett "$@" ;;
		'')
			log 'xinitman [d|e|l|n|s] [preset name]...'
			log 'delete Delete existing preset'
			log 'edit   Edit existing preset'
			log 'list   List all existing presets'
			log 'new    Create new preset'
			log 'set    Copy existing preset to ~/.xinitrc'
		;;
	esac
}

main "$@"
