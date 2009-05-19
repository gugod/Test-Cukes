#!/usr/bin/env perl -w
use strict;
use Test::More qw(no_plan);
use Test::Cukes;

feature(<<FEATURE_TEXT);
Feature: foo
  In order to bleh
  I want to bleh

  Scenario: blehbleh
    Given blah1
    When blah2
    Then blah3
FEATURE_TEXT

my @passed;

Given qr/blah1/ => sub {
    pass("blah 1");
    push @passed, 1;
};

When qr/blah2/ => sub {
    pass("blah 2");
    push @passed, 2;
};

Then qr/blah3/ => sub {
    pass("blah 3");
    push @passed, 3;
};

runtests;
is_deeply(\@passed, [1,2,3], "All step handlers are invoked.");
