--13.	Выдать полную информацию о читателе по его фамилии - группу, курс, факультет или кафедру, правонарушения, их количество, штрафы, утерянные книги и т.п. 
--
SELECT 'ФИО' AS Параметр, Readers.FULL_NAME  AS Значение
FROM Readers 
WHERE Readers.READER_ID = :ReaderId
UNION ALL
SELECT ReaderAttributes.ATTRIBUTE_NAME ,  ReaderAttributeValues.VALUE 
FROM  Readers 
JOIN ReaderAttributeValues ON Readers.READER_ID  = ReaderAttributeValues.READER_ID 
JOIN ReaderAttributes ON ReaderAttributeValues.ATTRIBUTE_ID = ReaderAttributes.ATTRIBUTE_ID 
WHERE Readers.READER_ID = :ReaderId
UNION ALL
SELECT 'Правонарушение', FINE_DATE|| ' '||REASON
FROM Readers 
JOIN Fines ON Fines.READER_ID  = Readers.READER_ID 
WHERE Readers.READER_ID = :ReaderId;


SELECT *
FROM Readers 
JOIN Fines ON Fines.READER_ID  = Readers.READER_ID 
WHERE Readers.READER_ID = :ReaderId;
