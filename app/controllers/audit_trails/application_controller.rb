module AuditTrails
  class ApplicationController < ActionController::Base
    include AuditTrails::SystemController
  end
end
