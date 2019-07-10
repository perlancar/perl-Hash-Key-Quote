package Hash::Key::Quote;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK = qw(
                       should_quote_hash_key
               );

sub should_quote_hash_key {
    my $str = shift;
    return 0 if $str =~ /\A-?[A-Za-z_]\w*\z/;
    return 0 if $str =~ /\A-?[1-9]\d{0,8}\z/;
    1;
}

1;
# ABSTRACT: Utility routines related to quoting of hash keys

=head1 DESCRIPTION


=head1 FUNCTIONS

=head2 should_quote_hash_key($str) => bool

Return true if C<$str> should be quoted as a hash key when placed before the fat
comma (C<< => >>) operator. According to the L<perlop> documentation:

 The "=>" operator (sometimes pronounced "fat comma") is a synonym for the comma
 except that it causes a word on its left to be interpreted as a string if it
 begins with a letter or underscore and is composed only of letters, digits and
 underscores. This includes operands that might otherwise be interpreted as
 operators, constants, single number v-strings or function calls. If in doubt
 about this behavior, the left operand can be quoted explicitly.

This means strings like C<"and"> or C<"v1"> need not be quoted.

But there are several other cases where a string needs not be quoted. For
example, numbers except in these cases:

 012        # perl will interpret it as a positive octal literal
 -012       # perl will interpret it as a negative octal literal
 1_000_000  # perl will strip the underscores from number
 -1_000_000 # ditto
 1_0e10     # ditto
 -1_0e10    # ditto
 +123       # perl will strip the + sign
 -+123      # ditto
 1e2        # perl will normalize it to "100"
 1_00a      # not a valid number, must be quoted

Another example is non-number string that begins with a dash and followed only
by letters/numbers/underscores, e.g. C<-foo>.

For simplicity, you should probably just always quote. But if you only want to
quote when necessary, this routine can help you.


=head1 SEE ALSO

L<perlop>

L<Data::Dump> from which this code is extracted.

=cut
