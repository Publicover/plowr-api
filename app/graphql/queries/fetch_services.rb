# frozen_string_literal: true

module Queries
  class FetchServices < Queries::BaseQuery
    type [Types::ServiceType], null: false

    def resolve
      unless context[:session][:token] && context[:current_user]
        raise(ExceptionHandler::InvalidToken, Message.invalid_token)
      end

      Service.all.order(created_at: :asc)
    end
  end
end