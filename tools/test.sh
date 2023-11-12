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
		printf %-18s "Testing ${i%% *}..."
		if command -v "${i%% *}" >/dev/null
		then
			job=
			for j in fg bg table
			do
				if $i "src/color.sh" "$j" >/dev/null 2>&1
				then
					esc=$green
				else
					esc=$red
				fi

				job="${job}${esc}${j}${reset} "
			done
		else
			job="${yellow}missing${reset}"
		fi
		printf %b "$job"
		printf '\n'
	done
}

testsh
