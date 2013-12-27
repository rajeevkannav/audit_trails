module AuditTrails
  class AuditBackLog < Audit
    AuditTrails::AuditBackLog.table_name = 'audit_trails_audits_backlogs'
  end
end