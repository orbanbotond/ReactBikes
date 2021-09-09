require 'pact'

Pact.provider_states_for 'Bikes UI' do
  provider_state "a bike exists" do
    set_up do
      model1 = BikeModel.create text: "Mountain"
      Bike.create weight: 1.2, color: Bike::COLORS.first, bike_model: model1, latitude: 48.210033, longitude: 16.363449, average_rating: 1
    end

    tear_down do
      Bike.destroy_all
      BikeModel.destroy_all
    end
  end


  provider_state "a bike with reservation exists" do
    set_up do
      model1 = BikeModel.create text: "Mountain"
      bike = Bike.create weight: 1.2, color: Bike::COLORS.first, bike_model: model1, latitude: 48.210033, longitude: 16.363449, average_rating: 1
      user = User.create email: 'boti@gmail.com'
      Reservation.create user: user, bike: bike
    end

    tear_down do
      Bike.destroy_all
      BikeModel.destroy_all
      Reservation.destroy_all
      User.destroy_all
    end
  end

  provider_state "a thing does not exist" do
    no_op # If there's nothing to do because the state name is more for documentation purposes,
          # you can use no_op to imply this.
  end
end