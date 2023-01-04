--1
CREATE TABLE book(
                     id SERIAL PRIMARY KEY,
                     title VARCHAR NOT NULL ,
                     year_of_Publishing INT NOT NULL ,
                     count_of_pages INT NOT NULL ,
                     author_id INT REFERENCES author(id) ON DELETE CASCADE
);
CREATE TABLE author(
                       id SERIAL PRIMARY KEY,
                       first_name VARCHAR NOT NULL ,
                       last_name VARCHAR NOT NULL ,
                       UNIQUE (first_name, last_name)
);

--2
INSERT INTO author (first_name, last_name)
VALUES ('Agata', 'Christie'),
       ('Erich Maria', 'Remark'),
       ('Lev', 'Tolstoy'),
       ('Fedor', 'Dostoevsky'),
       ('Michael', 'Bulgakov');

--3
INSERT INTO book(title, year_of_Publishing, count_of_pages, author_id)
VALUES ('Death on the Nile', 1937, 320, 1),
       ('Murder in alphabetical order', 1936, 282, 1),
       ('Schatten im Paradies', 1971, 456, 2),
       ('Der Funke Leben', 1952, 420, 2),
       ('Anna Karenina', 1984, 418, 3),
       ('War and Peace', 1867, 1300, 3),
       ('White Nights', 1848, 320, 4),
       ('Demons', 1871, 768, 4),
       ('The Master and Margarita', 1967, 512, 5),
       ('Dogs heart', 1925, 218, 5);

--4
SELECT
    b.title,
    b.year_of_Publishing,
    (SELECT
         first_name
     FROM author a
     WHERE a.id = b.author_id)
FROM book b
ORDER BY year_of_Publishing;

SELECT
    b.title,
    b.year_of_Publishing,
    (SELECT
         first_name
     FROM author a
     WHERE a.id = b.author_id)
FROM book b
ORDER BY year_of_Publishing DESC;

--5
SELECT
    count(*)
FROM book
WHERE author_id = (SELECT id FROM author WHERE first_name = 'Agata');

--6
SELECT
    *
FROM book
WHERE count_of_pages > (SELECT
                            avg(count_of_pages)
                        FROM book);

--7
SELECT
    *,
    (SELECT
         sum(count_of_pages)
     FROM (SELECT
               *
           FROM book
           ORDER BY year_of_Publishing DESC
               LIMIT 5) book)
FROM (SELECT
          *
      FROM book
      ORDER BY year_of_Publishing DESC
          LIMIT 5) book;

--8
UPDATE book
SET count_of_pages = 3000
WHERE count_of_pages = 318;

--9
DELETE FROM author
WHERE id = (SELECT
                author_id
            FROM book
            WHERE count_of_pages = (SELECT
                                        max(count_of_pages)
                                    FROM book));
