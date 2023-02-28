class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string "title"
      t.string "description"
      t.date "deadline"
      t.integer "type_Report", default: 0
      t.string "status"
      t.string "image"
      t.integer "project_id"
      t.integer "developer_id"
      t.integer "creator_id"
      t.timestamps
    end
  end
end
