require 'pry'
require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: "wordgames")
    yield(connection)
  ensure
    connection.close
  end
end

info = File.readlines('words.txt')
info.each do |word|
  current = word.chomp.chomp
  if current.length >= 4
    sql = "INSERT INTO words (word) VALUES ($1)"
    values = [current]
    db_connection { |conn| conn.exec_params(sql, values) }
  end
end
