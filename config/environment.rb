# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

if Rails.env.development?
	Rails.logger = Logger.new(STDOUT)
	ActiveRecord::Base.logger = nil
end