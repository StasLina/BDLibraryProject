CREATE TABLE Libraries (
    library_id INT PRIMARY KEY,               -- Уникальный идентификатор библиотеки
    library_name VARCHAR(255),                -- Название библиотеки
    address VARCHAR(255)                      -- Адрес библиотеки
);


CREATE TABLE LocationTypes (
    location_type_id INT PRIMARY KEY,         -- Уникальный идентификатор типа локации
    location_type_name VARCHAR(100)          -- Название типа (например, "абонемент", "читальный зал")
);


CREATE TABLE Locations (
    location_id INT PRIMARY KEY,              -- Уникальный идентификатор локации
    library_id INT,                           -- Ссылка на библиотеку
    location_name VARCHAR(100),               -- Название локации
    location_type_id INT,                     -- Ссылка на тип локации
    FOREIGN KEY (library_id) REFERENCES Libraries(library_id),
    FOREIGN KEY (location_type_id) REFERENCES LocationTypes(location_type_id)
);


CREATE TABLE ReaderCategories (
    category_id INT PRIMARY KEY,              -- Уникальный идентификатор категории
    category_name VARCHAR(100),               -- Название категории (например, "студент", "лектор")
    max_borrow_days INT                       -- Максимальное время (в днях), на которое можно взять книгу
);

CREATE TABLE Readers (
    reader_id INT PRIMARY KEY,                -- Уникальный идентификатор читателя
    full_name VARCHAR(255),                   -- Полное имя читателя
    category_id INT,                          -- Ссылка на категорию читателя
    FOREIGN KEY (category_id) REFERENCES ReaderCategories(category_id)
);

--    subscription_id INT,                      -- Ссылка на активный абонемент

CREATE TABLE Subscriptions (
    subscription_id INT PRIMARY KEY,          -- Уникальный идентификатор подписки
    reader_id INT,                            -- Ссылка на читателя
    location_id INT,                          -- Ссылка на локацию
    start_date DATE,                          -- Дата начала подписки
    end_date DATE,                            -- Дата окончания подписки
    max_books INT,                            -- Максимальное количество выдаваемых книг
    FOREIGN KEY (reader_id) REFERENCES Readers(reader_id),
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY,                  -- Уникальный идентификатор книги
    title VARCHAR(255),                       -- Название книги
    author VARCHAR(255),                      -- Автор книги
    publication_year INT,                     -- Год публикации
    total_copies INT                          -- Общее количество экземпляров
);


CREATE TABLE BookInventory (
    inventory_id INT PRIMARY KEY,             -- Уникальный идентификатор записи
    book_id INT,                              -- Ссылка на книгу
    location_id INT,                          -- Ссылка на локацию
    quantity INT,                             -- Количество экземпляров в данной локации
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);


CREATE TABLE InterlibraryRequests (
    request_id INT PRIMARY KEY,               -- Уникальный идентификатор запроса
    source_location_id INT,                   -- Локация-источник
    destination_location_id INT,              -- Локация-получатель
    request_date DATE,                        -- Дата запроса
    status VARCHAR(50),                       -- Статус запроса ("выполнен", "ожидает")
    FOREIGN KEY (source_location_id) REFERENCES Locations(location_id),
    FOREIGN KEY (destination_location_id) REFERENCES Locations(location_id)
);


CREATE TABLE InterlibraryRequestDetails (
    detail_id INT PRIMARY KEY,                -- Уникальный идентификатор строки
    request_id INT,                           -- Ссылка на межбиблиотечный запрос
    book_id INT,                              -- Ссылка на книгу
    quantity INT,                             -- Количество экземпляров
    FOREIGN KEY (request_id) REFERENCES InterlibraryRequests(request_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);


CREATE TABLE BookStatus(
	status_id INT PRIMARY KEY,
	name VARCHAR(50)
);

CREATE TABLE BookIssues (
    issue_id INT PRIMARY KEY,                 -- Уникальный идентификатор выдачи
    reader_id INT,                            -- Ссылка на читателя
    book_id INT,                              -- Ссылка на книгу
    issue_date DATE,                          -- Дата выдачи
    due_date DATE,                            -- Срок возврата
    return_date DATE,                         -- Дата фактического возврата
    location_id INT,                          -- Локация, где книга была выдана
    status_id INT,                       -- Статус ("возвращено", "задолженность")
    FOREIGN KEY (reader_id) REFERENCES Readers(reader_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (location_id) REFERENCES Locations(location_id),
	FOREIGN KEY (status_id) REFERENCES BookStatus(status_id)
);


CREATE TABLE Fines (
    fine_id INT PRIMARY KEY,                  -- Уникальный идентификатор штрафа
    reader_id INT,                            -- Ссылка на читателя
    amount DECIMAL(10, 2),                    -- Сумма штрафа
    reason VARCHAR(255),                      -- Причина штрафа
    fine_date DATE,                           -- Дата наложения штрафа
	fine_date_end DATE, 						-- Конец штрафа
    FOREIGN KEY (reader_id) REFERENCES Readers(reader_id)
);


CREATE TABLE ReaderAttributes (
    attribute_id INT PRIMARY KEY,        -- Уникальный идентификатор атрибута
    attribute_name VARCHAR(255)          -- Название атрибута (например, "Факультет", "Курс")
);


CREATE TABLE ReaderAttributeValues (
    reader_id INT,                       -- Ссылка на читателя
    attribute_id INT,                    -- Ссылка на атрибут
    value VARCHAR(255),                  -- Значение атрибута
    PRIMARY KEY (reader_id, attribute_id),
    FOREIGN KEY (reader_id) REFERENCES Readers(reader_id),
    FOREIGN KEY (attribute_id) REFERENCES ReaderAttributes(attribute_id)
);


CREATE TABLE AttributeRestrictions (
    category_id INT,                     -- Категория читателя (например, студент, преподаватель)
    attribute_id INT,                    -- Ссылка на атрибут
    PRIMARY KEY (category_id, attribute_id),
    FOREIGN KEY (attribute_id) REFERENCES ReaderAttributes(attribute_id)
);