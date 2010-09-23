class CreateFinalBoxes < ActiveRecord::Migration
  def self.up
    create_table :final_boxes do |t|
      t.string :boxid

      t.timestamps
    end
  end

  def self.down
    drop_table :final_boxes
  end
end
