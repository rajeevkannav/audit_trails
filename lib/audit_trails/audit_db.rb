module AuditTrails
  class AuditDb
    def self.adbconf
      begin
        db_configurations = YAML::load(IO.read('config/database_audit_trails.yml'))[Rails.env]
      rescue
        _database = File.join(Rails.root, 'config', 'database.yml')
        db_configurations = YAML::load(IO.read(_database))["audit_#{Rails.env}"]
      rescue
        db_configurations = YAML::load(IO.read(_database))[Rails.env]
      end
      db_configurations
    end

    def self.rdbconf
      _database = File.join(Rails.root, 'config', 'database.yml')
      db_configurations = YAML::load(IO.read(_database))[Rails.env]
      db_configurations
    end

  end
end
