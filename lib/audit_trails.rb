require "audit_trails/engine"
require "audit_trails/version"
require "audit_trails/ar_enhanced"
require "audit_trails/audit_db"

module AuditTrails
  module SystemController
    def self.included(base)
      base.send(:before_filter, :store_current_controller)
    end

    def store_current_controller
      Thread.current.thread_variable_set('controller', self)
    end
  end
end
