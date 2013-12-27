module AuditTrails
  class ActiveRecord::Base
    # To change this template use File | Settings | File Templates.
    around_create :log_create_activity, :unless => lambda { self.class.name == 'AuditTrails::Audit' }
    around_update :log_update_activity, :unless => lambda { self.class.name == 'AuditTrails::Audit' }
    around_destroy :log_destroy_activity, :unless => lambda { self.class.name == 'AuditTrails::Audit' }

    def log_activity(key, changes, owner, ip_address, object = nil, message = nil)
      begin
        owner_id = owner.id rescue nil
        AuditTrails::Audit.create(:key => key, :user_id => owner_id, :recipient => object,
                                  :parameters => YAML.dump(changes), :message => message, :ip_address => ip_address)

      rescue Exception => ex
        Rails.logger.error ex.message
        Rails.logger.error ex.backtrace
      end
    end

    def log_create_activity
      changes = self.changes
      yield
      log_activity("#{self.class.name}.create", changes, current_user, get_ip_address, self) unless (self.class.name == 'ActiveRecord::SchemaMigration')
    end

    def log_update_activity
      changes = self.changes
      yield
      log_activity("#{self.class.name}.update", changes, current_user, get_ip_address, self)
    end

    def log_destroy_activity
      changes = self.changes
      yield
      log_activity("#{self.class.name}.destroy", changes, current_user, get_ip_address, self)
    end

    def current_user
      Thread.current.thread_variable_get('controller').current_user rescue nil
    end

    def get_ip_address
      Thread.current.thread_variable_get('controller').get_ip_address rescue '127.0.0.1'
    end

  end
end
