require 'test_helper'

class CreateRoutesJobTest < ActiveJob::TestCase
  include ActiveJob::TestHelper

  setup do
    @base = base_locations(:one)
  end

  test 'job can be queued' do
    assert_enqueued_jobs 0
    CreateRoutesJob.perform_later(@base.zip)
    assert_enqueued_jobs 1
  end

  test 'can assemble routes and create service deliveries' do
    # Fudging here: gonna show that this job creats a service_delivery for each
    #   service_request, so I need to delete what I have leftover from seeds
    ServiceDelivery.delete_all
    populate_daily_routes_data

    VCR.use_cassette('create routes job') do
      assert_difference('ServiceDelivery.count', +5) do
        CreateRoutesJob.new.perform(96146)
      end
    end
    assert_equal ServiceRequest.count, ServiceDelivery.count
  end
end