require 'test_helper'

class Mutations::AddressTest < ActionDispatch::IntegrationTest
  test 'can create any address as admin' do
    graphql_as_admin

    assert_difference('Address.count') do
      VCR.use_cassette('graphql admin add address') do
        post graphql_path, params: { query: add_address_helper(users(:three).id) }
      end
    end

    assert_response :success
    assert_not_nil Address.last.latitude
    assert_not_nil Address.last.longitude
  end

  test 'can update any address as admin' do
    graphql_as_admin

    post graphql_path, params: { query: update_address_helper(addresses(:one).id) }

    assert_response :success
    assert_equal addresses(:one).reload.name, json['data']['updateAddress']['address']['name']
  end
end