load "defaults.rb"

Backup::Model.new(:daily_backup, 'Daily Backup') do

   ##
   # MySQL [Database]
   #
   database MySQL do |db|
     db.name = "app_db_production"
     db.username = "user"
     db.password = "password"
   end

   archive :my_archive do |archive|
     archive.add '/var/lib/mysql/master.info' #will give you information on DB position
   end

   #This can be done manually via a cron as well. But I'm a lazy guy
   store_with SCP do |server|
     server.username = 'user'
     server.password = 'password'
     server.ip = 'localhost'
     server.port = 22
     server.path = '~/backups/daily' #backup destination
     server.keep = 10
   end

   #compress the backup load. After all space is money
   compress_with Gzip do |compression|
     compression.best = true
     compression.fast = false
   end

   notify_by Mail do |mail|
     mail.on_success = true
     mail.on_failure = true
   end
end
