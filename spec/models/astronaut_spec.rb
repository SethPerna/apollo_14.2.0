require 'rails_helper'

RSpec.describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  describe '.average_age' do
    it 'averages the age of all astronauts' do
      neil = Astronaut.create!(name: 'Neil', age: 1, job: 'Commander')
      buzz = Astronaut.create!(name: 'Buzz', age: 2, job: 'Pilot')
      joe = Astronaut.create!(name: 'Joe', age: 3, job: 'Poop Deck')
      expect(Astronaut.average_age).to eq(2)
    end
  end

  describe '#astro_missions' do
    it 'prints all missions for an astronaut ordered alphabetically' do
      neil = Astronaut.create!(name: 'Neil', age: 1, job: 'Commander')
      apollo = Mission.create!(title: 'Apollo 13', time_in_space: 1)
      cap = Mission.create!(title: 'Cap', time_in_space: 1)
      a = AstronautMission.create!(astronaut_id: "#{neil.id}", mission_id: "#{apollo.id}")
      b = AstronautMission.create!(astronaut_id: "#{neil.id}", mission_id: "#{cap.id}")
      expect(neil.astro_missions).to eq([apollo.title, cap.title])
    end
  end

  describe '#total_time_in_space' do
    it 'adds the total time in space for each astronaut' do
      neil = Astronaut.create!(name: 'Neil', age: 1, job: 'Commander')
      buzz = Astronaut.create!(name: 'Buzz', age: 2, job: 'Pilot')
      joe = Astronaut.create!(name: 'Joe', age: 3, job: 'Poop Deck')
      apollo = Mission.create!(title: 'Apollo 13', time_in_space: 1)
      cap = Mission.create!(title: 'Cap', time_in_space: 3)
      dung = Mission.create!(title: 'Dung', time_in_space: 1)
      a = AstronautMission.create!(astronaut_id: "#{neil.id}", mission_id: "#{apollo.id}")
      b = AstronautMission.create!(astronaut_id: "#{neil.id}", mission_id: "#{cap.id}")
      c = AstronautMission.create!(astronaut_id: "#{joe.id}", mission_id: "#{dung.id}")
      expect(neil.total_time_in_space).to eq(4)
      expect(buzz.total_time_in_space).to eq(0)
      expect(joe.total_time_in_space).to eq(1)
    end
  end
end
