class StrictSchema < Dry::Validation::Schema
  def strict_keys?(input)
    (input.keys - self.rules.keys).empty?
  end

  def self.messages
    super.merge(en: { errors: { strict_keys?: 'has unknown keys' } } )
  end
end
