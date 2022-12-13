# frozen_string_literal: true

# Class User serves as the Rails model for entity "user" in this app
class User < ApplicationRecord
  validates :username,  presence: true, uniqueness: { case_sensitive: false },
                        length: { minimum: 3, maximum: 25 }
  has_secure_password
end
