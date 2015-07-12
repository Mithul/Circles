class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :impress
  before_action :check_user_member

  def impress
  	# @impress_enable = true
  end

  def check_user_member
	if current_user and current_user.member == nil and 
		!(params[:controller] == 'devise/sessions' or params[:controller] == 'devise/registrations') and 
			!(params[:controller] == 'users' and (params[:action]=='set_member' or params[:action]=='assign_member'))
		redirect_to set_member_path
	end  	
  end

end
