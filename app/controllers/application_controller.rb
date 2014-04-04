class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :update_site_visit_count

  private

    def update_site_visit_count
      webcount = WebCount.first_or_initialize
      webcount.update_attributes(num_request: (webcount.num_request + 1) )
    end
end
