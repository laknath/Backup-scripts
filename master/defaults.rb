#Email settings. This will use local mail relay
Backup::Configuration::Notifier::Mail.defaults do |mail|
    mail.address  = 'localhost'
    mail.port     = 25
    mail.domain   = 'example.com'
    mail.from     = 'admin@example.com'
    mail.to       = 'me@example.com'
end

