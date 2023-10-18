#!/bin/sh
set -Cefu

usage() {
	printf '%s\n' 'color.sh [bg | fg | table] [char]'
	exit 1
} >&2

color_bg() {
	for y in 4 10
	do
		for z in 0 1 2 3 4 5 6 7
		do
			printf "\033[%s%sm   %s\033[0m" "$y" "$z" "$1"
		done
		printf '%b' '\n'
	done
}

color_fg() {
	for y in 0 1
	do
		for z in 0 1 2 3 4 5 6 7
		do
			printf "\033[%s;3%sm%s " "$y" "$z" "$1"
		done

		printf '%b' '\033[0m' '\n'
	done
}

color_table() {
	printf '%12s' 40m
	printf '%6s' 41m 42m 43m 44m 45m 46m 47m 48m
	printf '\n'

	for fgs in '   0' '   1' \
		'  30' '1;30' '  31' '1;31' \
		'  32' '1;32' '  33' '1;33' \
		'  34' '1;34' '  35' '1;35' \
		'  36' '1;36' '  37' '1;37'
	do
		fg=
		for w in $fgs
		do
			fg="$fg$w"
		done

		printf '%b' "  ${fgs}m \033[${fg}m  $1  "

		for bg in 40m 41m 42m 43m 44m 45m 46m 47m
		do
			printf ' %b' "\033[${fg}m\033[${bg}  $1  \033[0m"
		done

		printf '\n'
	done
}

main() {
	[ $# -ge 3 ] && usage

	case "${1:-table}" in
	bg)
		color_bg "${2:-}" ;;
	fg)
		color_fg "${2:-λ}" ;;
	table)
		color_table "${2:-λ}" ;;
	*)
		usage ;;
	esac
}

main "$@"
