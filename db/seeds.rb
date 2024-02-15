# db/seeds.rb

# Load data from data.json in the assets folder
json_file = Rails.root.join('app', 'assets', 'data.json')
json_data = JSON.parse(File.read(json_file))

# Seed the database
json_data.each do |person_data|
  person = Person.create!(name: person_data['name'])

  detail_data = person_data['info']
  
  # Ensure the person object is valid before trying to create a detail
  if person.valid?
    person.create_detail!(
      email: detail_data['email'],
      title: detail_data['title'],
      age: detail_data['age'],
      phone: detail_data['phone']
    )
  else
    puts "Error creating person: #{person.errors.full_messages.join(', ')}"
  end
end
