class CardSetTest < ActiveSupport::TestCase
	test "name is required" do
		assert_raises ActiveRecord::RecordInvalid do
			CardSet.create!
		end
	end

	test "name must be unique" do
		card_set = create(:card_set)
		assert_raises ActiveRecord::RecordInvalid do
			CardSet.create! name: card_set.name
		end
	end
end
