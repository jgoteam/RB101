WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]] # diagonals
NUM_TO_WIN = 5
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

def intro
  prompt "Let's play Tic-Tac-Toe!"
  prompt "First to #{NUM_TO_WIN} wins."
  prompt ""
end

def display_board(brd, current_round, current_score, algo_loaded)
  system('clear') || system('cls')
  puts "\t Player [ '#{PLAYER_MARKER}' ]: #{current_score[:Player]}"
  puts "    Computer (#{algo_loaded}) [ '#{COMPUTER_MARKER}' ]: " \
   "#{current_score[:Computer]}"
  puts "    ___________________________ "
  puts "   |          ROUND #{current_round}          |"
  puts "   |___________________________|"
  puts "\t"
  puts "\t     |     |"
  puts "\t  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "\t     |     |"
  puts "\t-----+-----+-----"
  puts "\t     |     |"
  puts "\t  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "\t     |     |"
  puts "\t-----+-----+-----"
  puts "\t     |     |"
  puts "\t  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "\t     |     |"
  puts ""
end

def initialize_board
  (1..9).each_with_object({}) { |num, hash| hash[num] = INITIAL_MARKER }
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(num_arr, delimiter = ', ', append_last = 'or')
  if num_arr.size == 1 || num_arr.size == 0
    num_arr.join
  elsif num_arr.size == 2
    "#{num_arr[0]} #{append_last} #{num_arr[1]}"
  else
    num_arr.map.with_index do |i, idx|
      idx != num_arr.size - 1 ? "#{i}#{delimiter}" : "#{append_last} #{i}"
    end.join
  end
end

def who_chooses_first
  user_selection = nil
  loop do
    prompt "Choose how who is first is determined: "
    prompt "\t1) Player chooses first, then alternate every round"
    prompt "\t2) Computer chooses first, then alternate every round"
    user_selection = gets.chomp.to_i
    break if (1..2).include?(user_selection)
    prompt "That's not a valid choice. Please enter 1 or 2."
  end
  user_selection
end

def who_first(num)
  if num == 1
    answer = nil
    loop do
      prompt "Do you want to go first for the 1st round? (y or n)"
      answer = gets.chomp
      break if ['y', 'yes', 'n', 'no'].include?(answer.downcase)
      prompt "That's not a valid choice. Please enter 'y' or 'n'."
    end
    ['y', 'yes'].include?(answer.downcase) ? 'Player' : 'Computer'
  else
    ['Player', 'Computer'].sample
  end
end

def users_chosen_level
  algo_num = nil
  loop do
    prompt "Now choose the difficulty level of the computer: "
    prompt "1) easy 2) medium 3) hard"
    algo_num = gets.chomp.to_i
    break if (1..3).include?(algo_num)
    prompt "That's not a valid choice. Please enter 1, 2, or 3."
  end
  algo_num
end

def easy_algo(brd)
  empty_squares(brd).sample
end

def medium_algo(brd)
  d_squares = []
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 2 &&
       brd.values_at(*line).count(INITIAL_MARKER) == 1
      line_arr = *line
      line_arr.each { |sq| d_squares << sq if brd[sq] == INITIAL_MARKER }
    end
  end
  d_squares.empty? ? empty_squares(brd).sample : d_squares.sample
end

def hard_algo(brd)
  atk_squares = []
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(COMPUTER_MARKER) == 2 &&
       brd.values_at(*line).count(INITIAL_MARKER) == 1
      line_arr = *line
      line_arr.each { |sq| atk_squares << sq if brd[sq] == INITIAL_MARKER }
    end
  end
  return 5 if brd[5] == INITIAL_MARKER
  atk_squares.empty? ? medium_algo(brd) : atk_squares.sample
end

def player_goes!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}): "
    square = gets.chomp
    break if empty_squares(brd).include?(square.to_i) &&
              square.to_i.to_s == square
    prompt "Sorry that's not a valid choice."
  end
  brd[square.to_i] = PLAYER_MARKER
end

def comp_goes!(brd, algo_level)
  square = [easy_algo(brd), medium_algo(brd), hard_algo(brd)][algo_level - 1]
  brd[square] = COMPUTER_MARKER
end

def place_marker!(brd, current_player, algo_level)
  current_player == 'Player' ? player_goes!(brd) : comp_goes!(brd, algo_level)
end

def alternate_player(player)
  player == 'Player' ? 'Computer' : 'Player'
end

def detect_round_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def round_won?(brd)
  !!detect_round_winner(brd)
end

def post_round(brd, match_scoreboard, round_num)
  if round_won?(brd)
    match_scoreboard[detect_round_winner(brd).to_sym] += 1
    prompt "#{detect_round_winner(brd)} won round #{round_num}!"
  elsif board_full?(brd)
    match_scoreboard[:Draws] += 1
    prompt "#{round_num} is a tie!"
  end
  prompt "Next round coming up..." if !match_won?(match_scoreboard)
  sleep(1.5)
end

def match_won?(current_score)
  !!detect_match_winner(current_score)
end

def detect_match_winner(current_score)
  if current_score[:Player] == NUM_TO_WIN
    return 'Player'
  elsif current_score[:Computer] == NUM_TO_WIN
    return 'Computer'
  end
  nil
end

def display_final_score(final_score, winner, algo_loaded)
  system('clear') || system('cls')
  puts ""
  puts "#{winner} won the tic-tac-toe match!"
  puts " ___________________________ "
  puts "|        Final Score        |"
  puts "|___________________________|"
  puts "          Player: #{final_score[:Player]}"
  puts "       Computer(#{algo_loaded}): #{final_score[:Computer]}"
  puts "          (Draws: #{final_score[:Draws]})"
  puts ""
end

loop do # main game loop
  intro
  user_selection = who_chooses_first
  current_player = who_first(user_selection)
  prompt "#{current_player} will go first for the 1st round."
  sleep(1.5)
  system('clear') || system('cls')

  algo_num = users_chosen_level
  algo_name = ["Easy", "Medium", "Hard"][algo_num - 1]

  match_scoreboard = { Player: 0, Computer: 0, Draws: 0 }
  round_num = 1
  loop do # round loop
    board = initialize_board
    loop do
      display_board(board, round_num, match_scoreboard, algo_name)
      place_marker!(board, current_player, algo_num)
      current_player = alternate_player(current_player)
      break if round_won?(board) || board_full?(board)
    end

    display_board(board, round_num, match_scoreboard, algo_name)
    post_round(board, match_scoreboard, round_num)
    round_num += 1
    break if match_won?(match_scoreboard)
  end

  display_final_score(match_scoreboard, \
                      detect_match_winner(match_scoreboard), algo_name)

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thanks for playing Tic-Tac-Toe! Goodbye!")
