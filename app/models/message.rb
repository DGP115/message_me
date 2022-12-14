# frozen_string_literal: true

# Class Message serves as the Rails model for entity "message" in this app
class Message < ApplicationRecord
  belongs_to :user
  validates :body, presence: true
end
