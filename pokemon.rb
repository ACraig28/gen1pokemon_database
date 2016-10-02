require 'pg'

def disable_notices(conn)
  conn.exec('SET client_min_messages TO WARNING;') # still like some kind of msg to go out
end

def createTable(conn, tableName)
  conn.exec("CREATE TABLE IF NOT EXISTS #{tableName}("\
  'id SERIAL PRIMARY KEY, name varchar, type varchar,'\
   'move varchar, rank numeric(3), effective varchar)')
 end

def alterTable
end

def removeTable(conn, deleteTable)
   conn.exec("DROP TABLE #{deleteTable}")
end




def main()
conn = PG.connect(dbname: 'pokemon')
disable_notices(conn)
puts "To create a pokemon table, type 'create', to delete a table, type 'delete'."
response = gets.chomp
  if response == 'create'
    puts 'What type of pokemon table do you want to create?'
    newTable = gets.chomp
    createTable(conn, newTable)
    puts "Your #{newTable} table has been created."
  elsif response == 'delete'
    puts "Are you sure?"
    confirmation = gets.chomp
    if confirmation == 'yes'
      puts 'What table would you like to delete?'
    archaicTable = gets.chomp
      removeTable(conn, archaicTable)
    end
  end
end

main if __FILE__==$PROGRAM_NAME
