class CreateResourceAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :resource_associations do |t|
      t.references :resource
      t.references :resourceable, polymorphic: true, index: { name: 'index_resourceable' }
    end

    ListItem.all.each do |item|
      ResourceAssociation.create(resource: item.list.resource, resourceable: item.listable)
    end
  end
end
