module Lib::Scalars
  class DateTime < Base
    description 'DateTime'

    def self.coerce_input(input_value, _context)
      Time.zone.parse(input_value)&.to_datetime
    end

    def self.coerce_result(ruby_value, _context)
      ruby_value.utc.iso8601
    end
  end
end
