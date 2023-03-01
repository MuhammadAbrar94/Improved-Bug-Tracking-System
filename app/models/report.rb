# frozen_string_literal: true

# Style/SymbolArray: Use %i or %I for an array of symbols.
# Original code:
# enum type_Report: [:feature, :bug]

# This is Report
class Report < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1, maximum: 25 }
  validates_uniqueness_of :title, scope: :project_id

  enum type_Report: %i[feature bug]
  attribute :status, :string, default: 'new'

  mount_uploader :image, ImageUploader

  belongs_to :project
  validates :project_id, presence: true

  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  belongs_to :developer, class_name: 'User', foreign_key: 'developer_id', optional: true
end