OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], {:scope => "user,public_repo", :client_options => {:ssl => {:ca_file => "#{Rails.root}/config/cert.pem" }}}
end