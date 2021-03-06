require 'guard'
require 'guard/guard'

module Guard

  # The PHPUnit guard gets notified about system
  # events.
  #
  class PHPUnit < Guard

    autoload :Inspector, 'guard/phpunit/inspector'
    autoload :Formatter, 'guard/phpunit/formatter'
    autoload :Notifier,  'guard/phpunit/notifier'
    autoload :Runner,    'guard/phpunit/runner'

    DEFAULT_OPTIONS = {
      :all_on_start   => true,
      :all_after_pass => true,
      :keep_failed    => true,
      :cli            => nil,
      :tests_path     => Dir.pwd,
      :enable_progress_formatter   => false,
    }

    # Initialize Guard::PHPUnit.
    #
    # @param [Array<Guard::Watcher>] watchers the watchers in the Guard block
    # @param [Hash] options the options for the Guard
    # @option options [Boolean] :all_on_start run all tests on start
    # @option options [Boolean] :all_after_pass run all tests after failed tests pass
    # @option options [Boolean] :keep_failed remember failed tests or not
    # @option options [String] :cli The CLI arguments passed to phpunit
    # @option options [String] :tests_path the path where all tests exist
    #
    def initialize(watchers = [], options = {})
      defaults = DEFAULT_OPTIONS.clone
      @options = defaults.merge(options)
      super(watchers, @options)

      @failed_paths     = []
      @previous_failed = false

      Inspector.tests_path = @options[:tests_path]
    end

    # Gets called once when Guard starts.
    #
    # @raise [:task_has_failed] when stop has failed
    #
    def start
      run_all if options[:all_on_start]
    end

    # Gets called when all tests should be run.
    #
    # @raise (see #start)
    #
    def run_all
      success = Runner.run(options[:tests_path], options.merge(
        :message => 'Running all tests'
      ))

      @previous_failed = !success
      throw :task_has_failed unless success
    end

    # Gets called when the watched tests have changes.
    #
    # @param [Array<String>] paths to the changed tests
    # @raise (see #start)
    #
    def run_on_changes(paths)
      paths = Inspector.clean(paths + @failed_paths)

      success = Runner.run(paths, options)
      update_failed_paths(success, paths)
      run_all_after_pass(success)

      throw :task_has_failed unless success
    end

    private

    # Adds or removes path to the failed_paths bassed
    # on the tests result.
    #
    # @param [Boolean] tests_passed whether the tests passed or not
    # @param [Array<String>] paths the tests paths
    #
    def update_failed_paths(tests_passed, paths)
      return unless @options[:keep_failed]

      if tests_passed
        @failed_paths -= paths
      else
        @failed_paths += paths
      end
    end

    # Runs all tests after the failed tests pass.
    #
    # @param (see .update_failed_paths)
    #
    def run_all_after_pass(tests_passed)
      return unless @options[:all_after_pass]

      if tests_passed
        run_all if @previous_failed
      else
        @previous_failed = true
      end
    end
  end
end
