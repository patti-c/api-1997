class ChangeMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :text, :string
    add_column :messages, :conversation_id, :integer
    add_column :conversations, :relationship_id, :integer
  end
end
