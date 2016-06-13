use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'Monetra',
    VERSION_FROM => 'Monetra.pm', # finds \$VERSION
    AUTHOR       => 'Brad House (brad@monetra.com)',
    ABSTRACT     => 'Interfacing with Monetra',
    PREREQ_PM    => {
                     'Test::Simple' => 0.44, 
		     'IO::Socket' => 1.25,
		     'IO::Socket::SSL' => 0.96,
		     'IO::Select' => 1.17,
		     'MIME::Base64' => 2.06,
		     'Time::HiRes' => 1.02 
                    },
);
