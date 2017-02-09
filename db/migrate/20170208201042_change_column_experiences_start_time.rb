class ChangeColumnExperiencesStartTime < ActiveRecord::Migration

  def self.up
    change_table :experiences do |t|
      t.change :start_time, :time
      t.change :end_time, :time
    end
  end

  def self.down
    change_table :experiences do |t|
      t.change :start_time, :datetime
      t.change :end_time, :datetime
    end
  end
end
