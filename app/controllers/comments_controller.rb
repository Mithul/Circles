class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    # @comment = Comment.new(comment_params)
    if params[:task_id]
      id = params[:task_id]
      post = Task
    elsif params[:circle_id]
      id = params[:circle_id]
      post = Circle
    elsif params[:member_id]
      id = params[:member_id]
      post = Member
    elsif params[:role_id]
      id = params[:role_id]
      post = Role
    elsif params[:report_id]
      id = params[:report_id]
      post = Report
    end
    @post = post.find(id)
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    @comment.save
    
    redirect_to tasks_path
    # respond_to do |format|
    #   if @comment.save
    #     format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
    #     format.json { render :show, status: :created, location: @comment }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @comment.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    
    redirect_to tasks_path   
    # respond_to do |format|
    #   if @comment.update(comment_params)
    #     format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @comment }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @comment.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    redirect_to tasks_path
    # respond_to do |format|
    #   format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :post)
    end
end
