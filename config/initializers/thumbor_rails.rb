ThumborRails.setup do |config|
  config.server_url = ENV.fetch('THUMBOR_URL')
  config.security_key = ENV.fetch('THUMBOR_SECURITY_KEY')
end
