# Read from file and convert intcode_program into array
path = File.join(File.dirname(__FILE__), 'day5_input.txt')
INTCODE_PROGRAM = File.read(path).split(',').map(&:to_i)

def add(x, y)
    x + y
end

def multiply(x, y)
    x * y
end


# Given intcode program, return output
def run_program(intcode_program)
    program = intcode_program.clone.map(&:clone)

    i = 0
    until program[i] == 99
        puts program[i]
        instruction = program[i].to_s.rjust(4, '0').split('')

        res = program[i+3]

        opcode = instruction[2..3].join.to_i
        x = instruction[1] == "0" ? program[program[i+1]] : program[i+1]
        y = instruction[0] == "0" ? program[program[i+2]] : program[i+2]

        if opcode == 1
            program[res] = add(x, y)
            i += 4
        elsif opcode == 2
            program[res] = multiply(x, y)
            i += 4
        elsif opcode == 3 
            puts "Enter a number to be saved at address #{program[i+1]}:"
            program[program[i+1]] = gets.chomp.to_i
            i += 2
        elsif opcode == 4
            puts "Value at address #{program[i+1]}: #{program[program[i+1]]}"
            i += 2
        elsif opcode == 5
            if x != 0 
                i = y 
            else
                i += 3
            end
        elsif opcode == 6
            if x == 0
                i = y 
            else
                i += 3
            end
        elsif opcode == 7
            program[res] = x < y ? 1 : 0
            i += 4
        elsif opcode == 8
            program[res] = x == y ? 1 : 0
            i += 4
        end
    end
    program[0]
end

run_program(INTCODE_PROGRAM)