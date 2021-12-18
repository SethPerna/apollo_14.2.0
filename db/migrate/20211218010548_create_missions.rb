class CreateMissions < ActiveRecord::Migration[5.2]
  def change
    create_table :missions do |t|
      t.string :title
      t.integer :time_in_space

      t.timestamps
    end
  end
end
