class CreateBuges < ActiveRecord::Migration[7.0]
  def change
    create_table :buges do |t|
      t.string :title
      t.string :description
      t.date :deadline
      t.integer :typeBug, default: 0
      t.string :status
      t.string :image
      t.integer :project_id
      t.timestamps
    end
  end
end
