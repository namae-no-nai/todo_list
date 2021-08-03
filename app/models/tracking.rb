class Tracking < ApplicationRecord
  validates :event, :properties, presence: true
end
