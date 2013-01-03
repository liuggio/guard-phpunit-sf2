guard 'rspec', :version => 2, :rvm => ['1.8.7@guard-phpunit-sf2', '1.9.3@guard-phpunit-sf2'] do
  watch('spec/spec_helper.rb') { 'spec' }
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/(.+)\.rb})     { |m| "spec/#{m[1]}_spec.rb" }
end
