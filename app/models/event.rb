class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_many :reservations, foreign_key: :attended_event_id
  has_many :attendees, through: :reservations, dependent: :destroy

  scope :past, -> { where('date < ? ', Date.current) }
  scope :future, -> { where('date > ?', Date.current) }
end