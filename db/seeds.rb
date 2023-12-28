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