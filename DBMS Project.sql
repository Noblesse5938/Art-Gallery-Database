create database Pr;
use Pr;
CREATE TABLE Gallery (
    gid varchar(26) PRIMARY KEY,
    gname varchar(24),
    location varchar(26) DEFAULT NULL
); 

CREATE TABLE Exhibition (
    eid varchar(20) PRIMARY KEY,
    gid varchar(20) REFERENCES Gallery(gid),
    startdate date DEFAULT NULL,
    enddate date NOT NULL
);

CREATE TABLE Artist (
    artistid varchar(20) PRIMARY KEY,
    gid varchar(20) REFERENCES Gallery(gid),
    eid varchar(20) REFERENCES Exhibition(eid),
    fname char(25) DEFAULT NULL,
    lname char(25) DEFAULT NULL,
    birthplace char(25) DEFAULT NULL,
    style char(25) DEFAULT NULL
);

CREATE TABLE Artwork (
    artid varchar(20) PRIMARY KEY,
    title varchar(20) DEFAULT NULL,
    year varchar(5) DEFAULT NULL,
    type_of_art varchar(20) NOT NULL,
    price integer NOT NULL,
    eid varchar(20) REFERENCES Exhibition(eid),
    gid varchar(20) REFERENCES Gallery(gid),
    artistid varchar(20) REFERENCES Artist(artistid)
);

CREATE TABLE Customer (
    custid varchar(20) PRIMARY KEY,
    gid varchar(20) REFERENCES Gallery(gid),
    artid varchar(20) REFERENCES Artwork(artid),
    Fname char(25) NOT NULL,
    Lname char(25) DEFAULT NULL,
    age integer DEFAULT NULL,
    address char(25) DEFAULT NULL,
    phone_no numeric(15)
);

INSERT INTO Gallery VALUES
('FA1', 'Academy Of Fine Art', 'Kolkata'),
('KS2', 'Triveni Kala Sangam', 'Delhi'),
('JG3', 'Jehangir Gallery', 'Mumbai'),
('MA4', 'Gallery Of Modern Art', 'Delhi'),
('AG4', 'Amdavad Ni Gufa', 'Ahmedabad');

INSERT INTO Exhibition VALUES
('H123', 'KS2', '2018-12-21', '2019-01-05'),
('I123', 'JG3', '2019-01-25', '2019-02-05'),
('G123', 'AG4', '2018-12-01', '2018-12-15'),
('J123', 'FA1', '2018-12-15', '2019-01-15'),
('K123', 'MA4', '2019-03-09', '2019-03-27');

INSERT INTO Artist VALUES
('A1', 'MA4', 'K123', 'Raja', 'Ravi Verma', 'Kerala', 'Oil on Canvas'),
('A2', 'FA1', 'J123', 'Rabindranath', 'Tagore', 'Kolkata', 'Simple bold forms'),
('A3', 'KS2', 'H123', 'Amrita', 'Sher-gil', 'Hungary', 'Post-impression'),
('A4', 'FA1', 'J123', 'Abanindranath', 'Tagore', 'Kolkata', 'Indian-style'),
('A5', 'AG4', 'G123', 'Tyeb', 'Mehta', 'Kheda', 'Abstracted'),
('A6', 'JG3', 'I123', 'S.L', 'Haldankar', 'Mumbai', 'Landscape Painting');

INSERT INTO Artwork VALUES
('ART1', 'Mahishasura', '1990', 'Painting', 10000000, 'G123', 'AG4', 'A5'),
('ART2', 'Sumair', '1936', 'Painting', 15000000, 'H123', 'KS2', 'A3'),
('ART3', 'Glow of hope', '1946', 'Painting', 2500000, 'I123', 'JG3', 'A6'),
('ART4', 'Self Portrait', '1934', 'Painting', 19000000, 'J123', 'FA1', 'A2'),
('ART5', 'Lady in Moonlight', '1889', 'Painting', 200000, 'K123', 'MA4', 'A1'),
('ART6', 'Bharat Mata', '1905', 'Painting', 1050000, 'J123', 'FA1', 'A4'),
('ART7', 'The Rickshaw Puller', '1982', 'Sculpture', 5550000, 'G123', 'AG4', 'A5'),
('ART8', 'Asoka’s Queen', '1910', 'Painting', 3050000, 'J123', 'FA1', 'A4'),
('ART9', 'Sleeping Woman', '1933', 'Painting', 6750000, 'H123', 'KS2', 'A3'),
('ART10', 'Damyanti', '1895', 'Painting', 8050000, 'K123', 'MA4', 'A1');

INSERT INTO Customer VALUES
('C1', 'MA4', 'ART10', 'Akshay', 'Thakur', 23, 'Kolkata', 9289836700),
('C2', 'FA1', 'ART6', 'Ashutosh', 'Ranjan', 25, 'Jaipur', 9663463210),
('C3', 'KS2', 'ART9', 'Ayush', 'Dhar', 25, 'Pune', 8097685642),
('C4', 'FA1', 'ART4', 'Avanish', 'Mehta', 30, 'Mumbai', 7890015477),
('C5', 'AG4', 'ART1', 'Ashish', 'Mehta', 27, 'Kolkata', 6743250089),
('C6', 'AG4', 'ART7', 'Mahak', 'Jain', 25, 'Jaipur', 6003250089),
('C7', 'KS2', 'ART2', 'Nidhi', 'Nevrekar', 25, 'Mumbai', 7840280089);


SELECT 	Gname,location FROM Gallery;

SELECT * FROM Artwork WHERE price > 10000000;

SELECT * FROM Exhibition ORDER BY startdate DESC;


SELECT title, price + (price * 0.012) AS `changed_price` FROM Artwork;

SELECT * FROM Artwork WHERE gid = 'FA1' AND type_of_art = 'Painting';

SELECT * FROM Artwork WHERE year BETWEEN '1900' AND '1950';

SELECT year, COUNT(*) AS artworks_per_year FROM Artwork GROUP BY year;

SELECT gid, SUM(price) AS total_price FROM Artwork GROUP BY gid HAVING SUM(price) > 10000000;

SELECT title AS result FROM Artwork UNION SELECT Fname AS result FROM Customer;


SELECT a.artid AS result
FROM Artwork a
LEFT JOIN Customer c ON a.artid = c.artid
WHERE c.artid IS NULL;

SELECT Exhibition.*, Gallery.gname FROM Exhibition INNER JOIN Gallery ON Exhibition.gid = Gallery.gid;

SELECT Exhibition.eid, SUM(Artwork.price) AS total_price FROM Artwork INNER JOIN Exhibition ON Artwork.eid = Exhibition.eid GROUP BY Exhibition.eid;


SELECT fname,address from Customer where address LIKE '_u%';


SELECT Exhibition.*, Gallery.gname FROM Exhibition INNER JOIN Gallery ON Exhibition.gid = Gallery.gid;

SELECT Exhibition.eid, SUM(Artwork.price) AS
 total_price FROM Artwork INNER JOIN Exhibition
 ON Artwork.eid = Exhibition.eid GROUP BY Exhibition.eid;
 

 SELECT *FROM Artwork RIGHT OUTER JOIN Exhibition ON Artwork.eid = Exhibition.eid;
 
 SELECT * FROM Customer WHERE gid = (SELECT gid FROM Gallery WHERE gname = 'Academy Of Fine Art');
 
 
SELECT * FROM Artwork WHERE eid IN (SELECT eid FROM
 Exhibition WHERE startdate >= '2019-01-01' AND startdate <= '2019-12-31');
SELECT Fname,address FROM Customer where Fname NOT LIKE 'A%';
 
 DELETE FROM Artwork WHERE year < '1900';
SELECT * FROM Artwork;

DELETE FROM Exhibition WHERE eid = 'J123';
SELECT * FROM Exhibition;










