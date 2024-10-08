create schema library

use library

create table authors(
author_id int primary key,
name varchar(200)
);

create table genres(
genre_id int primary key,
genre_name varchar(50)
);


create table books(
book_id int primary key,
title varchar(220),
author_id int,
genre_id int,
publication_date date,
isbn varchar(13),
availability boolean,
foreign key (author_id) references authors(author_id),
foreign key (genre_id) references genres(genre_id)
);

insert into authors (author_id,name) values (1,'Harper Lee');
insert into authors (author_id,name) values (2,' George Orwell');
insert into authors (author_id,name) values (3,'F. Scott Fitzgerald');
insert into authors (author_id,name) values (4,' Jane Austen');
insert into authors (author_id,name) values (5,' J.D. Salinger');
insert into authors (author_id,name) values (6,'Herman Melville');
insert into authors (author_id,name) values (7,' J.R.R. Tolkien');
insert into authors (author_id,name) values (8,'Cormac McCarthy');
insert into authors (author_id,name) values (9,' Paulo Coelho');
insert into authors (author_id,name) values (10,'Yuval Noah Harari');

insert into genres (genre_id,genre_name) values
(1,'Fiction'),
(2,' Science Fiction'),
(3,'Fiction'),
(4,'Romance'),
(5,'Fiction'),
(6,'Adventure'),
(7,'Fiction'),
(8,'Adventure'),
(9,'Fantasy'),
(10,'Fiction');

INSERT INTO books (book_id, title, author_id, genre_id, publication_date, isbn, availability) VALUES
(100, 'To Kill a Mockingbird', 1, 1, '1960-07-11', '9780061120084', TRUE),
(101, '1984', 2, 2, '1949-06-08', '9780451524935', TRUE),
(102, 'The Great Gatsby', 3, 1, '1925-04-10', '9780743273565', TRUE),  
(103, 'Pride and Prejudice', 4, 3, '1813-01-28', '9781503290563', TRUE),  
(104, 'The Catcher in the Rye', 5, 1, '1951-07-16', '9780316769488', TRUE),  
(105, 'Moby-Dick', 6, 4, '1851-10-18', '9781503280786', TRUE),  
(106, 'The Hobbit', 7, 5, '1937-09-21', '9780547928227', TRUE), 
(107, 'The Road', 8, 1, '2006-09-26', '9780307387899', TRUE),  
(108, 'The Alchemist', 9, 1, '1988-05-01', '9780061122415', TRUE), 
(109, 'Sapiens: A Brief History of Humankind', 10, 6, '2011-09-04', '9780062316097', TRUE); 


CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    available_copies INT DEFAULT 0,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO inventory (book_id, available_copies) VALUES
(100, 5),  -- 5 copies of 'To Kill a Mockingbird'
(101, 5),  -- 5 copies of '1984'
(102, 5),  -- 5 copies of 'The Great Gatsby'
(103, 5),  -- 5 copies of 'Pride and Prejudice'
(104, 5),  -- 5 copies of 'The Catcher in the Rye'
(105, 5),  -- 5 copies of 'Moby-Dick'
(106, 5),  -- 5 copies of 'The Hobbit'
(107, 5),  -- 5 copies of 'The Road'
(108, 5),  -- 5 copies of 'The Alchemist'
(109, 5);  -- 5 copies of 'Sapiens: A Brief History of Humankind'

UPDATE inventory
SET available_copies = available_copies + 3
WHERE book_id = 101;

UPDATE inventory
SET available_copies = available_copies +5
WHERE book_id = 103;

UPDATE inventory
SET available_copies = available_copies - 3
WHERE book_id = 103;

SELECT b.title, i.available_copies
FROM books b
JOIN inventory i ON b.book_id = i.book_id;

drop table inventory;

select * from authors;
select * from books;
select * from genres;
select * from inventory;

CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200),
    phone_num BIGINT,
    mail_id VARCHAR(200),
    membership VARCHAR(200),
    status VARCHAR(200)
);

INSERT INTO members (name, phone_num, mail_id, membership, status) 
VALUES
('Arul Selvan', 9876543210, 'arul.selvan123@gmail.com', 'premium', 'active'),
('Meena Kannan', 9012345678, 'meena.kannan987@gmail.com', 'normal', 'active'),
('Rajesh Kumar', 9123654789, 'rajeshkumar.tn@gmail.com', 'normal', 'active'),
('Priya Ramesh', 8765234567, 'priya.ramesh456@gmail.com', 'premium', 'active'),
('Suresh Balaji', 8901765432, 'suresh.balaji432@gmail.com', 'premium', 'active');

CREATE TABLE borrowing (
    borrowing_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    returned BOOLEAN,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO borrowing (member_id, book_id, borrow_date, return_date, returned) VALUES
(1, 101, '2023-09-20', NULL, FALSE);

UPDATE borrowing
SET return_date = '2023-09-27', returned = TRUE
WHERE borrowing_id = 1;

SELECT m.name, b.title, br.borrow_date, br.return_date, br.returned
FROM members m
JOIN borrowing br ON m.member_id = br.member_id
JOIN books b ON b.book_id = br.book_id
WHERE m.member_id = 1;
