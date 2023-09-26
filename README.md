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
        </ul>
      </li>
      <li>
        Управление играми (CRUD)
        <ul>
          <li>Создание нового товара-игры</li>
          <li>
            Просмотр подробной информации об играх (название, цена, жанр,
            издатель, описание и т. д.)
          </li>
          <li>Редактирование данных об игре</li>
          <li>Удаление данных об игре</li>
        </ul>
      </li>
      <li>
        Покупка игры
        <ul>
          <li>Добавление игры в корзину</li>
          <li>Оплата покупки доступными методами оплаты</li>
          <li>Редактирование данных об игре</li>
          <li>Добавление игры в библиотеку</li>
        </ul>
      </li>
    </ol>
    <h2>Описание сущностей базы данных</h2>
    <ol>
      <li>
        Пользователь (Users)
        <ul>
          <li>user_id (Идентификатор пользователя): INT (Primary Key)</li>
          <li>nickname (Имя): VARCHAR</li>
          <li>
            email (Адрес электронной почты): VARCHAR (уникальное значение)
          </li>
          <li>password (Пароль): VARCHAR (хешированный пароль)</li>
          <li>library_id (Идентификатор библиотеки): INT (Foreign Key)</li>
          <li>
            wishlist_id (Идентификатор списка желаемого): INT (Foreign Key)
          </li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
          Связи: Относится к ролям через таблицу <b>Roles</b> - Many
          Mandatory-to-Many Optional, <b>User_logs</b> - One
          Mandatory-to-Optional Many, <b>Reviews</b> - Many Optional-to-One
          Mandatory, <b>Orders</b> - Many Optional-to-One Mandatory,
          <b>Wishlists</b> - One Mandatory-to-One Mandatory, <b>Libraries</b> - One
          Mandatory-to-One Mandatory, <b>Carts</b> - One
          Mandatory-to-One Mandatory.
        </p>
      </li>
      <li>
        Роли (Roles)
        <ul>
          <li>role_id (Идентификатор роли): INT (Primary Key)</li>
          <li>role_name (Название роли): VARCHAR (уникальное значение)</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
          Связи: Назначается пользователям через таблицу <b>Users</b> -
          Many-to-Many Mandatory.
        </p>
      </li>
      <li>
        Отзывы (Reviews)
        <ul>
          <li>review_id (Идентификатор отзыва): INT (Primary Key)</li>
          <li>rating (Рейтинг игры): INT(0-5)</li>
          <li>description (Описание отзыва): VARCHAR</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
            Связи: Относятся к играм через <b>Games</b> - One-to-Many Optional.
        </p>
      </li>
      <li>
        Игры (Games)
        <ul>
          <li>game_id (Идентификатор игры): INT (Primary Key)</li>
          <li>name (Название игры): VARCHAR (Уникальное значение)</li>
          <li>description (Описание игры): VARCHAR</li>
          <li>category_id (Идентификатор категории): INT (Foreign Key)</li>
          <li>publisher_id (Идентификатор издателя): INT (Foreign Key)</li>
          <li>platform_id (Идентификатор платформы): INT (Foreign Key)</li>
          <li>review_id (Идентификатор отзыва): INT (Foreign Key)</li>
          <li>game_pics (Пути на картинки к играм) : TEXT[]</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
            Связи: Относятся к категориям через <b>Categories</b> - (Many Mandatory-to-Many Optional), <b>Publishers</b> - (Many Mandatory-to-Many Optional), <b>Platforms</b> - (Many Mandatory-to-Many Optional), <b>Cart</b> - (Many Optional-to-Many Optional), <b>Wishlist</b> - (Many Optional-to-Many Optional).
        </p>
        </p>
      </li>
      <li>
        Корзины (Carts)
        <ul>
          <li>cart_id (Идентификатор корзины): INT (Primary Key)</li>
          <li>game_id (Идентификатор игры): INT (Foreign Key)</li>
          <li>user_id (Идентификатор пользователя): INT (Foreign Key)</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
            Связи: Относятся к играм через <b>Games</b> - Many Optional-to-Many Optional, <b>Users</b> - One Mandatory-to-One Mandatory.
        </p>
      </li>
      <li>
        Списки желаемого (Wishlists)
        <ul>
          <li>wishlist_id (Идентификатор списка желаемого): INT (Primary Key)</li>
          <li>game_id (Идентификатор игры): INT (Foreign Key)</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
            Связи: Относятся к играм через <b>Games</b> - Many Optional-to-Many Optional, <b>Users</b> - One Mandatory-to-One Mandatory.
        </p>
      </li>
      <li>
        Библиотеки (Libraries)
        <ul>
          <li>library_id (Идентификатор библиотеки): INT (Primary Key)</li>
          <li>game_id (Идентификатор игры): INT (Foreign Key)</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
            Связи: Относятся к играм через <b>Games</b> - Many Optional-to-Many Optional, <b>Users</b> - One Mandatory-to-One Mandatory.
        </p>
      </li>
      <li>
        Категории (Categories)
        <ul>
          <li>category_id (Идентификатор корзины): INT (Primary Key)</li>
          <li>category_name (Название категории): VARCHAR (Уникальное значение)</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
            Связи: Относятся к играм через <b>Games</b> - Many Optional-to-Many Mandatory.
        </p>
      </li>
      <li>
        Издатели (Publishers)
        <ul>
          <li>publisher_id (Идентификатор издателя): INT (Primary Key)</li>
          <li>name (Название издателя): VARCHAR (Уникальное значение)</li>
          <li>description (Описание издателя): VARCHAR (Уникальное значение)</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
            Связи: Относятся к играм через <b>Games</b> - Many Optional-to-Many Mandatory.
        </p>
      </li>
      <li>
        Платформы (Platforms)
        <ul>
          <li>platform_id (Идентификатор платформы): INT (Primary Key)</li>
          <li>name (Название платформы): VARCHAR (Уникальное значение)</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
            Связи: Относятся к играм через <b>Games</b> - Many Optional-to-Many Mandatory.
        </p>
      </li>
      <li>
        Журналы (User_logs)
        <ul>
          <li>user_log_id (Идентификатор журнала): INT (Primary Key)</li>
          <li>user_id (Идентификатор пользователя): INT (Foreign Key)</li>
          <li>date_of_event (Время и дата события): DATE</li>
          <li>description (Описание события): VARCHAR</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
            Связи: Относятся к пользователям через <b>Users</b> - Many Optional-to-One Mandatory.
        </p>
      </li>
      <li>
        Заказы (Orders)
        <ul>
          <li>order_id (Идентификатор заказа): INT (Primary Key)</li>
          <li>user_id (Идентификатор пользователя): INT (Foreign Key)</li>
          <li>order_date (Время и дата заказа): DATE</li>
          <li>game_id (Идентификатор заказанной игры): INT (Foreign Key)</li>
          <li>status (Описание статуса): VARCHAR</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
            Связи: Относятся к пользователям через <b>Users</b> - One Mandatory-to-Many Optional, <b>Games</b> - One Mandatory-to-Many Optional, <b>Payments</b> - One Mandatory-to-One Optional.
        </p>
      </li>
      <li>
        Платежи (Payments)
        <ul>
          <li>payment_id (Идентификатор платежа): INT (Primary Key)</li>
          <li>order_id (Идентификатор заказа): INT (Foreign Key)</li>
          <li>payment_date (Время и дата оплаты): DATE</li>
          <li>amount (Цена оплаты): DECIMAL</li>
        </ul>
        <p>Ограничения: Нет дополнительных ограничений</p>
        <p>
            Связи: Относятся к заказам через <b>Orders</b> - One Optional-to-One Mandatory.
        </p>
      </li>
    </ol>
    <h2>Схема базы данных</h2>
    <img src="https://github.com/westcrime/data-models-and-database-management-systems/Lab1/diagram.png" alt="схема БД">
  </body>
</html>
