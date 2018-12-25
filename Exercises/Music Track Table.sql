#My name anonymized for GitHub.
use name_test
CREATE DATABASE name_cds;
USE name_cds
CREATE TABLE track (     
	trkid      INTEGER auto_increment,                          
	trknum     INTEGER,     
	trktitle   VARCHAR(50),      
    trklength   DECIMAL(4,2),         
	PRIMARY KEY (trkid));
show tables;
desc track;
insert into track values (1, 1, 'Giant Steps', 4.72); 
insert into track values (2, 2, 'Cousin Mary', 5.75); 
insert into track values (3, 3, 'Countdown', 2.35); 
insert into track values (4, 4, 'Spiral', 5.93); 
insert into track values (5, 5, 'Syeeda''s song flute', 7); 
insert into track values (6, 6, 'Naima', 4.35); 
insert into track values (7, 7, 'Mr. P.C.', 6.95); 
insert into track values (8, 8, 'Giant Steps', 3.67); 
insert into track values (9, 9, 'Naima', 4.45); 
insert into track values (10, 10, 'Cousin Mary', 5.9);
insert into track values (11, 11, 'Countdown', 4.55); 
insert into track values (12, 12, 'Syeeda''s song flute', 7.03); 
insert into track values (13, 1, 'Stomp of King Porter', 3.2); 
insert into track values (14, 2, 'Sing a Study in Brown', 2.85);
insert into track values (15, 3, 'Sing Moten''s Swing', 3.6); 
insert into track values (16, 4, 'A-tisket, A-tasket', 2.95); 
insert into track values (17, 5, 'I Know Why', 3.57); 
insert into track values (18, 6, 'Sing You Sinners', 2.75); 
insert into track values (19, 7, 'Java Jive', 2.85); 
insert into track values (20, 8, 'Down South Camp Meetin''', 3.25); 
insert into track values (21, 9, 'Topsy', 3.23); 
insert into track values (22, 10, 'Clouds', 7.2); 
insert into track values (23, 11, 'Skyliner', 3.18); 
insert into track values (24, 12, 'It''s Good Enough to Keep', 3.18); 
insert into track values (25, 13, 'Choo Choo Ch'' Boogie', 3);
select * from track