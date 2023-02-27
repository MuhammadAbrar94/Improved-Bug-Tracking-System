class BugesController < ApplicationController

  def index
    @project = Project.find(params[:project_id])
    if (current_user.role == "developer")
      @buge = Buge.where(project_id: params[:project_id], developer_id: current_user.id)
    elsif (current_user.role == "qa")
      @buge = Buge.where(project_id: params[:project_id])
    end
  end

  def new
    @buge = Buge.new
    @project = Project.find(params[:project_id])
    @users = User.joins(:assigns).where(role: :developer, assigns: { project_id: @project.id })
  end

  def create
    @users = User.all
    @buge = Buge.new(buge_params)
    @project = Project.find(params[:buge][:project_id])

    @buge.project = @project
    @buge.creator = current_user
    @buge.developer_id = params[:buge][:developer_id]

    if @buge.save
      flash[:success] = "Added #{@buge.title} to projects!"
      redirect_to buge_path(@buge)
    else
      render "new", status: 300
    end
  end

  def edit
    @buge = Buge.find(params[:id])
    @project = Project.find(params[:project_id])
  end

  def update
    @buge = Buge.find(params[:id])
    if @buge.update(buge_params)
      flash[:success] = "Added #{@buge.title} to projects!"
      redirect_to buge_path(@buge)
    else
      render "edit"
    end
  end

  def show
    @buge = Buge.find(params[:id])
  end

  def destroy
    Buge.find(params[:id]).destroy
    flash[:success] = "Bug deleted successfully"
    redirect_to buges_path
  end

  private

  def buge_params
    params.require(:buge).permit(:creator_id, :title, :description, :type_bug, :deadline, :image, :developer_id, :status)
  end
end
