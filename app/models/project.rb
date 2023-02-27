class Project < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1, maximum: 25 }
  validates_uniqueness_of :title
  validates :description, presence: true, length: { minimun: 1, maximum: 500 }
  has_many :buges, dependent: :destroy

  belongs_to :user #for manager
  validates :user_id, presence: true

  has_many :assigns, dependent: :destroy
  has_many :users, through: :assigns  #for developer and qa
end
