# frozen_string_literal: true

module Api
  module V1
    class AddressPolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          return scope.all if user.admin? || user.driver?
          return scope.where(user_id: user.id) if user.customer?
        end
      end

      def index?
        true
      end

      def show?
        index?
      end

      def create?
        index?
      end

      def update?
        index?
      end

      def destroy?
        # binding.pry
        return true if user.admin? || user.customer?
        return false if user.driver?
      end

      def permitted_attributes
        %i[
          line_1
          line_2
          city
          state
          zip
          user_id
          estimate_complete
          estimate_confirmed
          actual_footage
          name
          latitude
          longitude
        ]
      end
    end
  end
end
