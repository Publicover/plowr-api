require 'test_helper'

class Queries::EarlyBirdTest < ActionDispatch::IntegrationTest
  test 'should get owned early birds as customer' do
    addresses(:blank).destroy
    graphql_as_customer

    post graphql_path, params: { query: index_early_birds_helper }

    assert_response :success
    assert_equal users(:customer).early_birds.count, json['data']['indexEarlyBirds'].size
    assert EarlyBird.count > users(:customer).early_birds.count
  end

  test 'should only get own early bird as customer' do
    graphql_as_customer

    post graphql_path, params: { query: show_early_bird_helper(early_birds(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']

    post graphql_path, params: { query: show_early_bird_helper(early_birds(:two).id) }

    assert_response :success
    assert_equal early_birds(:two).id, json['data']['showEarlyBird']['id'].to_i
  end
end
