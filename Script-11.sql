--11.	Определить, есть ли данная книга в наличии на абонементах, и в каком количестве. ''

-- Установить ID книги для проверки
SET :book_id = NULL; -- Укажите конкретный ID книги или оставьте NULL для всех книг

-- Основной запрос
SELECT 
    b.book_id AS book_id,
    b.title AS book_title,
    l.location_name AS location_name,
    lt.location_type_name AS location_type,
    COALESCE(SUM(bi.quantity), 0) AS total_copies_available -- Доступное количество экземпляров
FROM 
    Books b
LEFT JOIN 
    BookInventory bi ON b.book_id = bi.book_id
LEFT JOIN 
    Locations l ON bi.location_id = l.location_id
LEFT JOIN 
    LocationTypes lt ON l.location_type_id = lt.location_type_id
WHERE 
    (:book_id IS NULL OR b.book_id = :book_id) -- Фильтр по книге, если указан book_id
    AND lt.location_type_name = 'Абонемент' -- Проверка только на абонементах
GROUP BY 
    b.book_id, b.title, l.location_name, lt.location_type_name
HAVING 
    COALESCE(SUM(bi.quantity), 0) > 0 -- Исключить книги, которых нет в наличии
ORDER BY 
    b.title, l.location_name;

   
   