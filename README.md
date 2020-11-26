Name
====

HexDump::Tiny

Synopsis
========

    #!/usr/bin/env raku

    use HexDump::Tiny;

    .say for hexdump(slurp("filename"));

Description
===========

Generate a hexdump from a scalar.
