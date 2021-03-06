require 'test_helper'

class Mutations::AddressTest < ActionDispatch::IntegrationTest
  test 'cannot create address for another user as customer' do
    graphql_as_customer

    post graphql_path, params: { query: create_address_helper(users(:admin).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'can create own address as customer' do
    graphql_as_customer

    assert_difference('Address.count') do
      VCR.use_cassette('graphql customer add address') do
        post graphql_path, params: { query: create_address_helper(users(:customer).id) }
      end
    end

    assert_response :success
    assert_not_nil Address.last.latitude
    assert_not_nil Address.last.longitude
  end

  test 'cannot update another address as customer' do
    name = Faker::Lorem.word
    graphql_as_customer

    post graphql_path, params: { query: update_address_helper(addresses(:one).id, name) }

    assert_response :success
    assert_equal json['errors'][0]['message'], Message.unauthorized
  end

  test 'can update own address as customer' do
    name = Faker::Lorem.word
    graphql_as_customer

    post graphql_path, params: { query: update_address_helper(addresses(:two).id, name) }

    assert_response :success
    assert_equal addresses(:two).reload.name, json['data']['updateAddress']['address']['name']
  end

  test 'can destroy own address as customer' do
    address = addresses(:two)
    graphql_as_customer

    assert_difference('Address.count', -1) do
      post graphql_path, params: { query: destroy_address_helper(address.id) }
    end

    assert_response :success
    assert_equal Message.is_deleted(address), json['data']['destroyAddress']['isDeleted']

    post graphql_path, params: { query: destroy_address_helper(addresses(:one).id) }
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
