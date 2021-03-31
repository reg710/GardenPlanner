require 'sqlite3' # specifies sqlite version to use.
# Create connection with the database
# Need to results as hash to be true for the rest to work
connection = SQLite3::Database.open "gardenbox.sqlite"
connection.results_as_hash = true

puts "What is the length of your garden box in feet?"
length = gets.chomp.to_i

puts "What is the width of your garden box in feet?"
width = gets.chomp.to_i

area = length * width
perimeter = (2 * length) + (2 * width)
puts "In your garden, what would you like to plant?"

# Select command to find per square foot yield from datbase
select_command = connection.prepare "SELECT * FROM Vegetables" 

#opens reader
reader = select_command.execute 

# Loops through reader and saves the yieldInt cell from database
# to the veg_yield variable for calculating below
reader.each do |row|
    puts "  #{row['ID']}) #{row['VeggieName']}"
end
response = gets.downcase.chomp

# Create a variable to store yield info from database
veg_yield = ""
veg_type = ""

# Select command to find per square foot yield from datbase
select_command = connection.prepare "SELECT * FROM Vegetables WHERE ID = '#{response}'" 

#opens reader
reader = select_command.execute 

# Loops through reader and saves the yieldInt cell from database
# to the veg_yield variable for calculating below
reader.each do |yield_db|
    veg_yield = yield_db['YieldInt'].to_i
    veg_type = yield_db['VeggieName']
end

#Calculates the amount possible by dividing the int yield by 16 and multiplying the area
# Must include .to_f in order for math to work
# Include .floor at the end to round down to whole numbers
veg_possible = (veg_yield.to_f/16 * area).floor
puts
puts "Personalized garden fun facts:"
puts "  Your garden is #{area} square feet and has a perimeter of #{perimeter} feet."
puts "  You could plant #{veg_possible} #{veg_type} plants."
