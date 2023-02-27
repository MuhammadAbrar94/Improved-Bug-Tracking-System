class RenameOldColumnNameToNewColumnNameInMyTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :Buges, :creater_id, :creator_id

  end
end
