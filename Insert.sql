INSERT INTO Libraries (library_id, library_name, address) VALUES (1, 'Главная библиотека', 'ул. Ленина, 10');
INSERT INTO Libraries (library_id, library_name, address) VALUES (2, 'Филиал №1', 'ул. Советская, 22');
INSERT INTO Libraries (library_id, library_name, address) VALUES (3, 'Филиал №2', 'ул. Победы, 5');
INSERT INTO Libraries (library_id, library_name, address) VALUES (4, 'Филиал №3', 'ул. Гагарина, 12');
INSERT INTO Libraries (library_id, library_name, address) VALUES (5, 'Филиал №4', 'ул. Академическая, 8');


-- Таблица LocationTypes
INSERT INTO LocationTypes (location_type_id, location_type_name) VALUES (1, 'Читальный зал');
INSERT INTO LocationTypes (location_type_id, location_type_name) VALUES (2, 'Абонемент');
INSERT INTO LocationTypes (location_type_id, location_type_name) VALUES (3, 'Картотека');
INSERT INTO LocationTypes (location_type_id, location_type_name) VALUES (4, 'Электронный архив');
INSERT INTO LocationTypes (location_type_id, location_type_name) VALUES (5, 'Выставочный зал');

-- Таблица ReaderAttributes
INSERT INTO ReaderAttributes (attribute_id, attribute_name) VALUES (1, 'Кафедра');
INSERT INTO ReaderAttributes (attribute_id, attribute_name) VALUES (2, 'Факультет');
INSERT INTO ReaderAttributes (attribute_id, attribute_name) VALUES (3, 'Курс');
INSERT INTO ReaderAttributes (attribute_id, attribute_name) VALUES(4, 'Группа');
INSERT INTO ReaderAttributes (attribute_id, attribute_name) VALUES(5, 'Учёная степень');
INSERT INTO ReaderAttributes (attribute_id, attribute_name) VALUES(6, 'Звание');

-- Таблица Locations
INSERT INTO Locations (location_id, library_id, location_name, location_type_id) VALUES
(1, 1, 'Читальный зал №1', 1);

INSERT INTO Locations (location_id, library_id, location_name, location_type_id) VALUES
(2, 1, 'Абонемент', 2);

INSERT INTO Locations (location_id, library_id, location_name, location_type_id) VALUES
(3, 2, 'Читальный зал №2', 1);

INSERT INTO Locations (location_id, library_id, location_name, location_type_id) VALUES
(4, 3, 'Картотека', 3);

INSERT INTO Locations (location_id, library_id, location_name, location_type_id) VALUES
(5, 4, 'Электронный архив', 4);


-- Таблица ReaderCategories
INSERT INTO ReaderCategories (category_id, category_name, max_borrow_days) VALUES (1, 'Студент', 30);
INSERT INTO ReaderCategories (category_id, category_name, max_borrow_days) VALUES (2, 'Преподаватель', 90);
INSERT INTO ReaderCategories (category_id, category_name, max_borrow_days) VALUES (3, 'Аспирант', 60);
INSERT INTO ReaderCategories (category_id, category_name, max_borrow_days) VALUES (4, 'Слушатель', 45);
INSERT INTO ReaderCategories (category_id, category_name, max_borrow_days) VALUES (5, 'Стажёр', 30);

-- Таблица Readers
INSERT INTO Readers (reader_id, full_name, category_id) VALUES
(1, 'Иван Иванов', 1);
INSERT INTO Readers (reader_id, full_name, category_id) VALUES
(2, 'Петр Петров', 2);
INSERT INTO Readers (reader_id, full_name, category_id) VALUES
(3, 'Сергей Сидоров', 3);
INSERT INTO Readers (reader_id, full_name, category_id) VALUES
(4, 'Анна Смирнова', 4);
INSERT INTO Readers (reader_id, full_name, category_id) VALUES (5, 'Екатерина Волкова', 5);


INSERT INTO Subscriptions (subscription_id, reader_id, location_id, start_date, end_date, max_books) VALUES (1, 1, 2, '2024-01-01', '2024-12-31', 5);
INSERT INTO Subscriptions (subscription_id, reader_id, location_id, start_date, end_date, max_books) VALUES (2, 2, 1, '2024-01-01', '2024-12-31', 10);
INSERT INTO Subscriptions (subscription_id, reader_id, location_id, start_date, end_date, max_books) VALUES (3, 3, 3, '2024-02-01', '2024-12-31', 7);
INSERT INTO Subscriptions (subscription_id, reader_id, location_id, start_date, end_date, max_books) VALUES (4, 4, 4, '2024-03-01', '2024-12-31', 3);
INSERT INTO Subscriptions (subscription_id, reader_id, location_id, start_date, end_date, max_books) VALUES (5, 5, 5, '2024-04-01', '2024-12-31', 2);


-- Таблица Books
INSERT INTO Books (book_id, title, author, publication_year, total_copies) VALUES
(1, 'Война и мир', 'Лев Толстой', 1869, 10);
INSERT INTO Books (book_id, title, author, publication_year, total_copies) VALUES
(2, 'Преступление и наказание', 'Федор Достоевский', 1866, 8);
INSERT INTO Books (book_id, title, author, publication_year, total_copies) VALUES
(3, 'Анна Каренина', 'Лев Толстой', 1877, 6);
INSERT INTO Books (book_id, title, author, publication_year, total_copies) VALUES
(4, 'Герой нашего времени', 'М.Ю. Лермонтов', 1840, 5);
INSERT INTO Books (book_id, title, author, publication_year, total_copies) VALUES
(5, 'Евгений Онегин', 'А.С. Пушкин', 1833, 7);

-- Таблица BookInventory
INSERT INTO BookInventory (inventory_id, book_id, location_id, quantity) VALUES (1, 1, 1, 5);
INSERT INTO BookInventory (inventory_id, book_id, location_id, quantity) VALUES (2, 1, 2, 5);
INSERT INTO BookInventory (inventory_id, book_id, location_id, quantity) VALUES (3, 2, 1, 8);
INSERT INTO BookInventory (inventory_id, book_id, location_id, quantity) VALUES (4, 3, 3, 6);
INSERT INTO BookInventory (inventory_id, book_id, location_id, quantity) VALUES (5, 4, 4, 5);

-- Таблица BookStatus
INSERT INTO BookStatus (status_id, name) VALUES (1, 'Возвращено');
INSERT INTO BookStatus (status_id, name) VALUES (2, 'Задолженность');
INSERT INTO BookStatus (status_id, name) VALUES (3, 'Выдано');
INSERT INTO BookStatus (status_id, name) VALUES (4, 'Утеряно');
INSERT INTO BookStatus (status_id, name) VALUES (5, 'Резерв');

-- Таблица BookIssues
INSERT INTO BookIssues (issue_id, reader_id, book_id, issue_date, due_date, return_date, location_id, status_id) VALUES
(1, 1, 1, TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2024-02-15', 'YYYY-MM-DD'), TO_DATE('2024-02-10', 'YYYY-MM-DD'), 1, 1);

INSERT INTO BookIssues (issue_id, reader_id, book_id, issue_date, due_date, return_date, location_id, status_id) VALUES
(2, 2, 2, TO_DATE('2024-01-20', 'YYYY-MM-DD'), TO_DATE('2024-03-20', 'YYYY-MM-DD'), NULL, 1, 2);


INSERT INTO BookIssues (issue_id, reader_id, book_id, issue_date, due_date, return_date, location_id, status_id) VALUES
(3, 3, 3, TO_DATE('2024-02-10', 'YYYY-MM-DD'), TO_DATE('2024-03-10', 'YYYY-MM-DD'), NULL, 3, 3);

INSERT INTO BookIssues (issue_id, reader_id, book_id, issue_date, due_date, return_date, location_id, status_id) VALUES
(4, 4, 4, TO_DATE('2024-03-05', 'YYYY-MM-DD'), TO_DATE('2024-03-30', 'YYYY-MM-DD'), TO_DATE('2024-03-28', 'YYYY-MM-DD'), 4, 1);

INSERT INTO BookIssues (issue_id, reader_id, book_id, issue_date, due_date, return_date, location_id, status_id) VALUES
(5, 5, 5, TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2024-04-15', 'YYYY-MM-DD'), NULL, 5, 2);

INSERT INTO BookIssues (issue_id, reader_id, book_id, issue_date, due_date, return_date, location_id, status_id) VALUES
(6, 2, 2, TO_DATE('2023-01-20', 'YYYY-MM-DD'), TO_DATE('2023-03-20', 'YYYY-MM-DD'), NULL, 1, 2);


-- Таблица Fines
INSERT INTO Fines (fine_id, reader_id, amount, reason, fine_date, fine_date_end) VALUES
(1, 2, 100.00, 'Просрочка возврата', TO_DATE('2024-03-25', 'YYYY-MM-DD'),TO_DATE('2024-10-25', 'YYYY-MM-DD'));

INSERT INTO Fines (fine_id, reader_id, amount, reason, fine_date, fine_date_end) VALUES
(2, 3, 200.00, 'Утеря книги', TO_DATE('2024-03-20', 'YYYY-MM-DD'),
TO_DATE('2024-07-20', 'YYYY-MM-DD'));

INSERT INTO Fines (fine_id, reader_id, amount, reason, fine_date, fine_date_end) VALUES
(3, 5, 50.00, 'Повреждение книги', TO_DATE('2024-04-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05', 'YYYY-MM-DD'));

INSERT INTO Fines (fine_id, reader_id, amount, reason, fine_date, fine_date_end) VALUES
(4, 5, 50.00, 'Повреждение книги', TO_DATE('2024-04-05', 'YYYY-MM-DD'), TO_DATE('2026-06-05', 'YYYY-MM-DD'));


INSERT INTO Fines (fine_id, reader_id, amount, reason, fine_date, fine_date_end) VALUES
(5, 2, 50.00, 'Повреждение книги', TO_DATE('2024-04-05', 'YYYY-MM-DD'), TO_DATE('2026-06-05', 'YYYY-MM-DD'));

INSERT INTO Fines (fine_id, reader_id, amount, reason, fine_date, fine_date_end) VALUES
(6, 3, 50.00, 'Повреждение книги', TO_DATE('2024-04-05', 'YYYY-MM-DD'), TO_DATE('2026-06-05', 'YYYY-MM-DD'));



-- Таблица ReaderAttributeValues
INSERT INTO ReaderAttributeValues (reader_id, attribute_id, value) VALUES (1, 1, 'Кафедра математики');
INSERT INTO ReaderAttributeValues (reader_id, attribute_id, value) VALUES (1, 2, 'Факультет прикладной математики');
INSERT INTO ReaderAttributeValues (reader_id, attribute_id, value) VALUES (1, 3, '3 курс');
INSERT INTO ReaderAttributeValues (reader_id, attribute_id, value) VALUES (1, 4, 'Группа А-32');
INSERT INTO ReaderAttributeValues (reader_id, attribute_id, value) VALUES (2, 1, 'Кафедра физики');
INSERT INTO ReaderAttributeValues (reader_id, attribute_id, value) VALUES (2, 2, 'Факультет физики');
INSERT INTO ReaderAttributeValues (reader_id, attribute_id, value) VALUES (2, 3, '5 курс');
INSERT INTO ReaderAttributeValues (reader_id, attribute_id, value) VALUES (2, 4, 'Группа Ф-51');
INSERT INTO ReaderAttributeValues (reader_id, attribute_id, value) VALUES (3, 1, 'Кафедра литературы');
INSERT INTO ReaderAttributeValues (reader_id, attribute_id, value) VALUES (3, 2, 'Факультет гуманитарных наук');
INSERT INTO ReaderAttributeValues (reader_id, attribute_id, value) VALUES (4, 3, '1 курс');
INSERT INTO ReaderAttributeValues (reader_id, attribute_id, value) VALUES (4, 4, 'Группа Г-11');

-- Таблица AttributeRestrictions
INSERT INTO AttributeRestrictions (category_id, attribute_id) VALUES (1, 1);
INSERT INTO AttributeRestrictions (category_id, attribute_id) VALUES (1, 2);
INSERT INTO AttributeRestrictions (category_id, attribute_id) VALUES (1, 3);
INSERT INTO AttributeRestrictions (category_id, attribute_id) VALUES (1, 4);
INSERT INTO AttributeRestrictions (category_id, attribute_id) VALUES (2, 1);
INSERT INTO AttributeRestrictions (category_id, attribute_id) VALUES (2, 2);




    
    -- Заявки на межбиблиотечный абонемент
INSERT INTO InterlibraryRequests (request_id, source_location_id, destination_location_id, request_date, status) 
VALUES (1, 2, 3, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'ожидает');

INSERT INTO InterlibraryRequests (request_id, source_location_id, destination_location_id, request_date, status) 
VALUES (2, 3, 1, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'выполнен');

INSERT INTO InterlibraryRequests (request_id, source_location_id, destination_location_id, request_date, status) 
VALUES (3, 4, 5, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'ожидает');

INSERT INTO InterlibraryRequests (request_id, source_location_id, destination_location_id, request_date, status) 
VALUES (4, 5, 2, TO_DATE('2024-01-20', 'YYYY-MM-DD'), 'выполнен');

INSERT INTO InterlibraryRequests (request_id, source_location_id, destination_location_id, request_date, status) 
VALUES (5, 1, 4, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 'ожидает');

INSERT INTO InterlibraryRequests (request_id, source_location_id, destination_location_id, request_date, status) 
VALUES (5, 1, 4, TO_DATE('2024-10-05', 'YYYY-MM-DD'), 'ожидает');

.-- Подробности заявок (какие книги заказывались)
--INSERT INTO InterlibraryRequestDetails (detail_id, request_id, book_id, quantity) 
--VALUES (1, 1, 1, 2);

INSERT INTO InterlibraryRequestDetails (detail_id, request_id, book_id, quantity) 
VALUES (2, 1, 2, 1);

INSERT INTO InterlibraryRequestDetails (detail_id, request_id, book_id, quantity) 
VALUES (3, 2, 3, 1);

INSERT INTO InterlibraryRequestDetails (detail_id, request_id, book_id, quantity) 
VALUES (4, 2, 4, 2);

INSERT INTO InterlibraryRequestDetails (detail_id, request_id, book_id, quantity) 
VALUES (5, 3, 5, 3);

INSERT INTO InterlibraryRequestDetails (detail_id, request_id, book_id, quantity) 
VALUES (6, 4, 1, 1);

INSERT INTO InterlibraryRequestDetails (detail_id, request_id, book_id, quantity) 
VALUES (7, 4, 5, 2);

INSERT INTO InterlibraryRequestDetails (detail_id, request_id, book_id, quantity) 
VALUES (8, 5, 2, 3);

INSERT INTO InterlibraryRequestDetails (detail_id, request_id, book_id, quantity) 
VALUES (9, 5, 4, 1);
