USE IMDBMovies;

SELECT * FROM SYSOBJECTS WHERE xtype = 'U';
GO


 DELETE FROM TopAnimatedImDb WHERE ([Title] IS NULL) OR ([Gross] IS NULL) OR ([Genre] IS NULL)
 AND ([Metascore] IS NULL) OR ([Director] IS NULL) OR ([Released] IS NULL);

SELECT COUNT(*) FROM TopAnimatedImDb;

SELECT COUNT(Genre) AS Freq,Genre FROM TopAnimatedImDb GROUP BY Genre;

SELECT COUNT(Genre) AS Freq ,Genre,Director FROM TopAnimatedImDb GROUP BY Director,Genre ORDER BY Freq DESC;

UPDATE TopAnimatedImDb SET Gross = REPLACE(REPLACE(Gross, '$', ''), 'M', '');
ALTER TABLE TopAnimatedImDb ALTER COLUMN Gross FLOAT;

SELECT ROUND(SUM(Gross),2) AS Total, ROUND(AVG(Gross),2) AS Prom, Genre, COUNT(Genre) AS N FROM TopAnimatedImDb GROUP BY Genre ORDER BY N DESC;;

SELECT ROUND(AVG(Metascore),2) AS Promedio, Released, Genre FROM TopAnimatedImDb GROUP BY Genre,Released ORDER BY Promedio DESC;
