class DropCategoriesResources < ActiveRecord::Migration[5.2]
  def change
    query  = 'SELECT * FROM categories_resources'
    result = ActiveRecord::Base.connection.execute(query).to_a

    result.each do |row|
      Resource.find_by(row['resource_id'].to_i).update(category_id: row['category_id'].to_i)
    end

    drop_table :categories_resources
  end
end
