require 'test_helper'

class Mutations::PlowTest < ActionDispatch::IntegrationTest
  test 'can create plow as customer' do
    graphql_as_customer

    post graphql_path, params: { query: add_plow_helper(users(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should update plow as customer' do
    graphql_as_customer

    post graphql_path, params: { query: update_plow_helper(plows(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should destroy plow as customer' do
    graphql_as_customer

    post graphql_path, params: { query: destroy_plow_helper(plows(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
