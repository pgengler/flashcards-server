class AddCollectionIdToCards < ActiveRecord::Migration[6.1]
  def change
    add_reference :cards, :collection, null: false, foreign_key: true
  end
end
