#!/usr/bin/env perl -w
use strict;
use Test::Cukes;
my @passed;

Given qr/blah1/ => sub {
    push @passed, 1;

    assert @passed == 1;
};

When qr/blah2/ => sub {
    push @passed, 2;
    assert @passed == 2;
};

Then qr/blah3/ => sub {
    push @passed, 3;
    assert @passed == 3;

    assert( @{[ 1, 2, 3 ]} == @passed );
};

runtests(<<FEATURE_TEXT);
Feature: foo
  In order to bleh
  I want to bleh

  Scenario: blehbleh
    Given blah1
    When blah2
    Then blah3
FEATURE_TEXT
