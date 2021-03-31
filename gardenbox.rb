require 'sqlite3' # specifies sqlite version to use.

puts "What is the length of your garden box in feet?"
length = gets.chomp.to_i

puts "What is the width of your garden box in feet?"
width = gets.chomp.to_i

area = length * width
perimeter = (2 * length) + (2 * width)

puts "Your garden is #{area} square feet and has a perimter of #{perimeter} feet."

# Try to find a way to pull available plants from database and insert into puts
puts "In your garden, would you like to plant carrots, corn, or beets?"
response = gets.downcase.chomp

# Create a variable to store yield info from database
veg_yield = ""

# Create connection with the database
connection = SQLite3::Database.open "gardenbox.sqlite"
connection.results_as_hash = true

# Select command to find per square foot yield from datbase
select_command = connection.prepare "SELECT YieldInt FROM Vegetables WHERE VeggieName = '#{response}'" 

#opens reader
reader = select_command.execute 

# Loops through reader and saves the yieldInt cell from database
# to the veg_yield variable for calculating below
reader.each do |yield_db|
    veg_yield = yield_db['YieldInt'].to_i
end

#Calculates the amount possible by dividing the int yield by 16 and multiplying the area
# Must include .to_f in order for math to work
# Include .floor at the end to round down to whole numbers
veg_possible = (veg_yield.to_f/16 * area).floor
puts "You could plant #{veg_possible} #{response}"


# Old code from original garden box progrm:
# carrot_possible = (1 * area).to_i
# corn_possible = (3.0/16 * area).to_i
# beets_possible = (9.0/16 * area).to_i
# if response.downcase == "carrots" 

#     puts "You could plant #{carrot_possible} carrots."
# end

# if response.downcase == "corn"   
#     puts "You could plant #{corn_possible} corn plants"
# end

# if response.downcase == "beets"
#     puts "You could plant #{beets_possible} beets"
# end

