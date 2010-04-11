#!/usr/bin/env perl -w
use strict;
use Test::Cukes;
use Test::More;

feature(<<FEATURE_TEXT);
Feature: foo
  In order to bleh
  I want to bleh

  Scenario: blehbleh
    Given I will say the word 'cake'
    When it is my birthday
    Then we will eat 28 cakes

  Scenario: Failed assertion leads to skipping remaining steps
    Given anything
    When I fail this step
    Then I skip this one

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

    ok 1, "Using is, ok, etc no longer screw up Cuke's test plan and cause"
      . " it to fail.";

    assert @passed        == 2;
    assert @regex_matches == 1
};

Then qr/we will eat (\d+) (.+)/ => sub {
    push @passed, 3;
    push @regex_matches, @_;

    assert @passed        == 3;
    assert @regex_matches == 3;

    is_deeply [1, 2, 3], \@passed, "Steps were called in the correct order";
    is_deeply ['cake', 28, 'cakes'], \@regex_matches, "Regex matches were"
      . " correctly passed to the step functions";
};


Given qr/anything/ => sub {
    assert "Anything is ok";
    ok 1, "passed Given";
};

When qr/fail/ => sub {
    assert 0 == 1;
};

Then qr/skip/ => sub {
    ok 0, "This shoudln't be executed at all!";
};

runtests;
