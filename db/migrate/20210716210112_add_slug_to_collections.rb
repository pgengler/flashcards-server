class AddSlugToCollections < ActiveRecord::Migration[6.1]
  def change
    add_column :collections, :slug, :string
  end
end
