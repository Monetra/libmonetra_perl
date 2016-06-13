use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'MCVE',
    'VERSION_FROM'	=> 'MCVE.pm',
#    'PREREQ_FATAL'	=> TRUE,
#    'PREREQ_PM'		=> { 'Monetra' },
    ($] >= 5.005 ?
      (ABSTRACT_FROM => 'MCVE.pm',
       AUTHOR     => 'A. U. Thor <a.u.thor@a.galaxy.far.far.away>') : ()),
    'LIBS'		=> [''],
    'DEFINE'		=> '',
    'INC'		=> '', 
);
