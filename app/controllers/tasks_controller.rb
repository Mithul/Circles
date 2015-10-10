class TasksController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    tasks = Task.all
    reports = Report.all
    roles = Role.all
    circles = Circle.all
    @tasks = (reports + tasks + roles + circles).sort{|a,b| a.created_at <=> b.created_at }.reverse
  end

  def workflow
  end

  def workflow_data
    json = []
    Task.where(:task => nil).each do |t|
      if t.from == nil
        next
      end
      event = {name: t.title,
            values: [],
            id: t.id}
      t.tasks.each do |sub_task|
        value = {
              from: "/Date(#{sub_task.from.to_time.to_i*1000})/",
              to: "/Date(#{sub_task.to.to_time.to_i*1000})/",
              label: sub_task.title,
              url: task_path(sub_task)
            }
        value[:customClass] =  sub_task.circle.name.camelize if sub_task.circle
            event[:values] << value
      end
      json << event
    end
    # json << event
    render :json => json
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
     if request.xhr?
      render :layout => false
    end
  end

  # GET /tasks/new
  def new
    @task = Task.new
    if request.xhr?
      render :layout => false
    end
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :category, :description, :circle_id, :from, :to, :task_id)
    end
end
