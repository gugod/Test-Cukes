package Test::Cukes::Scenario;
use Any::Moose;
use 5.010;

has name => (
    is => "rw",
    required => 1,
    isa => "Str"
);

has givens => (
    is => "rw",
    required => 1,
    isa => "ArrayRef[Str]"
);

has whens => (
    is => "rw",
    required => 1,
    isa => "ArrayRef[Str]"
);

has thens => (
    is => "rw",
    required => 1,
    isa => "ArrayRef[Str]"
);

sub BUILDARGS {
    my $class = shift;
    if (@_ == 1 && ! ref $_[0]) {
        my $scenario_text = shift;
        my $current_section = ""; # "whens", "givens", or "thens"
        my $args = {
            name => "",
            givens => [],
            whens => [],
            thens => []
        };

        for my $line (split /\n+/, $scenario_text) {
            given ($line) {
                when (/^Scenario:\s(.+)$/) {
                    $args->{name} = $1;
                }
                when (/^  (Given|When|Then)\s(.+)$/) {
                    $current_section = lc($1 . "s");
                    push @{$args->{ $current_section }}, $2;
                }
                when (/^  And\s(.+)$/) {
                    die "\"And\" cannot be the first statment in the scenario text"
                        unless defined $current_section;
                    push @{$args->{ $current_section }}, $1;
                }
            }
        }

        return $args;
    }

    return $class->SUPER::BUILDARGS(@_);
}

__PACKAGE__->meta->make_immutable;
no Any::Moose;
1;
