#!/bin/sh
set -Cefu

reset='\033[0m'
cyan='\033[36m'
under='\033[4m'

bench() {
	bin="$1" warm="$2" rep="$3"
	shift 3

	dir='./src'

	hf() {
		set -- -w"$warm" -r"$rep" -S none --style full \
			--sort mean-time --export-markdown - \
			-L shell bash,dash,ksh93,mksh,osh,oksh,posh,yash,'zsh -i'

		for subcmd in bg fg table
		do
			hyperfine "$@" "{shell} $dir/$bin $subcmd" 2>&1
		done
	}

	bench=$(hf | grep -v Warning | sed -e 's:\./src/::g')

	{
		printf '%b\n' "${under}${cyan}$bin benchmarks${reset}" ''
		printf '%s\n' "$bench"          |
			sed -n '/Benchmark /,/^$/p' |
				sed -n '/Summary/,/^$/p'
	} >> /dev/tty

	{
		printf '%s\n\n%s %s%b\n' "## \`$bin\` benchmarks" \
			'Commands are run as:' "\`<shell> -c $bin <cmd>\`" '\n'
		printf '%s\n' "$bench" |
			sed -n '/| Command /,/^$/p'  |
			awk -v RS='' -v bin="$bin" '{
				gsub(/(color\.sh|scolor\.sh| -i)/, "")
				gsub(/  (bg|fg|table)/, "")
				print "#### `" bin " " (NR == 1 ? "bg" : NR == 2 ? "fg" : "table") "`"
				print $0 "\n"
			}' |
			deno fmt --ext md -
	}
}

{
	bench color.sh  8 16
	bench scolor.sh 2 4
} >| doc/Benchmark.md
