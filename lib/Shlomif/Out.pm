package Shlomif::Out;

use strict;
use warnings;

use parent 'Exporter';

our @EXPORT_OK = (qw(modify_on_change write_on_change write_on_change_no_utf8));

sub write_on_change
{
    my ( $io, $text_ref ) = @_;

    if ( ( !-e $io ) or ( $io->slurp_utf8() ne $$text_ref ) )
    {
        $io->spew_utf8($$text_ref);
    }

    return;
}

sub modify_on_change
{
    my ( $io, $sub_ref ) = @_;

    my $text = $io->slurp_utf8();

    if ( $sub_ref->( \$text ) )
    {
        $io->spew_utf8($text);
    }

    return;
}

sub write_on_change_no_utf8
{
    my ( $io, $text_ref ) = @_;

    if ( ( !-e $io ) or ( $io->slurp() ne $$text_ref ) )
    {
        $io->spew($$text_ref);
    }

    return;
}

1;

=head1 COPYRIGHT & LICENSE

Copyright 2017 by Shlomi Fish

This program is distributed under the MIT / Expat License:
L<http://www.opensource.org/licenses/mit-license.php>

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

=cut
