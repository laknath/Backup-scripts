load "defaults.rb"

Backup::Model.new(:monthly_backup, 'Monthly Backup') do

   ##
   # MySQL [Database]
   #
   database MySQL do |db|
     db.name = "app_db_production"
     db.username = "user"
     db.password = "password"
   end

   store_with Dropbox do |db|
     db.email = 'user@example.com'
     db.password = 'password'
     db.api_key = '23234'
     db.api_secret = '234253'
     db.keep = 12
     db.timeout = 300
   end

   archive :my_archive do |archive|
     archive.add '/var/lib/mysql/master.info'
   end

   #Note: compress the backup.
     encrypt_with OpenSSL do |encryption|
     encryption.base64 = true
     encryption.salt = true
     encryption.password = 'password'
   end

   compress_with Gzip do |compression|
     compression.best = true
     compression.fast = false
   end

   notify_by Mail do |mail|
     mail.on_success = true
     mail.on_failure = true
   end
end
