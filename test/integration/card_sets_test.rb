require 'test_helper'
require 'helpers/integration_test_helpers'

class CardSetsTest < ActionDispatch::IntegrationTest
  include IntegrationTestHelpers

  test 'can create a new card set' do
    assert_difference 'CardSet.count' do
      jsonapi_post :card_set, { name: 'Card Set' }
    end

    assert_response :created
  end

  test 'does not create a card set without a name' do
    assert_no_difference 'CardSet.count' do
      jsonapi_post :card_set, { name: '' }
    end

    assert_response :unprocessable_entity
  end
end
