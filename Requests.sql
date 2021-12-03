
--1
SELECT Title FROM Reviews
WHERE username = N'Kakashi 🌀'; 

--2
SELECT Title FROM Reviews
WHERE Title_Platform = N'PC'
GROUP BY Title
ORDER BY AVG(Rating) DESC;

--3
SELECT TOP 3 Title FROM Reviews
GROUP BY Title
ORDER BY COUNT(Rating) DESC;

--4
SELECT DISTINCT Developer FROM Games
WHERE (PC = 1 AND PS4 = 1 AND Switch = 1);
