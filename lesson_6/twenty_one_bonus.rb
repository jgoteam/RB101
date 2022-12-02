require 'io/console'

SUITS = ['♠', '♥', '♦', '♣']
POSSIBLE_CARDS = ('2'..'10').to_a + ['J', 'Q', 'K', 'A']
CARD_VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
                '7' => 7, '8' => 8, '9' => 9, '10' => 10,
                'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 11 }
MAX_NO_BUST = 21
NUM_TO_WIN = 5

def prompt(msg)
  puts "=> #{msg}"
end

def welcome
  system('clear') || system('cls')
  prompt "Let's play 21!"
  prompt "First to #{NUM_TO_WIN} wins"
  prompt ""
  prompt "Press any key to start!"
  STDIN.getch
end

def new_deck
  (POSSIBLE_CARDS * 4).zip(SUITS * 13).map do |card|
    card_hash = {}
    card_hash[:rank] = card[0]
    card_hash[:suit] = card[1]
    card_hash[:value] = CARD_VALUES[card[0]]
    card_hash
  end
end

def deal_card!(player, deck)
  drawn_card = deck.shift
  player << drawn_card
end

def add_hidden_card!(dealer)
  dealer << { rank: "?", suit: "?", value: 0 }
end

def reveal_card!(dealer, gdeck)
  dealer.delete_at(1)
  deal_card!(dealer, gdeck)
  prompt "Dealer will reveal card"
  thinking
end

# rubocop: disable Metrics/AbcSize, Metrics/MethodLength
def display_hand(whos_hand)
  (whos_hand.size).times { print " ________   " }
  puts
  whos_hand.each do |card|
    print "|#{card[:rank]}#{card[:suit]}    ".ljust(9) + "|"
    print "  "
  end
  2.times do
    puts
    (whos_hand.size).times do
      print "|        |"
      print "  "
    end
  end
  puts
  whos_hand.each do |card|
    print "|" + "    #{card[:rank]}#{card[:suit]}|".rjust(9)
    print "  "
  end
  puts
end
# rubocop: enable Metrics/AbcSize, Metrics/MethodLength

def display_board(round_num, player, dealer, scoreboard)
  system('clear') || system('cls')
  puts "  Dealer: #{scoreboard[:Dealer]}\t  Player: #{scoreboard[:Player]}"
  puts " ___________________________ "
  puts "|          ROUND #{round_num}          |"
  puts "|___________________________|"
  puts ""
  puts "Dealer"
  display_hand(dealer)
  puts ""
  puts ""
  puts ""
  puts "Player"
  display_hand(player)
  puts ""
end

def thinking
  print "=> "
  3.times do
    print "."
    sleep(1)
  end
  puts ""
end

def new_round!(player, dealer, deck)
  2.times { deal_card!(player, deck) }
  deal_card!(dealer, deck)
  add_hidden_card!(dealer)
end

def find_total(whos_hand)
  total = 0
  ace_count = whos_hand.count { |card| card[:rank] == 'A' }
  whos_hand.reverse.each { |card| total += card[:value] }
  ace_count.times { total -= 10 if total > MAX_NO_BUST }
  total
end

def busted?(whos_hand)
  find_total(whos_hand) > MAX_NO_BUST
end

def hit_or_stay(player)
  choice = nil
  loop do
    prompt "1) Hit or 2) Stay"
    prompt "(Note..you currently have 21!)" if find_total(player) == 21
    choice = gets.chomp.to_i
    break if [1, 2].include?(choice)
    prompt "That's not a valid choice. Please enter 1 or 2."
  end
  choice
end

def player_goes!(player, dealer, gdeck, round_num, scoreboard)
  prompt "Player's turn"
  loop do
    display_board(round_num, player, dealer, scoreboard)
    player_action = hit_or_stay(player)
    if player_action == 1
      deal_card!(player, gdeck)
      break if busted?(player)
    else
      prompt "You chose to stay"
      break thinking
    end
  end
  display_board(round_num, player, dealer, scoreboard)
end

def dealer_goes!(dealer, player, gdeck, round_num, scoreboard)
  prompt "Dealer's turn"
  reveal_card!(dealer, gdeck)
  loop do
    display_board(round_num, player, dealer, scoreboard)
    prompt "Dealer's turn"
    if find_total(dealer) <= 16
      prompt "Dealer has 16 or less, and must hit"
      thinking
      deal_card!(dealer, gdeck)
      break if busted?(dealer)
    else
      prompt "Dealer has at least 17, and must stay"
      break thinking
    end
  end
end

def run_round!(player, dealer, deck, round_totals, round_num, scoreboard)
  1.times do
    display_board(round_num, player, dealer, scoreboard)
    player_goes!(player, dealer, deck, round_num, scoreboard)
    break if busted?(player)

    display_board(round_num, player, dealer, scoreboard)
    dealer_goes!(dealer, player, deck, round_num, scoreboard)
    break if busted?(dealer)
    break
  end
  round_totals[:Player] = find_total(player)
  round_totals[:Dealer] = find_total(dealer)
  display_board(round_num, player, dealer, scoreboard)
end

def detect_match_winner(scoreboard)
  return 'Player' if scoreboard[:Player] == NUM_TO_WIN
  return 'Dealer' if scoreboard[:Dealer] == NUM_TO_WIN
  nil
end

def match_won?(scoreboard)
  !!detect_match_winner(scoreboard)
end

def match_continues(round_num)
  prompt "Press any key to continue to round #{round_num + 1}"
  STDIN.getch
end

def match_ends
  prompt "Match is over! Press any key to continue."
  STDIN.getch
end

def show_result(round_totals, round_num)
  if round_totals[:Player] > MAX_NO_BUST
    puts "Player lost round #{round_num}, " \
         "busted with: #{round_totals[:Player]}"
  elsif round_totals[:Dealer] > MAX_NO_BUST
    puts "Player won round #{round_num}. " \
         "Dealer busted with: #{round_totals[:Dealer]}"
  elsif round_totals[:Dealer] > round_totals[:Player]
    puts "Dealer won round #{round_num}. " \
         "#{round_totals[:Dealer]} vs #{round_totals[:Player]}"
  elsif round_totals[:Player] > round_totals[:Dealer]
    puts "You won round #{round_num}. " \
         "#{round_totals[:Player]} vs #{round_totals[:Dealer]}"
  else
    puts "Push for round #{round_num}. Both had #{round_totals[:Dealer]}"
  end
end

def update_scores(round_totals, scoreboard)
  if round_totals[:Player] > MAX_NO_BUST
    scoreboard[:Dealer] += 1
  elsif round_totals[:Dealer] > MAX_NO_BUST
    scoreboard[:Player] += 1
  elsif round_totals[:Dealer] > round_totals[:Player]
    scoreboard[:Dealer] += 1
  elsif round_totals[:Player] > round_totals[:Dealer]
    scoreboard[:Player] += 1
  else
    scoreboard[:Pushes] += 1
  end
end

def post_round(round_totals, round_num, scoreboard)
  show_result(round_totals, round_num)
  update_scores(round_totals, scoreboard)
  match_won?(scoreboard) ? match_ends : match_continues(round_num)
end

def display_final_score(final_score, winner)
  system('clear') || system('cls')
  puts ""
  puts "#{winner} won the 21 match!"
  puts " ___________________________ "
  puts "|        Final Score        |"
  puts "|___________________________|"
  puts "          Player: #{final_score[:Player]}"
  puts "          Dealer: #{final_score[:Dealer]}"
  puts "         (Pushes: #{final_score[:Pushes]})"
  puts ""
end

def play_again?
  again = nil
  loop do
    prompt "Play again? (y or n)"
    again = gets.chomp
    break if ['y', 'yes', 'n', 'no'].include?(again.downcase)
    prompt "That's not a valid choice. Please enter 'y' or 'n'."
  end
  unless ['y', 'yes'].include?(again.downcase)
    prompt "Thanks for playing 21! Goodbye!"
    exit
  end
end

loop do
  welcome

  deck = []
  deck = new_deck.shuffle

  round_num = 1
  scoreboard = { Player: 0, Dealer: 0, Pushes: 0 }
  loop do
    player = []
    dealer = []
    round_totals = { Player: 0, Dealer: 0 }
    new_round!(player, dealer, deck)
    run_round!(player, dealer, deck, round_totals, round_num, scoreboard)
    post_round(round_totals, round_num, scoreboard)
    round_num += 1
    break if match_won?(scoreboard)
  end
  display_final_score(scoreboard, detect_match_winner(scoreboard))
  play_again?
end
