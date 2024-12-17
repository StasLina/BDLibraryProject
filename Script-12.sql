--12.	Получить перечень читателей, у которых на руках некоторая книга и читателя, который раньше всех должен ее должен сдать


WITH AllRecords AS (
    SELECT * 
    FROM BookIssues 
    WHERE RETURN_DATE IS NULL
    ORDER BY BookIssues.DUE_DATE  DESC 
)
SELECT  Readers.FULL_NAME 
FROM AllRecords
JOIN Readers ON AllRecords.READER_ID  = Readers.READER_ID 
WHERE DUE_DATE = (SELECT DUE_DATE FROM AllRecords WHERE ROWNUM =1);


