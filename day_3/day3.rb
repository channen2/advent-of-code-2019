# For each of the two wires, 
    ## Convert wire path to arrays
    # The arrays represent the start/end coordinates of each line
    ## U7,R6,D4,L4 0
def to_a(wire_path)
    lines = []
    x_current, y_current = 0, 0
    cumulative_steps = 0

    wire_path.each do |path|
        direction, distance = path[0], path[1..-1].to_i
        dx, dy = 0, 0

        dy += distance if direction == "U"
        dy -= distance if direction == "D"
        dx += distance if direction == "R"
        dx -= distance if direction == "L"
        
        start_coords = [x_current, y_current]
        end_coords = [x_current + dx, y_current + dy]
        x_current, y_current = end_coords
        cumulative_steps += distance
        

        lines << {
            start_coords: start_coords,
            end_coords: end_coords,
            cumulative_steps: cumulative_steps,
        }
    end
    lines
end

# returns true if z is between x and y
def is_between?(z, x, y)
    y > x ? z.between?(x, y) : z.between?(y, x)
end

# Given two lines, return intersection point or nil
def get_intersection(line_a, line_b)
    a, b = line_a[:start_coords], line_a[:end_coords] 
    c, d = line_b[:start_coords], line_b[:end_coords] 

    # line_a vertical, line_b horizontal
    if a[0] == b[0] && c[1] == d[1]
        if is_between?(a[0], c[0], d[0]) && is_between?(c[1], a[1], b[1])
            return a[0],c[1] unless a[0] == 0 && c[1] == 0        
        end
    # line_a horizontal, line_b vertical
    elsif a[1] == b[1] && c[0] == d[0]
        if is_between?(a[1], c[1], d[1]) && is_between?(c[0], a[0], b[0])
            return c[0],a[1] unless c[0] == 0 && a[1]
        end
    end
    nil
end

def calculate_steps(intersection, line)
    x1, y1 = line[:start_coords]
    x2, y2 = line[:end_coords]
    steps = line[:cumulative_steps]

    if x1 == x2 
        return steps - (y2 - intersection[1]).abs if is_between?(intersection[1], y1, y2)
    elsif y1 == y2
        return steps - (x2 - intersection[0]).abs if is_between?(intersection[0], x1, x2)
    end
    steps
end

def get_manhattan_distance(coordinates)
    x, y = coordinates
    return x.abs + y.abs
end

path_a = File.join(File.dirname(__FILE__), 'wire_a.txt')
path_b = File.join(File.dirname(__FILE__), 'wire_b.txt')

wire_a_info = File.read(path_a).split(',')
wire_b_info = File.read(path_b).split(',')

wire_a = to_a(wire_a_info)
wire_b = to_a(wire_b_info)

# For each line in wire 1, 
    # if intersection with wire 2,
    # return point of intersection
intersections = []
distance_to_intersections = []
wire_a.each_with_index do |line_a, i|
    wire_b.each_with_index do |line_b, j|
        intersection = get_intersection(line_a, line_b)
        unless intersection.nil?
            intersections << intersection
            steps = calculate_steps(intersection, line_a) + calculate_steps(intersection, line_b)
            distance_to_intersections << steps
        end
    end
end

manhattan_distances = intersections.map{|coords| get_manhattan_distance(coords)}
shortest_path_index = distance_to_intersections.rindex(distance_to_intersections.min)

closest_index = manhattan_distances.rindex(manhattan_distances.min)
puts "The intersection points are at: "
p intersections

puts "The intersection with the lowest manhattan distance to the central port "
puts "is #{intersections[closest_index]}, which is #{manhattan_distances[closest_index]} units away."
puts "The sum of the wire paths is: #{distance_to_intersections[closest_index]}"

puts "The intersection with the shortest total path length "
puts "is #{intersections[shortest_path_index]}, which is #{distance_to_intersections[shortest_path_index]} units long"