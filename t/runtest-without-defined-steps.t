#!/usr/bin/env perl -w
use strict;
use Test::Cukes;
use Test::More;

feature(<<FEATURE_TEXT);
Feature: foo
  In order to bleh
  I want to bleh

  Scenario: blehbleh
    Given blah1
    When blah2
    Then blah3
FEATURE_TEXT

runtests;

ok(@Test::Cukes::missing_steps == 3);
pass; # two dummise
pass;
