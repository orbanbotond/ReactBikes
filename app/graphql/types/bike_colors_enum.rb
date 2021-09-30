module Types
  class BikeColorsEnum < ::Types::Base::Enum
    Bike::COLORS.each { |color| value color }
  end
end
