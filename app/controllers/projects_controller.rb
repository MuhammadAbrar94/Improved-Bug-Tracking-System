class ProjectsController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user
      @user = current_user
      @manage = current_user.managed_projects.paginate(page: params[:page], per_page: 2)
      # @projects = @user.managed_projects.paginate(page: params[:page], per_page: 3)
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
    @users = User.where(role: [:developer, :qa])
    @selected_user_ids = @project.users.pluck(:id)
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      @project.users = []
      # loop through the selected user_ids to create new Assign records
      if !params[:user_ids].nil?
        params[:user_ids].each do |user_id|
          user = User.find(user_id)
          @project.users << user
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
