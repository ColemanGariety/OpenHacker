class RenameTypeToName < ActiveRecord::Migration
  def change
    rename_column :ribbons, :type, :name
  end
end
