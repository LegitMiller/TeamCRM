ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => 'smtp.sendgrid.com',
  :port                 => '587',
  :domain               => 'heroku.com',
  :user_name            => 'app35232199@heroku.com',
  :password             => '33dnot5f',
  :authentication       => :plain,
  :enable_starttls_auto => true
}

#ActionMailer::Base.default_url_options[:host] = "localhost:3000"
#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?

#ActionMailer::Base.smtp_settings = {
#  :address              => "smtp.gmail.com",
#  :port                 => 587,
#  :domain               => "gmail.com",
#  :user_name            => "questendeavor",
#  :password             => "5354asdf",
#  :authentication       => "plain",
#  :enable_starttls_auto => true
#}
