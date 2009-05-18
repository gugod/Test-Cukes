#!/usr/bin/env perl -w
use strict;
use Test::More tests => 4;
use Test::Cukes::Scenario;

my $scenario = Test::Cukes::Scenario->new(<<SCENARIO_TEXT);
Scenario: Some random scenario text
  Given the pre-conditions is there
  When it branches into the second level
  Then the final shall be reached
SCENARIO_TEXT

is($scenario->name, "Some random scenario text");
is_deeply($scenario->givens, ["the pre-conditions is there"]);
is_deeply($scenario->whens, ["it branches into the second level"]);
is_deeply($scenario->thens, ["the final shall be reached"]);
