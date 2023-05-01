SELECT g.title_of_genre, COUNT(name_nickname)
FROM genre g
JOIN genre_performer gp ON g.id = gp.genre_id
JOIN performer p ON gp.performer_id = p.id
GROUP BY title_of_genre;


SELECT a.title, COUNT(t.id) FROM album a
JOIN track t ON t.album_id = a.id
WHERE year_of_release IN(2019, 2020)
GROUP BY a.title;

SELECT COUNT(t.title) FROM track t
JOIN album a ON t.album_id = a.id
WHERE year_of_release BETWEEN 2019 AND 2020;

SELECT a.title, AVG(t.duration)
FROM album a JOIN track t
ON a.id = t.album_id
GROUP BY a.title;


SELECT DISTINCT p.name_nickname FROM performer p
JOIN album_performer ap ON p.id = ap.performer_id
JOIN album ON ap.album_id = album.id
WHERE year_of_release NOT IN (2020);

SELECT name_nickname
FROM performer
WHERE name_nickname NOT IN (SELECT name_nickname
			    FROM performer p
			    JOIN album_performer ap ON p.id = ap.performer_id
			    JOIN album a ON ap.album_id = a.id
			    WHERE year_of_release = 2020);

SELECT DISTINCT c.title
FROM  collection c
JOIN track_collection tc ON c.id = tc.collection_id
JOIN track t ON tc.track_id = t.id
JOIN album a ON t.album_id = a.id
JOIN album_performer ap ON a.id = ap.album_id
JOIN performer p ON ap.performer_id = p.id
WHERE name_nickname =  'Zivert';


SELECT a.title
FROM album a
JOIN album_performer ap ON a.id = ap.album_id
JOIN performer p ON ap.performer_id = p.id
JOIN genre_performer gp ON p.id = gp.performer_id
JOIN genre g ON gp.genre_id = g.id
GROUP BY a.title
HAVING  COUNT(g.id) > 1;

SELECT DISTINCT a.title
FROM album a
JOIN album_performer ap ON a.id = ap.album_id
JOIN performer p ON ap.performer_id = p.id
JOIN genre_performer gp ON p.id = gp.performer_id
GROUP BY a.title, p.id
HAVING COUNT(gp.genre_id) > 1;



SELECT title
FROM track
WHERE id NOT IN (SELECT  track_id FROM track_collection);


SELECT t.title FROM track t
LEFT JOIN track_collection tc ON t.id = tc.track_id
WHERE tc.track_id is NULL;

SELECT name_nickname
FROM performer p
JOIN album_performer ap ON p.id = ap.performer_id
JOIN album a ON ap.album_id = a.id
JOIN track t ON a.id = t.album_id
WHERE duration = (SELECT MIN(duration) FROM track);


SELECT a.title
FROM album a
JOIN track t ON a.id = t.album_id
GROUP BY a.title
HAVING COUNT(t.title) = (SELECT COUNT(t.title)
			 FROM track t JOIN album a ON t.album_id = a.id
			 GROUP BY a.title
			 ORDER BY COUNT(t.title)
			 LIMIT 1);