<!DOCTYPE html>
<html lang="ru">
  <head>
    <meta charset="UTF-8" />
  </head>
  <body>
    <h1>Тема: интернет-магазин видеоигр</h1>
    <p>ФИО: Толстой Дмитрий Вячеславович</p>
    <p>Номер группы: 153502</p>
    <h2>Функциональные требования</h2>
    <ol>
      <li>
        Авторизация и управление пользователями
        <ul>
          <li>
            Регистрация новых пользователей с указанием имени, адреса
            электронной почты и пароля
          </li>
          <li>Вход в систему с использованием логина и пароля</li>
          <li>Выход из системы</li>
        </ul>
      </li>
      <li>
        Управление пользователями (CRUD)
        <ul>
          <p>(Админимтратор имеет права на нижеперечисленные действия со всеми аккаунтами)</p>
          <li>Создание новых пользователей с указанием основной информации</li>
          <li>Просмотр информации о пользователе</li>
          <li>Редактирование данных пользователя</li>
          <li>Удаление данных пользователя</li>
        </ul>
      </li>
      <li>
        Система ролей
        <ul>
          <li>
            Определение различных ролей пользователей (например, администратор,
            покупатель и т. д.)
          </li>
          <li>Привязка ролей к пользователям</li>
          <li>Управление правами доступа на основе ролей</li>
        </ul>
      </li>
      <li>
        Журналирование действий пользователя
        <ul>
          <li>
            Регистрация всех действий, совершаемых пользователями в системе
          </li>
          <li>
            Запись даты, времени и идентификатора пользователя при каждом
            действии
          </li>
          <li>
            Просмотр журнала действий всех пользователей (Администратор)
          </li>
        </ul>
      </li>
      <li>
        Управление играми (CRUD)
        <ul>
          <li>Создание нового товара-игры(Администратор)</li>
          <li>
            Просмотр подробной информации об играх (название, цена, жанр,
            издатель, описание и т. д.)
          </li>
          <li>Редактирование данных об игре(Администратор)</li>
          <li>Удаление данных об игре(Администратор)</li>
        </ul>
      </li>
      <li>
        Покупка игры
        <ul>
          <li>Добавление игры в корзину</li>
          <li>Оформление заказа</li>
          <li>Добавление игры в библиотеку</li>
        </ul>
      </li>
    </ol>
    <h2>Описание сущностей базы данных</h2>
    <ol>
      <li>
        Пользователь (Users)
        <ul>
          <li>user_id (Идентификатор пользователя): SERIAL (Primary Key)</li>
          <li>nickname (Имя): VARCHAR</li>
          <li>password (Пароль): VARCHAR (хешированный пароль)</li>
          <li>email (Адрес электронной почты): VARCHAR (уникальное значение)</li>
          <li>balance (Баланс пользователя): DECIMAL</li>
          <li>profile_pic (Путь к картинке профиля) VARCHAR(50)</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
          Связи:
          <b>Roles</b> - Many Mandatory-to-One Mandatory, 
          <b>User_logs</b> - One Mandatory-to-Optional Many, 
          <b>Reviews</b> - Many Optional-to-One Mandatory, 
          <b>Orders</b> - One Mandatory-to-Many Optional, 
          <b>Wishlists</b> - One Mandatory-to-Many Optional, 
          <b>Libraries</b> - One Mandatory-to-Many Optional, 
          <b>Carts</b> - One Mandatory-to-Many Optional, 
          <b>Payments</b> - One Mandatory-to-Many Optional.
        </p>
      </li>
      <li>
        Payments (Пополнения)
        <ul>
          <li>payment_id (Идентификатор платежа): SERIAL (Primary Key)</li>
          <li>payment_date (Дата пополнения): DATE</li>
          <li>user_id (Идентификатор пользователя): INT (Foreign key)</li>
          <li>description (Информация о пополнении): VARCHAR</li>
          <li>amount (Сумма пополнения): DECIMAL</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
          Связи:
          <b>Users</b> - Many Optional-to-One Mandatory.
        </p>
      </li>
      <li>
        Роли (Roles)
        <ul>
          <li>role_id (Идентификатор роли): SERIAL (Primary Key)</li>
          <li>role_name (Название роли): VARCHAR (уникальное значение)</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
          Связи: 
          <b>Users</b> - One Mandatory-to-Many Mandatory.
        </p>
      </li>
      <li>
        Отзывы (Reviews)
        <ul>
          <li>review_id (Идентификатор отзыва): SERIAL (Primary Key)</li>
          <li>rating (Рейтинг игры): INT(0-5)</li>
          <li>description (Описание отзыва): VARCHAR</li>
          <li>game_id (Идентификатор пользователя): INT</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
          Связи: 
          <b>Games</b> - Many Optional-to-One Mandatory, 
          <b>Users</b> - Many Optional-to-One Mandatory.
        </p>
      </li>
      <li>
        Игры (Games)
        <ul>
          <li>game_id (Идентификатор игры): SERIAL (Primary Key)</li>
          <li>name (Название игры): VARCHAR (Уникальное значение)</li>
          <li>game_description (Описание игры): VARCHAR</li>
          <li>publisher_id (Идентификатор издателя): INT (Foreign Key)</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
        Связи:
        <b>Categories</b> - Many Optional-to-Many Mandatory, 
        <b>Publishers</b> - Many Optional-to-One Mandatory, 
        <b>Platforms</b> - Many Optional-to-Many Mandatory, 
        <b>Carts</b> - One Mandatory-to-Many Optional, 
        <b>Wishlist</b> - One Mandatory-to-Many Optional, 
        <b>Pictures</b> - Many Optional-to-Many Optional.
        </p>
      </li>
      <li>
        Картинки (Pictures)
        <ul>
          <li>picture_id (Идентификатор картинки): SERIAL (Primary Key)</li>
          <li>path (Путь к картинке): VARCHAR</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
          Связи: 
          <b>Games</b> - Many Optional-to-Many Optional.
        </p>
      </li>
      <li>
        Корзины (Carts)
        <ul>
          <li>game_id (Идентификатор игры): INT (Foreign Key)</li>
          <li>user_id (Идентификатор пользователя): INT (Foreign Key)</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
          Связи:
          <b>Games</b> - Many Optional-to-One Mandatory, 
          <b>Users</b> - Many Optional-to-One Mandatory.
        </p>
      </li>
      <li>
        Списки желаемого (Wishlists)
        <ul>
          <li>game_id (Идентификатор игры): INT (Foreign Key)</li>
          <li>user_id (Идентификатор пользователя): INT (Foreign Key)</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
          Связи:
          <b>Games</b> - Many Optional-to-One Mandatory, 
          <b>Users</b> - Many Optional-to-One Mandatory.
        </p>
      </li>
      <li>
        Библиотеки (Libraries)
        <ul>
          <li>game_id (Идентификатор игры): INT (Foreign Key)</li>
          <li>user_id (Идентификатор пользователя): INT (Foreign Key)</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
          Связи:
          <b>Games</b> - Many Optional-to-One Mandatory, 
          <b>Users</b> - Many Optional-to-One Mandatory.
        </p>
      </li>
      <li>
        Категории (Categories)
        <ul>
          <li>category_id (Идентификатор корзины): SERIAL (Primary Key)</li>
          <li>category_name (Название категории): VARCHAR (Уникальное значение)</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
          Связи:
          <b>Games</b> - Many Optional-to-Many Mandatory.
        </p>
      </li>
      <li>
        Издатели (Publishers)
        <ul>
          <li>publisher_id (Идентификатор издателя): SERIAL (Primary Key)</li>
          <li>name (Название издателя): VARCHAR (Уникальное значение)</li>
          <li>description (Описание издателя): VARCHAR</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
          Связи:
          <b>Games</b> - One Mandatory-to-Many Optional.
        </p>
      </li>
      <li>
        Платформы (Platforms)
        <ul>
          <li>platform_id (Идентификатор платформы): SERIAL (Primary Key)</li>
          <li>name (Название платформы): VARCHAR (Уникальное значение)</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
          Связи: 
          <b>Games</b> - Many Mandatory-to-Many Optional.
        </p>
      </li>
      <li>
        Журналы (User_logs)
        <ul>
          <li>user_log_id (Идентификатор журнала): SERIAL (Primary Key)</li>
          <li>user_id (Идентификатор пользователя): INT (Foreign Key)</li>
          <li>date_of_event (Время и дата события): DATE</li>
          <li>description (Описание события): VARCHAR</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
          Связи:
          <b>Users</b> - Many Optional-to-One Mandatory.
        </p>
      </li>
      <li>
        Заказы (Orders)
        <ul>
          <li>order_id (Идентификатор заказа): SERIAL (Primary Key)</li>
          <li>user_id (Идентификатор пользователя): INT (Foreign Key)</li>
          <li>order_date (Время и дата заказа): DATE</li>
          <li>game_id (Идентификатор заказанной игры): INT (Foreign Key)</li>
          <li>status (Описание статуса): VARCHAR</li>
          <li>amount (Цена заказа) DECIMAL</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
          Связи:
          <b>Users</b> - Many Optional-to-One Mandatory, 
          <b>Games</b> - Many Optional-to-Many Mandatory.
        </p>
      </li>
      </ol>
    <h2>Схема базы данных</h2>
    <span><img src="https://github.com/westcrime/data-models-and-database-management-systems/blob/master/diagram.png?raw=true"/></span>

  </body>
</html>
