require 'test_helper'
require 'helpers/integration_test_helpers'

class CardSetsTest < ActionDispatch::IntegrationTest
  include IntegrationTestHelpers

  setup :create_collection

  test 'can create a new card set' do
    assert_difference 'CardSet.count' do
      jsonapi_post :card_set, { name: 'Card Set' }, [@collection]
    end

    assert_response :created
  end

  test 'cannot create a card set without a name' do
    assert_no_difference 'CardSet.count' do
      jsonapi_post :card_set, { name: '' }, [@collection]
    end

    assert_response :unprocessable_entity
  end

  test 'cannot create a card set without a collection' do
    assert_no_difference 'CardSet.count' do
      jsonapi_post :card_set, { name: 'New card set' }
    end

    assert_response :unprocessable_entity
  end

  test 'can update the name of a card set' do
    card_set = create(:card_set, name: 'Card set')

    jsonapi_patch card_set, { name: 'New name' }
    assert_response :success

    card_set.reload
    assert_equal card_set.name, 'New name'
  end

  test 'cannot update a card set to a blank name' do
    card_set = create(:card_set, name: 'Card set')

    jsonapi_patch card_set, { name: '' }
    assert_response :unprocessable_entity

    card_set.reload
    assert_equal card_set.name, 'Card set', 'name was not changed'
  end

  test 'can delete a card set' do
    card_set = create(:card_set)

    assert_difference 'CardSet.count', -1 do
      jsonapi_delete card_set
    end

    assert_response :no_content
  end

  test 'can get a single card set' do
    card_set = create(:card_set, name: 'the name')

    jsonapi_get card_set

    assert_response :success
    body = JSON.parse(response.body)
    assert_equal 'the name', body['data']['attributes']['name']
  end

  private

  def create_collection
    @collection = create(:collection)
  end
end
