# frozen_string_literal: true

module BaseLocationsMutation
  def create_base_location_helper
    <<~GQL
      mutation {
        createBaseLocation(input:{params:{
          name: "Harbor High",
          line1: "221 Lake Ave.",
          city: "Ashtabula",
          state: "Ohio",
          zip: "44004"
        }}) {
          baseLocation {
            id
            name
            line1
            line2
            city
            state
            latitude
            longitude
          }
        }
      }
    GQL
  end

  def update_base_location_helper(id, name)
    <<~GQL
      mutation {
        updateBaseLocation(input:{id:#{id}, params:{
          name: "#{name}",
        }}) {
          baseLocation {
            id
            name
            line1
            line2
            city
            state
            latitude
            longitude
          }
        }
      }
    GQL
  end

  def destroy_base_location_helper(id)
    <<~GQL
      mutation {
        destroyBaseLocation(input:{id:#{id}}) {
          isDeleted
        }
      }
    GQL
  end
end
