![Shell Script](https://img.shields.io/badge/Shell_Script-9DDE66?logo=gnubash&logoColor=000&style=for-the-badge)
[![POSIX.1%2D2017](https://img.shields.io/badge/POSIX.1&#8209;2017-6A737D?labelColor=6A737D&style=for-the-badge)](https://www.google.com)

# `color.sh` - terminal color tests in POSIX sh

![](graphics/color-sh.png)

###### Generated using [`agg`], colors by [`kanagawa.nvim`].

### Supported shells

|      Shell | Version       | Supported |
| ---------: | :------------ | :-------- |
|   [`bash`] | `5.2.15`      | Yes       |
|   [`dash`] | `0.5.12`      | Yes       |
|  [`ksh93`] | `93u+m/1.0.7` | Yes       |
|   [`mksh`] | `59c`         | Yes       |
|   [`oksh`] | `7.3`         | Yes       |
|   [`posh`] | `0.14.1`      | Yes[^1]   |
|   [`yash`] | `2.55`        | Yes       |
|    [`zsh`] | `5.9`         | Yes       |
| [`elvish`] | `0.19.2`      | No        |
|   [`fish`] | `3.6.1`       | No        |
|    [`nsh`] | `0.4.2`       | No        |
|     [`nu`] | `0.85.05`     | No        |
|   [`tcsh`] | `6.21.00`     | No        |

## Benchmarks

See [Benchmarks](doc/Benchmark.md).

## License

##### Original by [Daniel Crisman].

`grok.sh` is licensed under the terms of the MIT License.

See the [LICENSE](LICENSE) file for details.

[^1]: To accomodate `posh`, parameter substitution had to be used. \
See: [What does `${1+"$@"}` mean | Sven Mascheck](https://www.in-ulm.de/~mascheck/various/bourne_args/).

[`agg`]: https://github.com/asciinema/agg
[`kanagawa.nvim`]: https://github.com/rebelot/kanagawa.nvim
[Daniel Crisman]: https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
[`bash`]: https://git.savannah.gnu.org/cgit/bash.git/
[`dash`]: https://git.kernel.org/pub/scm/utils/dash/dash.git
[`ksh93`]: https://github.com/ksh93/ksh
[`mksh`]: https://github.com/MirBSD/mksh
[`oksh`]: https://github.com/ibara/oksh
[`posh`]: https://salsa.debian.org/clint/posh
[`yash`]: https://github.com/magicant/yash
[`zsh`]: https://github.com/zsh-users/zsh
[`elvish`]: https://github.com/elves/elvish
[`fish`]: https://github.com/fish-shell/fish-shell
[`nsh`]: https://github.com/nuta/nsh
[`nu`]: https://github.com/nushell/nushell
[`tcsh`]: https://github.com/freebsd/freebsd-src/tree/main/bin/csh
