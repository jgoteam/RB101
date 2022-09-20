require 'yaml'
MESSAGES = YAML.load_file('mortgage_messages.yml')
# Set LANGUAGE to 'eng' for English or 'es' for Spanish
LANGUAGE = "eng"

def prompt(message, post="")
  message = MESSAGES[LANGUAGE][message]
  Kernel.puts("=> #{message} #{post}")
end

def valid_number?(number)
  /^[+-]?\d*\.?\d+$/.match(number)
end

prompt('welcome')

loop do
  prompt('main_menu')

  loop do
    prompt('options')
    option = gets().chomp().strip().downcase()

    if option == 'q'
      prompt('goodbye')
      exit(true)
    elsif %w('s', 'd', 'h').include?(option)
      break
    else
      prompt('invalid_option')
    end
  end

 loop do
    prompt('')




=begin
m = p * (j / (1 - (1 + j)**(-n)))


m = monthly payment
p = loan amount
j = monthly interest rate
n = loan duration in months
=end
