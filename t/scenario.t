#!/usr/bin/env perl -w
use strict;
use Test::More tests => 3;
use Test::Cukes::Scenario;

my $scenario = Test::Cukes::Scenario->new(<<SCENARIO_TEXT);
Scenario: Some random scenario text
  Given the pre-conditions is there
  When it branches into the second level
  Then the final shall be reached
SCENARIO_TEXT

is_deeply($scenario->given, ["the pre-conditions is there"]);
is_deeply($scenario->when, ["it branches into the second level"]);
is_deeply($scenario->then, ["the final shall be reached"]);
