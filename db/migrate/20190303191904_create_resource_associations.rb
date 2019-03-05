class CreateResourceAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :resource_associations do |t|
      t.references :resource
      t.references :resourceable, polymorphic: true, index: { name: 'index_resourceable' }
    end

    query = 'SELECT * FROM list_items LEFT JOIN lists ON lists.id = list_items.list_id'
    result = ActiveRecord::Base.connection.execute(query).to_a

    result.each do |row|
      ResourceAssociation.create(resource_id: row['resource_id'], resourceable_type: row['listable_type'], resourceable_id: row['listable_id'])
    end
  end
end
