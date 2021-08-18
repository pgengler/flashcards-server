require 'test_helper'
require 'helpers/integration_test_helpers'

class CollectionsTest < ActionDispatch::IntegrationTest
  include IntegrationTestHelpers

  test 'can create a new collection' do
    assert_difference 'Collection.count' do
      jsonapi_post :collections, { name: 'abc' }
    end
    assert_response :created
  end

  test 'cannot create a collection without a name' do
    assert_no_difference 'Collection.count' do
      jsonapi_post :collections, { name: '' }
    end
    assert_response :unprocessable_entity
  end

  test 'can edit a collection' do
    collection = create(:collection, name: 'xyz')

    jsonapi_patch collection, { name: 'abc' }

    assert_response :success

    collection.reload

    assert_equal collection.name, 'abc'
  end

  test 'cannot update a collection to set a blank name' do
    collection = create(:collection, name: 'abc')

    jsonapi_patch collection, { name: '' }

    assert_response :unprocessable_entity

    collection.reload

    assert_equal collection.name, 'abc', 'name is not changed to be blank'
  end

  test 'can delete a collection' do
    collection = create(:collection)

    assert_difference 'Collection.count', -1 do
      jsonapi_delete collection
    end

    assert_response :no_content
  end

  test 'can get a single collection' do
    collection = create(:collection, name: 'the collection')

    jsonapi_get collection

    assert_response :success
    body = JSON.parse(response.body)
    assert_equal 'the collection', body['data']['attributes']['name']
  end

  test 'can add multiple cards to a collection via CSV import' do
    collection = create(:collection)

    csv_data = CSV.generate do |csv|
      csv << ['a front', 'a back']
      csv << ['another front', 'another back']
      csv << ['yet another front', 'yet another back']
    end

    assert_difference 'Card.count', 3 do
      post "/api/collections/#{collection.id}/import", params: csv_data, headers: { 'Content-Type': 'text/csv' }
    end

    assert_response :success
  end

  test 'import operation returns JSON with the number of cards added' do
    collection = create(:collection)
    create_list :card, 5, collection: collection

    csv_data = CSV.generate do |csv|
      csv << ['a front', 'a back']
      csv << ['another front', 'another back']
      csv << ['yet another front', 'yet another back']
      csv << ['by now', 'you know the drill']
    end

    post "/api/collections/#{collection.id}/import", params: csv_data, headers: { 'Content-Type': 'text/csv' }

    assert_response :success
    assert_equal response.headers['Content-Type'], 'application/vnd.api+json'

    json = JSON.parse(response.body)
    assert_equal json['meta']['cards_imported'], 4, 'includes number of cards imported in response meta'
    assert_equal json['data']['relationships']['cards']['data'].length, 9, 'returns all cards (including newly-imported ones) in response'
  end

  test 'fails with 404 Not Found if trying to import to a nonexistent collection' do
    csv_data = CSV.generate do |csv|
      csv << ['a front', 'a back']
      csv << ['another front', 'another back']
      csv << ['yet another front', 'yet another back']
    end

    assert_no_difference 'Card.count' do
      post '/api/collections/3145926/import', params: csv_data, headers: { 'Content-Type': 'text/csv' }
    end

    assert_response :not_found
  end

  test 'does not any cards to collection if CSV import fails' do
    collection = create(:collection)

    csv_data = CSV.generate do |csv|
      csv << ['a front', 'a back']
      csv << ['another front', nil]
      csv << [nil, 'another back']
    end

    assert_no_difference 'Card.count' do
      post "/api/collections/#{collection.id}/import", params: csv_data, headers: { 'Content-Type': 'text/csv' }
    end

    assert_response :unprocessable_entity
  end

end
