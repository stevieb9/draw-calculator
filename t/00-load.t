#!perl
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Investment::Account::Calculator' ) || print "Bail out!\n";
}

diag( "Testing Investment::Account::Calculator $Investment::Account::Calculator::VERSION, Perl $], $^X" );
