/* Delete the tables if they already exist */
drop table if exists Movie;
drop table if exists Reviewer;
drop table if exists Rating;

/* Create the schema for our tables */
create table Movie(mID int, title text, year int, director text);
create table Reviewer(rID int, name text);
create table Rating(rID int, mID int, stars int, ratingDate date);

/* Populate the tables with our data */
insert into Movie values(101, 'Gone with the Wind', 1939, 'Victor Fleming'),
(102, 'Star Wars', 1977, 'George Lucas'),
(103, 'The Sound of Music', 1965, 'Robert Wise'),
(104, 'E.T.', 1982, 'Steven Spielberg'),
(105, 'Titanic', 1997, 'James Cameron'),
(106, 'Snow White', 1937, null),
(107, 'Avatar', 2009, 'James Cameron'),
(108, 'Raiders of the Lost Ark', 1981, 'Steven Spielberg');

insert into Reviewer values(201, 'Sarah Martinez'),
(202, 'Daniel Lewis'),
(203, 'Brittany Harris'),
(204, 'Mike Anderson'),
(205, 'Chris Jackson'),
(206, 'Elizabeth Thomas'),
(207, 'James Cameron'),
(208, 'Ashley White');

insert into Rating values(201, 101, 2, '2011-01-22'),
(201, 101, 4, '2011-01-27'),
(202, 106, 4, null),
(203, 103, 2, '2011-01-20'),
(203, 108, 4, '2011-01-12'),
(203, 108, 2, '2011-01-30'),
(204, 101, 3, '2011-01-09'),
(205, 103, 3, '2011-01-27'),
(205, 104, 2, '2011-01-22'),
(205, 108, 4, null),
(206, 107, 3, '2011-01-15'),
(206, 106, 5, '2011-01-19'),
(207, 107, 5, '2011-01-20'),
(208, 104, 3, '2011-01-02');

select *
from movie m 

select *
from rating r 

select *
from reviewer rw



-- 1.	Find the titles of all movies directed by Steven Spielberg.
select *
from movie m 
where director = 'Steven Spielberg'

-- 2.	Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.
select distinct(m.year)
from movie m
left join rating r 
on m.mID = r.mID 
where r.stars = 4 or r.stars = 5
order by m.`year`

-- 3.	Find the titles of all movies that have no ratings.
select m.title , r.stars 
from movie m 
left join rating r 
on m.mID = r.mID 
where r.stars is null 

-- 4.	Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.
select rw.name , r.ratingDate 
from reviewer rw
right join rating r
on rw.rID = r.rID 
where r.ratingDate is null

-- 5.	Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.
select rw.name , m.title , r.stars , r.ratingDate 
from reviewer rw
left join rating r
on rw.rID = r.rID 
left join movie m 
on m.mID = r.mID 

-- 6.	For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.
select m.title , max(r.stars) as highest_stars
from movie m 
left join rating r 
on m.mID = r.mID 
group by m.title 
 having highest_stars is not null
order by m.title

-- 7.	For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from thighest to lowest, then by movie title.
select max(r.stars)-min(r.stars) as rating_spread , m.title 
from rating r
right join movie m 
on r.mID = m.mID 
where r.stars is not null 
group by m.title
order by rating_spread desc, m.title 