require 'test_helper'
require 'helpers/integration_test_helpers'

class CardsTest < ActionDispatch::IntegrationTest
  include IntegrationTestHelpers

  setup :create_collection

  test 'can create a new card' do
    assert_difference 'Card.count' do
      jsonapi_post :card, {
        front: 'abc',
        back: 'xyz'
      }, [@collection]
    end
    assert_response :created
  end

  test 'cannot create a card without front and back content' do
    assert_no_difference 'Card.count' do
      jsonapi_post :card, { front: '', back: '' }, [@collection]
    end
    assert_response :unprocessable_entity
  end

  test 'can edit a card' do
    card = create(:card)

    jsonapi_patch :card, card.id, { front: 'abc' }

    assert_response :success

    card.reload

    assert_equal card.front, 'abc'
  end

  test 'cannot update a card to set blank content' do
    card = create(:card, front: 'Back', back: 'Front')

    jsonapi_patch :card, card.id, { back: '' }

    assert_response :unprocessable_entity

    card.reload

    assert_equal card.back, 'Front'
  end

  test 'can delete a card' do
    card = create(:card)

    assert_difference 'Card.count', -1 do
      jsonapi_delete :card, card.id
    end

    assert_response :no_content
  end

  test 'can get a single card' do
    card = create(:card, front: 'the front', back: 'the back')

    jsonapi_get :card, card.id

    assert_response :success
    body = JSON.parse(response.body)
    assert_equal 'the front', body['data']['attributes']['front']
    assert_equal 'the back', body['data']['attributes']['back']
  end

  private

  def create_collection
    @collection = create(:collection)
  end
end
