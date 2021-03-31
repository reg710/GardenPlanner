require 'sqlite3'


veg_yield = ""
connection = SQLite3::Database.open "gardenbox.sqlite"
connection.results_as_hash = true

select_command = connection.prepare "SELECT * FROM Vegetables WHERE VeggieName = 'beets'" 
reader = select_command.execute 

reader.each do |yield_db|
    veg_yield = yield_db['YieldInt'].to_i
end

puts veg_yield
puts veg_yield.class