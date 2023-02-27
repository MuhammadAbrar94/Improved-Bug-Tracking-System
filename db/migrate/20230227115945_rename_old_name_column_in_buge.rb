class RenameOldNameColumnInBuge < ActiveRecord::Migration[7.0]
  def change
    rename_column :Buges, :typeBug, :type_bug
  end
end
