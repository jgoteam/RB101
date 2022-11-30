require 'io/console'

SUITS = ['♠', '♥', '♦', '♣']
POSSIBLE_CARDS = ('2'..'10').to_a + ['J', 'Q', 'K', 'A']
CARD_VALUES = (POSSIBLE_CARDS).each_with_object({}) do |card, new_hash|
                if (2..10).include?(card.to_i)
                  new_hash[card] = card.to_i
                elsif ['J', 'Q', 'K'].include?(card)
                  new_hash[card] = 10
                else
                  new_hash[card] = [1,11]
                end
              end
MAX_NO_BUST = 21
NUM_TO_WIN = 5

def prompt(msg)
  puts "=> #{msg}"
end

def new_deck
  (POSSIBLE_CARDS*4).zip(SUITS*13).shuffle
end

def deal_card!(player, deck)
  drawn_card = deck.shift
  player << drawn_card
end

def add_hidden_card!(dealer, deck)
  dealer << ["?", "?"]
end

def find_total(whos_hand)
  total = 0
  whos_hand.each do |card|
    if card.first == 'A'
      total + CARD_VALUES[card[0]][1] > MAX_NO_BUST ? total += CARD_VALUES[card[0]][0] : total += CARD_VALUES[card[0]][1]
    else
      total += CARD_VALUES[card[0]]
    end
  end
  total
end

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

def display_board(round_num, player, dealer, match_scoreboard)
  system('clear') || system('cls')
  puts "     Dealer: #{match_scoreboard[:Dealer]}\tPlayer: #{match_scoreboard[:Player]}"
  puts "    ___________________________ "
  puts "   |          ROUND #{round_num}          |"
  puts "   |___________________________|"
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

def new_round!(player, dealer, deck, round_num, match_scoreboard)
  2.times { deal_card!(player, deck) }
  deal_card!(dealer, deck)
  add_hidden_card!(dealer, deck)
end

def alternate_player!(current_player)
  current_player == 'Player' ? 'Dealer' : 'Player'
end

def busted?(whos_hand)
  find_total(whos_hand) > MAX_NO_BUST
end

def player_goes!(player, dealer, gdeck, round_num, match_scoreboard)
  prompt "Player's turn"
  p_action = nil
  loop do
    loop do
      prompt "1) Hit or 2) Stay"
      prompt "(Note that you currently have 21!)" if find_total(player) == 21
      p_action = gets.chomp.to_i
      break if [1,2].include?(p_action)
      prompt "That's not a valid choice. Please enter 1 or 2."
    end
    if p_action == 1
      deal_card!(player, gdeck)
      break if busted?(player)
      display_board(round_num, player, dealer, match_scoreboard)
    else
      prompt "You chose to stay"
      thinking
      break
    end
  end
end

def dealer_goes!(dealer, player, gdeck, round_num, match_scoreboard)
  prompt "Dealer's turn"
  dealer.delete_at(1)
  deal_card!(dealer, gdeck)
  prompt "Dealer will reveal card"
  thinking
  loop do
    display_board(round_num, player, dealer, match_scoreboard)
    prompt "Dealer's turn"
    if find_total(dealer) <= 16
      prompt "Dealer's hand is 16 or less, and must hit"
      thinking
      deal_card!(dealer, gdeck)
      break if busted?(dealer)
    else
      prompt "Dealer's hand is over 16, and must stay"
      thinking
      break
    end
  end
end

def run_turn!(current_player, player, dealer, deck)
  puts "#{current_player}'s turn"
  current_player == 'Player' ? player_goes!(player, deck, stay_count) : dealer_goes!(dealer, player, deck, stay_count)
end

def detect_match_winner(match_scoreboard)
  return 'Player' if match_scoreboard[:Player] == NUM_TO_WIN
  return 'Dealer' if match_scoreboard[:Dealer] == NUM_TO_WIN
  nil
end

def match_won?(match_scoreboard)
  !!detect_match_winner(match_scoreboard)
end

def post_round(player, dealer, round_num, match_scoreboard)
  if busted?(player)
    puts "Player lost round #{round_num}, busted with: #{find_total(player)}"
    match_scoreboard[:Dealer] += 1
  elsif busted?(dealer)
    puts "Player won round #{round_num}. Dealer busted with: #{find_total(dealer)}"
    match_scoreboard[:Player] += 1
  else
    if find_total(dealer) > find_total(player)
      puts "Dealer won round #{round_num}. #{find_total(dealer)} vs #{find_total(player)}"
      match_scoreboard[:Dealer] += 1
    elsif find_total(player) > find_total(dealer)
      puts "You won round #{round_num}. #{find_total(player)} vs #{find_total(dealer)}"
      match_scoreboard[:Player] += 1
    else
      puts "Push for round #{round_num}. Both had #{find_total(dealer)}"
      match_scoreboard[:Pushes] += 1
    end
  end
  puts
  unless match_won?(match_scoreboard)
    prompt "Press any key to continue to Round #{round_num + 1}"
    STDIN.getch
  end
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

loop do # match loop
  prompt "Let's play 21!"
  prompt "Best to #{NUM_TO_WIN} wins"
  prompt ""
  prompt "Press any key to start!"
  STDIN.getch

  deck = []
  deck = new_deck
  round_num = 1
  match_scoreboard = { Player: 0, Dealer: 0, Pushes: 0 }
  loop do # round loop
    player = []
    dealer = []
    new_round!(player, dealer, deck, round_num, match_scoreboard)
    loop do # run round
      display_board(round_num, player, dealer, match_scoreboard)
      player_goes!(player, dealer, deck, round_num, match_scoreboard)
      break if busted?(player)

      display_board(round_num, player, dealer, match_scoreboard)
      dealer_goes!( dealer, player, deck, round_num, match_scoreboard)
      break if busted?(dealer)
      break
    end

    display_board(round_num, player, dealer, match_scoreboard)
    post_round(player, dealer, round_num, match_scoreboard)
    round_num += 1
    break if match_won?(match_scoreboard)
  end
  display_final_score(match_scoreboard, detect_match_winner(match_scoreboard))

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless ['y', 'yes'].include?(answer.downcase)
end

prompt "Thanks for playing 21! Goodbye!"
