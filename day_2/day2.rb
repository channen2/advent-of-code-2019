## Part 1

# Read from file and convert intcode_program into array
path = File.join(File.dirname(__FILE__), 'day2_input.txt')
INTCODE_PROGRAM = File.read(path).split(',').map(&:to_i)

# Given intcode program, return output
# Position 0: Output
# Position 1: Noun
# Position 2: Verb
def run_program(intcode_program, noun, verb)
    program = intcode_program.clone.map(&:clone)
    program[1] = noun
    program[2] = verb 
    program.each_slice(4) do |opcode, a, b, res|
        # puts "#{opcode}, #{a}, #{b}, #{res}"
        if opcode == 1
            program[res] = program[a] + program[b]
        elsif opcode == 2
            program[res] = program[a] * program[b]
        elsif opcode == 99
            break
        end
    end
    output = program[0]
    puts "#{noun}, #{verb}, #{output}"
    output
end

# puts run_program(INTCODE_PROGRAM, 99,99)

## Part 2

## Change values of Noun/Verb (Pos 1/2) until desired output achieved
## Desired output: 19690720
noun, verb = 0, 0
keep_going = true
while(keep_going)
    output = run_program(INTCODE_PROGRAM, noun, verb)

    if output == 19690720
        keep_going = false 
    else  
        if verb < 99 
            verb += 1
        elsif noun < 99
            noun += 1
            verb = 0
        else 
            keep_going = false
        end
    end
end

puts "Final noun: #{noun}, verb: #{verb}"
puts 100 * noun + verb