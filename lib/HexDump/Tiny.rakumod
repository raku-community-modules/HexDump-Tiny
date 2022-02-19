sub hexdump($value, :$chunk-size = 16) is export {
    $value.comb.batch($chunk-size, :partial).kv.map: -> $k, @v {
        my $hex := @v.map( -> $a, $b? {
            $b
              ?? sprintf("%02x%02x", $a.ord, $b.ord) 
              !! sprintf("%02x", $a.ord) 
        }).join(" ");

        ($k * $chunk-size).fmt('%08x:  ')
          ~ sprintf("%-*s", $chunk-size * 2 + $chunk-size div 2, $hex)
          ~ "  "
          ~ @v.map(*.subst(/<-print>/, '.', :g)).join;
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

It takes a value of which to create a hexadecimal dump, and an
optional named argument C<:chunk-size> to indicate the number of
bytes to be grouped (default: 16).  It returns a list of hexdump
lines.

=head1 AUTHOR

Jonathan Scott Duff

Source can be located at: https://github.com/raku-community-modules/HexDump-Tiny .
Comments and Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2015 - 2017 Jonathan Scott Duff

Copyright 2018 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
