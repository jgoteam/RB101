WHO_WINS = { rock: %w[lizard scissors],
             paper: %w[rock spock],
             scissors: %w[paper lizard],
             spock: %w[rock scissors],
             lizard: %w[spock paper] }

VALID_CHOICES = WHO_WINS.keys.map(&:to_s)
SYM_TABLE = %w(r p s k l)
display_choices = VALID_CHOICES.zip(SYM_TABLE.map { |x| "(#{x})" }).flatten
                               .each_slice(2).map(&:join).join(', ')
num_to_w = 3

def prompt(message)
  puts "=> #{message}"
end

def convert_char(choice)
  return 'foo' if SYM_TABLE.include?(choice) == false
  VALID_CHOICES[SYM_TABLE.find_index(choice.downcase).to_i]
end

def run_round(p1, comp, scores)
  prompt("You chose: #{p1}; Computer chose: #{comp}")
  if WHO_WINS[p1.to_sym].include?(comp)
    prompt("#{p1.capitalize} beats #{comp}..")
    prompt("You win!")
    scores[:p1] += 1
  elsif WHO_WINS[comp.to_sym].include?(p1)
    prompt("#{comp.capitalize} beats #{p1}..")
    prompt("Computer wins!")
    scores[:comp] += 1
  else
    prompt("It's a draw!")
  end
end

def display_match(winner, scores)
  prompt("\n")
  prompt("#{winner} won the RPSSL match!")
  prompt("--Final score--\n" \
  "\tPlayer: #{scores[:p1]}\n" \
  "\tComp: #{scores[:comp]}")
end

prompt("Welcome to Rock-Paper-Scissors-Spock-Lizard! First to #{num_to_w} wins")

scores =  { p1: 0, comp: 0 }
p1_choice = ''
comp_choice = ''
loop do
  round_num = 1
  scores[:p1] = 0
  scores[:comp] = 0
  loop do
    puts "\n-- Round #{round_num} --"
    loop do
      prompt("Choose one: #{display_choices}")
      p1_choice = gets.chomp.strip
      if p1_choice.size == 1
        p1_choice = convert_char(p1_choice)
      end
      if VALID_CHOICES.include?(p1_choice)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    comp_choice = VALID_CHOICES.sample

    run_round(p1_choice, comp_choice, scores)

    break display_match('You', scores) if scores[:p1] == num_to_w
    break display_match('The computer', scores) if scores[:comp] == num_to_w

    round_num += 1
  end

  prompt("Play again?(Y)")
  again = gets.chomp.downcase.strip
  system('clear') || system('cls') if again == 'y'
  break unless again == 'y'
end

prompt("Thank you for playing Rock-Paper-Scissors-Spock-Lizard! Goodbye!")
