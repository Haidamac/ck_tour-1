class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  enum confirmation: { pending: 0, approved: 1, cancelled: 2 }

  validates :number_of_peoples, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :enough_seats, on: :create

  def enough_seats
    return unless number_of_peoples > tour.seats - tour.appointments.where.not(id:)
                                                       .pluck(:number_of_peoples).sum

    errors.add(:room, 'is not enough free seats in the selected tour')
  end
end
