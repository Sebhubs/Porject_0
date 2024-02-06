# SQL Exercises Overview

This document provides an overview and explanation of SQL exercises focused on creating tables, inserting data, and performing various queries to manipulate and retrieve data.

## Table Creation

### Creating `distribution_companies` Table

The `distribution_companies` table is designed to store information about movie distribution companies, including a unique ID and the company name.

```sql
CREATE TABLE distribution_companies (
    id INT PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL
);
```

### Creating `movies` Table

The `movies` table stores detailed information about movies, including title, IMDb rating, release year, budget, box office earnings, the ID of the distribution company, and the languages spoken in the movie. It establishes a foreign key relationship with the `distribution_companies` table.

```sql
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
```

## Data Insertion

### Inserting Data into `distribution_companies`

Populates the `distribution_companies` table with names of known movie distribution companies.

```sql
INSERT INTO distribution_companies (id, company_name) VALUES
(1, 'Columbia Pictures'),
(2, 'Paramount Pictures'),
...
(10, 'StudioCanal');
```

### Inserting Data into `movies`

Inserts a collection of famous movies along with their details such as IMDb rating, release year, budget, box office earnings, and distribution company.

```sql
INSERT INTO movies (id, movie_title, imdb_rating, year_released, budget, box_office, distribution_company_id, language) VALUES
(1, 'The Shawshank Redemption', 9.2, 1994, 25.00, 73.30, 1, 'English'),
...
(10, 'The Good, the Bad and the Ugly', 8.8, 1966, 1.20, 38.90, 8, 'English, Italian, Spanish');
```

## Querying Data

### Basic SELECT Queries

Queries to display all entries from `distribution_companies`, and to select specific columns from `movies`.

```sql
SELECT * FROM distribution_companies;

SELECT movie_title, imdb_rating, year_released FROM movies;
```

### Conditional Queries

These queries demonstrate filtering data based on conditions such as box office earnings, movie titles containing specific keywords, and movies released before a certain year with a high IMDb rating.

```sql
SELECT movie_title, box_office FROM movies WHERE box_office > 300;

SELECT movie_title, imdb_rating, year_released FROM movies WHERE movie_title LIKE '%Godfather%';

SELECT movie_title, imdb_rating, year_released FROM movies WHERE year_released < 2001 AND imdb_rating > 9;
```

### Sorting and Ordering

Shows how to order movies by their release year.

```sql
SELECT movie_title, imdb_rating, year_released FROM movies WHERE year_released > 1991 ORDER BY year_released ASC;
```

### Aggregation and Grouping

Examples of using `GROUP BY` to aggregate data, such as counting movies by language or calculating the average budget.

```sql
SELECT language, COUNT(*) AS number_of_movies FROM movies GROUP BY language;

SELECT language, AVG(budget) AS movie_budget FROM movies GROUP BY language HAVING AVG(budget) > 50;
```

### Join Operations

Illustrates how to join the `movies` table with the `distribution_companies` table to display movies along with their distribution company names.

```sql
SELECT movie_title, company_name FROM distribution_companies dc JOIN movies m ON dc.id = m.distribution_company_id;
```

These exercises are designed to provide hands-on experience with SQL, covering a range of operations from data definition and manipulation to complex queries and data analysis.
