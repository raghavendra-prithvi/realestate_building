Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity
end
OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}