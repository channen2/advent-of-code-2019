# Password in range: 130254-678275
start_num = 130254
end_num = 678275


def valid?(password)
    digits = password.to_s.split('').map(&:to_i)

    has_double_digit = false
    prev_num  = 0
    repeated = 1

    digits.each_with_index do |digit, idx|
        return false if digit < prev_num
        if digit == prev_num
            repeated += 1
        else 
            has_double_digit = true if repeated == 2  
            repeated = 1 
        end
        prev_num = digit
    end
    has_double_digit || repeated == 2
end

valid_passwords = 0
start_num.upto(end_num) do |password|
    valid_passwords += 1 if valid?(password)
end

puts "Number of valid passwords in the range #{start_num} to #{end_num} is: "
puts valid_passwords
