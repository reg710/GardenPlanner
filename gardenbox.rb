require 'sqlite3' # specifies sqlite version to use.
# Create connection with the database
# Need 'results as hash' to be true for the rest to work
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

# Loops through reader and prints all the rowID cells 
# and the vegetable name cells from the database
reader.each do |row|
    puts "  #{row['ID']}) #{row['VeggieName']}"
end
response = gets.chomp.downcase

# Create a variable to store yield info from database
veg_yield = ""
veg_type = ""

# Select command to find per square foot yield from datbase
select_command = connection.prepare "SELECT * FROM Vegetables WHERE ID = '#{response}'" 

#opens reader
reader = select_command.execute 

# Loops through reader, looking only at the row of the vegID chosen by user,
# and saves the yieldInt to the veg_yield variable for calculating below 
# and saves the VeggieName cell info to veg_type
reader.each do |row|
    veg_yield = row['YieldInt'].to_i
    veg_type = row['VeggieName']
end

#Calculates the amount possible by dividing the int yield by 16 and multiplying the area
# Must include .to_f in order for math to work
# Include .floor at the end to round down to whole numbers
veg_possible = (veg_yield.to_f/16 * area).floor
puts
puts "Personalized garden fun facts:"
puts "  Your garden is #{area} square feet and has a perimeter of #{perimeter} feet."
puts "  You could plant #{veg_possible} #{veg_type} plants."
