require 'test_helper'

class Queries::ServiceDeliveryTest < ActionDispatch::IntegrationTest
  test 'should get all service deliveries as admin' do
    graphql_as_admin

    post graphql_path, params: { query: index_service_deliveries_helper }

    assert_response :success
    assert_equal ServiceDelivery.count, json['data']['indexServiceDeliveries'].size
  end

  test 'should get any service delivery as admin' do
    graphql_as_admin

    post graphql_path, params: { query: show_service_delivery_helper(service_deliveries(:one).id) }

    assert_response :success
    assert_equal service_deliveries(:one).id, json['data']['showServiceDelivery']['id'].to_i
  end
end
