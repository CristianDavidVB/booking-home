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

puts 'creating users...'
user = User.create!(
  email: 'prueba@prueba.com',
  password: '123456'
)
puts 'users created!'

puts 'creating property1...'
property1 = Property.new(
  property_types: 0,
  price: 100,
  currencies: 0,
  address: 'Av. Siempre Viva 123',
  area: 100,
  nro_rooms: 3,
  nro_bathrooms: 2,
  description: 'Departamento en arriendo',
  community_id: 1,
  user_id: user.id,
)

property1.photo.attach(io: File.open('app/assets/images/casa1.jpg'), filename: 'property1.jpg', content_type: 'image/jpg')
property1.save!

puts 'property1 created!'

puts 'creating property2...'
property2 = Property.new(
  property_types: 1,
  price: 15000,
  currencies: 1,
  address: 'Av. Siempre Viva 123',
  area: 100,
  nro_rooms: 3,
  nro_bathrooms: 2,
  description: 'Departamento en venta',
  community_id: 1,
  user_id: user.id
)

property2.photo.attach(io: File.open('app/assets/images/casa2.jpg'), filename: 'property2.jpg', content_type: 'image/jpg')
property2.save!
puts 'property2 created!'