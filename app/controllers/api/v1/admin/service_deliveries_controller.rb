# frozen_string_literal: true

class Api::V1::Admin::ServiceDeliveriesController < ApplicationController
  before_action :set_service_delivery, except: %i[index create]

  def index
    @service_deliveries = policy_scope([:api, :v1, ServiceDelivery])
    authorize [:api, :v1, @service_deliveries]

    serialized_response(@service_deliveries)
  end

  def show
    serialized_response(@service_delivery)
  end

  def create
    @service_delivery = ServiceDelivery.new(service_delivery_params)
    authorize [:api, :v1, @service_delivery]
    return unless @service_delivery.save

    @service_delivery.confirm_siblings
    @service_delivery.update(total_cost: @service_delivery.calculate_total_cost)
    serialized_response(@service_delivery)
  end

  def update
    @service_delivery.update(service_delivery_params)
    serialized_response(@service_delivery)
  end

  def destroy
    @service_delivery.destroy
    serialized_response(@service_delivery)
  end

  private

    def set_service_delivery
      @service_delivery = ServiceDelivery.find(params[:id])
      authorize [:api, :v1, @service_delivery]
    end

    def service_delivery_params
      params.require(:service_delivery).permit(policy([:api, :v1, ServiceDelivery]).permitted_attributes)
    end
end
