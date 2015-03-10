class CardSetTest < ActiveSupport::TestCase
	test "name is required" do
		assert_raises ActiveRecord::RecordInvalid do
			CardSet.create!
		end
	end

	test "name must be unique" do
		assert_raises ActiveRecord::RecordInvalid do
			CardSet.create! name: card_sets(:one).name
		end
	end
end
