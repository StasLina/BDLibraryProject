--5.	Определить пункт выдачи, на которой самое большое (маленькое) число читателей, 
-- читателей-задолжников, самая большая сумма задолженности. 
WITH TotalReaders AS (
  SELECT 
    l.location_name,
    COUNT(DISTINCT CASE WHEN bi.status_id = 2 THEN bi.READER_ID END) AS total_readers
  FROM 
    BookIssues bi
  JOIN 
    Locations l ON bi.location_id = l.location_id
  GROUP BY 
    l.location_name
),
TotalDebtors AS (
  SELECT 
    l.location_name,
    COUNT(DISTINCT CASE WHEN bi.status_id = 3 THEN bi.reader_id END) AS total_debtors
  FROM 
    BookIssues bi
  JOIN 
    Locations l ON bi.location_id = l.location_id
  GROUP BY 
    l.location_name
),
TotalDebtCount AS (
  SELECT 
    l.location_name,
    COUNT(CASE WHEN bi.status_id = 2 THEN bi.book_id END) AS total_debts
  FROM 
    BookIssues bi
  JOIN 
    Locations l ON bi.location_id = l.location_id
  GROUP BY 
    l.location_name
)
SELECT 
  'Maximum Readers' AS metric,
  LISTAGG(location_name, ', ') WITHIN GROUP (ORDER BY location_name) AS location_names,
  MAX(total_readers) AS value
FROM 
  TotalReaders
WHERE 
  total_readers = (SELECT MAX(total_readers) FROM TotalReaders)
UNION ALL
SELECT 
  'Maximum Debtors' AS metric,
  LISTAGG(location_name, ', ') WITHIN GROUP (ORDER BY location_name) AS location_names,
  MAX(total_debtors) AS value
FROM 
  TotalDebtors
WHERE 
  total_debtors = (SELECT MAX(total_debtors) FROM TotalDebtors)
UNION ALL
SELECT 
  'Maximum Total Debts' AS metric,
  LISTAGG(location_name, ', ') WITHIN GROUP (ORDER BY location_name) AS location_names,
  MAX(total_debts) AS value
FROM 
  TotalDebtCount
WHERE 
  total_debts = (SELECT MAX(total_debts) FROM TotalDebtCount);
 
