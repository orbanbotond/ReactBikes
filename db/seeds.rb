# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create email: "orban@toptal.com", password: "bikepassword123"

BikeModel.create text: 'Mountain'
BikeModel.create text: 'Road'
BikeModel.create text: 'City'
BikeModel.create text: 'Family'
BikeModel.create text: 'Extravaganza'
