require 'test_helper'
require 'helpers/integration_test_helpers'

class CardSetsTest < ActionDispatch::IntegrationTest
  include IntegrationTestHelpers

  test 'can create a new card set' do
    assert_difference 'CardSet.count' do
      jsonapi_post '/api/card-sets', params: {
        data: {
          attributes: { name: 'Card Set' },
          type: 'card-sets'
        }
      }.to_json
    end

    assert_response :created
  end

  test 'does not create a card set without a name' do
    assert_no_difference 'CardSet.count' do
      jsonapi_post '/api/card-sets', params: {
        data: {
          attributes: { name: '' },
          type: 'card-sets'
        }
      }.to_json
    end

    assert_response :unprocessable_entity
  end
end
