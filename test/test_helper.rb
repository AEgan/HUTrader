require 'simplecov'
SimpleCov.start 'rails'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'contexts'
class ActiveSupport::TestCase
  # hides sql output from unit tests
  ActiveRecord::Base.logger.level = 2

  # includes context methods
  include Contexts
  # Add more helper methods to be used by all tests here...
  def deny(assertion, message="no message given")
    assert(!assertion, message)
  end

  def assert_not_authorized(msg = "You are not authorized to perform this action.")
    assert_equal msg, flash[:warning]
    assert_redirected_to :home
  end
end
# Because I like Turn's outline format but the gem is no longer supported
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
