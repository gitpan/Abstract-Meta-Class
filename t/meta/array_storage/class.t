
use strict;
use warnings;

use Test::More tests => 10;

{
    package SuperDummy;
    use Abstract::Meta::Class ':all';
    storage_type 'Array';
    has '$.x' => (default => 'x value');
    has '$.z' => (default => 'z value');

}

{
    package SubDummy;
    use base 'SuperDummy';
    use Abstract::Meta::Class ':all';
    storage_type 'Array';
    has '$.y';
    has '$.k';
}

    my $subclass = SubDummy->new;
    isa_ok($subclass,'SubDummy');
    is($subclass->x, 'x value', 'should have x value');
   

{
    package Custom;
    use Abstract::Meta::Class ':has';
    storage_type 'Array';
    has '$.a';
    Custom->meta->install_constructor;
    # or your own contructor
}

    my $custom = Custom->new;
    isa_ok($custom, 'Custom');
    

{
    package Initialise;
    use Abstract::Meta::Class ':all';
    storage_type 'Array';
    has '$.attr';
    Initialise->meta->set_initialise_method('init');;
    sub init {
        my ($self) = @_;
        $self->set_attr('initialise ...');
    }
}
    
    my $init = Initialise->new;
    is($init->attr,'initialise ...', 'should have initialise ...');
    
    
{
    package ClassA;
    use Abstract::Meta::Class ':all';
    storage_type 'Array';
    
    has '$.z' => (default => 0);
    abstract 'method1';

    my $classA = ClassA->new;
    ::isa_ok($classA , 'ClassA');
    eval {$classA->method1};
    ::like($@, qr{method1 is an abstract method}, 'catch an exception method1 is an abstract method');

    abstract_class;
    eval {ClassA->new;};
    ::like($@, qr{Can't instantiate abstract class}, 'can\'t instantiate abstract class');
}

{
    package ClassD;
    use Abstract::Meta::Class ':all';
    storage_type 'Array' , sub {my $class  = shift; bless [@_], $class} ;
    has '$.a';
    has '$.b';
}

    my $d = ClassD->new(121,1);
    isa_ok($d, 'ClassD');
    is($d->a, 121, 'should hava a attribute');
    is($d->b, 1, 'should hava b attribute');
