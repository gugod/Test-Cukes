package Test::Cukes;
use strict;
use warnings;
use Exporter::Lite;
use Test::More;
use Test::Cukes::Feature;

our $VERSION = "0.01";
our @EXPORT = qw(feature runtests Given When Then);

my $steps = {};
my $feature = {};

sub feature {
    my $caller = caller;
    my $text = shift;

    $feature->{$caller} = Test::Cukes::Feature->new($text)
}

sub runtests {
    my $caller = caller;
    for my $scenario (@{$feature->{$caller}->scenarios}) {
        my %steps = %{$steps->{$caller}};
        for my $step_text (@{$scenario->steps}) {
            Test::More::note( $step_text );

            my (undef, $step) = split " ", $step_text, 2;
            while (my ($step_pattern, $cb) = each %steps) {
                if ($step =~ m/$step_pattern/) {
                    $cb->();
                    next;
                }
            }
        }
    }
}

sub _add_step {
    my ($step, $cb) = @_;
    my $caller = caller;
    $steps->{$caller}{$step} = $cb;
}

*Given = *_add_step;
*When = *_add_step;
*Then = *_add_step;

1;
__END__

=head1 NAME

Test::Cukes -

=head1 SYNOPSIS

  use Test::Cukes;

=head1 DESCRIPTION

Test::Cukes is

=head1 AUTHOR

Kang-min Liu E<lt>gugod@gugod.orgE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
