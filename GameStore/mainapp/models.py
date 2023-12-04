from configparser import ConfigParser
from tkinter import W
from urllib import request
from django.db import models
import psycopg2

class CurrentUser(models.Model):
    is_authenticated = False
    user_id = 0

    @classmethod
    def login(cls, id: int):
        cls.user_id = id
        cls.is_authenticated = True

    @classmethod
    def logout(cls)->int:
        id = cls.user_id
        cls.user_id = 0
        cls.is_authenticated = False
        return id
        
    @classmethod
    def login(cls, nickname, password):
        result = DbService.login(nickname, password)
        if result != None:
            cls.is_authenticated = True
            cls.user_id = result['user_id']
        return result

    @classmethod
    def get_username(cls)->str:
        username = ''
        if cls.is_authenticated:
            username = DbService.get_user(cls.user_id)['nickname']
        else:
            username = 'error'

        return username
    

class DbService(models.Model):
    
    is_initialized = False

    @classmethod
    def initialize_database(cls, filename='mainapp/database.ini', section='postgresql'):
        parser = ConfigParser()

        parser.read(filename)

        db = {}
        if parser.has_section(section):
            params = parser.items(section)
            for param in params:
                db[param[0]] = param[1]
        else:
            raise Exception('Section {0} not found in the {1} file'.format(section, filename))

        try:
            cls._database_connection = psycopg2.connect(**db)
            cls._database_connection.autocommit = True
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
        finally:
            cls.is_initialized = True

    @classmethod
    def get_games(cls, sort_factor = 'name'):
        if not cls.is_initialized:
            cls.initialize_database()
        db_cursor = cls._database_connection.cursor()
        request = f'''SELECT g.game_id, g.name, g.description, p.name, c.name, g.cost, g.picture_path FROM Games g
        LEFT JOIN Publishers p ON p.publisher_id = g.publisher_id
        LEFT JOIN Categories c ON c.category_id = g.category_id ORDER BY g.{sort_factor};'''
        db_cursor.execute(request)
        games = db_cursor.fetchall()
        updated_games = []
        for game in games:
            updated_games.append({'game_id': game[0], 'game_name': game[1], 'game_description': game[2], 'game_publisher_name': game[3],
                                   'game_category_name': game[4], 'game_cost': game[5], 'game_avg_rating': cls.get_avg_of_game(game[0])})
        return updated_games

    @classmethod
    def get_avg_of_game(cls, id):
        if not cls.is_initialized:
            cls.initialize_database()
        cls.initialize_database()
        db_cursor = cls._database_connection.cursor()
        request = f'''SELECT get_avg_rating_of_game({id})'''
        db_cursor.execute(request)
        result = db_cursor.fetchall()
        return (result[0])[0]
    
    @classmethod
    def get_user(cls, id):
        if not cls.is_initialized:
            cls.initialize_database()
        db_cursor = cls._database_connection.cursor()
        request = f'''SELECT user_id, nickname, email, profile_pic_path, balance FROM Users WHERE user_id = {id};'''
        db_cursor.execute(request)
        result = (db_cursor.fetchall())[0]
        final_result = {'user_id': result[0], 'nickname': result[1], 'email': result[2], 'profile_pic_path': result[3], 'balance': result[4]}
        return final_result

    @classmethod
    def login(cls, nickname, password):
        if not cls.is_initialized:
            cls.initialize_database()
        db_cursor = cls._database_connection.cursor()
        request = f'''SELECT user_id, nickname, password FROM Users WHERE nickname = '{nickname}';'''
        db_cursor.execute(request)
        result = (db_cursor.fetchall())
        if len(result) != 0 and result[0][2] == password:
            return cls.get_user(result[0])
        return None
