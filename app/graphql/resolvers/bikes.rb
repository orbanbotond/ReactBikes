module Resolvers
  module Bikes
    def bikes(id: nil)
      relation = if id.present?
        Bike.where(id: id)
      else
        Bike.all
      end
      relation
    end
  end
end