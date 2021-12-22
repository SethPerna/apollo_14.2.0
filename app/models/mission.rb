class Mission < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :time_in_space
  has_many :astronaut_missions
  has_many :astronauts, through: :astronaut_missions
end
