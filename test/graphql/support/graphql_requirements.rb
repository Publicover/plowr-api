# frozen_string_literal: true

require_relative '../support/mutations/addresses_mutation'
require_relative '../support/mutations/auth_mutation'
require_relative '../support/mutations/base_locations_mutation'
require_relative '../support/mutations/daily_routes_mutation'
require_relative '../support/mutations/early_birds_mutation'
require_relative '../support/mutations/graphql_login'
require_relative '../support/mutations/plows_mutation'
require_relative '../support/mutations/service_requests_mutation'
require_relative '../support/mutations/service_deliveries_mutation'
require_relative '../support/mutations/services_mutation'
require_relative '../support/mutations/size_estimates_mutation'
require_relative '../support/mutations/snow_accumulations_mutation'
require_relative '../support/mutations/users_mutation'
require_relative '../support/queries/addresses_query'
require_relative '../support/queries/base_locations_query'
require_relative '../support/queries/daily_routes_query'
require_relative '../support/queries/early_birds_query'
require_relative '../support/queries/everything_query'
require_relative '../support/queries/plows_query'
require_relative '../support/queries/service_deliveries_query'
require_relative '../support/queries/service_requests_query'
require_relative '../support/queries/services_query'
require_relative '../support/queries/size_estimates_query'
require_relative '../support/queries/snow_accumulations_query'
require_relative '../support/queries/users_query'

module GraphqlRequirements
  class Minitest::Test
    include AddressesMutation
    include AddressesQuery
    include AuthMutation
    include BaseLocationsMutation
    include BaseLocationsQuery
    include DailyRoutesMutation
    include DailyRoutesQuery
    include EarlyBirdsMutation
    include EarlyBirdsQuery
    include EverythingQuery
    include GraphqlLogin
    include PlowsMutation
    include PlowsQuery
    include ServiceDeliveriesMutation
    include ServiceDeliveriesQuery
    include ServicesMutation
    include ServicesQuery
    include SizeEstimatesMutation
    include SizeEstimatesQuery
    include ServiceRequestsMutation
    include ServiceRequestsQuery
    include SnowAccumulationsMutation
    include SnowAccumulationsQuery
    include UsersMutation
    include UsersQuery
  end
end
