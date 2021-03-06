# frozen_string_literal: true

module Mutations
  module Update
    class UpdateDailyRoute < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :params, Types::Input::DailyRouteInputType, required: true

      field :daily_route, Types::Api::DailyRouteType, null: false

      def ready?(**_args)
        error_unless_admin
      end

      def resolve(id:, params:)
        check_logged_in_user

        daily_route_params = Hash(params)
        daily_route = DailyRoute.find(id)
        daily_route.update(daily_route_params)

        { daily_route: daily_route }
      end
    end
  end
end
