--3.	Получить перечень двадцати наиболее часто заказываемых книг в данном читальном зале для данного факультета, для всего вуза. 
SELECT
    b.title,
    COUNT(*) AS order_count
FROM 
    BookIssues bi
JOIN 
    Books b ON bi.book_id = b.book_id
JOIN 
    Readers r ON bi.reader_id = r.reader_id
JOIN 
    (
        SELECT
            r.reader_id,
            MAX(CASE WHEN ra.attribute_id = 2 THEN rav.value END) AS faculty
        FROM
            Readers r
        JOIN
            ReaderAttributeValues rav ON r.reader_id = rav.reader_id
        JOIN
            ReaderAttributes ra ON rav.attribute_id = ra.attribute_id
        GROUP BY
            r.reader_id
    ) a ON a.reader_id = r.reader_id
JOIN 
    Locations l ON bi.location_id = l.location_id
WHERE 
    (l.location_name LIKE :локация OR :локация IS NULL) 
    AND (a.faculty LIKE :факультет OR :факультет IS NULL)
GROUP BY 
    b.title
ORDER BY 
    b.title DESC;
   
--FETCH FIRST 20 ROWS ONLY;
