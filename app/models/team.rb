class Team < ActiveRecord::Base
  def <=> (other)
    other.get_points <=> get_points
  end

  def get_scorers
    scorers = []
    scorers << Scorer.new(p1name,p1team,p1alive)
    scorers << Scorer.new(p2name,p2team,p2alive)
    scorers << Scorer.new(p3name,p3team,p3alive)
    scorers << Scorer.new(p4name,p4team,p4alive)
    scorers << Scorer.new(p5name,p5team,p5alive)

    scorers << Scorer.new(p6name,p6team,p6alive)
    scorers << Scorer.new(p7name,p7team,p7alive)
    scorers << Scorer.new(p8name,p8team,p8alive)
    scorers << Scorer.new(p9name,p9team,p9alive)
    scorers << Scorer.new(p10name,p10team,p10alive)
  end
  
  def get_points
    points = 0
    get_scorers.each { |scorer|
      points = points + scorer.total_points
    }
    points
  end

  def get_players_alive
    alive = 0
    get_scorers.each { |scorer|
      alive = alive + 1 if scorer.alive
    }
    alive
  end
end
