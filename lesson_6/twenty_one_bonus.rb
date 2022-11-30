require 'io/console'

SUITS = ['♠', '♥', '♦', '♣']
POSSIBLE_CARDS = ('2'..'10').to_a + ['J', 'Q', 'K', 'A']
CARD_VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
                '7' => 7, '8' => 8, '9' => 9, '10' => 10,
                'J' => 10, 'Q' => 10, 'K' => 10, 'A' => [1, 11] }
MAX_NO_BUST = 21
NUM_TO_WIN = 1

def prompt(msg)
  puts "=> #{msg}"
end

def welcome
  prompt "Let's play 21!"
  prompt "Best to #{NUM_TO_WIN} wins"
  prompt ""
  prompt "Press any key to start!"
  STDIN.getch
end

def new_deck
  (POSSIBLE_CARDS * 4).zip(SUITS * 13).shuffle
end

def deal_card!(player, deck)
  drawn_card = deck.shift
  player << drawn_card
end

def add_hidden_card!(dealer)
  dealer << ["?", "?"]
end

def reveal_card!(dealer, gdeck)
  dealer.delete_at(1)
  deal_card!(dealer, gdeck)
  prompt "Dealer will reveal card"
  thinking
end

def find_total(whos_hand)
  total = 0
  ace_count = whos_hand.count { |card| card[0] == 'A' }
  whos_hand.reverse.each do |card|
    add_on = if card.first == 'A'
               CARD_VALUES[card[0]][1]
             else
               CARD_VALUES[card[0]]
             end
    total += add_on
  end
  ace_count.times { total -= 10 if total > MAX_NO_BUST }
  total
end

# rubocop: disable Metrics/AbcSize, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/MethodLength
def display_hand(whos_hand)
  (whos_hand.size).times { print " ________   " }
  puts
  if whos_hand[0][0] == '10'
    print "|#{whos_hand[0][0]}#{whos_hand[0][1]}     |"
  else
    print "|#{whos_hand[0][0]}#{whos_hand[0][1]}      |"
  end
  whos_hand.each_with_index do |card, idx|
    next if idx == 0
    print "  "
    if card[0] == '10'
      print "|#{card[0]}#{card[1]}     |"
    else
      print "|#{card[0]}#{card[1]}      |"
    end
  end
  puts
  print "|        |"
  (whos_hand.size - 1).times do
    print "  "
    print "|        |"
  end
  puts
  print "|        |"
  (whos_hand.size - 1).times do
    print "  "
    print "|        |"
  end
  puts
  if whos_hand[0][0] == '10'
    print "|     #{whos_hand[0][0]}#{whos_hand[0][1]}|"
  else
    print "|      #{whos_hand[0][0]}#{whos_hand[0][1]}|"
  end
  whos_hand.each_with_index do |card, idx|
    next if idx == 0
    print "  "
    if card[0] == '10'
      print "|     #{card[0]}#{card[1]}|"
    else
      print "|      #{card[0]}#{card[1]}|"
    end
  end
  puts
end
# rubocop: enable Metrics/AbcSize, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/MethodLength

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
    p_action = hit_or_stay(player)
    if p_action == 1
      deal_card!(player, gdeck)
      break if busted?(player)
      display_board(round_num, player, dealer, scoreboard)
    else
      prompt "You chose to stay"
      break thinking
    end
  end
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

def run_round!(player, dealer, deck, round_num, scoreboard)
  1.times do |_|
    display_board(round_num, player, dealer, scoreboard)
    player_goes!(player, dealer, deck, round_num, scoreboard)
    break if busted?(player)

    display_board(round_num, player, dealer, scoreboard)
    dealer_goes!(dealer, player, deck, round_num, scoreboard)
    break if busted?(dealer)
    break
  end
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

def show_result(p_total, d_total, round_num)
  if p_total > MAX_NO_BUST
    puts "Player lost round #{round_num}, " \
         "busted with: #{p_total}"
  elsif d_total > MAX_NO_BUST
    puts "Player won round #{round_num}. " \
         "Dealer busted with: #{d_total}"
  elsif d_total > p_total
    puts "Dealer won round #{round_num}. " \
         "#{d_total} vs #{p_total}"
  elsif p_total > d_total
    puts "You won round #{round_num}. " \
         "#{p_total} vs #{d_total}"
  else
    puts "Push for round #{round_num}. Both had #{d_total}"
  end
end

def update_scores(p_total, d_total, scoreboard)
  if p_total > MAX_NO_BUST
    scoreboard[:Dealer] += 1
  elsif d_total > MAX_NO_BUST
    scoreboard[:Player] += 1
  elsif d_total > p_total
    scoreboard[:Dealer] += 1
  elsif p_total > d_total
    scoreboard[:Player] += 1
  else
    scoreboard[:Pushes] += 1
  end
end

def post_round(p_total, d_total, round_num, scoreboard)
  show_result(p_total, d_total, round_num)
  update_scores(p_total, d_total, scoreboard)
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

loop do
  welcome

  deck = []
  deck = new_deck
  round_num = 1
  scoreboard = { Player: 0, Dealer: 0, Pushes: 0 }
  loop do
    player = []
    dealer = []
    new_round!(player, dealer, deck)
    run_round!(player, dealer, deck, round_num, scoreboard)
    p_total = find_total(player)
    d_total = p_total > MAX_NO_BUST ? 0 : find_total(dealer)

    post_round(p_total, d_total, round_num, scoreboard)
    round_num += 1
    break if match_won?(scoreboard)
  end
  display_final_score(scoreboard, detect_match_winner(scoreboard))

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless ['y', 'yes'].include?(answer.downcase)
end

prompt "Thanks for playing 21! Goodbye!"
