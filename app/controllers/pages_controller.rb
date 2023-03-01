# frozen_string_literal: true

# This is PagesController
class PagesController < ApplicationController
  def home
    return unless current_user

    @manages = current_user.managed_projects.paginate(page: params[:page], per_page: 2)
  end
end
