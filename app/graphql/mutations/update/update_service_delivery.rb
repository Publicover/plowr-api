# frozen_string_literal: true

module Mutations
  module Update
    class UpdateServiceDelivery < Mutations::BaseMutation
      # OK, so there's not actually a reason to use this.
      # This is a record generated by the back end for when
      # it's time to roll out the plows--more of a payment record
      # than anything.

      argument :id, ID, required: true
      argument :params, Types::Input::ServiceDeliveryInputType, required: true

      field :service_delivery, Types::Api::ServiceDeliveryType, null: false
      field :address, Types::Api::AddressType, null: true

      def ready?(**_args)
        error_unless_admin
      end

      def resolve(id:, params:)
        check_logged_in_user

        service_delivery_params = Hash(params)
        service_delivery = ServiceDelivery.find(id)
        service_delivery.update(service_delivery_params)
        address = service_delivery.address

        { service_delivery: service_delivery, address: address }
      end
    end
  end
end
