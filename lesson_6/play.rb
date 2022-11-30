
suits = ['♠', '♥', '♦', '♣']
possible_cards = ('2'..'10').to_a + ['J', 'Q', 'K', 'A']

new_deck = ((possible_cards)*4).zip(suits*13).shuffle

CARD_VALUES = (possible_cards).each_with_object({}) do |card, new_hash|
                (2..10).include?(card.to_i)? new_hash[card] = card.to_i : card == 'Ace' ? new_hash[card] = [1,11] : new_hash[card] = 10
              end
MAX_NO_BUST = 21
player1 = []

def add_hidden_card!(dealer, deck)
  dealers_hand << ["?", "?"]
  mystery_card = deck.pop
end

def deal_card!(player, num_of_cards, deck)
  dealt_cards = []
  num_of_cards.times do
    player << deck.pop
    dealt_cards << player.last
  end
  dealt_cards
end

def find_total(whos_hand)
  total = 0
  whos_hand.each do |card|
    if card[0] == 'A'
      total + CARD_VALUES[card[0]][1] > MAX_NO_BUST ? total += CARD_VALUES[card[0]][0] : total += CARD_VALUES[card[0]][1]
    else
      total += CARD_VALUES[card[0]]
    end
  end
  total
end

3.times { player1 << new_deck.pop }

#p player1

p deal_card!(player1, 1, new_deck)[0]

p player1
p find_total(player1)



