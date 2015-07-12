class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :admin_only, :except => [:show,:set_member,:assign_member, :index, :update]

  def index
    if current_user.role == "admin"
      @user_role_change = true
      @users = User.all
    elsif current_user.member.category == "kore" 
      @user_role_change = false
      circle = Circle.where(:id => current_user.member.main_circle).first
      members = circle.members
      @users = []
      members.each do |m|
        @users << m.user if m.user
      end
      puts @users
    else
      redirect_to root_path
    end
  end

  def set_member
    # redirect_to root_path if Member.where(:user => current_user).first != nil
    @members = Member.where(:user => nil).order(:name).pluck(:name, :id)
  end

  def assign_member
    member = Member.find(params[:users][:member])
    member.user = current_user
    member.save
    redirect_to root_path
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    @user.member.category = params[:user][:member_role]
    @user.member.save
    params[:user].delete(:member_role)
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def secure_params
    params.require(:user).permit(:role,:member,:member_role)
  end

end
