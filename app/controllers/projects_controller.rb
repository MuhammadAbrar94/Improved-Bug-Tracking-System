class ProjectsController < ApplicationController

  def index
    if current_user
      @user = current_user
      @projects = @user.managed_projects
    end
  end

  def new
    @project = Project.new
    @users = User.where(role: :developer).or(User.where(role: :qa))
  end

  def create
    @users = User.all
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      @assigns = []
      # loop through the selected user_ids to create new Assign records
      if !params[:user_ids].nil?
        params[:user_ids].each do |user_id|
          user = User.find(user_id)
          assign = Assign.new(user: user, project: @project)
          @assigns << assign if assign.save
        end
      end
      flash[:success] = "Added #{@project.title} to projects!"
      redirect_to project_path(@project)
    else
      render "new", status: 300
    end
  end

  def edit
    @project = Project.find(params[:id])
    assign_users = @project.assigns.pluck(:user_id)
    @users = User.where(role: [:developer, :qa]).where.not(id: assign_users)
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      @assigns = []
      # loop through the selected user_ids to create new Assign records
      if !params[:user_ids].nil?
        params[:user_ids].each do |user_id|
          user = User.find(user_id)
          assign = Assign.new(user: user, project: @project)
          @assigns << assign if assign.save
        end
      end
      flash[:success] = "Your project was updated successfully"
      redirect_to @project
    else
      render "edit"
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = "Project deleted successfully"
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
