require 'pg'

def disable_notices(conn)
  conn.exec('SET client_min_messages TO WARNING;') # still like some kind of msg to go out
end

def listTableOptions
  "To create or delete a pokemon table type '1'."
end

def requestTableOption
  "Please enter 'create' or 'delete'."
end

def listRecordOptions
  "To add, modify, or delete a pokemon from an existing table, type '2'."
end

def requestRecordOption
  "Please enter 'add', 'modify', or 'delete'."
end

def createTable(conn, tableName)
  conn.exec("CREATE TABLE IF NOT EXISTS #{tableName}("\
  'id SERIAL PRIMARY KEY, name varchar,'\
  'move varchar, rank numeric(3), effective varchar)')
end

def renameTable(conn,originalName, newName)
  conn.exec("RENAME TABLE #{originalName} TO #{newName}")
end

def removeTable(conn, deleteTable)
  conn.exec("DROP TABLE #{deleteTable}")
end

def create_pokemon_record(conn, table, name, move, moveRank, effectiveAgainist)
  conn.exec("INSERT INTO #{table} VALUES(name varchar, move varchar, moveRank numeric, effectiveAgainist varchar)")
end


def main()
  conn = PG.connect(dbname: 'pokemon')
  disable_notices(conn)
  puts "Welcome to your Pokemon database!!"
  puts listTableOptions
  puts listRecordOptions
  number = gets.chomp.to_i
  if number == 1
    puts requestTableOption
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
        puts "The #{archaicTable} has been dropped from your database."
      end
    else
      puts "That is not a valid response."
    end
  elsif number == 2
    puts requestRecordOption
    response = gets.chomp
    if response == 'add'
      puts "What pokemon type table would you like to add a record to?"
      table = gets.chomp
      puts "What is the pokemon's name?"
      pokemonName = gets.chomp
      puts "What is the one of the pokemon's moves?"
      pokemonMove = gets.chomp
      puts "What is the rank of the move?"
      moveRank = gets.chomp.to_i
      puts "This pokemone is effective against what other pokemon type?"
      effectiveAgainst = gets.chomp
      puts "Thank you!"
      create_pokemon_record(conn, table, pokemonName, pokemonMove, moveRank, effectiveAgainst)
    end
  end
end

main if __FILE__==$PROGRAM_NAME
