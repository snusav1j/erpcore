class UserSettingsController < ApplicationController

  def index

  end

  def show

  end

  def set_sidebar_state
    @updated = current_user.set_sidebar_state(param_b(:sidebar_hidden))
    respond_to :js
  end

  def set_column_visibility_block_state
    @updated = current_user.set_column_visibility_block_state(param_b(:block_hidden))
    respond_to :js
  end

  def set_custom_fields_table_block_state
    @updated = current_user.set_custom_fields_block_state(param_b(:block_hidden))
    respond_to :js
  end
  
  private

end