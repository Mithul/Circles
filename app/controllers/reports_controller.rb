class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  respond_to :html

  def index
    @reports = Report.all
    respond_with(@reports)
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "CTF-Report-#{@report.title}" , :wkhtmltopdf => '/usr/bin/wkhtmltopdf',   # Excluding ".pdf" extension.
        :page_size => 'A4'
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
  end

  def create
    @report = Report.new(report_params)
    @report.save
    redirect_to report_path(:format => :pdf, :id => @report.id)
  end

  def update
    @report.update(report_params)
    respond_with(@report)
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
      params.require(:report).permit(:title, :date, :time, :duration, :venue, :initiator, :bucket, :participants, :description, :conclusion, :author, :inter, :othbucket)
    end
end
