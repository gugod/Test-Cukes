use inc::Module::Install;
name 'Test-Cukes';
all_from 'lib/Test/Cukes.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';

auto_include;
WriteAll;
