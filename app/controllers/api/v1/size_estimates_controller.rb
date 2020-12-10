# frozen_string_literal: true

class Api::V1::SizeEstimatesController < ApplicationController
  before_action :set_size_estimate, except: %i[index create]
  before_action :set_address, except: %i[index create]

  def index
    @size_estimates = policy_scope([:api, :v1, SizeEstimate])
    authorize [:api, :v1, @size_estimates]
    serialized_response(@size_estimates, SizeEstimate)
  end

  def show
    serialized_response(@size_estimate, SizeEstimate)
  end

  def create
    @size_estimate = SizeEstimate.new(size_estimate_params)
    authorize [:api, :v1, @size_estimate]

    serialized_response(@size_estimate, SizeEstimate) if @size_estimate.save
  end

  def update
    @size_estimate.update(size_estimate_params)
    serialized_response(@size_estimate, SizeEstimate)
  end

  def destroy
    @size_estimate.destroy!
    serialized_response(@size_estimate, SizeEstimate)
  end

  private

    def set_size_estimate
      @size_estimate = SizeEstimate.find(params[:id])
      authorize [:api, :v1, @size_estimate]
    end

    def set_address
      @address = @size_estimate.address
    end

    def size_estimate_params
      params.require(:size_estimate).permit(policy([:api, :v1, SizeEstimate]).permitted_attributes)
    end
end
