module AddressesMutation
  def add_address_helper(user_id)
    <<~GQL
      mutation {
        addAddress(input:{params:{
          line1:"4717 Main Ave",
          city:"Ashtabula",
          state:"OH",
          zip:"44004",
          name:"Ashtabula City Hall",
          driveway:2,
          userId:#{user_id}
          }}) {
            address {
              id
              line1
              city
              state
              zip
              name
              driveway
              latitude
              longitude
              user {
                id
                email
                fName
                lName
                phone
              }
            }
          }
        }
    GQL
  end

  def update_address_helper(id)
    <<~GQL
      mutation {
        updateAddress(input:{id:#{id}, params:{
          name:"City Hall"
        }}) {
          address {
            id
            line1
            city
            state
            zip
            name
          }
        }
      }
    GQL
  end
end