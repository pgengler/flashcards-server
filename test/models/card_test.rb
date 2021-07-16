require 'test_helper'

class CardTest < ActiveSupport::TestCase
	test "requires a front" do
		collection = create(:collection)
		assert_raises ActiveRecord::RecordInvalid do
			Card.create! back: 'back', collection: collection
		end
	end

	test "requires a back" do
		collection = create(:collection)
		assert_raises ActiveRecord::RecordInvalid do
			Card.create! front: 'front', collection: collection
		end
	end

	test 'requires that it be part of a collection' do
		assert_raises ActiveRecord::RecordInvalid do
			Card.create! front: 'front', back: 'back'
		end
	end
end
