CREATE TABLE distribution_companies (
    id INT PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL
);

CREATE TABLE movies (
    id INT PRIMARY KEY,
    movie_title VARCHAR(255) NOT NULL,
    imdb_rating DECIMAL(2, 1) NOT NULL,
    year_released INT NOT NULL,
    budget DECIMAL(10, 2),
    box_office DECIMAL(10, 2),
    distribution_company_id INT,
    language VARCHAR(255) NOT NULL,
    FOREIGN KEY (distribution_company_id) REFERENCES distribution_companies(id)
);

INSERT INTO distribution_companies (id, company_name) VALUES
(1, 'Columbia Pictures'),
(2, 'Paramount Pictures'),
(3, 'Warner Bros. Pictures'),
(4, 'United Artists'),
(5, 'Universal Pictures'),
(6, 'New Line Cinema'),
(7, 'Miramax Films'),
(8, 'Produzioni Europee Associate'),
(9, 'Buena Vista'),
(10, 'StudioCanal');


INSERT INTO movies (id, movie_title, imdb_rating, year_released, budget, box_office, distribution_company_id, language) VALUES
(1, 'The Shawshank Redemption', 9.2, 1994, 25.00, 73.30, 1, 'English'),
(2, 'The Godfather', 9.2, 1972, 7.20, 291.00, 2, 'English'),
(3, 'The Dark Knight', 9.0, 2008, 185.00, 1006.00, 3, 'English'),
(4, 'The Godfather Part II', 9.0, 1974, 13.00, 93.00, 2, 'English, Sicilian'),
(5, '12 Angry Men', 9.0, 1957, 0.34, 2.00, 4, 'English'),
(6, "Schindler's List", 8.9, 1993, 22.00, 322.20, 5, 'English, German, Yiddish'),
(7, 'The Lord of the Rings: The Return of the King', 8.9, 2003, 94.00, 1146.00, 6, 'English'),
(8, 'Pulp Fiction', 8.8, 1994, 8.50, 213.90, 7, 'English'),
(9, 'The Lord of the Rings: The Fellowship of the Ring', 8.8, 2001, 93.00, 898.20, 6, 'English'),
(10, 'The Good, the Bad and the Ugly', 8.8, 1966, 1.20, 38.90, 8, 'English, Italian, Spanish');


SELECT *
FROM distribution_companies;

SELECT
  movie_title,
  imdb_rating,
  year_released
FROM movies;


SELECT
  movie_title,
  box_office
FROM movies
WHERE box_office > 300;


SELECT
  movie_title,
  imdb_rating,
  year_released
FROM movies
WHERE movie_title LIKE '%Godfather%';


SELECT
  movie_title,
  imdb_rating,
  year_released
FROM movies
WHERE year_released < 2001 AND imdb_rating > 9;


SELECT
  movie_title,
  imdb_rating,
  year_released
FROM movies
WHERE year_released > 1991
ORDER BY year_released ASC;


SELECT
  language,
  COUNT(*) AS number_of_movies
FROM movies
GROUP BY language;


SELECT
  year_released,
  language,
  COUNT(*) AS number_of_movies
FROM movies
GROUP BY year_released, language
ORDER BY year_released ASC;


SELECT
  language,
  AVG(budget) AS movie_budget
FROM movies
GROUP BY language
HAVING AVG(budget) > 50;


SELECT
  movie_title,
  company_name
FROM distribution_companies dc
JOIN movies m
ON dc.id = m.distribution_company_id;


