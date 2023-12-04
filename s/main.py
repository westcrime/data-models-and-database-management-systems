import psycopg2

from app import App
from services.database import config


def connect():
    """Соединение к PostgreSQL серверу"""
    database_connection = None
    try:
        # read connection parameters
        params = config()

        # connect to the PostgreSQL server
        print('Соединение к PostgreSQL серверу...')
        database_connection = psycopg2.connect(**params)
        database_connection.autocommit = True

        # create a cursor
        cur = database_connection.cursor()

        # execute a statement
        app = App(cur)

        # close the communication with the PostgreSQL
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if database_connection is not None:
            database_connection.close()
            print('Связь с PostgreSQL сервером прекращена.')


if __name__ == '__main__':
    connect()