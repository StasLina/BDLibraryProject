-- В разработке
-- 6.	Получить перечень и общее число книг, заказанных на межбиблиотечном абонементе за последний месяц, семестр, год. 
WITH TimePeriods AS (
  SELECT 
    'Last Month' AS period,
    ADD_MONTHS(SYSDATE, -1) AS start_date,
    SYSDATE AS end_date
  FROM dual
  UNION ALL
  SELECT 
    'Last Semester' AS period,
    ADD_MONTHS(SYSDATE, -6) AS start_date,
    SYSDATE AS end_date
  FROM dual
  UNION ALL
  SELECT 
    'Last Year' AS period,
    ADD_MONTHS(SYSDATE, -12) AS start_date,
    SYSDATE AS end_date
  FROM dual
),
InterlibraryOrders AS (
  SELECT 
    bi.book_id,
    COUNT(bi.book_id) AS total_orders,
    bi.issue_date
  FROM 
    BookIssues bi
  WHERE 
    bi.status_id = 5 -- Межбиблиотечный абонемент
  GROUP BY 
    bi.book_id, bi.issue_date
)
SELECT 
  tp.period,
  LISTAGG(b.title, ', ') WITHIN GROUP (ORDER BY b.title) AS book_list,
  COUNT(DISTINCT io.book_id) AS total_books
FROM 
  TimePeriods tp
LEFT JOIN 
  InterlibraryOrders io ON io.issue_date BETWEEN tp.start_date AND tp.end_date
LEFT JOIN 
  Books b ON io.book_id = b.book_id
GROUP BY 
  tp.period
ORDER BY 
  tp.period DESC;
