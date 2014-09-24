use 5.014;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME            => "Attribute::RecordCallers",
    ABSTRACT        => 'Records callers of subroutines',
    VERSION_FROM    => "lib/Attribute/RecordCallers.pm",
    LICENSE         => 'perl',
    PREREQ_PM       => {
        'Test::More'    => 0,
    },
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources => {
            repository => {
                type => 'git',
                url  => 'https://github.com/rgs/Attribute-RecordCallers.git',
                web  => 'https://github.com/rgs/Attribute-RecordCallers',
            },
        },
    },
);
