class Team < ActiveRecord::Base
  # teams need both cities and names
  # neither are unique, but the combo has to be
  validates_presence_of :city
  validates :name, presence: true, uniqueness: { scope: :city }

  scope :alphabetical, -> { order(:city, :name) }
end
