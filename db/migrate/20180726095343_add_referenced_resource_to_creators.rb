class AddReferencedResourceToCreators < ActiveRecord::Migration[5.2]
  def change
    add_reference :creators, :referenced_resource, foreign_key: { to_table: :resources }
  end
end
