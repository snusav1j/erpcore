class ApplicationController < ActionController::Base
  include ApplicationHelper
  include TranslateHelper

  before_action :authenticate_user!
  before_action :set_global_vars
	before_action :load_custom_fields
  before_action :check_user_banned, unless: :devise_controller?
  helper_method :current_company

  def current_company
    current_user&.company
  end
  
  def set_global_vars
    Rails.logger.warn "=== NEW REQUEST: #{request.original_fullpath}"
    @http_host = "#{request.protocol}#{request.host_with_port}"
    @cur_url = request.original_fullpath
		@ref_url = request.referer

    @http_address = "#{@http_host}/#{@cur_url}"
  end

	def get_val_from_params name
		val = nil
		if name.is_a?(Array)
			val = params
			while val.is_a?(Hash)
				name.each do |key|
					val = val[key] if val
				end
			end
		else
			val = params[name]
		end
		val
	end
  
  def param_i name, default_value=nil
		val = self.get_val_from_params name
    val.present? && val.to_i > 0 ? h(val).to_i : default_value
  end

	def param_a name, default_value=[]
		res = default_value
		vals = self.get_val_from_params name
		if vals.present?
			vals.each do |val|
				res << h(val).to_i if val.to_i > 0
			end
		end
		res
	end

  def param_dec name, default_value=nil
		val = self.get_val_from_params name
		return default_value if !val
		val = val.gsub(',', '.')
    val.present? && val.to_d > 0 ? h(val).to_d : default_value
  end

  def param_f name, default_value=nil
		val = self.get_val_from_params name
		return default_value if !val
		val = val.gsub(',', '.')
    val.present? && val.to_f > 0 ? h(val).to_f : default_value
  end

  def param_b name, default_value=nil
		val = self.get_val_from_params name
    res = default_value
    res = true if val == "true" || val == '1'
    res = false if val == "false" || val == '0'
    res
  end

  def param_s name, default_value=nil
		val = self.get_val_from_params name
    val.present? ? h(val.strip) : default_value
  end

  def param_d name, default_value=nil
		val = self.get_val_from_params name
    val.present? ? h(val).to_date : default_value
  end

  def param_dt name, default_value=nil
		val = self.get_val_from_params name
    val.present? ? h(val).to_datetime : default_value
  end

  def param_sym name, default_value=false
    params[name].blank? ? default_value : h(params[name]).to_sym
  end

	def param_ar name, default_value=[]
		params[name].present? ? params[name].to_a : default_value
	end

  private

  def load_custom_fields
    return unless respond_to?(:controller_name)

    entity = controller_name.singularize

    @custom_fields = CustomField.for_entity(entity, current_company)
  end

  def check_user_banned
    return unless current_user

    inactive_company = current_user.company&.inactive?
    user_banned = current_user.banned?

    alert_msg = 
      if inactive_company && user_banned
        tm(User, :access_denied)
      elsif user_banned
        tm(User, :banned)
      elsif inactive_company
        tm(User, :inactive_company)
      else
        tm(User, :error_contact_administrator)
      end
        
    if user_banned || (inactive_company)
      sign_out current_user
      redirect_to new_user_session_path, alert: alert_msg
    end
  end

end
