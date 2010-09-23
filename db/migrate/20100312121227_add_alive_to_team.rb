class AddAliveToTeam < ActiveRecord::Migration
  def self.up
    add_column :teams, :p1alive, :boolean, :default => true
    add_column :teams, :p2alive, :boolean, :default => true
    add_column :teams, :p3alive, :boolean, :default => true
    add_column :teams, :p4alive, :boolean, :default => true
    add_column :teams, :p5alive, :boolean, :default => true
    add_column :teams, :p6alive, :boolean, :default => true
    add_column :teams, :p7alive, :boolean, :default => true
    add_column :teams, :p8alive, :boolean, :default => true
    add_column :teams, :p9alive, :boolean, :default => true
    add_column :teams, :p10alive, :boolean, :default => true
  end

  def self.down
    remove_column :teams, :p10alive
    remove_column :teams, :p9alive
    remove_column :teams, :p8alive
    remove_column :teams, :p7alive
    remove_column :teams, :p6alive
    remove_column :teams, :p5alive
    remove_column :teams, :p4alive
    remove_column :teams, :p3alive
    remove_column :teams, :p2alive
    remove_column :teams, :p1alive
  end
end
