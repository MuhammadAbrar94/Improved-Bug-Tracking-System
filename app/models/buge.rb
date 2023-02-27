class Buge < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1, maximum: 25 }
  validates_uniqueness_of :title, scope: :project_id

  enum type_bug: [:feature, :bug]
  attribute :status, :string, default: "new"

  mount_uploader :image, ImageUploader

  belongs_to :project
  validates :project_id, presence: true

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :developer, class_name: "User", foreign_key: "developer_id", optional: true
end
