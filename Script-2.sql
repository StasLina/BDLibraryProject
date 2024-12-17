--2.	Получить список и общее число всех читателей-задолжников, задолжников со сроком более 10 дней 
--на данном абоненте либо по всей библиотеке, по признаку принадлежности к кафедре, факультету, курсу, группе, по категориям читателей. 

SELECT
    LISTAGG(r.full_name, ', ') WITHIN GROUP (ORDER BY r.full_name) AS readers_with_fines,
    COUNT(*) AS total_debtors
FROM 
    BookIssues bi
JOIN 
    Readers r ON bi.reader_id = r.reader_id
JOIN 
    BookStatus bs ON bi.status_id = bs.status_id
JOIN 
    Subscriptions s ON r.reader_id = s.reader_id
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
            MAX(CASE WHEN ra.attribute_id = 6 THEN rav.value END) AS rank,
            r.category_id
        FROM
            Readers r
        JOIN
            ReaderAttributeValues rav ON r.reader_id = rav.reader_id
        JOIN
            ReaderAttributes ra ON rav.attribute_id = ra.attribute_id
        GROUP BY
            r.reader_id, r.full_name, r.category_id
    ) a ON a.reader_id = r.reader_id
WHERE 
    bs.name = 'Задолженность'
    AND bi.due_date < CURRENT_DATE - INTERVAL '10' DAY
    AND (l.location_name LIKE :локация OR :локация IS NULL) 
    AND (a.department LIKE :кафедра OR :кафедра IS NULL) 
    AND (a.faculty LIKE :факультет OR :факультет IS NULL)
    AND (a.course LIKE :курс OR :курс IS NULL)
    AND (a.group_name LIKE :группа OR :группа IS NULL)
    AND (a.category_id LIKE :категория OR :категория IS NULL);