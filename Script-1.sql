--INSERT INTO Libraries (library_id, library_name, address) VALUES (1, 'Главная библиотека', 'ул. Ленина, 10');
--INSERT INTO Libraries (library_id, library_name, address) VALUES (2, 'Филиал №1', 'ул. Советская, 22');
--INSERT INTO Libraries (library_id, library_name, address) VALUES (3, 'Филиал №2', 'ул. Победы, 5');
--INSERT INTO Libraries (library_id, library_name, address) VALUES (4, 'Филиал №3', 'ул. Гагарина, 12');

--1.	Получить перечень и общее число читателей для данного читального зала или абонента, либо по всей библиотеке, 
--по признаку принадлежности к кафедре, факультету, курсу, группе. 

@set локация = NULL
-- 'Читальный зал №1'
@set кафедра = NULL
--'Кафедра физики'
@set факультет = NULL
--'Факультет физики'
@set курс = NULL
--'3 курс'
@set группа = NULL
--'Группа Ф-51'

SELECT a.FULL_NAME, l.LOCATION_NAME, a.DEPARTMENT FROM 
    Subscriptions s
JOIN 
    Locations l ON s.location_id = l.location_id
JOIN 
(
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
   ORDER BY
       r.reader_id
  ) a ON a.reader_id = s.READER_ID 
 WHERE 
    (l.LOCATION_NAME LIKE :локация OR :локация IS NULL) 
    AND (
        (a.department LIKE :кафедра) OR :кафедра IS NULL
    )
    AND (
        (a.faculty LIKE :факультет) OR :факультет IS NULL
    )
    AND (
        (a.course LIKE :курс) OR :курс IS NULL
    )
    AND (
        (a.group_name LIKE :группа) OR :группа IS NULL
    );
 
SELECT
    LISTAGG(a.FULL_NAME, ', ') WITHIN GROUP (ORDER BY a.FULL_NAME) AS full_names_list,
    COUNT(*) AS total_readers
FROM 
    Subscriptions s
JOIN 
    Locations l ON s.location_id = l.location_id
JOIN 
(
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
   ORDER BY
       r.reader_id
  ) a ON a.reader_id = s.READER_ID 
 WHERE 
    (l.LOCATION_NAME LIKE :локация OR :локация IS NULL) 
    AND (
        (a.department LIKE :кафедра) OR :кафедра IS NULL
    )
    AND (
        (a.faculty LIKE :факультет) OR :факультет IS NULL
    )
    AND (
        (a.course LIKE :курс) OR :курс IS NULL
    )
    AND (
        (a.group_name LIKE :группа) OR :группа IS NULL
    );
 

      
      
