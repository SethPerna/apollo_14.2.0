require 'rails_helper'
describe 'astronauts index page' do
  it 'I see a list of all astronauts with name, age and job' do
    neil = Astronaut.create!(name: 'Neil', age: 1, job: 'Commander')
    buzz = Astronaut.create!(name: 'Buzz', age: 2, job: 'Pilot')
    visit '/astronauts'
    expect(page).to have_content(neil.name)
    expect(page).to have_content(neil.age)
    expect(page).to have_content(neil.job)
    expect(page).to have_content(buzz.name)
    expect(page).to have_content(buzz.age)
    expect(page).to have_content(buzz.job)
  end

  it 'I see the average age of all astronauts' do
    neil = Astronaut.create!(name: 'Neil', age: 1, job: 'Commander')
    buzz = Astronaut.create!(name: 'Buzz', age: 2, job: 'Pilot')
    joe = Astronaut.create!(name: 'Joe', age: 3, job: 'Poop Deck')
    visit '/astronauts'
    expect(page).to have_content('Average Age: 2')
  end

  it 'I see a list of the missions for each astronaut in alphabetical order' do
    neil = Astronaut.create!(name: 'Neil', age: 1, job: 'Commander')
    buzz = Astronaut.create!(name: 'Buzz', age: 2, job: 'Pilot')
    joe = Astronaut.create!(name: 'Joe', age: 3, job: 'Poop Deck')
    apollo = Mission.create!(title: 'Apollo 13', time_in_space: 1)
    cap = Mission.create!(title: 'Cap', time_in_space: 1)
    dung = Mission.create!(title: 'Dung', time_in_space: 1)
    a = AstronautMission.create!(astronaut_id: "#{neil.id}", mission_id: "#{apollo.id}")
    b = AstronautMission.create!(astronaut_id: "#{neil.id}", mission_id: "#{cap.id}")
    c = AstronautMission.create!(astronaut_id: "#{joe.id}", mission_id: "#{dung.id}")
    visit '/astronauts'
    expect(page).to have_content(apollo.title)
    expect(page).to have_content(cap.title)
    expect(page).to have_content(dung.title)
    expect(apollo.title).to appear_before(cap.title)
    expect(cap.title).to appear_before(dung.title)
  end

  it 'I see the total time in space for each astronaut' do
    neil = Astronaut.create!(name: 'Neil', age: 1, job: 'Commander')
    buzz = Astronaut.create!(name: 'Buzz', age: 2, job: 'Pilot')
    joe = Astronaut.create!(name: 'Joe', age: 3, job: 'Poop Deck')
    apollo = Mission.create!(title: 'Apollo 13', time_in_space: 1)
    cap = Mission.create!(title: 'Cap', time_in_space: 3)
    dung = Mission.create!(title: 'Dung', time_in_space: 1)
    a = AstronautMission.create!(astronaut_id: "#{neil.id}", mission_id: "#{apollo.id}")
    b = AstronautMission.create!(astronaut_id: "#{neil.id}", mission_id: "#{cap.id}")
    c = AstronautMission.create!(astronaut_id: "#{joe.id}", mission_id: "#{dung.id}")
    visit '/astronauts'
    expect(page).to have_content("Total Time in Space: #{neil.total_time_in_space}")
    expect(page).to have_content("Total Time in Space: #{buzz.total_time_in_space}")
    expect(page).to have_content("Total Time in Space: #{joe.total_time_in_space}")
  end
end
