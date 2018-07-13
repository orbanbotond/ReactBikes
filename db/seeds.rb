# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create email: "orban@toptal.com", password: "bikepassword123", admin:true
user = User.create email: "boti@toptal.com", password: "bikepassword123", admin:false

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

Reservation.create start_date: 3.day.ago, end_date: 2.day.ago, rating: 4, user_id: 2, bike_id: 1
Reservation.create start_date: 3.day.ago, end_date: 2.day.ago, user_id: 2, bike_id: 1
Reservation.create start_date: 4.days.from_now, end_date: 5.days.from_now, rating: 4, user_id: 2, bike_id: 1
Reservation.create start_date: 3.days.from_now, end_date: 4.days.from_now, user_id: 2, bike_id: 1, cancelled: true
