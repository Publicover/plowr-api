# frozen_string_literal: true

module Mutations
  class UpdateServiceDelivery < Mutations::BaseMutation
    # OK, so there's not actually a reason to use this.
    # This is a record generated by the back end for when
    # it's time to roll out the plows--more of a payment record
    # than anything.

    argument :id, ID, required: true
    argument :params, Types::Input::ServiceDeliveryInputType, required: true

    field :service_delivery, Types::ServiceDeliveryType, null: false
    field :address, Types::AddressType, null: true

    def ready?(**args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(id:, params:)
      service_delivery_params = Hash(params)
      service_delivery = ServiceDelivery.find(id)
      address = service_delivery.address

      if service_delivery.update(service_delivery_params)
        { service_delivery: service_delivery, address: address }
      else
        { errors: service_delivery.errors.full_messages }
      end
    end
  end
end
