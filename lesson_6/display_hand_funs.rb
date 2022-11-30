def display_hand(hand)
  (hand.size).times { print " ________   " }
  puts
  if hand[0][0] == '10'
    print "|#{hand[0][0]}#{hand[0][1]}     |"
  else
    print "|#{hand[0][0]}#{hand[0][1]}      |"
  end
  hand.each_with_index do |card, idx|
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
  (hand.size - 1).times do
    print "  "
    print "|        |"
  end
  puts
  print "|        |"
  (hand.size - 1).times do
    print "  "
    print "|        |"
  end
  puts
  if hand[0][0] == '10'
    print "|     #{hand[0][0]}#{hand[0][1]}|"
  else
    print "|      #{hand[0][0]}#{hand[0][1]}|"
  end
  hand.each_with_index do |card, idx|
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

def display_card(drawn_card)
  puts " _______"
  puts "|#{drawn_card[0][0]}#{drawn_card[1]}     |"
  puts "|       |"
  puts "|       |"
  puts "|     #{drawn_card[0][0]}#{drawn_card[1]}|"
  puts
end

sample_