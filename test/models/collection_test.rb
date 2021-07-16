require 'test_helper'

class CollectionTest < ActiveSupport::TestCase
  test 'requires a name' do
		assert_raises ActiveRecord::RecordInvalid do
			Collection.create! name: ''
		end
	end

  test 'name must be unique' do
    create :collection, name: 'foo'

    assert_raises ActiveRecord::RecordInvalid do
      Collection.create! name: 'foo'
    end
  end

  test 'it generates slug as dasherized version of name when created' do
    Collection.create! name: 'Foo Bar Baz'
    collection = Collection.first
    assert_equal 'foo-bar-baz', collection.slug
  end
end
