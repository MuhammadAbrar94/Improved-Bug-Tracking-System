# frozen_string_literal: true

# This is Assign
class Assign < ApplicationRecord
  belongs_to :user
  belongs_to :project
end
