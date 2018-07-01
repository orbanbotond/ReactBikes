# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create email: "orban@toptal.com", password: "bikepassword123"

model1 = BikeModel.create text: "Mountain"
model2 = BikeModel.create text: "Road"
model3 = BikeModel.create text: "City"
model4 = BikeModel.create text: "Family"
model5 = BikeModel.create text: "Extravaganza"

Bike.create weight: 1.2, color: Bike::COLORS.first, bike_model: model1, latitude: 48.210033, longitude: 16.363449
Bike.create weight: 2.2, color: Bike::COLORS.last, bike_model: model2, latitude: 44.439663, longitude: 26.096306
Bike.create weight: 5.2, color: Bike::COLORS.last, bike_model: model3, latitude: 47.497913, longitude: 19.040236
Bike.create weight: 3.4, color: Bike::COLORS[1], bike_model: model4, latitude: 47.497913, longitude: 19.040236
Bike.create weight: 4.6, color: Bike::COLORS[2], bike_model: model5, latitude: 51.503399, longitude: -0.119519
