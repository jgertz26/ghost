require 'pg'
require 'pry'
def db_connection
  begin
    connection = PG.connect(dbname: "wordgames")
    yield(connection)
  ensure
    connection.close
  end
end
