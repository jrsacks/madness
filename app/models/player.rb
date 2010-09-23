class Player < ActiveRecord::Base
  validates_presence_of :name, :team, :points, :boxid
  validates_numericality_of :points
  validate :points_must_be_atleast_zero

  def <=> (other)
    other.points <=> points
  end

protected
  def points_must_be_atleast_zero
    errors.add(:points, 'should be atleast 0') if points.nil? || points < 0
  end

private
  def get_top
    players = []
    Player.group_by(&:name).each do |name, games|
      players << "#{name} #{games.map(&:points).join(',')}"
    end
    players
  end
end
