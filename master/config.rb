load "defaults.rb"

Backup::Model.new(:sync_logs, 'Sync logs') do

  sync_with RSync do |rsync|
    rsync.ip = "200.200.200.200" #remote slave IP
    rsync.port = 22
    rsync.username = "username" #remote user
    rsync.mirror = true
    rsync.compress = true

    rsync.path = "/home/username/backups/master_logs" #remote path to rsync

    #local mysql binary log files should be rsynced
    rsync.directories do |directory|
      directory.add "/var/log/mysql/" #this is where master's binlogs are kept
    end
  end

   #notify only on failure
  notify_by Mail do |mail|
      mail.on_success = false
      mail.on_failure = true
  end
end
