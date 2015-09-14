require "pg"
require "pry"

def db_connection
  begin
    connection = PG.connect(dbname: "wordgames")
    yield(connection)
  ensure
    connection.close
  end
end

def find_rand_match(current_letters)
  sql = "SELECT word FROM words
        WHERE word LIKE ($1)
        ORDER BY RANDOM()
        LIMIT 1"
  values = [current_letters.concat("%")]
  db_connection { |conn| conn.exec_params(sql, values).to_a }
end

def complete_word?(current_letters)
  if current_letters.length < 4
    return false
  else
    sql = "SELECT word FROM words
          WHERE word=($1)"
    values = [current_letters]
    result = db_connection { |conn| conn.exec_params(sql, values).to_a }
    result != []
  end
end

def one_letter?(string)
  result = /^[a-z]$/.match(string)
  !result.nil?
end

def play_round

  plays = 0
  current_letters = ""

  while true

    puts
    puts "Enter 1 letter:"
    input = gets.chomp.downcase

    until one_letter?(input)
      puts "Enter ONE letter:"
      input = gets.chomp.downcase
    end

    current_letters.concat(input)
    puts "Current word: #{current_letters}"

    if complete_word?(current_letters)
      puts "You got beat by a dumb robot!"
      return
    end

    plays += 1
    possible_word = find_rand_match(current_letters)

    if possible_word == []
      puts "There's no words that start with #{current_letters.chop}! You're full of shit! You lose!"
      return
    end

    plays += 1

    current_letters = possible_word[0]["word"][0..plays - 1]

    50.times do
      if complete_word?(current_letters)
        current_letters.chop!
        possible_word = find_rand_match(current_letters)
        current_letters = possible_word[0]["word"][0..plays - 1]
      else
        break
      end
    end
    puts
    puts "Computer plays '#{current_letters[-1]}'"
    puts "Current word: #{current_letters}"

    if complete_word?(current_letters)
      puts "You have outsmarted a machine. Congrats."
      return "Human"
    end

    input = nil
  end
end

GAME = "GHOST"
puts "Welcome to Ghost Terminal"
puts "New Game!"

computer_score = 0
human_score = 0

until computer_score == 5 || human_score == 5
  winner = play_round
  if winner == "Human"
    computer_score += 1
  else
    human_score += 1
  end
  puts
  puts "How close are we... TO THE GRAVE:"
  puts "Human: #{GAME[0..(human_score - 1)]}" if human_score > 0
  puts "Computer: #{GAME[0..(computer_score - 1)]}" if computer_score > 0
end

if human_score == 5
  puts "You are now a GHOST. The ghost of someone who sucks at words! You lose!"
else
  puts "You have turned the computer into a GHOST. You win!"
  puts "But it was never alive so don't get too excited."
end
