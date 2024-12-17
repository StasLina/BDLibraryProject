-- Параметры для фильтрации
SET :start_date = TO_DATE('2024-01-01', 'YYYY-MM-DD');
--; -- Дата начала периода
SET :end_date = TO_DATE('2024-02-30', 'YYYY-MM-DD');
SET :локация = NULL;                                   -- Укажите конкретную локацию или оставьте NULL
SET :кафедра = NULL;
SET :факультет = NULL;
SET :курс = NULL;
SET :группа = NULL;

WITH NewReaders AS (
  SELECT 
    r.reader_id,
    r.full_name,
    l.location_name,
    MAX(CASE WHEN ra.attribute_id = 1 THEN rav.value END) AS department,
    MAX(CASE WHEN ra.attribute_id = 2 THEN rav.value END) AS faculty,
    MAX(CASE WHEN ra.attribute_id = 3 THEN rav.value END) AS course,
    MAX(CASE WHEN ra.attribute_id = 4 THEN rav.value END) AS group_name,
    MAX(CASE WHEN ra.attribute_id = 5 THEN rav.value END) AS degree,
    MAX(CASE WHEN ra.attribute_id = 6 THEN rav.value END) AS rank,
    s.start_date
  FROM 
    Subscriptions s
  JOIN 
    Readers r ON s.reader_id = r.reader_id
  JOIN 
    Locations l ON s.location_id = l.location_id
  LEFT JOIN 
    ReaderAttributeValues rav ON r.reader_id = rav.reader_id
  LEFT JOIN 
    ReaderAttributes ra ON rav.attribute_id = ra.attribute_id
  WHERE 
    s.start_date BETWEEN :start_date AND :end_date -- Новые читатели в указанном периоде
  GROUP BY 
    r.reader_id, r.full_name, l.location_name, s.start_date
),
DepartedReaders AS (
  SELECT 
    r.reader_id,
    r.full_name,
    l.location_name,
    MAX(CASE WHEN ra.attribute_id = 1 THEN rav.value END) AS department,
    MAX(CASE WHEN ra.attribute_id = 2 THEN rav.value END) AS faculty,
    MAX(CASE WHEN ra.attribute_id = 3 THEN rav.value END) AS course,
    MAX(CASE WHEN ra.attribute_id = 4 THEN rav.value END) AS group_name,
    MAX(CASE WHEN ra.attribute_id = 5 THEN rav.value END) AS degree,
    MAX(CASE WHEN ra.attribute_id = 6 THEN rav.value END) AS rank,
    s.end_date
  FROM 
    Subscriptions s
  JOIN 
    Readers r ON s.reader_id = r.reader_id
  JOIN 
    Locations l ON s.location_id = l.location_id
  LEFT JOIN 
    ReaderAttributeValues rav ON r.reader_id = rav.reader_id
  LEFT JOIN 
    ReaderAttributes ra ON rav.attribute_id = ra.attribute_id
  WHERE 
    s.end_date BETWEEN :start_date AND :end_date -- Выбывшие читатели в указанном периоде
  GROUP BY 
    r.reader_id, r.full_name, l.location_name, s.end_date
)
-- Итоговый запрос
SELECT 
  'New Readers' AS category,
  COUNT(DISTINCT nr.reader_id) AS total_readers,
  LISTAGG(nr.full_name, ', ') WITHIN GROUP (ORDER BY nr.full_name) AS reader_list
FROM 
  NewReaders nr
WHERE 
  (:локация IS NULL OR nr.location_name LIKE :локация) AND
  (:кафедра IS NULL OR nr.department LIKE :кафедра) AND
  (:факультет IS NULL OR nr.faculty LIKE :факультет) AND
  (:курс IS NULL OR nr.course LIKE :курс) AND
  (:группа IS NULL OR nr.group_name LIKE :группа)
UNION ALL
SELECT 
  'Departed Readers' AS category,
  COUNT(DISTINCT dr.reader_id) AS total_readers,
  LISTAGG(dr.full_name, ', ') WITHIN GROUP (ORDER BY dr.full_name) AS reader_list
FROM 
  DepartedReaders dr
WHERE 
  (:локация IS NULL OR dr.location_name LIKE :локация) AND
  (:кафедра IS NULL OR dr.department LIKE :кафедра) AND
  (:факультет IS NULL OR dr.faculty LIKE :факультет) AND
  (:курс IS NULL OR dr.course LIKE :курс) AND
  (:группа IS NULL OR dr.group_name LIKE :группа);
