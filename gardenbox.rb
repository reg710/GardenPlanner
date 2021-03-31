require 'sqlite3' # specifies sqlite version to use.
gardenboxesDB = SQLite3::Database.new("gardenbox.sqlite") # points to database file in same folder as program.
gardenboxesDB.results_as_hash = true
# #returns all data from the database as a hash
# # veggies = gardenboxesDB.execute("SELECT rowid, * FROM Vegetables")
# taken from Bob's code

puts "What is the length of your garden box in feet?"
length = gets.chomp.to_i

puts "What is the width of your garden box in feet?"
width = gets.chomp.to_i

area = length * width
perimeter = (2 * length) + (2 * width)

carrot_possible = (1 * area).to_i
corn_possible = (3.0/16 * area).to_i
beets_possible = (9.0/16 * area).to_i

puts "Your garden is #{area} square feet and has a perimter of #{perimeter} feet."

puts "In your garden, would you like to plant carrots, corn, or beets?"
response = gets.chomp

if response.downcase == "carrots" 
    puts "You could plant #{carrot_possible} carrots."
end

if response.downcase == "corn"   
    puts "You could plant #{corn_possible} corn plants"
end

if response.downcase == "beets"
    puts "You could plant #{beets_possible} beets"
end

