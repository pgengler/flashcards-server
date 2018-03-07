require 'test_helper'

class CardSetsControllerTest < ActionController::TestCase
	test "index action returns all card sets" do
		get :index
		assert_response :success
		assert_equal CardSet.count, json_response['card_sets'].length
	end

	test "creates a new card set when given valid data" do
		assert_difference 'CardSet.count' do
			post :create, params: { card_set: { name: 'New set' } }
		end
	end

	test "returns the correct HTTP status code when creating a new card set" do
		post :create, params: { card_set: { name: 'New set' } }
		assert_response :created
	end

	test "doesn't create a new card set when given invalid data" do
		assert_no_difference 'CardSet.count' do
			post :create, params: { card_set: { name: '' } }
		end
	end

	test "returns the correct HTTP status code when given invalid data" do
		post :create, params: { card_set: { name: card_sets(:one).name } }
		assert_response :unprocessable_entity
	end

	private

	def json_response
		@json_response ||= ActiveSupport::JSON.decode(@response.body)
	end
end
