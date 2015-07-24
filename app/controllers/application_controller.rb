class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :impress
  before_action :check_user_member
  before_filter :check_pending_visit

  def impress
  	# @impress_enable = true
  end

  def check_pending_visit
    if session[:goto] != nil  and 
      !(params[:controller] == 'devise/sessions' or params[:controller] == 'devise/registrations' or  params[:controller] == 'devise/confirmations') and 
        !(params[:controller] == 'users' and (params[:action]=='set_member' or params[:action]=='assign_member'))
      redirect_to session[:goto]
      session[:goto] = nil
    end
  end

  def authenticate_user!
    puts request.url,session[:goto]
    if session[:goto] == nil and !current_user
      session[:goto] = request.url
      puts 'SET'
    end
    super
  end

  def check_user_member
  	if current_user and current_user.member == nil and 
  		!(params[:controller] == 'devise/sessions' or params[:controller] == 'devise/registrations' or  params[:controller] == 'devise/confirmations') and 
  			!(params[:controller] == 'users' and (params[:action]=='set_member' or params[:action]=='assign_member'))
  		authenticate_user!
      redirect_to set_member_path
  	end  	
  end

end
