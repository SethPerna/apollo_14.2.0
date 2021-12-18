class CreateAstronauts < ActiveRecord::Migration[5.2]
  def change
    create_table :astronauts do |t|
      t.string :name
      t.integer :age
      t.string :job

      t.timestamps
    end
  end
end
