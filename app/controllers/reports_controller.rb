# frozen_string_literal: true

# This is ReportsController
class ReportsController < ApplicationController
  load_and_authorize_resource

  def index
    @project = Project.find(params[:project_id])
    case current_user.role
    when 'developer'
      # @report = Report.where(project_id: params[:project_id], developer_id: current_user.id)
      @reports = @project.reports.where(reports: { developer_id: current_user.id })
    when 'qa', 'manager'
      @reports = @project.reports
      # @report = Report.where(project_id: params[:project_id])
    end
  end

  def new
    @report = Report.new
    @project = Project.find(params[:project_id])
    @users = @project.users.developer
    # @users = @project.users.where(users: { role: :developer })
    # @users = User.joins(:assigns).where(role: :developer, assigns: { project_id: @project.id })
  end

  def create
    @users = User.all
    @report = Report.new(report_params)
    set_report_attributes
    if @report.save
      flash[:success] = "Added #{@report.title} to projects!"
      redirect_to report_path(@report)
    else
      render 'new', status: 300
    end
  end

  def edit
    @report = Report.find(params[:id])
    @project = Project.find(params[:project_id])
    # @users = User.joins(:assigns).where(role: :developer, assigns: { project_id: @project.id })
    # @users = @project.users.where(users: { role: :developer })
    @users = @project.users.developer
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      flash[:success] = "Added #{@report.title} to projects!"
      redirect_to report_path(@report)
    else
      render 'edit'
    end
  end

  def show
    @report = Report.find(params[:id])
  end

  def destroy
    Report.find(params[:id]).destroy
    flash[:success] = 'Report deleted successfully'
    redirect_to reports_path
  end

  private

  def report_params
    params.require(:report).permit(:creator_id, :title, :description,
                                   :type_Report, :deadline, :image, :developer_id, :status)
  end

  def set_report_attributes
    @project = Project.find(params[:report][:project_id])
    @report.project = @project
    @report.creator = current_user
    @report.developer_id = params[:report][:developer_id]
  end
end
