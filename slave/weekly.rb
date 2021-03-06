load "defaults.rb"

Backup::Model.new(:weekly_backup, 'Weekly Backup') do

   ##
   # MySQL [Database]
   #
   database MySQL do |db|
     db.name = "app_db_production"
     db.username = "user"
     db.password = "password"
   end

   store_with S3 do |s3|
     s3.region = 'us-east-1'
     s3.bucket = 'my-backups' #S3 bucket name
     s3.path = '/weekly' #Path in the S3 bucket
     s3.keep = 5 #how many older copies should be kept
   end

   archive :my_archive do |archive|
     archive.add '/var/lib/mysql/master.info'
   end

   #encrypt whatever being stored. After all these are external services
   encrypt_with OpenSSL do |encryption|
     encryption.base64 = true
     encryption.salt = true
     encryption.password = 'password'
   end

   #compress what's being stored
   compress_with Gzip do |compression|
     compression.best = true
     compression.fast = false
   end

   notify_by Mail do |mail|
     mail.on_success = true
     mail.on_failure = true
   end
end
