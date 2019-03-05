class RemoveListItems < ActiveRecord::Migration[5.2]
  def change
    drop_table :list_items
  end
end
