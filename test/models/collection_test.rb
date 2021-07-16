require 'test_helper'

class CollectionTest < ActiveSupport::TestCase
  test 'requires a name' do
		assert_raises ActiveRecord::RecordInvalid do
			Collection.create! name: ''
		end
	end
end
