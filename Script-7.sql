7.	Получить количество экземпляров книги для данного читального зала или абонента, во всей библиотеке, всех изданий. 

@set локация = '%№1%'
SELECT 
    l.location_name,
    l.location_type_id,
    b.book_id,
    b.title,
    SUM(b.total_copies) AS total_copies -- Общий объём экземпляров книги
  FROM 
    Books b
  LEFT JOIN 
    BookIssues bi ON b.book_id = bi.book_id
  LEFT JOIN 
    Locations l ON bi.location_id = l.location_id
  WHERE (l.location_name LIKE :локация OR :локация IS NULL)
GROUP BY 
    l.location_name, l.location_type_id, b.book_id, b.title
