class CreateAssign < ActiveRecord::Migration[7.0]
  def change
    create_table :assigns do |t|
      t.integer :user_id
      t.integer :project_id
      t.timestamps
    end
  end
end
