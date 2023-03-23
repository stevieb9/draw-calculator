#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Investment::Account::Calculator;

Investment::Account::Calculator->to_app;