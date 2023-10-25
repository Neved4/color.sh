#!/bin/sh
set -Cefu

reset='\033[0m'
red='\033[31m'
green='\033[32m'
yellow='\033[33m'

testsh() {
	for i in bash dash ksh mksh osh oksh posh sh 'zsh -i' yash \
		tcsh elvish nsh nu ysh xonsh
	do
		if command -v "${i%% *}" >/dev/null
		then
			printf "%-18s" "Testing ${i%% *}..."
			job=

			for j in fg bg table
			do
				if $i "src/color.sh" "$j" >/dev/null 2>&1
				then
					e=$green
				else
					e=$red
				fi

				job="${job}${e}${j}${reset} "
			done

			printf '%b' "${job}"
		else
			printf %-18s "Testing ${i%% *}... "
			printf "%b" "${yellow}miss${reset}"
		fi
		printf '\n'
	done
}

testsh
