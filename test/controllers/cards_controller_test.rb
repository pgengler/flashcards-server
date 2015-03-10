require 'test_helper'

class CardsControllerTest < ActionController::TestCase
	test "can create a new card" do
		assert_difference 'Card.count' do
			post :create, card: { front: 'Front text', back: 'Back text' }
		end
	end

	test "returns correct HTTP status code when a new card is created" do
		post :create, card: { front: 'Front text', back: 'Back text' }
		assert_response :created
	end

	test "returns correct HTTP status code when failing to create a new card" do
		post :create, card: { front: '', back: '' }
		assert_response :unprocessable_entity
	end

	test "can update a card" do
		put :update, id: cards(:one), card: { front: 'New front text' }
		cards(:one).reload
		assert_equal 'New front text', cards(:one).front
	end

	test "returns correct HTTP status code when updating a card" do
		put :update, id: cards(:one), card: { front: 'New front text' }
		assert_response :success
	end

	test "returns correct HTTP status code when failing to update a card" do
		put :update, id: cards(:one), card: { front: '' }
		assert_response :unprocessable_entity
	end

	test "returns correct HTTP status when trying to update a nonexistent card" do
		put :update, id: 12345, card: { front: 'Front', back: 'Back' }
		assert_response :not_found
	end

	test "can delete a card" do
		assert_difference('Card.count', -1) do
			delete :destroy, id: cards(:one)
		end
	end

	test "returns correct HTTP status code when deleting a card" do
		delete :destroy, id: cards(:one)
		assert_response :no_content
	end

	test "returns correct HTTP status code when trying to delete a nonexistent card" do
		delete :destroy, id: 12345
		assert_response :not_found
	end

	test "can get a single card" do
		get :show, id: cards(:one)
		assert_response :success
	end

	test "data for a single card includes the right fields" do
		get :show, id: cards(:one)
		assert_equal cards(:one).id, json_response['card']['id']
		assert_equal cards(:one).front, json_response['card']['front']
		assert_equal cards(:one).back, json_response['card']['back']
	end

	test "returns correct HTTP status code when trying to get a nonexistent card" do
		get :show, id: 12345
		assert_response :not_found
	end

	test "index action returns all cards" do
		get :index
		assert_response :success
		assert_equal Card.count, json_response['cards'].length
	end

	private

	def json_response
		@json_response ||= ActiveSupport::JSON.decode(@response.body)
	end
end
