require 'test_helper'

class CardTest < ActiveSupport::TestCase
	test "requires a front" do
		assert_raises ActiveRecord::RecordInvalid do
			Card.create! :back => 'back'
		end
	end

	test "requires a back" do
		assert_raises ActiveRecord::RecordInvalid do
			Card.create! :front => 'front'
		end
	end
end
