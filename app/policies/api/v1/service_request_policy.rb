# frozen_string_literal: true

module Api
  module V1
    class ServiceRequestPolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          scope.all
        end
      end

      def index?
        return true if user.admin?

        false
      end

      def show?
        true
      end

      def create?
        return true if user.admin? || user.customer?
      end

      def update?
        create?
      end

      def destroy?
        create?
      end

      def permitted_attributes
        [:address_id, :approved, :recurring, service_ids: []]
      end
    end
  end
end
