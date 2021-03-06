# frozen_string_literal: true

module Mutations
  class AuthUser < Mutations::BaseMutation
    argument :params, Types::Input::UserInputType, required: true

    field :token, String, null: true
    field :user, Types::Api::UserType, null: true

    def resolve(params:)
      auth_params = Hash(params)

      user = User.find_by(email: auth_params[:email])

      return unless user

      token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call

      context[:session][:token] = token
      context[:current_user] = user

      { user: user, token: token }
    end
  end
end
