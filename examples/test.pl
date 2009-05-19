#!/usr/bin/env perl
use strict;
use warnings;

# test.pl
use Test::More;
use Test::Cukes;

feature(<<TEXT);
Feature: writing behavior tests
  In order to make me happy
  As a test maniac
  I want to write behavior tests

  Scenario: Hello World
    Given the test program is running
    When it reaches this step
    Then it should pass
TEXT

Given qr/the test program is running/, sub {
    pass("running");
};

When qr/it reaches this step/, sub {
    pass("reaches");
};

Then qr/it should pass/, sub {
    pass("passes");
};

plan tests => 3;
runtests;
