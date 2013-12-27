# Todo : Database recreate on x number of entry and treat new db as active db.
# Todo : on load more request decide and implement multi-database
# TODO : Handle Audit Table Schema changes
# Todo : Remove ActiveRecord::SchemaMigration.create from Activity
# Todo : Through Test.
module AuditTrails
  class Audit < ActiveRecord::Base
    establish_connection AuditTrails::AuditDb.adbconf
    # Fixme Associations are not working. Ask Sachin to help
    belongs_to :user
    belongs_to :recipient, :polymorphic => true
  end
end


