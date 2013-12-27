require_dependency "audit_trails/application_controller"

module AuditTrails
  class HomeController < ApplicationController
    def index
      if params[:sql].nil?
        @activities = Audit.paginate(:page => params[:page], :per_page => 2).order("id DESC")
      else
        begin
          sql_files_path = File.join(Rails.root, 'backups')
          @sql = (params[:sql].to_i == 0) ? Dir.glob("#{sql_files_path}/*.{sql}").count : params[:sql].to_i - 1
          AuditBackLog.connection.execute(IO.read(File.join("#{sql_files_path}", "#{@sql}_audit_trails.sql"))) #rescue true
        rescue ActiveRecord::RecordNotUnique => e
          Rails.logger.info 'Tried to load already loaded sql file'
        rescue Errno::ENOENT => e
          Rails.logger.info e.message
          @sql = nil
        end
        @activities = AuditBackLog.paginate(:page => params[:page], :per_page => 2).order("id DESC")
      end
    end

  end
end
