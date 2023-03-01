# frozen_string_literal: true

# This is ProjectController
class ProjectsController < ApplicationController
  load_and_authorize_resource

  def index
    return unless current_user

    @user = current_user
    @manages = current_user.managed_projects.paginate(page: params[:page], per_page: 2)
    # @projects = @user.managed_projects.paginate(page: params[:page], per_page: 3)
  end

  def new
    @project = Project.new
    @users = User.where(role: %i[developer qa])
  end

  def create
    @users = User.all
    @project = Project.new(project_params)
    @project.user = current_user
    return render 'new', status: 300 unless @project.save

    create_assigns
    redirect_to project_path(@project)
  end

  def edit
    @project = Project.find(params[:id])
    @users = User.where(role: %i[developer qa])
    @selected_user_ids = @project.users.pluck(:id)
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      update_project_users
      flash[:success] = 'Your project was updated successfully'
      redirect_to @project
    else
      render 'edit'
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = 'Project deleted successfully'
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end

  def create_assigns
    @assigns = []
    # loop through the selected user_ids to create new Assign records
    return unless params[:user_ids]

    params[:user_ids].each do |user_id|
      user = User.find(user_id)
      assign = Assign.new(user: user, project: @project)
      @assigns << assign if assign.save
    end
  end

  def update_project_users
    @project.users = []
    return unless params[:user_ids]

    params[:user_ids].each do |user_id|
      user = User.find(user_id)
      @project.users << user
    end
  end
end
