WHO_WINS = { rock: %w[lizard scissors],
             paper: %w[rock spock],
             scissors: %w[paper lizard],
             spock: %w[rock scissors],
             lizard: %w[spock paper] }.freeze

VALID_CHOICES = WHO_WINS.keys.map(&:to_s)
SYM_TABLE = %w(r p s k l)
display_choices = VALID_CHOICES.zip(SYM_TABLE.map { |x| "(#{x})" }).flatten
                               .each_slice(2).map(&:join).join(', ')

def convert_char(choice)
  VALID_CHOICES[SYM_TABLE.find_index(choice.downcase).to_i]
end

p display_choices
p SYM_TABLE.find_index('r')
