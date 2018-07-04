# frozen_string_literal: true

class User < ApplicationRecord
  has_many :reservations, dependent: :destroy

  def password=(pwd_candidate)
    self.hashed_password = self.class.pwd_hash(pwd_candidate)
  end

  def valid_password?(pwd_candidate)
    hashed_password == self.class.pwd_hash(pwd_candidate)
  end

  def session_token
    @session_token ||= self.class.pwd_hash("#{hashed_password} #{SecureRandom.uuid}")
  end

  class <<self
    def pwd_hash(pwd_candidate)
      return "" unless pwd_candidate.present?

      Digest::MD5.hexdigest pwd_candidate
    end
  end
end
