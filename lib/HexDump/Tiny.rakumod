unit module HexDump::Tiny:ver<0.5>:auth<zef:raku-community-modules>;

proto sub hexdump(|) is export {*}

multi sub hexdump(Str() $string, *%_) {
    hexdump $string.encode, |%_
}

multi sub hexdump(Blob:D $blob, :$chunk-size = 16) {
    $blob.batch($chunk-size).kv.map: -> $k, @v {
        my $hex := @v.map(@v.elems %% 2
          ?? -> $a, $b  { sprintf("%02x%02x", $a, $b) }
          !! -> $a, $b? {
                $b ?? sprintf("%02x%02x", $a, $b) 
                   !! sprintf("%02x", $a)
             }
        ).join(" ");

        ($k * $chunk-size).fmt('%08x:  ')
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

HexDump::Tiny is module that exports a single subroutine C<hexdump>.

It takes a value of which to create a hexadecimal dump (either as
a C<Blob> or C<Buf> or as anything else that can be coerced to a
C<Str>), and an optional named argument C<:chunk-size> to indicate
the number of bytes to be grouped (default: 16).  It returns a
list of hexdump lines.

=head1 COMMAND-LINE INTERFACE

This module also installs a C<hd> command-line interface that allows
one to do a hexdump of a file, or the parameters on the command line,
or from STDIN (if no parameters are specified.

=head1 AUTHOR

Jonathan Scott Duff

Source can be located at: https://github.com/raku-community-modules/HexDump-Tiny .
Comments and Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2015 - 2017 Jonathan Scott Duff

Copyright 2018 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
