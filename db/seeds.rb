User.create(name: "Adam", password: "pass", email: "adamjohari4@gmail.com")
Deck.create(name: "Malay to English")
cards = File.open("english-malay").each_line.to_a
cards.each do |phrase|
  array = phrase.split(" ")
  array.each do |word|
    word.gsub(/\'|\"|\[/,"")
  end
  if array.length == 2
    if array[0] != array[1]
      if Card.where(deck_id: 1, question: array[1],answer: array[0]) == []
        Card.create(deck_id: 1, question: array[1], answer: array[0])
      end
    end
  end
end
Deck.create(name: "Mathematics")
(1..5).to_a.each do |number|
  (1..5).to_a.each do |randnum|
    Card.create(deck_id: 2, question: "#{number} + #{randnum}", answer: "#{number + randnum}")
    Card.create(deck_id: 2, question: "#{number} - #{randnum}", answer: "#{number - randnum}")
    Card.create(deck_id: 2, question: "#{number} x #{randnum}", answer: "#{number * randnum}")
  end
end