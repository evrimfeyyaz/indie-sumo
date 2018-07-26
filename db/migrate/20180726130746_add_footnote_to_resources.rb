class AddFootnoteToResources < ActiveRecord::Migration[5.2]
  def change
    add_column :resources, :footnote, :string
  end
end
