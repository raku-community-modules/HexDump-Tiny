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

HexDump::Tiny is module that exports a single subroutine `hexdump`.

It takes a value of which to create a hexadecimal dump, and an optional named argument `:chunk-size` to indicate the number of bytes to be grouped (default: 16). It returns a list of hexdump lines.

COMMAND-LINE INTERFACE
======================

This module also installs a `hd` command-line interface that allows one to do a hexdump of a file, or the parameters on the command line, or from STDIN (if no parameters are specified.

AUTHOR
======

Jonathan Scott Duff

Source can be located at: https://github.com/raku-community-modules/HexDump-Tiny . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2015 - 2017 Jonathan Scott Duff

Copyright 2018 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

