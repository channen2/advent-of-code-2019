## Part 1
## Calculate fuel required given mass
def calculate_fuel(mass)
    return mass / 3 - 2
end

path = File.join(File.dirname(__FILE__), 'day1_input.txt')
mass_array = File.readlines(path, chomp: true)

total_fuel = 0
mass_array.each do |mass|
    total_fuel += calculate_fuel(mass.to_i)
end

puts "Total fuel required: #{total_fuel}"


## Part 2
## Fuel needs fuel
def calculate_fuel_complete(mass)
    return 0 if mass <= 0
    fuel = mass / 3 - 2 
    fuel = 0 if fuel < 0
    return fuel + calculate_fuel_complete(fuel) 
end

total_fuel = 0
mass_array.each do |mass|
    total_fuel += calculate_fuel_complete(mass.to_i)
end

puts "Total fuel required: #{total_fuel}"

