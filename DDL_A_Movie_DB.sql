/*
Project: AMovieDb Project
Model: AMovieDB
Author: Rahul
Database: MS SQL Server 2017
*/

CREATE DATABASE A_Movie_DB
go

USE A_Movie_DB
go

-- Create tables section -------------------------------------------------

-- Table genre

CREATE TABLE [genre]
(
 [genreID]         char(3),  
 [genreCategory]   nchar(20)                      NOT NULL,
 PRIMARY KEY ([genreID])
)
go

-- Table movieTitle

CREATE TABLE [movieTitle]
(
 [movieTitleID]     Int          IDENTITY(50000,1) NOT NULL,
 [movieName]        Nvarchar(50)                   NOT NULL,
 [releaseDate]      Date                           NOT NULL,
 [releaseMethod]    char(7)                        NOT NULL,
 [duration]         char(6)                        NOT NULL,
 [majorAwardNoms]   Int         DEFAULT 0          NOT NULL,
 [movieRating]      Char(4)                        NOT NULL,
 [distributor]      nvarchar(50)                   NOT NULL,
 [certification]    Char(5)                        NOT NULL,
 [grossID]          Int                                NULL,
 PRIMARY KEY ([movieTitleID]),
 Constraint    chk_releaseMethod  Check  (releaseMethod IN ('Limited', 'Wide')),
 Constraint    chk_certification  Check  (certification IN ('R', 'PG-13', 'PG', 'NR', 'NC-17')) 
)
go

-- Table movieGenre

CREATE TABLE [movieGenre]
(
 [genreID]        char(3)                             NOT NULL,
 [movieTitleID]   Int                                 NOT NULL,
 PRIMARY KEY ([movieTitleID],[genreID])
)
go

-- Create indexes for table movieTitle

CREATE INDEX [grossIncome] ON [movieTitle] ([grossID])
go


-- Table movieStar

CREATE TABLE [movieStar]
(
 [movieStarID]   Int            IDENTITY(1000,1),
 [firstName]     nchar(20)                            NULL,
 [lastName]      nchar(20)                        NOT NULL,
 PRIMARY KEY ([movieStarID])
)
go



-- Table topBilledCast

CREATE TABLE [topBilledCast]
(
 [movieStarID]  Int                               NOT NULL,
 [movieTitleID] Int                               NOT NULL,
 PRIMARY KEY ([movieStarID],[movieTitleID])
)
go



-- Table director

CREATE TABLE [director]
(
 [directorID]     Int              IDENTITY(5000,1),
 [firstName]      nchar(20)                                 NULL,
 [lastName]       nchar(20)                             NOT NULL,
 PRIMARY KEY ([directorID])
)
go


-- Table movieDirector

CREATE TABLE [movieDirector]
(
 [directorID]      Int                                  NOT NULL,
 [movieTitleID]    Int                                  NOT NULL,
 PRIMARY KEY ([movieTitleID],[directorID])
)
go

-- Table gross

CREATE TABLE [gross]
(
 [grossID]       Int             IDENTITY(10000,1),
 [budget]        nchar(20)                                 NOT NULL,
 PRIMARY KEY ([grossID])
)
go

-- Table usa

CREATE TABLE [usa]
( [grossID]    int         PRIMARY KEY,
  [usaGross]   nchar(20)                        NOT NULL,
  constraint FK_USA_gross  Foreign Key (grossID) References gross(grossID)
)
go



-- Table overseas
CREATE TABLE [overseas]
( [grossID]       int         PRIMARY KEY,
  [overseasGross] nchar(20)                       NOT NULL,
  constraint FK_overseas_gross  Foreign Key (grossID) References gross(grossID)

)
go

-- Table digital

CREATE TABLE [digital]
( [grossID]       int        PRIMARY KEY,
  [digitalGross]  nchar(20)                      NOT NULL,
  constraint FK_digital_gross  Foreign Key (grossID) References gross(grossID)
)
go

-- Table country

CREATE TABLE [country]
(
 [countryID]          char (2),
 [countryName]        Nchar(50)                                          NOT NULL,
 PRIMARY KEY ([countryID]),
 UNIQUE CLUSTERED ([countryName])
)
go



-- Table movieOrigin

CREATE TABLE [movieOrigin]
(
 [countryID]        char (2)                                       NOT NULL,
 [movieTitleID]     Int                                            NOT NULL,
 PRIMARY KEY ([countryID],[movieTitleID])
)
go



-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE [topBilledCast] ADD CONSTRAINT [acts in] FOREIGN KEY ([movieStarID]) REFERENCES [movieStar] ([movieStarID]) ON UPDATE CASCADE ON DELETE CASCADE
go


ALTER TABLE [topBilledCast] ADD CONSTRAINT [consist] FOREIGN KEY ([movieTitleID]) REFERENCES [movieTitle] ([movieTitleID]) ON UPDATE CASCADE ON DELETE CASCADE
go


ALTER TABLE [movieGenre] ADD CONSTRAINT [have] FOREIGN KEY ([movieTitleID]) REFERENCES [movieTitle] ([movieTitleID]) ON UPDATE CASCADE ON DELETE CASCADE
go


ALTER TABLE [movieGenre] ADD CONSTRAINT [is associated with] FOREIGN KEY ([genreID]) REFERENCES [genre] ([genreID]) ON UPDATE CASCADE ON DELETE CASCADE
go


ALTER TABLE [movieDirector] ADD CONSTRAINT [is directed by] FOREIGN KEY ([movieTitleID]) REFERENCES [movieTitle] ([movieTitleID]) ON UPDATE CASCADE ON DELETE CASCADE
go


ALTER TABLE [movieDirector] ADD CONSTRAINT [directs] FOREIGN KEY ([directorID]) REFERENCES [director] ([directorID]) ON UPDATE CASCADE ON DELETE CASCADE
go


ALTER TABLE [movieTitle] ADD CONSTRAINT [genrates] FOREIGN KEY ([grossID]) REFERENCES [gross] ([grossID]) ON UPDATE CASCADE ON DELETE CASCADE
go


ALTER TABLE [movieOrigin] ADD CONSTRAINT [belongs] FOREIGN KEY ([countryID]) REFERENCES [country] ([countryID]) ON UPDATE CASCADE ON DELETE CASCADE
go


ALTER TABLE [movieOrigin] ADD CONSTRAINT [is of a] FOREIGN KEY ([movieTitleID]) REFERENCES [movieTitle] ([movieTitleID]) ON UPDATE CASCADE ON DELETE CASCADE
go



-- insert values in table genre 
INSERT genre 
           VALUES 
		   ('ADV','Adventure'), 
		   ('ACT','Action'), 
		   ('ANI','Animation'),  
		   ('BIO','Biography'), 
		   ('COM','Comedy'), 
		   ('CRI','Crime'),
		   ('DOC','Documentary'), 
		   ('DRA','Drama'),
		   ('FAN','Fantasy'), 
		   ('HIS','History'), 
		   ('HOR','Horror'),
		   ('MUS','Musical'),
		   ('MYS','Mystery'), 
		   ('ROM','Romance'), 
		   ('SCI','Sci-fi'), 
		   ('THR','Thriller'),
		   ('WES','Western')
 go

 -- insert values in table country

INSERT country 
              Values 
			  ('AF', 'Afghanistan'),
			  ('AL', 'Albania'),
			  ('AG', 'Algeria'),
			  ('AS', 'American Samoa'),
			  ('AD', 'Andorra'),
			  ('AO', 'Angola'),
			  ('AI', 'Anguilla'),
			  ('AQ', 'Antarctica'),
			  ('AB', 'Antigua and Barbuda'),
			  ('AR', 'Argentina'),
			  ('AM', 'Armenia'),
			  ('AW', 'Aruba'),
			  ('AU', 'Australia'), 
			  ('AT', 'Austria'),
			  ('AZ', 'Azerbaijan'),
			  ('BS', 'Bahamas'),
			  ('BH', 'Bahrain'),
			  ('BD', 'Bangladesh'), 
			  ('BB', 'Barbados'),
			  ('BY', 'Belarus'),
			  ('BE', 'Belgium'),
			  ('BZ', 'Belize'),
			  ('BJ', 'Benin'),
			  ('BM', 'Bermuda'),
			  ('BT', 'Bhutan'),
			  ('BO', 'Bolivia'),
			  ('BA', 'Bosnia and Herzegovina'),
			  ('BW', 'Botswana'),
			  ('BV', 'Bouvet Island'),
			  ('BR', 'Brazil'),
			  ('IO', 'British Indian Ocean Territory'),
			  ('BN', 'Brunei Darussalam'),
			  ('BG', 'Bulgaria'),
			  ('BF', 'Burkina Faso'),
			  ('BI', 'Burundi'),
			  ('KH', 'Cambodia'),
			  ('CM', 'Cameroon'),
			  ('CA', 'Canada'),
			  ('CV', 'Cape Verde'),
			  ('KY', 'Cayman Islands'),
			  ('CF', 'Central African Republic'),
			  ('TD', 'Chad'),
			  ('CL', 'Chile'),
			  ('CN', 'China'),
			  ('CX', 'Christmas Island'),
			  ('CC', 'Cocos (Keeling) Islands'),
			  ('CO', 'Colombia'),
			  ('KM', 'Comoros'),
			  ('CG', 'Congo'),
			  ('CK', 'Cook Islands'),
			  ('CR', 'Costa Rica'),
			  ('HR', 'Croatia (Hrvatska)'),
			  ('CU', 'Cuba'),
			  ('CY', 'Cyprus'),
			  ('CZ', 'Czech Republic'),
			  ('DK', 'Denmark'),
			  ('DJ', 'Djibouti'),
			  ('DM', 'Dominica'),
			  ('DO', 'Dominican Republic'),
			  ('TP', 'East Timor'),
			  ('EC', 'Ecuador'),
			  ('EG', 'Egypt'),
			  ('SV', 'El Salvador'),
			  ('GQ', 'Equatorial Guinea'),
			  ('ER', 'Eritrea'),
			  ('EE', 'Estonia'),
			  ('ET', 'Ethiopia'),
			  ('FK', 'Falkland Islands (Malvinas)'),
			  ('FO', 'Faroe Islands'),
			  ('FJ', 'Fiji'),
			  ('FI', 'Finland'),
			  ('FR', 'France'),
			  ('FX', 'France, Metropolitan'),
			  ('GF', 'French Guiana'),
			  ('PF', 'French Polynesia'),
			  ('TF', 'French Southern Territories'),
			  ('GA', 'Gabon'),
			  ('GM', 'Gambia'),
			  ('GE', 'Georgia'),
			  ('DE', 'Germany'),
			  ('GH', 'Ghana'),
			  ('GI', 'Gibraltar'),
			  ('GK', 'Guernsey'),
			  ('GR', 'Greece'),
			  ('GL', 'Greenland'),
			  ('GD', 'Grenada'),
			  ('GP', 'Guadeloupe'),
			  ('GU', 'Guam'),
			  ('GT', 'Guatemala'),
			  ('GN', 'Guinea'),
			  ('GW', 'Guinea-Bissau'),
			  ('GY', 'Guyana'),
			  ('HT', 'Haiti'),
			  ('HM', 'Heard and Mc Donald Islands'),
			  ('HN', 'Honduras'),
			  ('HK', 'Hong Kong'),
			  ('HU', 'Hungary'),
			  ('IS', 'Iceland'),
			  ('IN', 'India'),
			  ('IM', 'Isle of Man'),
			  ('ID', 'Indonesia'),
			  ('IR', 'Iran (Islamic Republic of)'),
			  ('IQ', 'Iraq'),
			  ('IE', 'Ireland'),
			  ('IL', 'Israel'),
			  ('IT', 'Italy'),
			  ('CI', 'Ivory Coast'),
			  ('JE', 'Jersey'),
			  ('JM', 'Jamaica'),
			  ('JP', 'Japan'),
			  ('JO', 'Jordan'),
			  ('KZ', 'Kazakhstan'),
			  ('KE', 'Kenya'),
			  ('KI', 'Kiribati'),
			  ('KP', 'Korea, Democratic People''s Republic of'),
			  ('KR', 'Korea, Republic of'),
			  ('XK', 'Kosovo'),
			  ('KW', 'Kuwait'),
			  ('KG', 'Kyrgyzstan'),
			  ('LA', 'Lao People''s Democratic Republic'),
			  ('LV', 'Latvia'),
			  ('LB', 'Lebanon'),
			  ('LS', 'Lesotho'),
			  ('LR', 'Liberia'),
			  ('LY', 'Libyan Arab Jamahiriya'),
			  ('LI', 'Liechtenstein'),
			  ('LT', 'Lithuania'),
			  ('LU', 'Luxembourg'),
			  ('MO', 'Macau'),
			  ('MK', 'Macedonia'),
			  ('MG', 'Madagascar'),
			  ('MW', 'Malawi'),
			  ('MY', 'Malaysia'),
			  ('MV', 'Maldives'),
			  ('ML', 'Mali'),
			  ('MT', 'Malta'),
			  ('MH', 'Marshall Islands'),
			  ('MQ', 'Martinique'),
			  ('MR', 'Mauritania'),
			  ('MU', 'Mauritius'),
			  ('TY', 'Mayotte'),
			  ('MX', 'Mexico'),
			  ('FM', 'Micronesia, Federated States of'),
			  ('MD', 'Moldova, Republic of'),
			  ('MC', 'Monaco'),
			  ('MN', 'Mongolia'),
			  ('ME', 'Montenegro'),
			  ('MS', 'Montserrat'),
			  ('MA', 'Morocco'),
			  ('MZ', 'Mozambique'),
			  ('MM', 'Myanmar'),
			  ('NA', 'Namibia'),
			  ('NR', 'Nauru'),
			  ('NP', 'Nepal'),
			  ('NL', 'Netherlands'),
			  ('AN', 'Netherlands Antilles'),
			  ('NC', 'New Caledonia'),
			  ('NZ', 'New Zealand'),
			  ('NI', 'Nicaragua'),
			  ('NE', 'Niger'),
			  ('NG', 'Nigeria'),
			  ('NU', 'Niue'),
			  ('NF', 'Norfolk Island'),
			  ('MP', 'Northern Mariana Islands'),
			  ('NO', 'Norway'),
			  ('OM', 'Oman'),
			  ('PK', 'Pakistan'),
			  ('PW', 'Palau'),
			  ('PS', 'Palestine'),
			  ('PA', 'Panama'),
			  ('PG', 'Papua New Guinea'),
			  ('PY', 'Paraguay'),
			  ('PE', 'Peru'),
			  ('PH', 'Philippines'),
			  ('PN', 'Pitcairn'),
			  ('PL', 'Poland'),
			  ('PT', 'Portugal'),
			  ('PR', 'Puerto Rico'),
			  ('QA', 'Qatar'),
			  ('RE', 'Reunion'),
			  ('RO', 'Romania'),
			  ('RU', 'Russian Federation'),
			  ('RW', 'Rwanda'),
			  ('KN', 'Saint Kitts and Nevis'),
			  ('LC', 'Saint Lucia'),
			  ('VC', 'Saint Vincent and the Grenadines'),
			  ('WS', 'Samoa'),
			  ('SM', 'San Marino'),
			  ('ST', 'Sao Tome and Principe'),
			  ('SA', 'Saudi Arabia'),
			  ('SN', 'Senegal'),
			  ('RS', 'Serbia'),
			  ('SC', 'Seychelles'),
			  ('SL', 'Sierra Leone'),
			  ('SG', 'Singapore'),
			  ('SK', 'Slovakia'),
			  ('SI', 'Slovenia'),
			  ('SB', 'Solomon Islands'),
			  ('SO', 'Somalia'),
			  ('ZA', 'South Africa'),
			  ('GS', 'South Georgia South Sandwich Islands'),
			  ('SS', 'South Sudan'),
			  ('ES', 'Spain'),
			  ('LK', 'Sri Lanka'),
			  ('SH', 'St. Helena'),
			  ('PM', 'St. Pierre and Miquelon'),
			  ('SD', 'Sudan'),
			  ('SR', 'Suriname'),
			  ('SJ', 'Svalbard and Jan Mayen Islands'),
			  ('SZ', 'Swaziland'),
			  ('SE', 'Sweden'),
			  ('CH', 'Switzerland'),
			  ('SY', 'Syrian Arab Republic'),
			  ('TW', 'Taiwan'),
			  ('TJ', 'Tajikistan'),
			  ('TZ', 'Tanzania, United Republic of'),
			  ('TH','Thailand'),
			  ('TG', 'Togo'),
			  ('TK', 'Tokelau'),
			  ('TO', 'Tonga'),
			  ('TT', 'Trinidad and Tobago'),
			  ('TN', 'Tunisia'),
			  ('TR', 'Turkey'),
			  ('TM', 'Turkmenistan'),
			  ('TC', 'Turks and Caicos Islands'),
			  ('TV', 'Tuvalu'),
			  ('UG', 'Uganda'),
			  ('UA', 'Ukraine'),
			  ('AE', 'United Arab Emirates'),
			  ('GB', 'United Kingdom'),
			  ('US', 'United States'),
			  ('UM', 'United States minor outlying islands'),
			  ('UY', 'Uruguay'),
			  ('UZ', 'Uzbekistan'),
			  ('VU', 'Vanuatu'),
			  ('VA', 'Vatican City State'),
			  ('VE', 'Venezuela'),
			  ('VN', 'Vietnam'),
			  ('VG', 'Virgin Islands (British)'),
			  ('VI', 'Virgin Islands (U.S.)'),
			  ('WF', 'Wallis and Futuna Islands'),
			  ('EH', 'Western Sahara'),
			  ('YE', 'Yemen'),
			  ('ZR', 'Zaire'),
			  ('ZM', 'Zambia'),
			  ('ZW', 'Zimbabwe')

go

-- insert values in table movieStar
INSERT movieStar
Values
('Lin', 'Shaye'), 
('Leigh', 'Whannell'), 
('Angus', 'Sampson'),
('Jessica', 'Chastain'), 
('Idris', 'Elba'), 
('Kevin', 'Costner'), 
('Dominic', 'Cooper'), 
('Austin', 'Stowell'), 
('Gemma', 'Chan'), 
('Liam', 'Neeson'), 
('Vera', 'Farmiga'), 
('Patrick', 'Wilson'), 
('Ben', 'Whishaw'), 
('Hugh', 'Grant'), 
('Hugh', 'Bonneville'), 
('Taraji P', 'Henson'), 
('Billy', 'Brown'),
('Jahi Di''Allo', 'Winston'),
('Meryl', 'Streep'), 
('Tom', 'Hanks'), 
('Sarah', 'Paulson'),
('Bruce', 'Willis'), 
('Cole', 'Hauser'), 
('Shawn', 'Ashmore'), 
('Alex', 'Lawther'), 
('Ian', 'Nelson'),
('AnnaSophia', 'Robb'),
('Adel', 'Karam'), 
('Kamel El', 'Basha'), 
('Camille', 'Salameh'),
('Joseph', 'Beuys'), 
('Caroline', 'Tisdall'),
('Rhea', 'Thönges-Stringaris'),
('Chris', 'Hemsworth'), 
('Michael', 'Shannon'), 
('Michael', 'Peña'),
('Gerard', 'Butler'), 
('Pablo','Schreiber'), 
('O''Shea', 'Jackson Jr.'),
('Alex', 'Roe'), 
('Jessica', 'Rothe'),
('Abby Ryder', 'Fortson'), 
('Hana', 'Sugisaki'),
('Ryûnosuke', 'Kamiki'), 
('Yûki', 'Amami'),
('Nicolas', 'Cage'), 
('Selma', 'Blair'), 
('Anne', 'Winters'),
('Deepika', 'Padukone'), 
('Ranveer', 'Singh'), 
('Shahid', 'Kapoor'),
('Scott', 'Shepherd'), 
('Rosamund', 'Pike'), 
('Ava', 'Cooper'),
('Dylan', 'O''Brien'),
('Ki Hong', 'Lee'), 
('Kaya', 'Scodelario'),
('Addison', 'Timlin'), 
('Ian', 'Nelson'),
('Larry', 'Fessenden'),
('Dakota', 'Fanning'),
('Alice', 'Eve'), 
('Toni', 'Collette'), 
('Helen', 'Mirren'), 
('Sarah', 'Snook'),
('Finn', 'Scicluna-O''Prey'),
('Vernon', 'Beach'), 
('Callie', 'Carman'), 
('Delanee', 'Carman'),
('Daniela', 'Vega'),
('Francisco', 'Reyes'),
('Luis', 'Gnecco'),
('Alek', 'Skarlatos'), 
('Anthony', 'Sadler'), 
('Spencer', 'Stone'),
('Dakota', 'Johnson'), 
('Jamie', 'Dornan'), 
('Eric', 'Johnson'),
('James', 'Corden'), 
('Fayssal','Bazzi'), 
('Domhnall', 'Gleeson'),
('Whitney', 'Cummings'), 
('Toby', 'Kebbell'), 
('Beanie', 'Feldstein'),
('Emily', 'Browning'), 
('Adam', 'Horovitz'), 
('Mary-Louise', 'Parker'), 
('Akshay', 'Kumar'), 
('Radhika', 'Apte'), 
('Sonam', 'Kapoor'),
('Marine', 'Vacth'), 
('Jérémie', 'Renier'), 
('Jacqueline', 'Bisset'),
('Chadwick', 'Boseman'), 
('Michael B.', 'Jordan'), 
('Lupita', 'Nyong''o'),
('Eddie', 'Redmayne'),
('Tom', 'Hiddleston'),
('Maisie', 'Williams'),
('Taylor', 'James'),
('Billy', 'Zane'), 
('Lindsay', 'Wagner'), 
('Maryana', 'Spivak'), 
('Aleksey', 'Rozin'), 
('Matvey', 'Novikov')

				
go
-- insert values in table director
INSERT director
Values
('Adam', 'Robitel'),
('Aaron', 'Sorkin'),
('Clay', 'Staub'),
('Christopher', 'Radcliff'), 
('Lauren', 'Wolkstein'),
('Simon', 'West'),
('Jaume', 'Collet-Serra'),
('Paul', 'King'),
('Babak', 'Najafi'),
('Steven', 'Spielberg'),
('Brett', 'Donowho'),
('Trudie', 'Styler'),
('Ziad', 'Doueiri'),
('Andres', 'Veiel'),
('Nicolai', 'Fuglsig'),
('Christian', 'Gudegast'),
('Bethany Ashton', 'Wolf'),
('Greg', 'Barker'),
('Hiromasa', 'Yonebayashi'), 
('Giles', 'New'),
('Brian', 'Taylor'),
('Sanjay Leela', 'Bhansali'),
('Scott', 'Cooper'),
('Wes', 'Ball'),
('Robert', 'Mockler'),
('Ben', 'Lewin'),
('Peter', 'Spierig'), 
('Michael', 'Spierig'), 
('Jeff', 'Unay'),
('Sebastián', 'Lelio'),
('Clint', 'Eastwood'),
('James', 'Foley'),
('Will', 'Gluck'),
('Whitney', 'Cummings'),
('Alex Ross', 'Perry'),
('R.', 'Balki'),
('François', 'Ozon'),
('Ryan', 'Coogler'),
('Nick', 'Park'),
('Bruce', 'Macdonald'),
('Gabriel', 'Sabloff'),
('Andrey', 'Zvyagintsev')
go
-- insert values in table gross
INSERT gross
Values
-- budget column
('10,000,000'),
('30,000,000'),
('n/a'),
('40,000,000'),
('40,000,000'),
('30,000,000'),
('50,000,000'),
('n/a'),
('2,000,000'),
('n/a'),
('n/a'),
('35,000,000'),
('30,000,000'),
('3,500,000'),
('n/a'),
('n/a'),
('30,000,000'),
('40,000,000'),
('61,000,000'),
('n/a'),
('n/a'),
('3,500,000'),
('n/a'),
('n/a'),
('30,000,000'),
('55,000,000'),
('50,000,000'),
('n/a'),
('n/a'),
('2,800,000'),
('8,000,000'),
('200,000,000'),
('50,000,000'),
('n/a'),
('n/a')
go
-- insert values in table movieTitle
INSERT movieTitle
                Values
				('Insidious: The Last Key', '2018-01-05','Wide','103min',0, '5.7','Universal','PG-13', 10000),
				('Molly''s Game ', '2018-01-05', 'Wide', '140min', 3, '7.5','STX Entertainment', 'R', 10001),
				('Stratton', '2018-01-05', 'Limited', '95min', 0, '4.8', 'Momentum Pictures', 'R', 10002),
				('The Commuter','2018-01-12', 'Wide', '105min', 0, '6.5', 'Lionsgate', 'PG-13',10003),
				('Paddington 2', '2018-01-12', 'Wide', '103min', 3, '7.9', 'Warner Brothers', 'PG',10004),
				('Proud Mary', '2018-01-12', 'Wide', '89min', 0, '4.9', 'Sony Pictures', 'R',10005),
				('The Post', '2018-01-12', 'Wide', '116min', 8, '7.2', '20th Century Fox', 'PG-13', 10006),
				('Acts of Violence','2018-01-12', 'Limited','86min', 0,	'5.2','Lionsgate Premiere','R', 10007),
				('Freak Show','2018-01-12',	'Limited' ,'91min',	0,	'6.3',	'IFC Films','NR', 10008),
				('The Insult', '2018-01-12', 'Limited',	'113min', 1, '7.7',	'Cohen Media Group', 'R', 10009),
				('Beuys', '2018-01-17',	'Limited',	'107min', 0, '6.7',	'Kino Lorber' , 'NR', 10010),
				('12 Strong', '2018-01-19',	'Wide',	'130min', 0, '6.6',	'Warner Bros.',	'R', 10011),
				('Den of Thieves', '2018-01-19', 'Wide', '140min',	0,	'7', 'STX Entertainment', 'R',10012),
				('Forever My Girl',	'2018-01-19', 'Wide',	'108min',	0,	'6.7',	'Roadside Attractions',	'PG', 10013),
				('Mary and the Witch''s Flower',	'2018-01-19',	'Limited',	'103min',	0,	'6.8',	'GKIDS',	'PG', 10014),
				('Mom and Dad', '2018-01-19', 'Limited',	'86min',	0,	'5.5',	'Momentum Pictures',	'R', 10015),
				('Padmavat','2018-01-25',	'Limited',	'164min',	0,	'7',	'Paramount Pictures',	'NR', 10016),
				('Hostiles', '2018-01-26',	'Wide',	'134min',	0,	'7.2',	'Entertainment Studios Motion Pictures',	'R', 10017),
				('Maze Runner: The Death Cure',	'2018-01-26',	'Wide',	'143min',	0,	'6.2',	'20th Century Fox',	'PG-13', 10018),
				('Like Me', '2018-01-26', 'Limited', '80min',	0,	'5.5',	'Kino Lorber', 'NR', 10019),
				('Please Stand By', '2018-01-26',	'Limited',	'93min',	0,	'6.7',	'Magnolia Pictures',	'PG-13', 10020),
				('Winchester',	'2018-02-02',	'Wide',	'99min',	0,	'5.4',	'CBS Films',	'PG-13', 10021),
				('The Cage Fighter', '2018-02-02',	'Limited',	'81min',	0,	'5.7',	'IFC Films',	'NR', 10022),
				('A Fantastic Woman', '2018-02-02',	'Limited',	'104min',	2,	'7.2',	'Sony Pictures Classics',	'R', 10023),
				('The 15:17 to Paris',	'2018-02-09', 'Wide',	'94min',	0,	'5.2',	'Warner Bros.',	'PG-13', 10024),
				('Fifty Shades Freed',	'2018-02-09',	'Wide',	'105min',	0,	'4.5',	'Universal',	'R', 10025),
				('Peter Rabbit', '2018-02-09',	'Wide',	'95min',	0,	'6.6',	'Sony Pictures',	'PG', 10026),
				('The Female Brain', '2018-02-09',	'Limited',	'98min',	0,	'5.7',	'IFC Films',	'NR', 10027),
				('Golden Exits', '2018-02-09',	'Limited',	'94min',	0,	'5.8',	'Sony Pictures',	'R', 10028),
				('Padman',	'2018-02-09',	'Limited',	'140min',	0,	'8', 'Sony Pictures',	'PG-13', 10029),
				('Double Lover', '2018-02-09',	'Limited',	'107min',	1,	'6.2',	'Cohen Media Group',	'NR', 10030),
				('Black Panther',	'2018-02-16',	'Wide',	'134min',	11,	'7.4',	'Walt Disney',	'PG-13', 10031),
				('Early Man',	'2018-02-16',	'Wide',	'89min',	0,	'6.1',	'Lionsgate',	'PG', 10032),
				('Samson',	'2018-02-16',	'Wide',	'110min',	0,	'4.4',	'Pure Flix Entertainment',	'PG-13', 10033),
				('Loveless',	'2018-02-16',	'Limited',	'127min',	3,	'7.7',	'Sony Pictures Classics',	'R', 10034)

go
-- insert values in table movieOrigin
INSERT movieOrigin
Values
('US', 50000),	
('US', 50001),	
('GB', 50002),	
('US', 50003),	
('GB', 50004), ('FR', 50004),	
('US', 50005),	
('US', 50006),	
('CA', 50007), ('US', 50007),
('US', 50008),	
('LB', 50009),	
('DE', 50010),
('US', 50011),	
('US', 50012),	
('US', 50013),	
('JP', 50014),
('US', 50015),	
('IN', 50016),	
('US', 50017),	
('US', 50018),	
('US', 50019),	
('US', 50020),	
('US', 50021),	
('US', 50022),	
('CL', 50023), ('DE', 50023), ('ES', 50023), ('US', 50023),	
('US', 50024),	
('US', 50025),	
('AU', 50026), ('US', 50026),	
('US', 50027),	
('US', 50028),	
('IN', 50029),	
('BE', 50030), ('FR', 50030),	
('US', 50031),	
('FR', 50032), ('GB', 50032),	
('ZA', 50033), ('US', 50033),	
('RU', 50034)

go
-- insert values in table movieDirector
INSERT movieDirector
                Values
				(5000,50000),
				(5001,50001),
				(5002,50002),
				(5003,50003),
				(5004,50004),
				(5005,50005),
				(5006,50006),
				(5007,50007),
				(5008,50008),
				(5009,50009),
				(5010,50010),
				(5011,50011),
				(5012,50012),
				(5013,50013),
				(5014,50014),(5015,50014),
				(5016,50015),
				(5017,50016),
				(5018,50017),
				(5019,50018),
				(5020,50019),
				(5021,50020),
				(5022,50021), (5023,50021),
				(5024,50022),
				(5025,50023),
				(5026,50024),
				(5027,50025),
				(5028,50026),
				(5029,50027),
				(5030,50028),
				(5031,50029),
				(5032,50030),
				(5033,50031),
				(5034,50032),
				(5035,50033), (5036,50033),
				(5037,50034)

go
-- insert values in table movieGenre
INSERT movieGenre
Values
('HOR', 50000), ('MYS', 50000), ('THR', 50000), 
('BIO', 50001), ('CRI', 50001), ('DRA', 50001), 
('ACT', 50002), ('THR', 50002), 
('ACT', 50003), ('CRI', 50003), ('DRA', 50003), 
('ADV', 50004), ('COM', 50004),
('ACT', 50005), ('CRI', 50005), ('DRA', 50005), 
('BIO', 50006), ('DRA', 50006), ('HIS', 50006),
('ACT', 50007), ('CRI', 50007), 
('COM', 50008), ('DRA', 50008), 
('CRI', 50009), ('DRA', 50009), ('THR', 50009), 
('DOC', 50010),
('ACT', 50011), ('DRA', 50011), ('HIS', 50011),
('ACT', 50012), ('CRI', 50012), ('DRA', 50012), 
('DRA', 50013), ('MUS', 50013), ('ROM', 50013), 
('ANI', 50014), ('ADV', 50014),
('COM', 50015), ('HOR', 50015), ('THR', 50015),
('DRA', 50016), ('HIS', 50016), ('ROM', 50016), 
('ADV', 50017), ('DRA', 50017), ('WES', 50017), 
('ACT', 50018), ('SCI', 50018), ('THR', 50018), 
('CRI', 50019), ('DRA', 50019), ('HOR', 50019), 
('COM', 50020), ('DRA', 50020),
('BIO', 50021), ('DRA', 50021), ('FAN', 50021),
('DOC', 50022), ('ACT', 50022), ('DRA', 50022),
('DRA', 50023), 
('BIO', 50024), ('DRA', 50024), 
('DRA', 50025), ('ROM', 50025), ('THR', 50025), 
('ANI', 50026), ('ADV', 50026), ('COM', 50026), 
('COM', 50027),
('DRA', 50028),
('BIO', 50029), ('COM', 50029), ('DRA', 50029), 
('DRA', 50030), ('ROM', 50030), ('THR', 50030), 
('ACT', 50031), ('ADV', 50031), ('SCI', 50031), 
('ANI', 50032), ('ADV', 50032), ('COM', 50032), 
('ACT', 50033), ('DRA', 50033), 
('DRA', 50034)


go
-- insert values in table topBilledCast
INSERT topBilledCast
                Values
				(1000,50000),(1001,50000),(1002,50000),
				(1003,50001),(1004,50001),(1005,50001),
				(1006,50002),(1007,50002),(1008,50002),
				(1009,50003),(1010,50003),(1011,50003),
				(1012,50004),(1013,50004),(1014,50004),
				(1015,50005),(1016,50005),(1017,50005),
				(1018,50006),(1019,50006),(1020,50006),
				(1021,50007),(1022,50007),(1023,50007),
				(1024,50008),(1025,50008),(1026,50008),
				(1027,50009),(1028,50009),(1029,50009),
				(1030,50010),(1031,50010),(1032,50010),
				(1033,50011),(1034,50011),(1035,50011),
				(1036,50012),(1037,50012),(1038,50012),
				(1039,50013),(1040,50013),(1041,50013),
				(1042,50014),(1043,50014),(1044,50014),
				(1045,50015),(1046,50015),(1047,50015),
				(1048,50016),(1049,50016),(1050,50016),
				(1051,50017),(1052,50017),(1053,50017),
				(1054,50018),(1055,50018),(1056,50018),
				(1057,50019),(1058,50019),(1059,50019),
				(1060,50020),(1061,50020),(1062,50020),
				(1063,50021),(1064,50021),(1065,50021),
				(1066,50022),(1067,50022),(1068,50022),
				(1069,50023),(1070,50023),(1071,50023),
				(1072,50024),(1073,50024),(1074,50024),
				(1075,50025),(1076,50025),(1077,50025),
				(1078,50026),(1079,50026),(1080,50026),
				(1081,50027),(1082,50027),(1083,50027),
				(1084,50028),(1085,50028),(1086,50028),
				(1087,50029),(1088,50029),(1089,50029),
				(1090,50030),(1091,50030),(1092,50030),
				(1093,50031),(1094,50031),(1095,50031),
				(1096,50032),(1097,50032),(1098,50032),
				(1099,50033),(1100,50033),(1101,50033),
				(1102,50034),(1103,50034),(1104,50034)

go

-- insert values in table usa
INSERT usa
Values
(10000,'67,745,330'),
(10001,'28,780,744'),
(10002,'n/a'),
(10003,'36,343,858'),
(10004,'40,891,591'),
(10005,'20,868,638'),
(10006,'81,903,458'),
(10007,'n/a'),
(10008,'18,216'),
(10009,'1,000,038'),
(10010,'65,410'),
(10011,'45,819,713'),
(10012,'44,947,622'),
(10013,'16,376,066'),
(10014,'2,418,404'),
(10015,'n/a'),
(10016,'11,846,060'),
(10017,'29,819,114'),
(10018,'58,032,443'),
(10019,'12,965'),
(10020,'9,868'),
(10021,'25,091,816'),
(10022,'2,027'),
(10023,'2,019,554'),
(10024,'36,276,286'),
(10025,'100,407,760'),
(10026,'115,234,093'),
(10027,'16,273'),
(10028,'37,801'),
(10029,'1,662,927'),
(10030,'167,093'),
(10031,'700,059,566'),
(10032,'8,267,544'),
(10033,'4,719,928'),
(10034,'564,073')


go

-- insert values in table overseas
INSERT overseas
VALUES
(10000, '100,140,258'),
(10001, '24,516,101'),
(10002, '95,743'),
(10003, '65,641,573'),
(10004, '152,704,112'),
(10005, '840,901'),
(10006, '97,845,422'),
(10007, '1,266,769'),
(10008, '961'),
(10009, '2,264,873'),
(10010, '12,886'),
(10011, '25,298,665'),
(10012, '34,475,295'),
(10013, 'n/a'),
(10014, '39,543,806'),
(10015, '131,935'),
(10016, '62,784,891'),
(10017, '5,663,787'),
(10018, '207,846,093'),
(10019, 'n/a'),
(10020, '394,488'),
(10021, '19,286,224'),
(10022, 'n/a'),
(10023, '1,710,922'),
(10024, '19,819,914'),
(10025, '270,942,859'),
(10026, '231,900,455'),
(10027, 'n/a'),
(10028, 'n/a'),
(10029, '27,220,485'),
(10030, '4,721,312'),
(10031, '648,207,359'),
(10032, '37,018,346'),
(10033, '127,223'),
(10034, '4,255,436')

go

-- insert values in table digital
INSERT digital
VALUES
(10000, '3,543,980'),
(10001, '2,315,108'),
(10002, '93,378'),
(10003, '7,086,006'),
(10004, '5,712,811'),
(10005, '2,486,517'),
(10006, '6,159,026'),
(10007, '1,266,769'),
(10008, 'n/a'),
(10009, '72,927'),
(10010, 'n/a'),
(10011, '10,731,461'),
(10012, '6,270,724'),
(10013, '4,155,412'),
(10014, '1,315,992'),
(10015, '1,590,911'),
(10016, 'n/a'),
(10017, '5,468,131'),
(10018, '11,467,855'),
(10019, '20,581'),
(10020, '105,500'),
(10021, '3,865,376'),
(10022, 'n/a'),
(10023, '33,264'),
(10024, '3,110,781'),
(10025, '28,082,818'),
(10026, '18,376,411'),
(10027, '11,983'),
(10028, 'n/a'),
(10029, 'n/a'),
(10030, '76,480'),
(10031, '91,704,544'),
(10032, '1,916,883'),
(10033, '1,292,095'),
(10034, '50,626')

go