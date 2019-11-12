import psycopg2

conn = psycopg2.connect("postgresql://root:root@postgres/fuelsave")

# Open a cursor to perform database operations
cur = conn.cursor()

cur.execute(open("initial.sql", "r").read())

# Make the changes to the database persistent
conn.commit()

# Close communication with the database
cur.close()
conn.close()