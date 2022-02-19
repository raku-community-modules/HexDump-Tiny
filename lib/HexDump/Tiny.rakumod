unit module HexDump::Tiny:ver<0.6>:auth<zef:raku-community-modules>;

proto sub hexdump(|) is export {*}

multi sub hexdump(Str() $string, *%_) {
    hexdump $string.encode, |%_
}

multi sub hexdump(Blob:D $blob, *%_) {
    hexdump $blob.Seq, |%_
}

multi sub hexdump(Seq:D $seq, :$skip, :$head, :$chunk-size = 16) {
    ($skip
      ?? $head
        ?? $seq.skip($skip).head($head)
        !! $seq.skip($skip)
      !! $head
        ?? $seq.head($head)
        !! $seq
    ).batch($chunk-size).kv.map: -> $k, @v {
        my $hex := @v.map(-> $a, $b? {
            $b ?? sprintf("%02x%02x", $a, $b)
               !! sprintf("%02x", $a)
        }).join(" ");

        (($skip // 0) + $k * $chunk-size).fmt('%08x:  ')
          ~ sprintf("%-*s", $chunk-size * 2 + $chunk-size div 2, $hex)
          ~ "  "
          ~ Blob.new(@v)
              .decode
              .subst("\n", '␤', :g)
              .subst(/<-print>/, '⋅', :g)
    }
}

=begin pod

=head1 NAME

HexDump::Tiny - Generate hexadecimal dump

=head1 SYNOPSIS

=begin code :lang<raku>

use HexDump::Tiny;

.say for hexdump(slurp("filename"));

=end code

=head1 DESCRIPTION

HexDump::Tiny is module that exports a single subroutine C<hexdump>,
and installs a command-line interface to that called C<hd>.

=head1 SUBROUTINES

=head2 hexdump

=begin code :lang<raku>

.say for hexdump($blob);                         # entire blob

.say for hexdump($blob, :skip(96));              # bytes after first 96 bytes

.say for hexdump($blob, :head(96));              # first 96 bytes

.say for hexdump($blob, :skip(96), :head(256));  # after 96 bytes for 256 bytes

=end code

The C<hexdump> subroutine takes a value of which to create a hexadecimal
dump (either as a C<Blob> or C<Buf>, or as a C<Seq> or as anything else
that can be coerced to a C<Str>).

It returns a C<Seq> of hexdump lines.  It takes the following optional
named arguments:

=head3 skip

The named argument C<:skip> specifies the number of bytes to skip before
starting to generate the hexdump.  The default is B<0>.

=head3 head

The named argument C<:head> specifies the number of bytes to create a
hexdump for.  The default is all remaining bytes after bytes skipped.

=head3 chunk-size

The named argument C<:chunk-size> specifies the number of bytes per
line of hexdump.  The default is B<16>.

=head1 COMMAND-LINE INTERFACE

This module also installs a C<hd> command-line interface that allows
one to do a hexdump of a file, or the parameters on the command line,
or from STDIN (if no parameters are specified.

It also accepts the same named arguments as the C<hexdump> subroutine
does.

=head1 AUTHORS

Jonathan Scott Duff

Elizabeth Mattijsen

Source can be located at: https://github.com/raku-community-modules/HexDump-Tiny .
Comments and Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2015 - 2017 Jonathan Scott Duff

Copyright 2018 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
