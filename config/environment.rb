# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
    :address => ENV['MAILGUN_SMTP_SERVER'], 
    :port => ENV['MAILGUN_SMTP_PORT'], 
    :authentication => :plain, 
    :user_name => ENV['MAILGUN_SMTP_LOGIN'], 
    :password => ENV['MAILGUN_SMTP_PASSWORD'], 
    :domain => 'jasmine-courses.herokuapp.com'
    # :enable_starttls_auto => true 
  }


