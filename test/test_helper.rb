require 'simplecov'
SimpleCov.start 'rails'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # hides sql output from unit tests
  ActiveRecord::Base.logger.level = 2
  # Add more helper methods to be used by all tests here...
  def deny(assertion, message="no message given")
    assert(!assertion, message)
  end
end
# Because I like Turn's outline format but the gem is no longer supported
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new