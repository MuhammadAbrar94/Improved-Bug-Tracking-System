# frozen_string_literal: true

# This is user
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: %i[manager developer qa]
  # has_many :project  # for manager
  # has_many :project, through: :assigns # for developer and qa
  has_many :managed_projects, class_name: 'Project', foreign_key: 'user_id'

  has_many :assigns
  has_many :assigned_projects, through: :assigns, source: :project, dependent: :destroy

  has_many :reports, dependent: :destroy
end
