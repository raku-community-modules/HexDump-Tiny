[![Actions Status](https://github.com/raku-community-modules/HexDump-Tiny/workflows/test/badge.svg)](https://github.com/raku-community-modules/HexDump-Tiny/actions)

NAME
====

HexDump::Tiny - Generate hexadecimal dump

SYNOPSIS
========

```raku
use HexDump::Tiny;

.say for hexdump(slurp("filename"));
```

DESCRIPTION
===========

HexDump::Tiny is module that exports a single subroutine `hexdump`, and installs a command-line interface to that called `hd`.

SUBROUTINES
===========

hexdump
-------

```raku
.say for hexdump($blob);                         # entire blob

.say for hexdump($blob, :skip(96));              # bytes after first 96 bytes

.say for hexdump($blob, :head(96));              # first 96 bytes

.say for hexdump($blob, :skip(96), :head(256));  # after 96 bytes for 256 bytes
```

The `hexdump` subroutine takes a value of which to create a hexadecimal dump (either as a `Blob` or `Buf`, or as a `Seq` or as anything else that can be coerced to a `Str`).

It returns a `Seq` of hexdump lines. It takes the following optional named arguments:

### skip

The named argument `:skip` specifies the number of bytes to skip before starting to generate the hexdump. The default is **0**.

### head

The named argument `:head` specifies the number of bytes to create a hexdump for. The default is all remaining bytes after bytes skipped.

### chunk-size

The named argument `:chunk-size` specifies the number of bytes per line of hexdump. The default is **16**.

COMMAND-LINE INTERFACE
======================

This module also installs a `hd` command-line interface that allows one to do a hexdump of a file, or the parameters on the command line, or from STDIN (if no parameters are specified.

It also accepts the same named arguments as the `hexdump` subroutine does.

AUTHORS
=======

Jonathan Scott Duff

Elizabeth Mattijsen

Source can be located at: https://github.com/raku-community-modules/HexDump-Tiny . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2015 - 2017 Jonathan Scott Duff

Copyright 2018 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

