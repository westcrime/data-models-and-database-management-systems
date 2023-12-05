from configparser import ConfigParser
from tkinter import W
from unittest import result
from urllib import request
from django.db import models
import psycopg2

class CurrentUser(models.Model):
    # is_authenticated = False
    # user_id = 0 
    is_authenticated = True
    user_id = 25

    @classmethod
    def register(cls, nickname, password, email, role_id, balance = 0, profile_pic_path = ''):
        if DbService.register(nickname, password, email, role_id, profile_pic_path, balance):
            return cls.login(nickname, password)
        else:
            return None

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
    
    @classmethod
    def get_balance(cls)->str:
        balance = ''
        if cls.is_authenticated:
            balance = DbService.get_user(cls.user_id)['balance']
        else:
            balance = 'error'
        return balance
    

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
    def get_game(cls, id):
        if not cls.is_initialized:
            cls.initialize_database()
        db_cursor = cls._database_connection.cursor()
        request = f'''SELECT g.game_id, g.name, g.description, p.name, c.name, g.cost, g.picture_path FROM Games g
        LEFT JOIN Publishers p ON p.publisher_id = g.publisher_id
        LEFT JOIN Categories c ON c.category_id = g.category_id WHERE g.game_id = {id};'''
        db_cursor.execute(request)
        game = db_cursor.fetchall()[0]
        return {'game_id': game[0], 'game_name': game[1], 'game_description': game[2], 'game_publisher_name': game[3],
                                   'game_category_name': game[4], 'game_cost': game[5], 'game_avg_rating': cls.get_avg_of_game(game[0])}

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
        result = db_cursor.fetchall()
        if len(result) != 0 and result[0][2] == password:
            return cls.get_user(result[0][0])
        return None

    @classmethod
    def register(cls, nickname, password, email, role_id, profile_pic_path, balance):
        try:
            if not cls.is_initialized:
                cls.initialize_database()
            db_cursor = cls._database_connection.cursor()
            request = f'''INSERT INTO Users (nickname, password, email, role_id, profile_pic_path, balance) VALUES
            ('{nickname}', '{password}', '{email}', {role_id}, '{profile_pic_path}', {balance});'''
            db_cursor.execute(request)
            result = db_cursor.fetchall()
            return True
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
            return False
        
    @classmethod
    def get_cart_games(cls, user_id):
        if not cls.is_initialized:
                cls.initialize_database()
        db_cursor = cls._database_connection.cursor()
        request = f'''SELECT g.game_id, g.name, g.description, g.cost FROM Games g
LEFT JOIN Carts c ON c.user_id = {user_id} WHERE g.game_id = c.game_id;'''
        db_cursor.execute(request)
        games = db_cursor.fetchall()
        updated_games = []
        for game in games:
            updated_games.append({'game_id': game[0], 'game_name': game[1], 'game_description': game[2], 'game_cost': game[3]})
        return updated_games
    
    @classmethod
    def add_game_to_cart(cls, game_id, user_id):
        if not cls.is_initialized:
                cls.initialize_database()
        try:
            db_cursor = cls._database_connection.cursor()
            request = f'''SELECT add_game_to_carts({game_id}, {user_id});'''
            db_cursor.execute(request)
            result = db_cursor.fetchall()[0]
            if (result[0] == 't'):
                return True
            elif (result[0] == 'f'):
                return False
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
            return False
        
    @classmethod
    def remove_game_from_cart(cls, game_id):
        if not cls.is_initialized:
                cls.initialize_database()
        try:
            db_cursor = cls._database_connection.cursor()
            request = f'''DELETE FROM Carts WHERE game_id = {game_id} AND user_id = {CurrentUser.user_id};'''
            db_cursor.execute(request)
            return True
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
            return False

    @classmethod
    def get_library_games(cls):
        if not cls.is_initialized:
            cls.initialize_database()
        try:
            db_cursor = cls._database_connection.cursor()
            request = f'''SELECT g.game_id, g.name, g.description, p.name, c.name, g.cost, g.picture_path FROM Libraries l
        LEFT JOIN Games g ON g.game_id = l.game_id
        LEFT JOIN Publishers p ON p.publisher_id = g.game_id
        LEFT JOIN Categories c ON c.category_id = g.category_id WHERE l.user_id = {CurrentUser.user_id};'''
            db_cursor.execute(request)
            games = db_cursor.fetchall()
            updated_games = []
            for game in games:
                updated_games.append({'game_id': game[0], 'game_name': game[1], 'game_description': game[2], 'game_publisher_name': game[3],
                                    'game_category_name': game[4], 'game_cost': game[5], 'game_avg_rating': cls.get_avg_of_game(game[0])})
            return updated_games
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
            return None

    @classmethod
    def create_order(cls):
        if not cls.is_initialized:
            cls.initialize_database()
        try:
            db_cursor = cls._database_connection.cursor()
            request = f'''SELECT create_order_from_cart({CurrentUser.user_id});'''
            db_cursor.execute(request)
            return True
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
            return False
        
    @classmethod
    def get_orders(cls):
        if not cls.is_initialized:
            cls.initialize_database()
        try:
            db_cursor = cls._database_connection.cursor()
            request = f'''SELECT * FROM Orders WHERE user_id = {CurrentUser.user_id};'''
            db_cursor.execute(request)
            orders = db_cursor.fetchall()
            updated_orders = []
            for order in orders:
                updated_orders.append({'order_id': order[0], 'user_id': order[1], 'order_date': order[2], 'status': order[3], 'amount': order[4]})
            return updated_orders
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
            return None

    @classmethod
    def pay_order(cls, order_id):
        if not cls.is_initialized:
            cls.initialize_database()
        try:
            db_cursor = cls._database_connection.cursor()
            request = f'''SELECT pay_for_order({CurrentUser.user_id}, {order_id});'''
            db_cursor.execute(request)
            return True
        except (Exception, psycopg2.DatabaseError) as error:
            print(error)
            return False
