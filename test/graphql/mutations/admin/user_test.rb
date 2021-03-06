require 'test_helper'

class Mutations::UserTest < ActionDispatch::IntegrationTest
  test 'should create user as admin' do
    graphql_as_admin

    assert_difference('User.count') do
      post graphql_path, params: { query: create_user_helper }
    end

    assert_response :success
  end

  test 'should update any user as admin' do
    name = "Frank"
    graphql_as_admin

    post graphql_path, params: { query: update_user_helper(users(:driver).id, name) }

    assert_response :success
    assert_equal users(:driver).reload.f_name, name
  end

  test 'should destroy user as admin' do
    user = users(:driver)
    graphql_as_admin

    post graphql_path, params: { query: destroy_user_helper(user.id) }

    assert_response :success
    assert_equal Message.is_deleted(user), json['data']['destroyUser']['isDeleted']
  end
end
