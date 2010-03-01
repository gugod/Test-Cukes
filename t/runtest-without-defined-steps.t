#!/usr/bin/env perl -w
use strict;
use Test::Cukes;
use Test::More;

feature(<<FEATURE_TEXT);
Feature: foo
  In order to bleh
  I want to bleh

  Scenario: blehbleh
    Given I am a missing person
    When blah2
    Then blah3
FEATURE_TEXT

# This regex shouldn't match.
my $hit_given = 0;
When qr/I am a missing (animal|alien)/i => sub {
  $hit_given = 1;
};

runtests;

is($hit_given, 0, "Correctly never ran the 'when' test"); 
ok(@Test::Cukes::missing_steps == 3);
pass; # one dummy

