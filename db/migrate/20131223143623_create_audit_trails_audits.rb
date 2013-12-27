# This migration comes from audit_trails (originally 20131223143623)
class CreateAuditTrailsAudits < ActiveRecord::Migration

  def connection
    ActiveRecord::Base.establish_connection(AuditTrails::AuditDb.adbconf).connection
  end

  def change
    # Active Audit Table
    create_table :audit_trails_audits do |t|
      t.string :key
      t.belongs_to :recipient, :polymorphic => true
      t.integer :user_id
      t.text :parameters
      t.string :ip_address
      t.text :message

      t.timestamps
    end

    # BackLog Audit Table
    create_table :audit_trails_audits_backlogs do |t|
      t.string :key
      t.belongs_to :recipient, :polymorphic => true
      t.integer :user_id
      t.text :parameters
      t.string :ip_address
      t.text :message

      t.timestamps
    end

    self.revert_connection
  end

  def revert_connection
    ActiveRecord::Base.establish_connection(AuditTrails::AuditDb.rdbconf).connection
  end

end
