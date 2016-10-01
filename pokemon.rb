require 'pg'

def disable_notices(conn)
  conn.exec('SET client_min_messages TO WARNING;')
end

def create_pokemon_table(conn, table_name)
  conn.exec("CREATE TABLE IF NOT EXISTS #{table_name}("\
  'id SERIAL PRIMARY KEY, name varchar, type varchar,'\
   'move varchar, rank numeric(3), effective varchar)')
end

def remove_pokemon_table
end

def main()
conn = PG.connect(dbname: 'pokemon')
disable_notices(conn)
create_pokemon_table(conn, 'water')
end

main if __FILE__==$PROGRAM_NAME
