class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :set_global_vars

  def set_global_vars
    Rails.logger.warn "=== NEW REQUEST: #{request.original_fullpath}"
    @http_host = "#{request.protocol}#{request.host_with_port}"
    @cur_url = request.original_fullpath
		@ref_url = request.referer

    @http_address = "#{@http_host}/#{@cur_url}"
  end
end
