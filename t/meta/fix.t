
use strict;
use warnings;

use Test::More tests => 2;

#BUG 0.09-1
#deserialized object breaks on accessing array, hash attribute perl type.

{
    package SuperDummy;
    use Abstract::Meta::Class ':all';
    has '@.x' => (default => 'x value');
    has '%.z' => (default => 'z value');
}

my $obj = bless {}, 'SuperDummy';
my $x = $obj->x;
my $z = $obj->z;
is(ref($x), 'ARRAY', 'should have an array');
is(ref($z), 'HASH', 'should have a hash');
    
    