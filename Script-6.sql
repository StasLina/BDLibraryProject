-- В разработке
-- 6.	Получить перечень и общее число книг, заказанных на межбиблиотечном абонементе за последний месяц, семестр, год. 

-- Получить перечень и общее число книг, заказанных на межбиблиотечном абонементе за последний месяц, семестр, год.

SELECT * FROM InterlibraryRequests;

SELECT * FROM LOCATIONS;

SELECT * FROM Books;

  SELECT 
    ir.request_id,
    ir.request_date,
    ird.book_id,
    ird.QUANTITY 
  FROM 
    InterlibraryRequests ir
  JOIN 
    InterlibraryRequestDetails ird ON ir.request_id = ird.request_id
  WHERE 
    ir.request_date >= ADD_MONTHS(SYSDATE, -4) -- Ограничить запросы за последний год

WITH FilteredRequests AS (
  SELECT 
    ir.request_id,
    ir.request_date,
    ird.book_id,
    ird.QUANTITY 
  FROM 
    InterlibraryRequests ir
  JOIN 
    InterlibraryRequestDetails ird ON ir.request_id = ird.request_id
  WHERE 
    ir.request_date >= ADD_MONTHS(SYSDATE, -12) -- Ограничить запросы за последний год
)
SELECT 
  CASE 
    WHEN fr.request_date >= ADD_MONTHS(SYSDATE, -1) THEN 'Last Month'
    WHEN fr.request_date >= ADD_MONTHS(SYSDATE, -7) THEN 'Last Semester'
    WHEN fr.request_date >= ADD_MONTHS(SYSDATE, -12) THEN 'Last Year'
  END AS period
  ,b.TITLE AS Title
  , SUM(fr.QUANTITY)
FROM FilteredRequests fr
JOIN BOOKS b ON fr.book_id = b.book_id
GROUP BY 
  CASE 
    WHEN request_date >= ADD_MONTHS(SYSDATE, -1) THEN 'Last Month'
    WHEN request_date >= ADD_MONTHS(SYSDATE, -6) THEN 'Last Semester'
    WHEN request_date >= ADD_MONTHS(SYSDATE, -12) THEN 'Last Year'
  END, b.TITLE;
    
    

