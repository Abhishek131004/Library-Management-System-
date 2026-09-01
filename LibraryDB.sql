create database LibraryDB;
use LibraryDB;
create table Books(
Book_id int primary key,
Title varchar(150) not null,
Author varchar(100),
Genre varchar(50),
PublishedYear int,
CopiesAvailable int );

create table Members(
Member_id int primary key,
Name varchar(50),
MembershipDate date,
Email varchar(100),
PhoneNumber varchar(20));

create table BorrowingTable(
Borrow_id int primary key,
Book_id int,
Member_id int,
BorrowDate date,
ReturnDate date,
foreign key (Book_id) References Books(Book_id),
foreign key (Member_id) References Members(Member_id));

insert into Books (Book_id,Title,Author,Genre,PublishedYear,CopiesAvailable) values (1, 'To Kill a Mockingbird', 'Harper Lee', 'Fic on', 1960, 5), (2, '1984', 'George Orwell', 'Dystopian', 1949, 3), (3, 'Moby Dick', 'Herman Melville', 'Adventure', 1851, 4), (4, 'The Great Gatsby', 'F. Sco Fitzgerald', 'Classic', 1925, 2), (5, 'Pride and Prejudice', 'Jane Austen', 'Romance', 1813, 6), (6, 'The Catcher in the Rye', 'J.D. Salinger', 'Fic on', 1951, 4), (7, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 1937, 7), (8, 'The Da Vinci Code', 'Dan Brown', 'Thriller', 2003, 5), (9, 'The Alchemist', 'Paulo Coelho', 'Philosophy', 1988, 6), (10, 'War and Peace', 'Leo Tolstoy', 'Historical Fic on', 1869, 3); 
insert into Members (Member_id,Name,MembershipDate,Email,PhoneNumber) values (1, 'Alice Johnson', '2022-01-15', 'alice@example.com', '123-456-7890'), (2, 'Bob Smith', '2023-03-10', 'bob@example.com', '234-567-8901'), (3, 'Charlie Brown', '2021-11-25', 'charlie@example.com', '345-678-9012'), (4, 'Diana Prince', '2020-07-05', 'diana@example.com', '456-789-0123'), (5, 'Evan Parker', '2022-06-30', 'evan@example.com', '567-890-1234'), (6, 'Frank Castle', '2023-01-01', 'frank@example.com', '678-890-2345'), (7, 'Grace Hopper', '2022-11-30', 'grace@example.com', '789-012-3456'), (8, 'Hannah Baker', '2021-09-15', 'hannah@example.com', '890-123-4567'), (9, 'Isaac Newton', '2023-04-05', 'isaac@example.com', '901-234-5678'), (10, 'Jack Ryan', '2022-03-22', 'jack@example.com', '012-345-6789'); 
insert into BorrowingTable (Borrow_id,Book_id,Member_id,BorrowDate,ReturnDate) values (1, 1, 1, '2023-01-10', '2023-01-20'), (2, 2, 2, '2023-02-15', '2023-02-25'), (3, 3, 3, '2023-03-05', NULL), (4, 4, 4, '2023-04-01', '2023-04-15'), (5, 5, 5, '2023-05-20', NULL), (6, 6, 6, '2023-01-10', '2023-01-20'), (7, 7, 7, '2023-02-05', '2023-02-15'), (8, 8, 8, '2023-03-10', NULL), (9, 9, 9, '2023-04-20', '2023-05-01'), (10, 10, 10, '2023-05-25', NULL); 

select * from Books;

select * from Members where MembershipDate > '2022-01-01';

select * from books where CopiesAvailable < 3;

select B.Borrow_id,M.Name,BK.Title,B.BorrowDate,B.ReturnDate
From BorrowingTable B
Join Members M
ON B.Member_id = M.Member_id
Join Books BK
ON B.Book_id = BK.Book_id;

select BK.Title,M.Name,B.BorrowDate
From BorrowingTable B
Join Books BK
on B.Book_id = BK.Book_id
Join Members M
on B.Member_id = M.Member_id
where B.ReturnDate is NULL AND B.BorrowDate < curdate();

select M.Member_id,M.Name
From BorrowingTable B
join Members M
on B.Member_id= M.Member_id
join Books BK
on B.Book_id = BK.Book_id
group by M.Member_id,M.Name
having count(distinct BK.Genre) >= 3;

SELECT BK.Book_id,BK.Title,COUNT(*) AS TotalBorrowed
FROM BorrowingTable B
JOIN Books BK
ON B.Book_id = BK.Book_id
GROUP BY BK.Book_id, BK.Title
ORDER BY TotalBorrowed DESC
LIMIT 3;

SELECT Genre,COUNT(*) AS TotalBooks
FROM Books
GROUP BY Genre;

SELECT M.Name,BK.Title,B.BorrowDate,B.ReturnDate
FROM BorrowingTable B
JOIN Members M
ON B.Member_id = M.Member_id
JOIN Books BK
ON B.Book_id = BK.Book_id
WHERE M.Member_id = 3;

SELECT BK.Title,M.Name,B.BorrowDate
FROM BorrowingTable B
JOIN Books BK
ON B.Book_id = BK.Book_id
JOIN Members M
ON B.Member_id = M.Member_id
WHERE B.BorrowDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

SELECT AVG(DATEDIFF(ReturnDate, BorrowDate)) AS AverageBorrowDays
FROM BorrowingTable
WHERE ReturnDate IS NOT NULL;

SELECT BK.Book_id,BK.Title,COUNT(B.Borrow_id) AS TimesBorrowed
FROM Books BK
LEFT JOIN BorrowingTable B
ON BK.Book_id = B.Book_id
GROUP BY BK.Book_id, BK.Title
ORDER BY TimesBorrowed ASC
LIMIT 1;