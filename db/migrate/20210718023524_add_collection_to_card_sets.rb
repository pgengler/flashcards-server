class AddCollectionToCardSets < ActiveRecord::Migration[6.1]
  def change
    add_reference :card_sets, :collection, null: false, foreign_key: true
  end
end
