# frozen_string_literal: true

module Types
  module Api
    class SnowAccumulationType < Types::BaseObject
      def self.authorized?(object, context)
        super && (context[:current_user].admin? ||
                  context[:current_user].driver?)
      end
      field :id, ID, null: true
      field :inches, Integer, null: false
    end
  end
end
