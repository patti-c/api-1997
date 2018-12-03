class RenameMuted < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :sound_muted, :muted
  end
end
