#!/bin/sh
set -Cefu

usage() {
	printf '%s\n' 'color.sh [bg | fg | table] [char]'
	exit 1
} >&2

# Uses:
#   `printf` - bash, dash, ksh93, posh, yash, zsh
#   `print` - mksh, oksh, pdksh
#   `{n1..n2}` - bash, zsh, ksh93
set_sh() {
	brace_e=false

	# shellcheck disable=SC2059
	sprint() {
		printf "$@"
	}

	sprintln() {
		printf '\n'
	}

	if [ -n "${BASH_VERSION+x}" ] || [ -n "${ZSH_VERSION+x}" ]
	then
		brace_e=true
	elif [ -n "${KSH_VERSION+x}" ]
	then
		case "$KSH_VERSION" in
		*'AJM'*) # ksh93
			brace_e=true
			;;
		*'MIRBSD'*|*'PD'*) # mksh, pdksh, oksh
			sprint() {
				print -nr -- "$@"
			}

			sprintln() {
				print -r --
			}
			;;
		esac
	fi
}

color_bg() {
	case $brace_e in
	true)
		# shellcheck disable=SC3009
		for y in 4 10
		do
			sprint "${esc}[$y%sm    ${esc}[0m" {1..7}
			sprintln
		done
		;;
	false)
		for y in 4 10
		do
			for z in 0 1 2 3 4 5 6 7
			do
				sprint "${esc}[${y}${z}m    ${esc}[0m"
			done

			sprintln
		done
		;;
	esac
}

color_fg() {
	case $brace_e in
	true)
		# shellcheck disable=SC3009
		for y in 0 1
		do
			sprint "${esc}[$y;3%sm $1 ${esc}[0m" {1..7}
			sprintln
		done
		;;
	false)
		for y in 0 1
		do
			for z in 0 1 2 3 4 5 6 7
			do
				sprint "${esc}[${y};3${z}m$1 "
			done

			sprint "${esc}[0m"
			sprintln
		done
		;;
	esac
}

color_table() {
	arg=$1

	printf '%12s' 40m
	printf '%6s' 41m 42m 43m 44m 45m 46m 47m 48m
	sprintln

	set -- '   0' '   1' \
		'  30' '1;30' '  31' '1;31' \
		'  32' '1;32' '  33' '1;33' \
		'  34' '1;34' '  35' '1;35' \
		'  36' '1;36' '  37' '1;37'

	case $brace_e in
	true)
		# shellcheck disable=SC3009
		for fgs
		do
			fg=
			for w in $fgs
			do
				fg="$fg$w"
			done

			printf '%b' "  ${fgs}m ${esc}[${fg}m  $arg  "
			printf " ${esc}[${fg}m${esc}[4%sm  $arg  ${esc}[0m" {0..7}
			printf '\n'
		done
		;;
	false)
		for fgs
		do
			fg=
			for w in $fgs
			do
				fg="$fg$w"
			done

			sprint "  ${fgs}m ${esc}[${fg}m  $arg  "

			for bg in 0 1 2 3 4 5 6 7
			do
				sprint "${esc}[${fg}m ${esc}[4${bg}m  $arg  ${esc}[0m"
			done

			sprintln
		done
		;;
	esac
}

main() {
	[ $# -ge 3 ] && usage

	# shellcheck disable=SC3003
	esc=$'\033' && [ ${#esc} = 1 ] || esc=$(printf '\033')

	set_sh

	case "${1:-table}" in
	bg)
		color_bg "${2:-}" ;;
	fg)
		color_fg "${2:-λ}" ;;
	table)
		color_table "${2:-λ}" ;;
	*)
		table ;;
	esac
}

main ${1+"$@"}
