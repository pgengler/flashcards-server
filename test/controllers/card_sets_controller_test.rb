require 'test_helper'

class CardSetsControllerTest < ActionController::TestCase
	test "index action returns all card sets" do
		get :index
		assert_response :success
		assert_equal CardSet.count, json_response['card_sets'].length
	end

	private

	def json_response
		@json_response ||= ActiveSupport::JSON.decode(@response.body)
	end
end
