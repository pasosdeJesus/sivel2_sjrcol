# Load the Rails application.
require File.expand_path('../application', __FILE__)

ENV['RACK_MULTIPART_LIMIT'] = '1024'
ActiveRecord::Base.pluralize_table_names=false

# Initialize the Rails application.
Rails.application.initialize!
