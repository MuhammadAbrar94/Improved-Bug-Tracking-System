# frozen_string_literal: true

# This is Project
class Project < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1, maximum: 25 }
  validates_uniqueness_of :title
  validates :description, presence: true, length: { minimun: 1, maximum: 500 }
  has_many :reports, dependent: :destroy

  belongs_to :user
  validates :user_id, presence: true

  has_many :assigns, dependent: :destroy
  has_many :users, through: :assigns

  # scope :developer, ->  { self.users.where(users: { role: :developer }) }

end
