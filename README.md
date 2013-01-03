Guard::PHPUnit-sf2 [![Build Status](https://secure.travis-ci.org/liuggio/guard-phpunit-sf2.png)](http://travis-ci.org/liuggio/guard-phpunit-sf2) [![Dependency Status](https://gemnasium.com/liuggio/guard-phpunit-sf2.png?branch=master)](https://gemnasium.com/liuggio/guard-phpunit-sf2.png)
==============

Guard-phpunit-sf2 is just a fork of Guard-phpunit

The main goal is run guard-phpunit with Symfony2, the hope is to merge it with the original repo.

Q: This is Horrible why not PR the original fork?
A: This is a concept, I'll be very happy if you do it for me now,
   there are some logic difference that could be solved via options, I'd like to have enough time to do it.

If you want to see the differences between **guard-phpunit** and **guard-phpunit-sf2** here [Differences](https://github.com/liuggio/guard-phpunit-sf2/compare/master)


Guard::PHPUnit-sf2
==============


Guard-phpunit-sf2 allows you to automatically run [PHPUnit][6] tests when sources
are modified. It helps with integrating test-driven development (TDD) into
your development process: Just launch guard-phpunit before you start working
and it will notify you about the status of your tests!

*Note*: Although guard-phpunit-sf2 should work with any [PHP][7] version [PHPUnit][6] supports,
it has only been tested on [PHP][7] 5.3.8 and 5.4.4.

Install/Compile
-------

Please be sure to have [PHP][7], [PHPUnit][6] and [Ruby][1] installed on your machine before
you proceed with the installation.

guard-phpunit-sf2 has not been pushed on RubyGems. If you want to try it, clone the repository, build the gem and install it.

	git clone git@github.com:liuggio/guard-phpunit-sf2.git
	cd guard-phpunit-sf2
	gem build guard-phpunit-sf2.gemspec
	sudo gem instal guard-phpunit-sf2-0.1.4.gem

Usage
-----

Please read the [Guard usage documentation][3].

easy:

1. create the Guardfile as the example below then and put it in the root of your symfony2 project

2. then run `guard`

3. modify your files with your editor


Guardfile
---------

Guard-phpunit-sf2 can be used with any kind of [PHP][7] projects that uses PHPUnit as
its testing framwork. Please read the [Guard documentation][3] for more information
about the Guardfile DSL.

By default, guard-phpunit-sf2 will use the current working directory (pwd) to
search for tests and run them on start (if you enabled the `:all_on_start` option).

### Example PHP project

The [PHPUnit documentaion][4] uses the [Object Freezer][5] library as an example on how
to organize tests. This project uses the `Tests` directory for its tests.

An example of the Guardfile for the same project would look
something like:

```ruby

guard 'phpunit', :cli => '--colors -c app/' do
     # Watch tests files
     watch(%r{^src\/.+Test\.php$})

     # Watch src file and run its test,
     # Test string: src/Tvision/Bundle/CartBundle/Repository/CartRepository.php
     watch(%r{^src\/(.+)\/(.+)Bundle\/(.+)\.php$}) { |m| "src/#{m[1]}/#{m[2]}Bundle/Tests/#{m[3]}Test.php" } # Watch all files in your bundles and run the respective tests on change
end

```

Options
-------

The following options can be passed to Guard::PHPUnit:

```ruby
:all_on_start => false        # Run all tests on startup.
                              # default: true

:all_after_pass => false      # Run all tests after changed tests pass. This ensures
                              # that the process of making changed tests pass didn't
                              # break something else.
                              # default: true

:keep_failed => false         # Remember failed tests and keep running them with
                              # each change until they pass.
                              # default: true

:tests_path => 'tests'        # Relative path to the tests directory. This path
                              # is used when running all the tests.
                              # default: the current working directory (pwd)

:cli => '--colors -c app/'    # The options passed to the phpunit command
                              # when running the tests.
                              # default: nil

:enable_progress_formatter => true # enable a progress formatter
                              # default false

```

Author
------

[Maher Sallam](https://github.com/Maher4Ever)

[Giulio De Donato](https://github.com/liuggio)

[1]:http://ruby-lang.org
[3]:https://github.com/guard/guard#readme
[4]:http://www.phpunit.de/manual/current/en/
[5]:https://github.com/sebastianbergmann/php-object-freezer/
[6]:http://www.phpunit.de
[7]:http://php.net
