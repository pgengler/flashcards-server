require 'test_helper'
require 'helpers/integration_test_helpers'

class CollectionsTest < ActionDispatch::IntegrationTest
  include IntegrationTestHelpers

  test 'can create a new collection' do
    assert_difference 'Collection.count' do
      jsonapi_post '/api/collections', params: {
        data: {
          attributes: { name: 'abc' },
          type: 'collections'
        }
      }.to_json
    end
    assert_response :created
  end

  test 'cannot create a collection without a name' do
    assert_no_difference 'Collection.count' do
      jsonapi_post '/api/collections', params: {
        data: {
          attributes: { name: '' },
          type: 'collections'
        }
      }.to_json
    end
    assert_response :unprocessable_entity
  end

  test 'can edit a collection' do
    collection = create(:collection, name: 'xyz')

    jsonapi_patch "/api/collections/#{collection.id}", params: {
      data: {
        attributes: { name: 'abc' },
        id: collection.id,
        type: 'collections'
      }
    }.to_json

    assert_response :success

    collection.reload

    assert_equal collection.name, 'abc'
  end

  test 'cannot update a collection to set a blank name' do
    collection = create(:collection, name: 'abc')

    jsonapi_patch "/api/collections/#{collection.id}", params: {
      data: {
        attributes: { name: '' },
        id: collection.id,
        type: 'collections'
      }
    }.to_json

    assert_response :unprocessable_entity

    collection.reload

    assert_equal collection.name, 'abc', 'name is not changed to be blank'
  end

  test 'can delete a collection' do
    collection = create(:collection)

    assert_difference 'Collection.count', -1 do
      jsonapi_delete "/api/collections/#{collection.id}"
    end

    assert_response :no_content
  end

  test 'can get a single collection' do
    collection = create(:collection, name: 'the collection')

    jsonapi_get "/api/collections/#{collection.id}"

    assert_response :success
    body = JSON.parse(response.body)
    assert_equal 'the collection', body['data']['attributes']['name']
  end
end
