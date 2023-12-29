require 'csv'
csv_file_path = Rails.root.join('db', 'data', 'comunas.csv')

if File.exist?(csv_file_path)
  puts 'Importing communities...'

  csv_data = CSV.read(csv_file_path, headers: true, encoding: 'utf-8')
  csv_data.each do |row|
    Community.create!(id: row['id'], name: row['name'])
  end

  puts 'Communities imported!'
else
  puts 'Communities not imported!'
end

puts 'creating properties...'
Property.create!(
  property_types: 0,
  price: 100,
  currencies: 0,
  address: 'Av. Siempre Viva 123',
  area: 100,
  nro_rooms: 3,
  nro_bathrooms: 2,
  description: 'Departamento en arriendo',
  community_id: 1
)
puts 'properties created!'
