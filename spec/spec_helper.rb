$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'rspec'
require 'keepcon'
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

require_relative 'vcr_setup'

RSpec.configure do |config|
  config.after(:example) { Keepcon.contexts.clear }
end
