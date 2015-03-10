class CreateSets < ActiveRecord::Migration
  def change
    create_table :card_sets do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :card_sets_cards, id: false do |t|
      t.integer :card_id
      t.integer :card_set_id
    end

    add_index :card_sets_cards, :card_id
    add_index :card_sets_cards, :card_set_id
  end
end
