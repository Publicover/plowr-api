# frozen_string_literal: true

module Api
  module V1
    class ServicePolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          scope.all
        end
      end

      def index?
        true
      end

      def show?
        index?
      end

      def create?
        return true if user.admin?

        false
      end

      def update?
        create?
      end

      def destroy?
        create?
      end

      def permitted_attributes
        %i[name price_per_sq_ft price_per_inch_of_snow price_per_season]
      end
    end
  end
end
