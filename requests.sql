CREATE TABLE Platforms 
(
    platform_id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Publishers
(
    publisher_id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(50) UNIQUE NOT NULL,
    description VARCHAR(500) UNIQUE NOT NULL
);

CREATE TABLE Categories
(
    category_id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Roles 
(
    role_id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Users 
(
    user_id SERIAL PRIMARY KEY NOT NULL,
    nickname VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    role_id INT REFERENCES Roles(role_id),
    profile_pic_path VARCHAR(100) UNIQUE,
    balance DECIMAL NOT NULL
);

CREATE TABLE Games 
(
    game_id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(50) UNIQUE NOT NULL,
    description VARCHAR(500) NOT NULL,
    publisher_id INT REFERENCES Publishers(publisher_id) NOT NULL,
    category_id INT REFERENCES Categories(category_id) NOT NULL,
    cost DECIMAL NOT NULL,
    picture_path VARCHAR(100) UNIQUE
);

CREATE TABLE Platforms_Games
(
    game_id INT REFERENCES Games(game_id) NOT NULL,
    platform_id INT REFERENCES Platforms(platform_id) NOT NULL
);

CREATE TABLE Carts
(
    game_id INT REFERENCES Games(game_id) NOT NULL,
    user_id INT REFERENCES Users(user_id) NOT NULL
);

CREATE TABLE Libraries
(
    game_id INT REFERENCES Games(game_id) NOT NULL,
    user_id INT REFERENCES Users(user_id) NOT NULL
);

CREATE TABLE User_logs 
(
    user_log_id SERIAL PRIMARY KEY NOT NULL,
    user_id INT REFERENCES Users(user_id) NOT NULL,
    date_of_event DATE NOT NULL,
    description VARCHAR(250) NOT NULL
);

CREATE TABLE Payments 
(
    payment_id SERIAL PRIMARY KEY NOT NULL,
    payment_date DATE NOT NULL,
    user_id INT REFERENCES Users(user_id) NOT NULL,
    description VARCHAR(250) NOT NULL,
    amount DECIMAL NOT NULL
);

CREATE TABLE Orders 
(
    order_id SERIAL PRIMARY KEY NOT NULL,
    user_id INT REFERENCES Users(user_id) NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    amount DECIMAL NOT NULL
);

CREATE TABLE Orders_Games
(
    game_id INT REFERENCES Games(game_id) NOT NULL,
    order_id INT REFERENCES Orders(order_id) NOT NULL
);

CREATE TABLE Reviews 
(
    review_id SERIAL PRIMARY KEY NOT NULL,
    user_id INT REFERENCES Users(user_id) NOT NULL,
    game_id INT REFERENCES Games(game_id) NOT NULL,
    rating INT NOT NULL,
    CHECK (rating BETWEEN 0 AND 5),
    description VARCHAR(500) NOT NULL
);

INSERT INTO Categories (name) VALUES
('Simulator'),
('Action'),
('RPG'),
('Strategy'),
('Adventure'),
('Puzzle');

INSERT INTO Publishers (name, description) VALUES
('EA', 'Мировой лидер в игровой индустрии, известен своими спортивными симуляторами, такими как FIFA, а также широким спектром других популярных игр, включая шутеры Battlefield и ролевые игры Mass Effect.'),
('Ubisoft', 'Французская компания, славящаяся за создание великолепных открытых мировых игр, таких как Assassins Creed и Far Cry, а также серий Splinter Cell и Watch Dogs.'),
('Activision Blizzard', 'Гигант игровой индустрии с такими хитами, как Call of Duty, World of Warcraft и Overwatch. Одна из старейших компаний в сфере видеоигр.'),
('Bethesda', 'Известен своими эпическими ролевыми играми, включая The Elder Scrolls и Fallout. Их игры предлагают огромные открытые миры и глубокий сюжет.'),
('Rockstar Games', 'Создатели культовых Grand Theft Auto и Red Dead Redemption. Известен за детально проработанные миры и захватывающие истории в играх.');

INSERT INTO Platforms (name) VALUES
('PC'),
('Xbox'),
('PlayStation');

INSERT INTO Games (name, description, publisher_id, category_id, cost) VALUES
('FIFA 22', 'Футбольный симулятор с реалистичной графикой и улучшенным геймплеем.', (SELECT publisher_id FROM Publishers WHERE name = 'EA'), (SELECT category_id FROM Categories WHERE name = 'Simulator'), 39.99),
('Assassins Creed Valhalla', 'RPG-приключение, в котором вы играете за викинга и исследуете древнюю Англию.', (SELECT publisher_id FROM Publishers WHERE name = 'Ubisoft'), (SELECT category_id FROM Categories WHERE name = 'Adventure'), 19.99),
('Call of Duty: Warzone', 'Бесплатный боевой рояль в мире Call of Duty с интенсивными онлайн-сражениями.', (SELECT publisher_id FROM Publishers WHERE name = 'Activision Blizzard'), (SELECT category_id FROM Categories WHERE name = 'Action'), 0.0),
('The Elder Scrolls V: Skyrim', 'Эпическая RPG с открытым миром, где вы исследуете фэнтезийное королевство.', (SELECT publisher_id FROM Publishers WHERE name = 'Bethesda'), (SELECT category_id FROM Categories WHERE name = 'RPG'), 29.99),
('Grand Theft Auto V', 'Открытый мир, где вы совершаете ограбления и исследуете фиктивный город Лос-Сантос.', (SELECT publisher_id FROM Publishers WHERE name = 'Rockstar Games'), (SELECT category_id FROM Categories WHERE name = 'Adventure'), 39.99),
('Mass Effect Legendary Edition', 'Сборник ролевых игр с улучшенной графикой и вселенной научной фантастики.', (SELECT publisher_id FROM Publishers WHERE name = 'EA'), (SELECT category_id FROM Categories WHERE name = 'RPG'), 49.99),
('Far Cry 6', 'Шутер с открытым миром, вас ожидает борьба с тиранией на тропическом острове.', (SELECT publisher_id FROM Publishers WHERE name = 'Ubisoft'), (SELECT category_id FROM Categories WHERE name = 'Action'), 39.99),
('Diablo IV', 'RPG с мрачным фэнтезийным миром и борьбой с демонами.', (SELECT publisher_id FROM Publishers WHERE name = 'Activision Blizzard'), (SELECT category_id FROM Categories WHERE name = 'RPG'), 29.99),
('Fallout 4', 'Постапокалиптическая RPG с элементами выживания и исследования.', (SELECT publisher_id FROM Publishers WHERE name = 'Bethesda'), (SELECT category_id FROM Categories WHERE name = 'RPG'), 9.99),
('Red Dead Redemption 2', 'Вестерн с ошеломляющей графикой, где вы отправляетесь в путешествие в конце 19-го века.', (SELECT publisher_id FROM Publishers WHERE name = 'Rockstar Games'), (SELECT category_id FROM Categories WHERE name = 'Simulator'), 39.99);

INSERT INTO Roles (name) VALUES
('User'),
('Admin');

insert into Users (nickname, password, email, role_id, balance) values ('lcolbourn0', '$2a$04$EW4zWKiZAPRdqvz/dqb6K.3qA26GLjsT8ZBAQDpb6JFjDEqGxbVuW', 'tfance0@jalbum.net', 1, 39.59);
insert into Users (nickname, password, email, role_id, balance) values ('tmccroft1', '$2a$04$PUPWHe6OdiBe63iyJY1M9esrxfexyMDqwgEfqOIwQn9MVE4UwTcri', 'ebattey1@booking.com', 1, 6.01);
insert into Users (nickname, password, email, role_id, balance) values ('haggott2', '$2a$04$0O9fgMOopSKo5nIgbK4FYukOtGhS55MrBnQNQV4wpC6VDShwozJkC', 'drubens2@i2i.jp', 1, 4.82);
insert into Users (nickname, password, email, role_id, balance) values ('rgrolmann3', '$2a$04$jjgLBhQBaa7ZScTJtsZKx.96LCPHgxoYblm3iETgE.KzoMMzV5bIi', 'eclemmen3@liveinternet.ru', 1, 38.09);
insert into Users (nickname, password, email, role_id, balance) values ('vmacklam4', '$2a$04$V/Q98ejholWc59WWu22WG.RHvp9KnCZIWwssqNbvHAvCOPK884pLq', 'deberst4@nifty.com', 1, 87.45);
insert into Users (nickname, password, email, role_id, balance) values ('zvannozzii5', '$2a$04$M4985O7tBQwhM9gq3sQMtOb0VPecCd5O6PR4UiVfpgIr86nr6Xx4W', 'dellin5@dailymotion.com', 1, 10.13);
insert into Users (nickname, password, email, role_id, balance) values ('rcreasy6', '$2a$04$uBNelcgZUbgeYtLVj4UdoedTIiYIZlk2MDQ43vphxnnBNmvfk8IKi', 'mfigliovanni6@myspace.com', 1, 67.49);
insert into Users (nickname, password, email, role_id, balance) values ('ltchir7', '$2a$04$bFkCYx1ZNXor8oYhVf3rf.HzNLbPszFPLi9JYOvlVBaCOv2FnJleG', 'mziems7@statcounter.com', 1, 4.27);
insert into Users (nickname, password, email, role_id, balance) values ('jnovello8', '$2a$04$lyh9YbopC.RgEipupXkwkeY6TDjNQLf0DuitjGkgk2dv9vphwO1wW', 'bwillder8@cisco.com', 1, 42.43);
insert into Users (nickname, password, email, role_id, balance) values ('wbahde9', '$2a$04$NAp7qPF/O8EQNdTfwsU8UONZFMek3VYn/bQ1S5shDsTZIcsizzMTe', 'lchalk9@sitemeter.com', 1, 48.88);
insert into Users (nickname, password, email, role_id, balance) values ('ffussella', '$2a$04$wSnENb5it6GVlhNRL7So0.3CUQM7WUnCjRxaByFkuQ.yzZRCFXNSm', 'gcallena@princeton.edu', 1, 84.91);
insert into Users (nickname, password, email, role_id, balance) values ('clawmanb', '$2a$04$iLWdN72.v/Y7CUyuKUGgv.iosFV6unKvko9cVvGYPLQJJ9Tn6zjsa', 'mmenatb@craigslist.org', 1, 16.03);
insert into Users (nickname, password, email, role_id, balance) values ('rcaugheyc', '$2a$04$xpSvGGLxe3PoitYQGf7RS.6Iqi4QiqOcrotBO.4hpC8gKTeXgYC6q', 'rmuckeenc@prnewswire.com', 1, 29.03);
insert into Users (nickname, password, email, role_id, balance) values ('morwelld', '$2a$04$vikADNuesvfv8J2RyrdO.emsr4S4PKAOWr8d2hJOvw65RgrfnJHG6', 'foloned@amazon.de', 1, 80.17);
insert into Users (nickname, password, email, role_id, balance) values ('thawke', '$2a$04$Io0JG1rYGrWLYK8lWnjXnemJzcHGvG28EJ.7buA0aDsABC0wxuk/m', 'ecrowchee@technorati.com', 1, 26.11);
insert into Users (nickname, password, email, role_id, balance) values ('rmolloyf', '$2a$04$Y1Uwk09GFKLzIEqOUgALsuLVBcvOxqROr/SLRpfAKw8OENYEelMai', 'ydaelmanf@elegantthemes.com', 1, 64.7);
insert into Users (nickname, password, email, role_id, balance) values ('bmelliardg', '$2a$04$WRNJmH.8ILrgbpweYKvlcuaX4NOXRh5rCm3oclfiN.6wvKib8RUG.', 'mpefferg@marriott.com', 1, 17.51);
insert into Users (nickname, password, email, role_id, balance) values ('cskehanh', '$2a$04$b54zy6G1RCp/KZPpGFOXsuFaViQrgPAdntb0zvjK.ICMEeOKhC/3O', 'jgasnellh@cbslocal.com', 1, 23.76);
insert into Users (nickname, password, email, role_id, balance) values ('dhurnelli', '$2a$04$CWh9fdT.1yJvW4MLqReqJ.v8PS/u4isRXW1hDPXGO8bC5TvDQJg76', 'acokei@washington.edu', 1, 2.45);
insert into Users (nickname, password, email, role_id, balance) values ('bhendersonj', '$2a$04$GGxf.6ugg6ter/YSHTLU8e16ZG5c9sQdY569ouR47Jk5AjAUzNGNW', 'abriddenj@taobao.com', 1, 58.56);


INSERT INTO Platforms_Games (game_id, platform_id) VALUES
((SELECT game_id FROM Games WHERE name = 'FIFA 22'), (SELECT platform_id FROM Platforms WHERE name = 'PC')),
((SELECT game_id FROM Games WHERE name = 'FIFA 22'), (SELECT platform_id FROM Platforms WHERE name = 'Xbox')),
((SELECT game_id FROM Games WHERE name = 'FIFA 22'), (SELECT platform_id FROM Platforms WHERE name = 'PlayStation')),
((SELECT game_id FROM Games WHERE name = 'Call of Duty: Warzone'), (SELECT platform_id FROM Platforms WHERE name = 'PC')),
((SELECT game_id FROM Games WHERE name = 'Call of Duty: Warzone'), (SELECT platform_id FROM Platforms WHERE name = 'Xbox')),
((SELECT game_id FROM Games WHERE name = 'Call of Duty: Warzone'), (SELECT platform_id FROM Platforms WHERE name = 'PlayStation')),
((SELECT game_id FROM Games WHERE name = 'Grand Theft Auto V'), (SELECT platform_id FROM Platforms WHERE name = 'PC')),
((SELECT game_id FROM Games WHERE name = 'Grand Theft Auto V'), (SELECT platform_id FROM Platforms WHERE name = 'Xbox')),
((SELECT game_id FROM Games WHERE name = 'Grand Theft Auto V'), (SELECT platform_id FROM Platforms WHERE name = 'PlayStation')),
((SELECT game_id FROM Games WHERE name = 'Red Dead Redemption 2'), (SELECT platform_id FROM Platforms WHERE name = 'PC')),
((SELECT game_id FROM Games WHERE name = 'Red Dead Redemption 2'), (SELECT platform_id FROM Platforms WHERE name = 'Xbox')),
((SELECT game_id FROM Games WHERE name = 'Red Dead Redemption 2'), (SELECT platform_id FROM Platforms WHERE name = 'PlayStation')),
((SELECT game_id FROM Games WHERE name = 'Assassins Creed Valhalla'), (SELECT platform_id FROM Platforms WHERE name = 'PC')),
((SELECT game_id FROM Games WHERE name = 'The Elder Scrolls V: Skyrim'), (SELECT platform_id FROM Platforms WHERE name = 'PC')),
((SELECT game_id FROM Games WHERE name = 'Mass Effect Legendary Edition'), (SELECT platform_id FROM Platforms WHERE name = 'PC')),
((SELECT game_id FROM Games WHERE name = 'Far Cry 6'), (SELECT platform_id FROM Platforms WHERE name = 'PC')),
((SELECT game_id FROM Games WHERE name = 'Fallout 4'), (SELECT platform_id FROM Platforms WHERE name = 'PC'));

INSERT INTO Reviews (user_id, rating, description, game_id) VALUES
(1, 4, 'Very cool game!', (SELECT game_id FROM Games WHERE name = 'FIFA 22')),
(1, 5, 'Masterpiece!', (SELECT game_id FROM Games WHERE name = 'Red Dead Redemption 2')),
(2, 3, 'Good.', (SELECT game_id FROM Games WHERE name = 'Call of Duty: Warzone')),
(5, 4, 'Nice open world!', (SELECT game_id FROM Games WHERE name = 'The Elder Scrolls V: Skyrim')),
(7, 2, 'Very bad product.', (SELECT game_id FROM Games WHERE name = 'FIFA 22')),
(7, 5, 'Masterpiece!', (SELECT game_id FROM Games WHERE name = 'Fallout 4')),
(15, 5, 'Waste of money and time!', (SELECT game_id FROM Games WHERE name = 'Assassins Creed Valhalla'));

INSERT INTO Libraries (game_id, user_id) VALUES
((SELECT game_id FROM Games WHERE name = 'FIFA 22'), 1),
((SELECT game_id FROM Games WHERE name = 'FIFA 22'), 2),
((SELECT game_id FROM Games WHERE name = 'FIFA 22'), 3),
((SELECT game_id FROM Games WHERE name = 'Call of Duty: Warzone'), 15),
((SELECT game_id FROM Games WHERE name = 'Red Dead Redemption 2'), 15),
((SELECT game_id FROM Games WHERE name = 'Fallout 4'), 15);

INSERT INTO Carts (game_id, user_id) VALUES
((SELECT game_id FROM Games WHERE name = 'FIFA 22'), 5),
((SELECT game_id FROM Games WHERE name = 'FIFA 22'), 6),
((SELECT game_id FROM Games WHERE name = 'FIFA 22'), 9),
((SELECT game_id FROM Games WHERE name = 'Call of Duty: Warzone'), 16),
((SELECT game_id FROM Games WHERE name = 'Red Dead Redemption 2'), 16),
((SELECT game_id FROM Games WHERE name = 'Fallout 4'), 16);

-- Добавление пустого заказа
INSERT INTO Orders (user_id, order_date, status, amount) VALUES
(1, (SELECT CURRENT_DATE), 'Заказ не сформирован', 0.0),
(2, (SELECT CURRENT_DATE), 'Заказ не сформирован', 0.0),
(11, (SELECT CURRENT_DATE), 'Заказ не сформирован', 0.0);

-- Получаем список всех заказов
SELECT * FROM Orders;

-- Заполнение определнного заказа играми
INSERT INTO Orders_Games (game_id, order_id) VALUES
((SELECT game_id FROM Games WHERE name = 'FIFA 22'), 8),
((SELECT game_id FROM Games WHERE name = 'allout 4'), 8);

-- Обновление заказа на сумму выбранных игр
UPDATE Orders
SET amount = (
    SELECT SUM(Games.cost)
    FROM Orders_Games
    JOIN Games ON Orders_Games.game_id = Games.game_id
    WHERE Orders_Games.order_id = Orders.order_id
)
WHERE order_id = 8;

-- Обновление статуса заказа
UPDATE Orders
SET status = 'Заказ ждет оплаты'
WHERE order_id = 8;

-- Получение игр в заказе
SELECT * FROM Orders WHERE 
order_id = 8;
SELECT game_id FROM Orders_Games WHERE
order_id = 8;

-- Удаление заказа
DELETE FROM Orders WHERE
order_id = 8;
SELECT * FROM GAMES WHERE publisher_name = 'EA' OR publisher_name = 'Ubisoft'

SELECT u.nickname, o.order_id
FROM Users u
INNER JOIN Orders o
ON u.user_id = o.user_id;

-- Вывод пользователей и общая стоимость их заказов
SELECT u.nickname, SUM(g.cost) AS total_cost FROM Users u
LEFT JOIN Orders o ON u.user_id = o.user_id
LEFT JOIN Orders_Games og ON og.order_id = o.order_id
LEFT JOIN Games g ON g.game_id = og.game_id
GROUP BY u.nickname HAVING sum(g.cost) > 0 ORDER BY total_cost;

-- Получение игр от выбранных издателей
SELECT name FROM Games
WHERE publisher_id IN (SELECT publisher_id FROM Publishers WHERE name IN ('EA', 'Ubisoft'));

-- Получение количества приобретенных игр каждого пользователя
SELECT u.nickname, COUNT(l.game_id) AS count_of_games FROM Users u
LEFT JOIN Libraries l ON u.user_id = l.user_id
GROUP BY u.nickname HAVING COUNT(l.game_id) > 0 ORDER BY count_of_games;

-- Получение количества проданных копий каждой игры
SELECT g.name, COUNT(l.game_id) AS copies_sold FROM Games g
LEFT JOIN Libraries l ON g.game_id = l.game_id
GROUP BY g.name ORDER BY copies_sold;

-- Пример использования Partition
SELECT name, cost, publisher_id, COUNT(game_id) OVER (PARTITION BY publisher_id) AS number_of_games_from_this_publisher 
FROM Games;

-- Получение количества отзывов для каждой игры
SELECT g.name, COUNT(r.review_id) AS number_of_reviews FROM Games g
LEFT JOIN Reviews r ON r.game_id = g.game_id
GROUP BY g.name HAVING COUNT(r.review_id) > 0 ORDER BY number_of_reviews;

-- Вывод пользователей, у которых больше 5 игр в библиотеке (крутые)
SELECT nickname
FROM Users u
WHERE EXISTS (
    SELECT user_id
    FROM Libraries
    WHERE u.user_id = Libraries.user_id
    GROUP BY user_id
    HAVING COUNT(game_id) > 5
);

-- Union
SELECT user_id, description
FROM user_logs
WHERE date_of_event < '01.01.2000'
UNION
SELECT user_id, description
FROM user_logs_archive;

-- Case
SELECT
    nickname,
    CASE
        WHEN role_id = 1 THEN 'User'
        WHEN role_id = 2 THEN 'Admin'
        ELSE 'Unknown'
    END AS role_name
FROM Users;

-- Триггер, добавляющий к общей стоимости заказа стоимость добавленной игры
CREATE OR REPLACE FUNCTION update_sum_of_order_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Orders
    SET amount = amount + (SELECT cost FROM Games WHERE game_id = NEW.game_id)
    WHERE order_id = NEW.order_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_sum_of_order_trigger
AFTER INSERT ON Orders_Games
FOR EACH ROW
EXECUTE FUNCTION update_sum_of_order_trigger_function();

-- Процедура, с помощью которой можно можно сформировать заказ из игр в корзине в новый заказ
CREATE OR REPLACE FUNCTION create_order_from_cart(user_id_param INT)
RETURNS VOID AS $$
DECLARE
    new_order_id INT;
BEGIN
    -- Создаем новую строку в таблице Orders для пользователя
    INSERT INTO Orders (user_id, order_date, status, amount)
    VALUES (user_id_param, CURRENT_DATE, 'Заказ ждет оплаты', 0)
    RETURNING order_id INTO new_order_id;

    -- Переносим игры из корзины пользователя в таблицу Orders_Games
    INSERT INTO Orders_Games (game_id, order_id)
    SELECT game_id, new_order_id
    FROM Carts
    WHERE user_id = user_id_param;
END;
$$ LANGUAGE plpgsql;

-- Процедура, с помощью которой можно можно получить средний рейтинг игры
CREATE OR REPLACE FUNCTION get_avg_rating_of_game(game_id_param INT)
RETURNS DECIMAL AS $$
DECLARE avg_rating DECIMAL;
BEGIN
    SELECT AVG(rating) INTO avg_rating
    FROM Reviews
    WHERE game_id = game_id_param;

    RETURN avg_rating;
END;
$$ LANGUAGE plpgsql;

-- Процедура выводящая сообщение в текущие логи
CREATE OR REPLACE FUNCTION post_message_in_log(message_param character varying(250), user_id_param INT)
RETURNS VOID AS $$
BEGIN
    INSERT INTO user_logs (user_id, date_of_event, message)
    VALUES (user_id_param, CURRENT_DATE, message_param);
END;
$$ LANGUAGE plpgsql;

-- Логгирование юзера
CREATE OR REPLACE FUNCTION log_inserted_user()
RETURNS TRIGGER AS $$
DECLARE
    message VARCHAR(250);
BEGIN
    message := 'Новый пользователь с ID = ' || NEW.user_id || ' и именем = ' || NEW.nickname || ' был добавлен в таблицу.';

    PERFORM post_message_in_log(NEW.user_id, message);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER insert_new_user_trigger
AFTER INSERT ON Users
FOR EACH ROW
EXECUTE FUNCTION log_inserted_user();

CREATE OR REPLACE FUNCTION log_updated_user_data()
RETURNS TRIGGER AS $$
DECLARE
    message VARCHAR(250);
BEGIN
    message := 'Данные пользователя с ID = ' || OLD.user_id || ' были обновлены.';

    IF OLD.nickname <> NEW.nickname THEN
        message := message || ' Изменено имя пользователя: ' || OLD.nickname || ' -> ' || NEW.nickname || '.';
    END IF;

    IF OLD.email <> NEW.email THEN
        message := message || ' Изменен адрес электронной почты: ' || OLD.email || ' -> ' || NEW.email || '.';
    END IF;

    IF OLD.balance <> NEW.balance THEN
        message := message || ' Пополнен баланс пользователя: ' || OLD.balance || ' -> ' || NEW.balance || '.';
    END IF;

    PERFORM post_message_in_log(NEW.user_id, message);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_user_trigger
AFTER UPDATE ON Users
FOR EACH ROW
EXECUTE FUNCTION log_updated_user_data();

-- Пополнение баланса
CREATE OR REPLACE FUNCTION add_money_to_user_balance()
RETURNS TRIGGER AS $$
DECLARE
    amount DECIMAL;
BEGIN
    amount := NEW.amount;

    UPDATE Users SET balance = balance + NEW.amount
    WHERE user_id = NEW.user_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_balance_of_user
AFTER UPDATE ON Payments
FOR EACH ROW
EXECUTE FUNCTION add_money_to_user_balance();