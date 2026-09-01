#  Library Management System – SQL Project

##  Project Overview

This project is a **Library Management System** created using **MySQL**.

The database stores information about books, library members, and book borrowing records. SQL queries are used to retrieve, analyze, and manage the library data.

The project demonstrates practical SQL concepts such as **database creation, table creation, primary keys, foreign keys, data insertion, joins, filtering, grouping, aggregate functions, sorting, and date functions**.

---

##  Objectives

The main objectives of this project are:

* Create a library database using MySQL.
* Store book information.
* Store library member information.
* Track borrowed and returned books.
* Retrieve useful information using SQL queries.
* Identify overdue books.
* Analyze borrowing patterns.
* Find the most and least borrowed books.
* Practice SQL joins and aggregate functions.
* Work with dates and NULL values.

---

##  Technologies Used

* **Database:** MySQL
* **Language:** SQL
* **Tool:** MySQL Workbench
* **Version Control:** Git & GitHub

---

##  Database Structure

The database is named:

```sql
LibraryDB
```

It contains three tables:

### 1. Books

Stores information about books available in the library.

| Column          | Description                 |
| --------------- | --------------------------- |
| Book_id         | Unique ID of the book       |
| Title           | Name of the book            |
| Author          | Author of the book          |
| Genre           | Genre/category of the book  |
| PublishedYear   | Year the book was published |
| CopiesAvailable | Number of available copies  |

---

### 2. Members

Stores information about library members.

| Column         | Description             |
| -------------- | ----------------------- |
| Member_id      | Unique ID of the member |
| Name           | Member's name           |
| MembershipDate | Date the member joined  |
| Email          | Member's email          |
| PhoneNumber    | Member's phone number   |

---

### 3. BorrowingTable

Stores information about books borrowed by members.

| Column     | Description                |
| ---------- | -------------------------- |
| Borrow_id  | Unique borrowing record ID |
| Book_id    | ID of the borrowed book    |
| Member_id  | ID of the member           |
| BorrowDate | Date the book was borrowed |
| ReturnDate | Date the book was returned |

`Book_id` and `Member_id` are foreign keys connected to the `Books` and `Members` tables.

---

## 🔗 Database Relationships

The database follows this relationship:

```text
Books
  │
  │ Book_id
  ▼
BorrowingTable
  ▲
  │ Member_id
  │
Members
```

* One book can appear in multiple borrowing records.
* One member can borrow multiple books.
* `BorrowingTable` connects `Books` and `Members`.

---

## 📊 Sample Data

The database contains sample data for:

* 10 books
* 10 members
* 10 borrowing records

Example books include:

* To Kill a Mockingbird
* 1984
* Moby Dick
* The Great Gatsby
* Pride and Prejudice
* The Hobbit
* The Da Vinci Code
* The Alchemist
* War and Peace

---

#  SQL Queries Included

The project contains queries for the following tasks:

### 1. Retrieve all book details

```sql
SELECT * FROM Books;
```

### 2. Find members who joined after January 1, 2022

```sql
SELECT *
FROM Members
WHERE MembershipDate > '2022-01-01';
```

### 3. Find books with fewer than 3 copies

```sql
SELECT *
FROM Books
WHERE CopiesAvailable < 3;
```

### 4. Show borrowing history with member names and book titles

```sql
SELECT
    B.Borrow_id,
    M.Name,
    BK.Title,
    B.BorrowDate,
    B.ReturnDate
FROM BorrowingTable B
JOIN Members M
ON B.Member_id = M.Member_id
JOIN Books BK
ON B.Book_id = BK.Book_id;
```

### 5. Identify overdue books

```sql
SELECT
    BK.Title,
    M.Name,
    B.BorrowDate
FROM BorrowingTable B
JOIN Books BK
ON B.Book_id = BK.Book_id
JOIN Members M
ON B.Member_id = M.Member_id
WHERE B.ReturnDate IS NULL
AND B.BorrowDate < CURDATE();
```

### 6. Find members who borrowed at least 3 different genres

```sql
SELECT
    M.Member_id,
    M.Name
FROM BorrowingTable B
JOIN Members M
ON B.Member_id = M.Member_id
JOIN Books BK
ON B.Book_id = BK.Book_id
GROUP BY M.Member_id, M.Name
HAVING COUNT(DISTINCT BK.Genre) >= 3;
```

### 7. Find the top 3 most borrowed books

```sql
SELECT
    BK.Book_id,
    BK.Title,
    COUNT(*) AS TotalBorrowed
FROM BorrowingTable B
JOIN Books BK
ON B.Book_id = BK.Book_id
GROUP BY BK.Book_id, BK.Title
ORDER BY TotalBorrowed DESC
LIMIT 3;
```

### 8. Count books in each genre

```sql
SELECT
    Genre,
    COUNT(*) AS TotalBooks
FROM Books
GROUP BY Genre;
```

### 9. Retrieve borrowing history for MemberID = 3

```sql
SELECT
    M.Name,
    BK.Title,
    B.BorrowDate,
    B.ReturnDate
FROM BorrowingTable B
JOIN Members M
ON B.Member_id = M.Member_id
JOIN Books BK
ON B.Book_id = BK.Book_id
WHERE M.Member_id = 3;
```

### 10. Find books borrowed in the last 30 days

```sql
SELECT
    BK.Title,
    M.Name,
    B.BorrowDate
FROM BorrowingTable B
JOIN Books BK
ON B.Book_id = BK.Book_id
JOIN Members M
ON B.Member_id = M.Member_id
WHERE B.BorrowDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);
```

### 11. Calculate average borrowing duration

```sql
SELECT
    AVG(DATEDIFF(ReturnDate, BorrowDate)) AS AverageBorrowDays
FROM BorrowingTable
WHERE ReturnDate IS NOT NULL;
```

### 12. Find the least borrowed book

```sql
SELECT
    BK.Book_id,
    BK.Title,
    COUNT(B.Borrow_id) AS TimesBorrowed
FROM Books BK
LEFT JOIN BorrowingTable B
ON BK.Book_id = B.Book_id
GROUP BY BK.Book_id, BK.Title
ORDER BY TimesBorrowed ASC
LIMIT 1;
```

---

#  SQL Concepts Demonstrated

This project demonstrates the following SQL concepts:

* Database creation
* Table creation
* Primary Keys
* Foreign Keys
* `INSERT INTO`
* `SELECT`
* `WHERE`
* `JOIN`
* `LEFT JOIN`
* `GROUP BY`
* `HAVING`
* `ORDER BY`
* `LIMIT`
* `COUNT()`
* `AVG()`
* `DATEDIFF()`
* `DATE_SUB()`
* `CURDATE()`
* `IS NULL`
* `COUNT(DISTINCT ...)`

---

#  How to Run the Project

## Step 1: Install MySQL

Install **MySQL Server** and **MySQL Workbench**.

## Step 2: Open MySQL Workbench

Open MySQL Workbench and connect to your MySQL server.

## Step 3: Open the SQL File

Open:

```text
LibraryDB.sql
```

## Step 4: Execute the Script

Run the complete SQL script.

The script will:

1. Create the `LibraryDB` database.
2. Create the `Books` table.
3. Create the `Members` table.
4. Create the `BorrowingTable`.
5. Insert sample data.
6. Execute SQL queries for analysis.

---

#  Example Use Cases

This database can be used to answer questions such as:

* Which books are currently available?
* Which members recently joined?
* Which books have limited copies?
* Who borrowed a particular book?
* Which books are overdue?
* Which books are most popular?
* Which genres have the most books?
* How long are books typically borrowed?
* Which book has been borrowed the least?

---

#  Future Improvements

The project can be extended by adding:

* Book return management
* Automatic fine calculation
* Member login system
* Book availability tracking
* Search functionality
* Book reservation system
* Stored procedures
* Triggers
* Views
* More advanced reporting
* Power BI dashboard
* Web-based library management interface

---

#  Author

**Abhishek Urkude**

BTECH – Information Technology

Interested in **Data Analytics, SQL, Python, Machine Learning**.

---

