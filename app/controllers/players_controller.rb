class PlayersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  require 'open-uri'
  require 'hpricot'
  
  class Playa
    def initialize(team, name, points)
      @name = name
      @points = points
      @team = team
    end
    def <=> (other)
      other.points <=> points
    end
    def owned
      Team.find(:all).each { |team|
        return team.name if @name == team.p1name && @team == team.p1team
      }
      return "undrafted"
    end
    attr_reader :name, :points, :team
  end
    
  def update_page()
    get_box_links_from_date(params[:player]).each { |box|
      add_box_main box unless FinalBox.exists?(:boxid => box)
    }    
    redirect_to :action => 'index'
  end

  def add_box()
    add_box_main params[:player][:boxid]
    redirect_to :action => 'index'
  end

  # GET /players
  # GET /players.xml
  def index
    @players = Player.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @players }
    end
  end

  def top
    @points = []
    @players = Player.find(:all, :group => "name")
    @players.each do |player|
      sum = 0
      name = player.name.gsub("'","")
      Player.find(:all, :conditions => "name = '#{name}'").each do |game|
        sum = sum + game.points
        end
      @points << Playa.new(player.team, player.name, sum)
    end
    respond_to do |format|
      format.html
    end
  end

  # GET /players/1
  # GET /players/1.xml
  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/new
  # GET /players/new.xml
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.xml
  def create
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        flash[:notice] = 'Player was successfully created.'
        format.html { redirect_to(@player) }
        format.xml  { render :xml => @player, :status => :created, :location => @player }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.xml
  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        flash[:notice] = 'Player was successfully updated.'
        format.html { redirect_to(@player) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.xml
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to(players_url) }
      format.xml  { head :ok }
    end
  end

private
  def final(box)
    stringIo = open(box)
    html = stringIo.read
    html.each { |line|
      return true if line.include? "Final</span>&nbsp;"
    }
    return false
  end
  
  def get_players_from_game(box)
    stringIo = open(box)
    html = stringIo.read
    (1..2).each { |i| html.gsub!("ysprow#{i}","ysprow") }  
    
    player_lines = []
    count = 1
    final = false
    html.each { |line|
      final = true if line.include? "Final</span>&nbsp;"
      player_lines << count if line.include? "ysprow\" align="
      count = count + 1
    }

    diff = player_lines[1] - player_lines[0]
    team_one_players = 0
    (player_lines.length - 1).times { |i|
      if player_lines[i+1] - player_lines[i] != diff
        team_one_players = i+1
        end
    }
    logger.info "team one players: #{team_one_players}"

    doc = Hpricot(html)  
    teams = []
    doc.search("tr[@class=yspsctbg]/td").each { |t|
      if teams.length < 2 && final || teams.length < 3
        teams << t.inner_html.sub(/.*&nbsp;/,"").strip  
      end
    }
    teams.each { |t| logger.info "#{t}"} 
    team = final ? 0 : 1
    players = []
    doc.search("tr[@class=ysprow]").each {|p|
      line = p.inner_html.split("<\/td>")      
      name = get_name(line.first)
      unless name.nil?
        line.pop
        points = line.last.gsub!(/\D/,"")
        players << Playa.new(teams[team],name,points)
        team = final ? 1: 2 if players.length >= team_one_players
      end
    }
    players
  end
  
  def get_name(line)
    name = line.match(/[A-Z]\. [a-zA-Z\'\-]*/)
    full = line.match(/[A-Z][A-Za-z\'\-\.]*\ [A-Z][a-zA-Z\'\-]*/)
    return nil if name.nil? && full.nil?
    if name
      name[0]
    else
      first_last = full[0].split(' ')
      "#{first_last[0][0,1]}. #{first_last[1]}"
    end
  end

  def get_box_links_from_date(page)
    boxes = []
    open(page) { |f| 
      f.each_line { |line|
        if line.include? "\/ncaab\/boxscore?gid="                 
          boxes << "http://rivals.yahoo.com#{line.match(/\/ncaab\/boxscore\?gid=[0-9]*/)}"
        end
      }
    }
    boxes
  end

  def add_box_main(boxid)   
    players = get_players_from_game(boxid)
    final = final(boxid)
    FinalBox.new(:boxid => boxid).save if final
    
    players.each { |player|
      unless Player.exists?(:name => player.name, :team => player.team, :boxid =>boxid)
        Player.new(:name => player.name, :team => player.team, :points => player.points, :boxid => boxid).save
      else
        p = Player.find(:first, :conditions => {:name => player.name, :team => player.team, :boxid => boxid})
        Player.update(p.id, :name => player.name, :team => player.team, :points => player.points, :boxid => boxid)
      end
      logger.info "#{player.name} #{player.team} #{player.points}"
    }

    kill_lost_players(players) if final
  end

  def kill_lost_players(players)
    team1 = players.first.team
    team2 = players.last.team

    team1_score = 0
    team2_score = 0
    
    players.each { |player|
      if player.team == team1
        team1_score = team1_score + player.points.to_i
      else
        team2_score = team2_score + player.points.to_i
      end
    }
    
    loser = team1
    loser = team2 if team2_score < team1_score

    players.each { |player|
      if player.team == loser
        teams = Team.find(:all)
        teams.each { |team|
          Team.update(team.id, :p1alive => false) if player.name == team.p1name
          Team.update(team.id, :p2alive => false) if player.name == team.p2name
          Team.update(team.id, :p3alive => false) if player.name == team.p3name
          Team.update(team.id, :p4alive => false) if player.name == team.p4name
          Team.update(team.id, :p5alive => false) if player.name == team.p5name
          Team.update(team.id, :p6alive => false) if player.name == team.p6name
          Team.update(team.id, :p7alive => false) if player.name == team.p7name
          Team.update(team.id, :p8alive => false) if player.name == team.p8name
          Team.update(team.id, :p9alive => false) if player.name == team.p9name
          Team.update(team.id, :p10alive => false) if player.name == team.p10name
        }
      end
    }
  end

end
