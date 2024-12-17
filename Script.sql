--13.	Выдать полную информацию о читателе по его фамилии - группу, курс, факультет или кафедру, правонарушения, их количество, штрафы, утерянные книги и т.п. 
--

@set NAME = '%д%'
SELECT 'ФИО' AS Параметр, Readers.FULL_NAME  AS Значение
FROM Readers 
WHERE Readers.FULL_NAME LIKE :NAME
UNION ALL
SELECT ReaderAttributes.ATTRIBUTE_NAME ,  ReaderAttributeValues.VALUE 
FROM  Readers 
JOIN ReaderAttributeValues ON Readers.READER_ID  = ReaderAttributeValues.READER_ID 
JOIN ReaderAttributes ON ReaderAttributeValues.ATTRIBUTE_ID = ReaderAttributes.ATTRIBUTE_ID 
WHERE Readers.FULL_NAME LIKE :NAME
UNION ALL
SELECT 'Правонарушение', FINE_DATE|| ' '||REASON
FROM Readers 
JOIN Fines ON Fines.READER_ID  = Readers.READER_ID 
WHERE Readers.FULL_NAME LIKE :NAME
UNION ALL
SELECT 'Подписка', Subscriptions.START_DATE || '-' ||Subscriptions.END_DATE 
FROM Readers 
JOIN Subscriptions ON Subscriptions.READER_ID  = Readers.READER_ID 
WHERE Readers.FULL_NAME LIKE :NAME
UNION ALL 
SELECT 'Выдача',  Books.TITLE || ' ' || due_date || ' '||BookStatus.NAME 
FROM Readers 
JOIN BookIssues ON BookIssues.READER_ID  = Readers.READER_ID 
LEFT JOIN  Books ON Books.BOOK_ID = BookIssues.BOOK_ID 
LEFT JOIN BookStatus ON BookStatus.STATUS_ID  = BookIssues.STATUS_ID 
WHERE Readers.FULL_NAME LIKE :NAME AND BookIssues.STATUS_ID IN (2, 3, 4);

