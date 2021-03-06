require 'test_helper'

class Queries::SizeEstimateTest < ActionDispatch::IntegrationTest
  test 'should get all size estimates as admin' do
    graphql_as_admin

    post graphql_path, params: { query: index_size_estimates_helper }

    assert_response :success
    assert_equal SizeEstimate.count, json['data']['indexSizeEstimates'].size
  end

  test 'should get any size estimate as admin' do
    graphql_as_admin

    post graphql_path, params: { query: show_size_estimate_helper(size_estimates(:one).id) }

    assert_response :success
    assert_equal size_estimates(:one).id, json['data']['showSizeEstimate']['id'].to_i

    post graphql_path, params: { query: show_size_estimate_helper(size_estimates(:two).id) }

    assert_response :success
    assert_equal size_estimates(:two).id, json['data']['showSizeEstimate']['id'].to_i
  end
end
