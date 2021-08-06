class CardSetTest < ActiveSupport::TestCase
	test 'name is required' do
		collection = create(:collection)
		assert_raises ActiveRecord::RecordInvalid do
			CardSet.create! collection: collection
		end
	end

	test 'name must be unique within a collection' do
		collection = create(:collection)
		card_set = create(:card_set, collection: collection)
		assert_raises ActiveRecord::RecordInvalid do
			CardSet.create! name: card_set.name, collection: collection
		end
	end

	test 'names can be duplicated across collections' do
		name = 'A Card Set'
		create :card_set, name: name, collection: create(:collection)
		collection = create(:collection)

		assert_nothing_raised do
			CardSet.create! name: name, collection: collection
		end
	end

	test 'requires a collection' do
		assert_raises ActiveRecord::RecordInvalid do
			CardSet.create! name: 'Card set'
		end
	end

	test 'removing a card set does not remove its associated cards' do
		collection = create(:collection)
		card_set = create(:card_set, collection: collection)
		assert_no_difference 'Card.count' do
			card_set.destroy!
		end
	end
end
