ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  fixtures :all
end
