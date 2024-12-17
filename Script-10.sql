-- Перечень и общее число книг, заказанных данным читателем за последний месяц, семестр, год
@SET READER_ID = 1

SELECT 
    'Last Month' AS period,
    COUNT(bi.book_id) AS total_books,
    LISTAGG(b.title, ', ') WITHIN GROUP (ORDER BY bi.issue_date) AS books_list
FROM 
    BookIssues bi
JOIN 
    Books b ON bi.book_id = b.book_id
WHERE 
    bi.reader_id = :READER_ID 
    AND bi.issue_date >= SYSDATE - INTERVAL '1' MONTH
GROUP BY 
    'Last Month'
UNION ALL
SELECT 
    'Last Semester' AS period,
    COUNT(bi.book_id) AS total_books,
    LISTAGG(b.title, ', ') WITHIN GROUP (ORDER BY bi.issue_date) AS books_list
FROM 
    BookIssues bi
JOIN 
    Books b ON bi.book_id = b.book_id
WHERE 
    bi.reader_id = :READER_ID
    AND bi.issue_date >= SYSDATE - INTERVAL '6' MONTH
GROUP BY 
    'Last Semester'
UNION ALL
SELECT 
    'Last Year' AS period,
    COUNT(bi.book_id) AS total_books,
    LISTAGG(b.title, ', ') WITHIN GROUP (ORDER BY bi.issue_date) AS books_list
FROM 
    BookIssues bi
JOIN 
    Books b ON bi.book_id = b.book_id
WHERE 
    bi.reader_id = :READER_ID
    AND bi.issue_date >= SYSDATE - INTERVAL '12' MONTH
GROUP BY 
    'Last Year';