class CreateTeams < ActiveRecord::Migration
  def self.up
    drop_table :teams
    create_table :teams do |t|
      t.string :name
      t.string :p1name
      t.string :p1team
      t.string :p2name
      t.string :p2team
      t.string :p3name
      t.string :p3team
      t.string :p4name
      t.string :p4team
      t.string :p5name
      t.string :p5team
      t.string :p6name
      t.string :p6team
      t.string :p7name
      t.string :p7team
      t.string :p8name
      t.string :p8team
      t.string :p9name
      t.string :p9team
      t.string :p10name
      t.string :p10team

      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
