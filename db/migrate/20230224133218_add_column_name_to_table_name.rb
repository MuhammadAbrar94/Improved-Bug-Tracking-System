class AddColumnNameToTableName < ActiveRecord::Migration[7.0]
  def change
    add_column :Buges, :developer_id, :integer
    add_column :Buges, :creater_id, :integer

  end
end
