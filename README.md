# `tmplr` - a template replacement tool

`tmplr` is a simple tool to achieve a minimum level of genericity in
[libvsync][], [Dice][], and other projects without resorting to C preprocessor
macros.

[libvsync]: https://github.com/open-s4c/libvsync
[Dice]: https://github.com/open-s4c/dice

## Quick Installation

Build `tmplr` with your favorite POSIX C toolchain (clang or gcc) using the
provided Makefile:

```sh
git clone https://github.com/open-s4c/tmplr.git
cd tmplr
make
sudo make PREFIX=/usr/local install    # optional
```

`make install` drops the binary, man page, and `include/tmplr.h` under the
chosen prefix. Set `DESTDIR` when packaging for a distro.

## Template

`tmplr` reads input files and replaces mappings in template blocks. Template
blocks are marked with `$_begin` and `$_end` commands.

For example:

    $_begin(key=value)
    The following word, key, will be replaced by value.
    $_end

Iteration mappings may take a single value as in `key=value1` or multiple
values as in `key=[[value1; value2]]`. The list of values is separated by
semicolumn and optionally sorrounded by `[[` and `]]`.  Consider the example:

    $_begin(key=[[val1;val2]])
    Key --> key
    $_end

The template expansion will generate one block for each iteration. In the first
iteration, `key=val1`, in the second iteration, the mapping is `key=val2`.

## Persistent mappings

Outside template blocks you can define mappings that apply everywhere by using
`$_map(KEY, VALUE)` (or `TMPL_map` if you change the prefix). tmplr applies
iteration mappings first and then these persistent mappings, so they behave like
global defaults or overrides for identifiers that appear across many blocks.

## Command line and mapping override

`tmplr` takes a list of files as input and writes the expanded result to
the standard output. It provides the following flags:

- `-v` for verbose output and
- `-D` to select a single value for an iteration mapping. For example,
  - `-D keyA=value1`. Other values will be ignored.
  - `-D key="value1;value2"` sets key to the list `value1;value2`
- `-P TMPL` change command prefix to `TMPL_begin`, `TMPL_end`, etc.
- `-i` takes input from stdin in addition to file names. stdin is the last
  input to be processed.

## Valid keys and values

`tmplr` **does not** tokenize the input. Hence, a key "two words" is a
perfectly valid key. Characters such as $ can also be used in keys and values.

The only restriction is that keys cannot contain

- new line: `\n`
- parenthesis: `(` `)`
- comma: `,`
- semicolon: `;`
- nor any `tmplr` commands

Values cannot contain parenthesis, commas nor semicolon.

## Disclaimer

We are aware of similar, more powerful tools such as Jinja, Mustache and M4.
`tmplr` follows three design principles:

- simplicity: as simple and maintainable as possible
- dependency freedom: no additonal language which will get deprecated
- c-syntax transperency: annotation should not interfer with the LSP

# Fuzzing `tmplr` with AFL

After installing AFL, compile `tmplr` with `afl-gcc`:

    make CC=afl-gcc

Then run AFL with the tests in the `test/` directory. Since the tests uses
`_tmpl` prefix, you have also to pass that argument to `tmplr`.

    afl-fuzz -i test -o results -m256 -- ./tmplr -P _tmpl @@
