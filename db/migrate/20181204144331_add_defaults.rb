class AddDefaults < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :hidden, false
    change_column_default :users, :muted, false
  end
end
