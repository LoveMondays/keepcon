$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'rspec'
require 'keepcon'
require_relative 'vcr_setup'
