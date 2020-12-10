# frozen_string_literal: true

class Api::V1::ServicesController < ApplicationController
  before_action :set_service, except: [:index, :create]

  def index
    @services = Service.all
    serialized_response(@services, Service)
  end

  def show
    serialized_response(@service, Service)
  end

  def create
    @service = Service.new(service_params)

    serialized_response(@service, Service) if @service.save
  end

  def update
    @service.update(service_params)
    serialized_response(@service, Service)
  end

  def destroy
    @service.requests.destroy_all
    @service.destroy!
    serialized_response(@service, Service)
  end

  private

    def set_service
      @service = Service.find(params[:id])
      authorize [:api, :v1, @service]
    end

    def service_params
      params.require(:service).permit(policy([:api, :v1, Service]).permitted_attributes)
    end
end
