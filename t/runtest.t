#!/usr/bin/env perl -w
use strict;
use Test::Cukes;

feature(<<FEATURE_TEXT);
Feature: foo
  In order to bleh
  I want to bleh

  Scenario: blehbleh
    Given I will say the word 'cake'
    When it is my birthday 
    Then we will eat 28 cakes 
FEATURE_TEXT

my @passed;
my @regex_matches;

Given qr/I will say the word '(.+)'/ => sub {
    push @passed, 1;
    push @regex_matches, shift;

    assert @passed        == 1;
    assert @regex_matches == 1
};

When qr/it is my birthday/ => sub {
    push @passed, 2;
    push @regex_matches, shift;

    assert @passed        == 2;
    assert @regex_matches == 2
};

Then qr/we will eat (\d+) (.+)/ => sub {
    push @passed, 3;
    push @regex_matches, shift, shift;

    assert @passed        == 3;
    assert @regex_matches == 4;
    assert( @{[ 1, 2, 3 ]} == @passed );
    assert( @{[ 'cake', undef, 27, 'cakes' ]} == @regex_matches);
};

runtests;
