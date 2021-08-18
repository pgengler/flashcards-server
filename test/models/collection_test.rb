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

  test 'deleting a collection removes all associated cards' do
    collection_to_delete = create(:collection)
    create_list :card, 12, collection: collection_to_delete

    collection_to_keep = create(:collection)
    create_list :card, 11, collection: collection_to_keep

    assert_difference 'Card.count', -12 do
      collection_to_delete.destroy!
    end

    collection_to_keep.reload
    assert_equal collection_to_keep.cards.count, 11, 'does not remove cards from other collections'
  end

  test 'deleting a collection removes all associated card sets' do
    collection_to_delete = create(:collection)
    create_list :card_set, 2, collection: collection_to_delete

    collection_to_keep = create(:collection)
    create :card_set, collection: collection_to_keep

    assert_difference 'CardSet.count', -2 do
      collection_to_delete.destroy!
    end

    collection_to_keep.reload
    assert_equal collection_to_keep.card_sets.count, 1, 'does not remove card sets from other collections'
  end
end
