class RemoveFootnoteFromResources < ActiveRecord::Migration[5.2]
  def change
    remove_column :resources, :footnote, :string
  end
end
