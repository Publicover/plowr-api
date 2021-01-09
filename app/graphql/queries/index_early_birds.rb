# frozen_string_literal: true

module Queries
  class IndexEarlyBirds < Queries::BaseQuery
    type [Types::EarlyBirdType], null: false

    def resolve
      check_logged_in_user

      EarlyBird.all.order(created_at: :asc)
    end
  end
end