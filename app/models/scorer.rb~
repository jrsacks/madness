class Scorer
  attr_reader :name, :team, :total_points, :points, :alive

  def <=> (other)
    other.total_points <=> total_points
  end

  def initialize(name, team, alive)
    @name = name
    @team = team
    @alive = alive
    @points = get_points
    @total_points = get_total
  end
private
  def get_points
    entries = Player.find(:all, :conditions => {:name => @name, :team => @team}, :order => :boxid, :select => "points")
    points = []
    entries.each { |e|
      points << e.points
    }
    points.join(' ')
  end

  def get_total
    sum = 0
    @points.split(' ').each {|point|
      sum = sum + point.to_i
    }
    sum
  end

end
