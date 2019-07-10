#!perl

use 5.010001;
use strict;
use warnings;
use Test::More 0.98;

use Hash::Key::Quote qw(should_quote_hash_key);

ok(!should_quote_hash_key('123'));
ok(!should_quote_hash_key('foo'));
ok(!should_quote_hash_key('-foo'));

ok( should_quote_hash_key('+100'));
ok( should_quote_hash_key('012'));

done_testing;
