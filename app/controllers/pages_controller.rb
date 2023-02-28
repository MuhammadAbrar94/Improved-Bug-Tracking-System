class PagesController < ApplicationController
  def home
    if current_user
      @manage = current_user.managed_projects.paginate(page: params[:page], per_page: 2)
    end
  end
end
