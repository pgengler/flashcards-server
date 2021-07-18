class CardSetTest < ActiveSupport::TestCase
	test "name is required" do
		collection = create(:collection)
		assert_raises ActiveRecord::RecordInvalid do
			CardSet.create! collection: collection
		end
	end

	test "name must be unique" do
		card_set = create(:card_set)
		collection = create(:collection)
		assert_raises ActiveRecord::RecordInvalid do
			CardSet.create! name: card_set.name, collection: collection
		end
	end

	test 'requires a collection' do
		assert_raises ActiveRecord::RecordInvalid do
			CardSet.create! name: 'Card set'
		end
	end
end
