class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  respond_to :html

  def index
    @reports = Report.all
    respond_with(@reports)
  end

  def history
    @report = Report.find(params[:id]).versions.find(params[:ver]).reify
    respond_to do |format|
      format.html do 
        render 'show'
      end
      format.pdf do
        render pdf: "CTF-Report-#{@report.title}" , :wkhtmltopdf => '/usr/bin/wkhtmltopdf',   # Excluding ".pdf" extension.
        :page_size => 'A4',
        disable_external_links: false,
        template: 'reports/show'
      end
    end
    # render 'show'
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "CTF-Report-#{@report.title}" , :wkhtmltopdf => '/usr/bin/wkhtmltopdf',   # Excluding ".pdf" extension.
        :page_size => 'A4',
        disable_external_links: false
      end
    end
  end

  def new
    # @user = current_user.name
    @report = Report.new(:author => @user)
    @buckets = Circle.where(:category => 'main').pluck(:name)
    respond_with(@report)
  end

  def edit
    @buckets = Circle.where(:category => 'main').pluck(:name)
    @diffy = Diffy::Diff
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user
    @report.save
    redirect_to report_path(:format => :pdf, :id => @report.id)
  end

  def update
    @report.update(report_params)
    upload_params=params[:report][:uploads_attributes]
    if !upload_params.empty?
      upload_params.each_with_index do |upload,i|
        @report.uploads.delete(upload[1][:id]) if upload[1][:_destroy]=="1"
        @report.uploads << Upload.find(upload[1][:name]) if upload[1][:_exist]=="true"
      end
    end
    @report.user = current_user
    @report.save
    if !upload_params.empty?
      upload_params.each_with_index do |upload,i|
         Upload.find_by_name(upload[1][:name]).destroy if upload[1][:_exist]=="true"
      end
    end
    redirect_to report_path(:format => :pdf, :id => @report.id)
    # respond_with(@report)
  end

  def destroy
    @report.destroy
    respond_with(@report)
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:title, :date, :time, :duration, :venue, :initiator, :bucket, :participants, :description, :conclusion, :author, :inter, :othbucket, :category, uploads_attributes: [:name, :id, :file, :user_id,:_destroy])
    end
end
