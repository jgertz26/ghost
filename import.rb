require_relative "connection"
require "pry"

sql = "DROP TABLE IF EXISTS words;
CREATE TABLE words
(
id SERIAL PRIMARY KEY,
word varchar(100)
);"

db_connection { |conn| conn.exec(sql) }

info = File.readlines('words.txt')
info.each do |word|
  current = word.chomp
  if current.length >= 4
    sql = "INSERT INTO words (word) VALUES ($1)"
    values = [current]
    db_connection { |conn| conn.exec_params(sql, values) }
  end
end
