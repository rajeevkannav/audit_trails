namespace :db do
  desc "swap table names and Backup Audit trails data to sql."
  task :backup => [:environment] do
    unless AuditTrails::Audit.count < 3
      begin
        base_path = Rails.root
        backup_location = File.join(base_path, 'backups')
        FileUtils.mkdir_p(backup_location)
        filename = (Dir.glob("#{backup_location}/*.{sql}").count + 1).to_s + '_audit_trails.sql'
        backup_file = File.join(backup_location, filename)
        db_config = AuditTrails::Audit.connection_config
        o_tblname = AuditTrails::Audit.table_name
        n_tblname = AuditTrails::AuditBackLog.table_name
        AuditTrails::Audit.connection.execute("delete from #{n_tblname}")
        AuditTrails::Audit.connection.execute("RENAME TABLE #{o_tblname} TO temp")
        AuditTrails::Audit.connection.execute("RENAME TABLE #{n_tblname} TO #{o_tblname}")
        AuditTrails::Audit.connection.execute("RENAME TABLE temp TO #{n_tblname}")
        `mysqldump -u#{db_config[:username]} -p#{db_config[:password]} --compact -t #{db_config[:database]} #{n_tblname} > #{backup_file}`
        AuditTrails::Audit.connection.execute("delete from #{n_tblname}")
        raise "Unable to make DB backup!" if ($?.to_i > 0)
          #`gzip -9 #{backup_file}` #Fixme If Required.
      rescue Exception => e
        puts e.backtrace
      end
    end
  end
end




