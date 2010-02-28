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
    push @regex_matches, @_;

    assert @passed        == 1;
    assert @regex_matches == 1
};

When qr/it is my birthday/ => sub {
    push @passed, 2;

    assert @passed        == 2;
    assert @regex_matches == 1
};

Then qr/we will eat (\d+) (.+)/ => sub {
    push @passed, 3;
    push @regex_matches, @_;

    assert @passed        == 3;
    assert @regex_matches == 3;

    # We can't use is_deeply because Test::More doesn't play nice with
    # Cukes's plan.
    assert 1 == $passed[0];
    assert 2 == $passed[1];
    assert 3 == $passed[2];

    assert 'cake'  eq $regex_matches[0];
    assert 28      == $regex_matches[1];
    assert 'cakes' eq $regex_matches[2];
};

runtests;
