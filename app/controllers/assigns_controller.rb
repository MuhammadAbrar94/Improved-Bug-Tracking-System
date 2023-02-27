class AssignsController < ApplicationController
  def destroy
    Assign.find(params[:id]).destroy
    flash[:success] = "Assigne deleted successfully"
    assign = Assign.find(params[:id])
    project = params[:project_id]
    redirect_to project_path(project)
  end

end
