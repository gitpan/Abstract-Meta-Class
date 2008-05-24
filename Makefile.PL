
use ExtUtils::MakeMaker;
#auto_manifest;
WriteMakefile(
    NAME         => 'Abstract::Meta::Class',
    VERSION_FROM => 'lib/Abstract/Meta/Class.pm',
    DISTNAME     => 'Abstract-Meta-Class',
    PREREQ_PM    => { 
        'Carp'       => 0,
    },

    test	 => { TESTS => 't/*.t t/meta/*.t'},
    dist         => { COMPRESS => 'gzip', SUFFIX => 'gz' },
    clean        => { FILES => 'MANIFEST.bak' },
);
