module Resolvers
  module Bikes
    def bikes(id: nil)
      return Bike.where(id: id) if id.present?

      Bike.all
    end
  end
end