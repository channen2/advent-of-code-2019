require_relative 'binarytree'

path = File.join(File.dirname(__FILE__), 'day6_input.txt')
## List of planet orbits
orbit_list = File.readlines(path, chomp: true)

# p orbit_list

## Root of tree is "COM"
t = BinaryTree::Tree.new(["COM"])
root = t.root

queue = ["COM"]
total_orbits = orbit_list.length
i = 0

while i < total_orbits
    planet = queue.shift
    ## find_plus searches all nodes (regardless if in order or not)
    node = t.find_plus(planet)
    moons = orbit_list.lazy.select{|orbit| orbit[0..2] == planet}.first(2)
    moons = moons.map{|x| x[4..6]}
    moons.each{|moon| t.insert_to_node(moon, node)}
    i += moons.length
    queue += moons
end

# Navigate to each node, calculate depth, and add to total
def calculate_orbits(root, i=0, acc=0)
    return acc if root.nil?
    acc += i
    # p "root: #{root.value}, value: #{acc}. i: #{i}"

    acc = calculate_orbits(root.left_child, i+1, acc) if root.left_child    
    acc = calculate_orbits(root.right_child, i+1, acc) if root.right_child
    
    acc
end

## Total number of orbits
# p calculate_orbits(root)

planet_you = orbit_list.lazy.select{|orbit| orbit[4..6] == "YOU"}.first(1)[0][0..2]
planet_san = orbit_list.lazy.select{|orbit| orbit[4..6] == "SAN"}.first(1)[0][0..2]
# p t.find_plus("YOU")

# p planet_you
# p planet_san