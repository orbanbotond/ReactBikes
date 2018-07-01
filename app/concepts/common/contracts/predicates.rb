# frozen_string_literal: true

module Common
  module Contracts
    module Predicates
      include Dry::Logic::Predicates

      predicate(:email?) do |value|
        value.match?(URI::MailTo::EMAIL_REGEXP)
      end
    end
  end
end
