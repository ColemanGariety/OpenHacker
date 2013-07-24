OmniAuth.config.logger = Rails.logger

# Original scope code
# :scope => "user,public_repo"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], { :client_options => { :ssl => { :ca_file => "#{Rails.root}/config/cert.pem" } } }
end