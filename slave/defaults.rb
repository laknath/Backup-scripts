#Email settings. This will use local mail relay
Backup::Configuration::Notifier::Mail.defaults do |mail|
  mail.address = 'localhost'
  mail.port = 25
  mail.domain = 'staging.com'

  mail.from = 'admin@staging.com'
  mail.to = 'me@example.com'
end

#Twitter notification settings. Update with your Twitter settings
Backup::Configuration::Notifier::Twitter.defaults do |tweet|
  tweet.consumer_key = '2342'
  tweet.consumer_secret = '234'
  tweet.oauth_token = '342342-2342'
  tweet.oauth_token_secret = '24324'
end
