class Location < ApplicationRecord
  validates :name, presence: true
  validates :input, presence: true

  after_create_commit { broadcast_prepend_to "locations" }
  after_destroy_commit { broadcast_remove_to "locations" }
end
