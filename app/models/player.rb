class Player < ActiveRecord::Base
  belongs_to :team

  validates_presence_of :first_name, :last_name
  validates_numericality_of :overall, only_integer: true, allow_blank: true
  validate :player_belongs_to_team

  # scopes
  scope :alphabetical, -> { order(:last_name, :first_name) }
  scope :by_overall, -> { order(overall: :desc) }

  # get the player's name in LAST, FIRST format
  def name
    "#{last_name}, #{first_name}"
  end

  # get the player's name in FIRST LAST format
  def proper_name
    "#{first_name} #{last_name}"
  end

  private
  def player_belongs_to_team
    if Team.find_by_id(team_id).nil?
      errors.add(:team, "does not exist in the system")
      return false
    end
    true
  end
end
