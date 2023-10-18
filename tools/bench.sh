#!/bin/sh
set -Cefu

cmd='./src/color.sh'

bench() {
	set -- -w8 -r16 -S none --style full --sort mean-time --export-markdown - \
		-L shell bash,dash,mksh,oksh,posh,sh,yash,'zsh -i'

	for subcmd in bg fg table
	do
		hyperfine "$@" "{shell} $cmd $subcmd" 2>&1
	done
}

bench=$(bench | grep -v Warning | sed -e 's:\./src/::g')

{
	printf '%s\n' "$bench"          |
		sed -n '/Benchmark /,/^$/p' |
			sed -n '/Summary/,/^$/p'
} >/dev/stdout

{
	printf '%s\n\n%s %s%b\n' "## \`color.sh\` benchmarks" \
		'Commands are run as:' "\`<shell> -c color.sh <cmd>\`" '\n'
	printf '%s\n' "$bench" |
		sed -n '/| Command /,/^$/p'  |
		awk -v RS='' '{
			gsub(/(color\.sh| -i)/, "")
			gsub(/  (bg|fg|table)/, "")
			print "#### `color.sh " \
				(NR == 1 ? "bg" : NR == 2 ? "fg" : "table") "`"
			print $0 "\n"
		}' |
		deno fmt --ext md -
} >| doc/Benchmark.md
