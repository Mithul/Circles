class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  def list
    if params[:type] == 'circle'
      @circle = Circle.find(params[:id])
      @title ='Circle ' + @circle.name + "'s Roles"
      @roles = []
      @circle.roles.each do |r|
        member = r.members.first.name if r.members.count == 1
        member = 'Unassigned' if r.members.count == 0
        member = r.members.pluck(:name).join(', ') if r.members.count > 1
        @roles << {:name => r.name, :description => r.description, :circle => member}
      end
      circle = @circle.circle.name
    elsif params[:type] == 'member'
      @member = Member.find(params[:id])
      @title ='Member ' + @member.name + "'s Roles"
      roles = @member.roles
      @roles = []
      roles.each do |r|
        @roles << {:name => r.name, :description => r.description, :circle => r.circle_name}
      end
      circle = @member.main_circle.name
      circles = @member.circles.where.not(:name => circle).map{|c| c.name}
      if circles == nil or circles.count==0
        circles << "Not part of any other circle"
      end
    end
    if request.xhr?
      render :json => {'title'=> @title, 'roles' => @roles, 'circle' => circle, 'circles' => circles}
    else
      # render :layout => false
    end
  end 


  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:circle_id, :member_id, :name, :description)
    end
end
