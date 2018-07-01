# frozen_string_literal: true

class User < ApplicationRecord
  has_many :reservations

  def valid_password?(value)
    password == value
  end
end
