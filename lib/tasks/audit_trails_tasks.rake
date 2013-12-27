#namespace :audit_trails do
#
#  desc "Configure the variables that rails need in order to look up for the db configuration in a different folder"
#  task :set_custom_db_config_paths do
#    # This is the minimum required to tell rails to use a different location for all the files related to the database.
#    ENV['SCHEMA'] = 'db_audit_trails/schema.rb'
#    Rails.application.config.paths['db'] = ['db_audit_trails']
#    Rails.application.config.paths['db/migrate'] = ['db_audit_trails/migrate']
#    Rails.application.config.paths['db/seeds'] = ['db_audit_trails/seeds.rb']
#    Rails.application.config.paths['config/database'] = ['db_audit_trails/database_audit_trails.yml']
#  end
#
#  namespace :db do
#    task :drop => :set_custom_db_config_paths do
#      Rake::Task["db:drop"].invoke
#    end
#
#    task :create => :set_custom_db_config_paths do
#      Rake::Task["db:create"].invoke
#    end
#
#    task :migrate => :set_custom_db_config_paths do
#      Rake::Task["db:migrate"].invoke
#    end
#
#    task :rollback => :set_custom_db_config_paths do
#      Rake::Task["db:rollback"].invoke
#    end
#
#    task :seed => :set_custom_db_config_paths do
#      Rake::Task["db:seed"].invoke
#    end
#
#    task :version => :set_custom_db_config_paths do
#      Rake::Task["db:version"].invoke
#    end
#  end
#end