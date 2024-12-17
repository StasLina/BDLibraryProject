--8.	Получить перечень и общее число читателей, лишенных права пользования библиотекой, сроком более двух месяцев, во всей библиотеке, по признаку принадлежности к кафедре, факультету, курсу, группе, по категориям читателей. 

SELECT * FROM ReaderAttributeValues;


@set кафедра = NULL
--'Кафедра физики'
@set факультет = NULL
--'Факультет физики'
@set курс = NULL
--'3 курс'
@set группа = NULL


WITH SOURCE AS (
  SELECT DISTINCT
    a.READER_ID,
    a.full_name,
    a.department,
    a.faculty,
    a.course,
    a.group_name,
    a.degree,
    a.rank
  FROM 
    Fines f
  JOIN (
    SELECT
      r.reader_id,
      r.full_name,
      MAX(CASE WHEN ra.attribute_id = 1 THEN rav.value END) AS department,
      MAX(CASE WHEN ra.attribute_id = 2 THEN rav.value END) AS faculty,
      MAX(CASE WHEN ra.attribute_id = 3 THEN rav.value END) AS course,
      MAX(CASE WHEN ra.attribute_id = 4 THEN rav.value END) AS group_name,
      MAX(CASE WHEN ra.attribute_id = 5 THEN rav.value END) AS degree,
      MAX(CASE WHEN ra.attribute_id = 6 THEN rav.value END) AS rank
    FROM
      Readers r
    JOIN
      ReaderAttributeValues rav ON r.reader_id = rav.reader_id
    JOIN
      ReaderAttributes ra ON rav.attribute_id = ra.attribute_id
    GROUP BY
      r.reader_id, r.full_name
  ) a ON a.reader_id = f.reader_id 
  WHERE 
    f.fine_date_end > SYSDATE -- Штраф всё ещё активен
    AND SYSDATE >= f.fine_date + INTERVAL '2' MONTH -- Штраф длится более 2 месяцев
)
SELECT 
  COUNT(DISTINCT s.reader_id) AS total_readers, -- Общее количество читателей
  LISTAGG(s.full_name, ', ') WITHIN GROUP (ORDER BY s.full_name) AS reader_list -- Список читателей
FROM 
  SOURCE s
WHERE 
    (
        (s.department LIKE :кафедра) OR :кафедра IS NULL
    )
    AND (
        (s.faculty LIKE :факультет) OR :факультет IS NULL
    )
    AND (
        (s.course LIKE :курс) OR :курс IS NULL
    )
    AND (
        (s.group_name LIKE :группа) OR :группа IS NULL
    );
