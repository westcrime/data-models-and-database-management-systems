import psycopg2

class App:
    def __init__(self, cursor: psycopg2.cursor):
        self.db_cursor = cursor
        self.current_user_id = None
        self.is_user_authenticated = False

    def login(self, new_user_id: int):
        self.is_user_authenticated = True
        self.current_user_id = new_user_id

    def get_library(self):
        request = ''''''
        self.db_cursor.fetchall()

    def logout(self):
        self.is_user_authenticated = False

    def start_process(self):
        separator = '<-------------------------------------->'
        while True:
            if self.is_user_authenticated:
                menu_str = '''1. User profile\n         
                2. My library\n
                3. My cart\n
                4. My orders\n
                5. My payments\n
                5. Game store\n
                7. Exit\n'''
                print(menu_str)
                print(separator)
                user_answer = int(input('Choose a variant'))
                if user_answer == 1:

                elif user_answer == 2:
