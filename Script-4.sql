--4.	Получить перечень и общее число книг, поступивших и утерянных за последний год, 
--для данного читального зала, абонента или по всей библиотеке, по указанному автору, году выпуска, году поступления в библиотеку. 

SELECT
    b.title,
    b.author,
    b.publication_year,
    bi.issue_date AS arrival_date,
    COUNT(*) AS total_books
FROM 
    BookIssues bi
JOIN 
    Books b ON bi.book_id = b.book_id
JOIN
    Locations l ON bi.location_id = l.location_id
WHERE 
    (l.location_name LIKE :локация OR :локация IS NULL)  -- Фильтрация по читальному залу/абонементу
    AND (b.author LIKE :автор OR :автор IS NULL)  -- Фильтрация по автору
    AND (b.publication_year = :год_выпуска OR :год_выпуска IS NULL)  -- Фильтрация по году выпуска книги
    AND (EXTRACT(YEAR FROM bi.issue_date) = EXTRACT(YEAR FROM SYSDATE) - 1)  -- Поступили или утеряны за последний год
--    AND (bi.status_id IN (4, 5))  -- Статусы: 4 = Утеряно, 5 = Резерв (например, если это статус утерянной книги)
GROUP BY
    b.title, b.author, b.publication_year, bi.issue_date
ORDER BY
    total_books DESC;

   -- Вставка данных о выдаче книги (Возвращена)
INSERT INTO BookIssues (issue_id, reader_id, book_id, issue_date, due_date, return_date, location_id, status_id) 
VALUES (6, 1, 1, TO_DATE('2023-12-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-05', 'YYYY-MM-DD'), 1, 1);

-- Вставка данных о задолженности
INSERT INTO BookIssues (issue_id, reader_id, book_id, issue_date, due_date, return_date, location_id, status_id) 
VALUES (7, 2, 2, TO_DATE('2023-11-15', 'YYYY-MM-DD'), TO_DATE('2024-02-15', 'YYYY-MM-DD'), NULL, 2, 2);

-- Вставка данных о выданной книге
INSERT INTO BookIssues (issue_id, reader_id, book_id, issue_date, due_date, return_date, location_id, status_id) 
VALUES (8, 3, 3, TO_DATE('2023-12-10', 'YYYY-MM-DD'), TO_DATE('2024-01-10', 'YYYY-MM-DD'), NULL, 3, 3);

-- Вставка данных о возвращенной книге
INSERT INTO BookIssues (issue_id, reader_id, book_id, issue_date, due_date, return_date, location_id, status_id) 
VALUES (9, 4, 4, TO_DATE('2023-09-25', 'YYYY-MM-DD'), TO_DATE('2023-10-25', 'YYYY-MM-DD'), TO_DATE('2023-10-20', 'YYYY-MM-DD'), 4, 1);

-- Вставка данных о утерянной книге
INSERT INTO BookIssues (issue_id, reader_id, book_id, issue_date, due_date, return_date, location_id, status_id) 
VALUES (10, 5, 5, TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2023-06-10', 'YYYY-MM-DD'), NULL, 5, 4);
