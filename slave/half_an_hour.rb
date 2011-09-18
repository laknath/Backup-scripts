load "defaults.rb"

Backup::Model.new(:sync_backup, 'Sync Backup') do

   sync_with S3 do |s3|
     s3.access_key_id = '2342'
     s3.secret_access_key = '43243'
     s3.bucket = "my-backups" #your S3 bucket name
     s3.path = "/sync" #assuming you have a 'sync' folder in the bucket
     s3.mirror = true

     s3.directories do |directory|
       directory.add "/home/username/backups/payments/master_logs" #binlogs synced from master
     end
   end

   notify_by Mail do |mail|
     mail.on_success = false
     mail.on_failure = true
   end
end
