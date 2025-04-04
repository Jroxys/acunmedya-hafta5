
create table Userr(
id serial primary key,
name varchar(255) not null,
surname varchar(255) not null,
email varchar(255) unique not null,
phone varchar(15) unique not null

);

create table Student (
id serial primary key,
userId int unique not null,
department varchar(255) not null,
foreign key (userId) references Userr(id)
);

create table Author (
id serial primary key,
userId int unique not null,
foreign key (userId) references Userr(id)

);

create table Staff (
id serial primary key,
userId int unique not null,
foreign key (userId) references Userr(id)

);

create table Category (
id serial primary key,
categoryName varchar(255) not null
);

create table Book(
id serial primary key,
name varchar(255) not null,
publicationYear int,
edition varchar(50),
categoryId int not null,
authorId int not null,
foreign key (categoryId) references Category(id),
foreign key (authorId) references Author(id)
);



create table Loan (
id serial primary key,
studentId int not null,
bookId int not null,
checkOutDate date not null,
foreign key (studentId) references Student(id),
foreign key (bookId) references Book(id)
);

INSERT INTO Userr (name, surname, email, phone) VALUES
('Şevval', 'Aydın', 'sev@gmail.com', '05551112233'),
('Sümeyye', 'Gürsoy', 'süm@gmail.com', '05554445566'),
('Ömer', 'Kılıç', 'ömer@gmail.com', '05550001122'),
('Barış Efe', 'Bıyıklı', 'barıs@gmail.com', '05557778899');

INSERT INTO Student (userId, department) VALUES
(1, 'Bilgisayar Mühendisliği'),
(2, 'İşletme');

INSERT INTO Author (userId) VALUES
(3);

INSERT INTO Staff (userId) VALUES
(4);

INSERT INTO Category (categoryName) VALUES
('Bilgisayar Bilimleri'),
('Roman'),
('Bilim'),
('Tarih');

INSERT INTO Book (name, publicationYear, edition, categoryId, authorId) VALUES
('Bilinmeyen Bir Kadının Mektubu', 1922, '1. Baskı', 1, 1),
('Zamanın Kısa Tarihi', 1988, '2. Baskı', 2, 1),
('Şeker Portakalı',2021, '3. Baskı',3,1);

INSERT INTO Loan (studentId, bookId, checkOutDate) VALUES
(1, 1, '2025-04-01'),
(2, 2, '2025-04-02');

select * from Book;

--select * from Book where categoryId = (select id  from Category where categoryName= 'Bilgisayar Bilimleri');

select b.*
from Book as b 
join Category on b.categoryId = Category.id
where categoryName= 'Bilgisayar Bilimleri';


select * from Book where publicationYear >= 2020;

select book.Name as BookName, category.categoryName as CategoryName
from Book 
join Category on book.categoryId = Category.id;

select u.Name as Name, u.Surname as Surname, b.Name as BookName
from Loan as l 
join Student as s on l.studentId = s.id
join Userr as u on s.userId = u.id
join Book as b on l.bookId = b.id;


select b.Name as BookName, u.Name as AuthorName, u.Surname as AuthorSurname, b.publicationYear
from Book as b
join Author as a on b.authorId = a.id
join Userr as u on a.userId = u.id;

select u.Name, u.Surname, b.name as BookName, l.checkOutDate
from Loan as l
join Student as s on l.studentId = s.id
join Userr as u on s.userId = u.id
join Book as b on l.bookId = b.id;

select u.Name, u.Surname, b.name as BookName, l.ReturnDate
from Loan as l
join Student as s on l.studentId = s.id
join Userr as u on s.userId = u.id
join Book as b on l.bookId = b.id
where l.ReturnDate is null;

alter table Loan add column ReturnDate date;

select category.categoryName, count(b.id) as BookCount
from Book as b
join Category on b.categoryId = Category.id
group by category.categoryName;

select u.Name, u.Surname, count(l.id) as LoanCount
from Loan as l
join Student as s on l.studentId = s.id
join Userr as u on s.userId = u.id
group by u.id, u.Name , u.Surname
order by LoanCount DESC;








