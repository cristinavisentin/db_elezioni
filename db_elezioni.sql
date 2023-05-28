CREATE DATABASE db_elezioni;

USE db_elezioni;

SET FOREIGN_KEY_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 1;


########################################### TABELLA ELEZIONE ############################################
CREATE TABLE elezione(
	Legislatura INT(2) PRIMARY KEY AUTO_INCREMENT,
    AnnoSvolgimento YEAR NOT NULL,
    DataEffettiva DATE
);

INSERT INTO elezione(AnnoSvolgimento, DataEffettiva) VALUES(1948, "1948-04-18"), (1953, "1953-06-07"), (1958, "1958-05-25"), 
	(1963, "1963-04-28"), (1968, "1968-05-19"), (1973, "1972-05-07"), (1977, "1976-06-20"),
    (1981, "1979-06-03"), (1984, "1983-06-26"), (1988, "1987-06-15");
INSERT INTO elezione(AnnoSvolgimento, DataEffettiva) VALUES(1992, "1992-04-05"), (1997, "1994-03-27"), (1999, "1996-04-21"),
	(2001, "2001-05-13"), (2006, "2006-04-09"), (2011, "2008-04-13"), (2013, "2013-02-24"),
    (2018, "2018-03-04"), (2023, "2022-09-25");

SELECT * FROM elezione;


########################################### TABELLA VOTANTE ###########################################
CREATE TABLE votante(
	CF CHAR(16) PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    Cognome VARCHAR(45) NOT NULL,
    DataDiNascita DATE NOT NULL,
    Genere CHAR(1) NOT NULL,
    Città INT NOT NULL,
    Seggio INT(4), 
    FOREIGN KEY (città) REFERENCES città(ID),
    FOREIGN KEY (seggio) REFERENCES seggio(codice)
);

INSERT INTO votante VALUES("VSNCST30D52L424A", "Cristina", "Visentin", "1930-04-12", "F", 34100, 1), 
    ("ASNCST29D52L424A", "Andrea", "Visentin", "1929-03-15", "M", 34100, 1),
    ("GSNCST21D52L424A", "Giulia", "Melis", "1921-07-22", "F", 34100, 2),
    ("MSNCST43D52L424A", "Maya", "Visentin", "1943-03-01", "F", 34101, 3),
    ("BSNCST33D52L424A", "Mario", "Rossi", "1933-05-12", "M", 44101, 7),
    ("CSNCST19D52L424A", "Pino", "Abete", "1919-04-11", "M", 34103, 4);
INSERT INTO votante VALUES("SSNCST40D52L424A", "CAio", "bsi", "1940-04-11", "M", 54101, 1);  
INSERT INTO votante VALUES("WSNCST11D52L424A", "Marianna", "Visentin", "2011-04-12", "F", 34100, NULL);
INSERT INTO votante VALUES("ZSNCST04D52L424A", "Margherita", "Visentin", "2004-04-12", "F", 34100, 7);
INSERT INTO votante VALUES("ESNCST04D52L424A", "Elena", "Visentin", "2004-04-12", "F", 34100, 7);
INSERT INTO votante VALUES("ENNCST04D52L424A", "Francesco", "Visentin", "2004-06-12", "M", 00101, 3);
INSERT INTO votante VALUES("FNNCST56D52L424A", "Elio", "Visentin", "1956-06-12", "M", 34106, 1);
INSERT INTO votante VALUES("ONNCST35D52L424A", "Elsa", "Visentin", "1935-06-12", "F", 34100, 2);
INSERT INTO votante VALUES("INNCST80D52L424A", "Ida", "Blin", "1980-06-12", "F", 34103, 7);
INSERT INTO votante VALUES("RNNCST22D52L424A", "Marina", "Blin", "2022-06-19", "F", 34103, NULL);
INSERT INTO votante VALUES("PNNCST14D52L424A", "Sam", "Flin", "2014-06-12", "M", 34100, NULL);
INSERT INTO votante VALUES("PPNCST76D52L424A", "Sam", "Flonn", "1976-06-12", "M", 64101, 6);
INSERT INTO votante VALUES("VPNCST83D52L424A", "Samantah", "Flonn", "1983-07-12", "F", 64101, 7);

SELECT * FROM votante;


########################################### TABELLA PARTECIPAZIONE ###########################################
CREATE TABLE partecipazione(
	Elezione INT(2),
    Votante CHAR(16), 
    Espressione VARCHAR(45),
    Orario TIME,
    PRIMARY KEY (elezione, votante),
    FOREIGN KEY (elezione) REFERENCES elezione(legislatura),
    FOREIGN KEY (votante) REFERENCES votante(cf)
);

INSERT INTO partecipazione VALUES(10, "VSNCST30D52L424A", "Votato", "19:05:00"),(9, "VSNCST30D52L424A", "Votato", "20:05:00"),
	(8, "VSNCST30D52L424A", "Votato", "19:04:00"), (7, "VSNCST30D52L424A", "Votato", "9:05:00"), (6, "VSNCST30D52L424A", "Votato", "07:05:00"),
    (5, "VSNCST30D52L424A", NULL, NULL), (4, "VSNCST30D52L424A", NULL, NULL), (3, "VSNCST30D52L424A", NULL, NULL), 
    (2, "VSNCST30D52L424A", NULL, NULL), (1, "VSNCST30D52L424A", NULL, NULL);
INSERT INTO partecipazione VALUES(11, "VSNCST30D52L424A", "Votato", "19:20:00"), (12, "VSNCST30D52L424A", "Votato", "21:20:00"),
	(13, "VSNCST30D52L424A", "Votato", "12:20:00"), (14, "VSNCST30D52L424A", "Votato", "22:20:00"), (15, "VSNCST30D52L424A", "Votato", "13:20:00"),
    (16, "VSNCST30D52L424A", NULL, NULL);
    
INSERT INTO partecipazione VALUES(8, "GSNCST21D52L424A", "Votato", "13:05:00"), (9, "GSNCST21D52L424A", "Votato", "14:05:00"), 
	(10, "GSNCST21D52L424A", "Votato", "19:05:00"), (7, "GSNCST21D52L424A", "Votato", "22:05:00"), (6, "GSNCST21D52L424A", "Votato", "22:57:00"),
    (5, "GSNCST21D52L424A", "Votato", "15:05:00"), (4, "GSNCST21D52L424A", "Votato", "11:05:00"), (3, "GSNCST21D52L424A", NULL, NULL),
    (2, "GSNCST21D52L424A", NULL, NULL), (1, "GSNCST21D52L424A", NULL, NULL);
INSERT INTO partecipazione VALUES(11, "GSNCST21D52L424A", "Votato", "18:20:00"), (12, "GSNCST21D52L424A", "Votato", "21:20:00"),
	(13, "GSNCST21D52L424A", "Votato", "14:20:00"), (14, "GSNCST21D52L424A", "Votato", "10:20:09");
    
INSERT INTO partecipazione VALUES(3, "ASNCST29D52L424A", "Votato", "11:05:00"),
    (2, "ASNCST29D52L424A", "Votato", "19:10:00"), (1, "ASNCST29D52L424A", "Votato", "12:05:00"), (8, "ASNCST29D52L424A", "Votato", "20:05:00"),
    (4, "ASNCST29D52L424A", "Votato", "21:30:00"), (5, "ASNCST29D52L424A", "Votato", "10:05:00"), (6, "ASNCST29D52L424A", "Votato", "17:22:00"),
    (7, "ASNCST29D52L424A", "Votato", "14:05:00"), (9, "ASNCST29D52L424A", NULL, NULL), (10, "ASNCST29D52L424A", "Votato", "13:05:00");
INSERT INTO partecipazione VALUES(11, "ASNCST29D52L424A", "Votato", "09:20:00"), (12, "ASNCST29D52L424A", "Votato", "16:20:00"),
	(13, "ASNCST29D52L424A", "Votato", "15:20:00"), (14, "ASNCST29D52L424A", NULL, NULL);

INSERT INTO partecipazione VALUES(10, "MSNCST43D52L424A", "Votato", "13:05:00"),(9, "MSNCST43D52L424A", "Votato", "08:45:00"),
	(8, "MSNCST43D52L424A", NULL, NULL), (7, "MSNCST43D52L424A", "Votato", "18:05:00"), (6, "MSNCST43D52L424A", "Votato", "07:05:00"),
    (5, "MSNCST43D52L424A", NULL, NULL), (4, "MSNCST43D52L424A", NULL, NULL);
INSERT INTO partecipazione VALUES(11, "MSNCST43D52L424A", "Votato", "19:20:00"), (12, "MSNCST43D52L424A", "Votato", "21:20:00"),
	(13, "MSNCST43D52L424A", NULL, NULL), (14, "MSNCST43D52L424A", "Votato", "22:20:00"), (15, "MSNCST43D52L424A", "Votato", "13:20:00"),
    (16, "MSNCST43D52L424A", NULL, NULL), (17, "MSNCST43D52L424A", NULL, NULL);

INSERT INTO partecipazione VALUES(10, "SSNCST40D52L424A", NULL, NULL),(9, "SSNCST40D52L424A", "Votato", "20:05:00"),
	(8, "SSNCST40D52L424A", "Votato", "18:05:00"), (7, "SSNCST40D52L424A", "Votato", "09:05:00"), (6, "SSNCST40D52L424A", "Votato", "22:05:00"),
    (5, "SSNCST40D52L424A", NULL, NULL), (4, "SSNCST40D52L424A", "Votato", "13:05:00"), (3, "SSNCST40D52L424A", NULL, NULL);
INSERT INTO partecipazione VALUES(11, "SSNCST40D52L424A", "Votato", "10:20:00"), (12, "SSNCST40D52L424A", "Votato", "21:20:00"),
	(13, "SSNCST40D52L424A", NULL, NULL), (14, "SSNCST40D52L424A", NULL, NULL), (15, "SSNCST40D52L424A", "Votato", "13:20:00"),
    (16, "SSNCST40D52L424A", NULL, NULL), (17, "SSNCST40D52L424A", "Votato", "11:20:00"), (18, "SSNCST40D52L424A", "Votato", "07:20:00");

INSERT INTO partecipazione VALUES(10, "BSNCST33D52L424A", "Votato", "08:05:00"),(9, "BSNCST33D52L424A", "Votato", "09:05:00"),
	(8, "BSNCST33D52L424A", "Votato", "09:05:00"), (7, "BSNCST33D52L424A", "Votato", "21:05:00"), (6, "BSNCST33D52L424A", "Votato", "15:05:00"),
    (5, "BSNCST33D52L424A", NULL, NULL), (4, "BSNCST33D52L424A", "Votato", "19:05:00");
INSERT INTO partecipazione VALUES(11, "BSNCST33D52L424A", "Votato", "19:20:00"), (12, "BSNCST33D52L424A", "Votato", "21:20:00"),
	(13, "BSNCST33D52L424A", "Votato", "12:20:00"), (14, "BSNCST33D52L424A", "Votato", "22:20:00"), (15, "BSNCST33D52L424A", "Votato", "13:20:00"),
    (16, "BSNCST33D52L424A", NULL, NULL), (17, "BSNCST33D52L424A", "Votato", "13:20:00"), (18, "BSNCST33D52L424A", "Votato", "08:20:00");

INSERT INTO partecipazione VALUES(10, "CSNCST19D52L424A", "Votato", "16:05:00"),(9, "CSNCST19D52L424A", "Votato", "09:05:00"),
	(8, "CSNCST19D52L424A", "Votato", "20:05:00"), (7, "CSNCST19D52L424A", "Votato", "21:05:00"), (6, "CSNCST19D52L424A", "Votato", "13:05:00"),
    (5, "CSNCST19D52L424A", NULL, NULL), (4, "CSNCST19D52L424A", "Votato", "07:05:00"), (3, "CSNCST19D52L424A", "Votato", "09:05:00"), 
    (2, "CSNCST19D52L424A", "Votato", "12:05:00"), (1, "CSNCST19D52L424A", "Votato", "11:05:00");

INSERT INTO partecipazione VALUES(19, "ZSNCST04D52L424A", "Votato", "07:05:00");
INSERT INTO partecipazione VALUES(19, "ESNCST04D52L424A", "Votato", "07:08:00");
INSERT INTO partecipazione VALUES(19, "EENCST04D52L424A", "Votato", "19:05:00");

INSERT INTO partecipazione VALUES(19, "VPNCST83D52L424A", "Votato", "20:00:00"), 
	(18, "VPNCST83D52L424A", "Votato", "20:00:00"), (17, "VPNCST83D52L424A", "Votato", "20:00:00"),
    (16, "VPNCST83D52L424A", NULL, NULL), (15, "VPNCST83D52L424A", NULL, NULL), (14, "VPNCST83D52L424A", NULL, NULL);
    
INSERT INTO partecipazione VALUES(19, "PPNCST76D52L424A", "Votato", "20:00:00"), 
	(18, "PPNCST76D52L424A", "Votato", "20:00:00"), (17, "PPNCST76D52L424A", "Votato", "20:00:00"),
    (16, "PPNCST76D52L424A", NULL, NULL), (15, "PPNCST76D52L424A", NULL, NULL), (14, "PPNCST76D52L424A", NULL, NULL),
    (13, "PPNCST76D52L424A", NULL, NULL), (12, "PPNCST76D52L424A", NULL, NULL); 
    
INSERT INTO partecipazione VALUES(19, "INNCST80D52L424A", "Votato", "20:00:00"), 
	(18, "INNCST80D52L424A", "Votato", "20:00:00"), (17, "INNCST80D52L424A", "Votato", "20:00:00"),
    (16, "INNCST80D52L424A", NULL, NULL), (15, "INNCST80D52L424A", NULL, NULL), (14, "INNCST80D52L424A", NULL, NULL);

INSERT INTO partecipazione VALUES(10, "FNNCST56D52L424A", "Votato", "22:05:00"),(9, "FNNCST56D52L424A", "Votato", "16:05:00"),
	(8, "FNNCST56D52L424A", "Votato", "16:04:00"), (7, "FNNCST56D52L424A", NULL, NULL);
INSERT INTO partecipazione VALUES(11, "FNNCST56D52L424A", "Votato", "19:20:00"), (12, "FNNCST56D52L424A", "Votato", "21:20:00"),
	(13, "FNNCST56D52L424A", "Votato", "12:20:00"), (14, "FNNCST56D52L424A", "Votato", "22:20:00"), (15, "FNNCST56D52L424A", "Votato", "13:20:00"),
    (16, "FNNCST56D52L424A", "Votato", "12:20:00"), (17, "FNNCST56D52L424A", "Votato", "18:20:00"), (18, "FNNCST56D52L424A", "Votato", "10:20:00"),
    (19, "FNNCST56D52L424A", "Votato", "09:20:00");
    
INSERT INTO partecipazione VALUES(10, "ONNCST35D52L424A", "Votato", "22:05:00"),(9, "ONNCST35D52L424A", "Votato", "16:05:00"),
	(8, "ONNCST35D52L424A", "Votato", "16:04:00"), (7, "ONNCST35D52L424A", NULL, NULL), (6, "ONNCST35D52L424A", "Votato", "16:05:00"),
    (5, "ONNCST35D52L424A", "Votato", "07:04:00"), (4, "ONNCST35D52L424A", "Votato", "09:04:00"), (3, "ONNCST35D52L424A", "Votato", "12:04:00");
INSERT INTO partecipazione VALUES(11, "ONNCST35D52L424A", "Votato", "19:20:00"), (12, "ONNCST35D52L424A", "Votato", "21:20:00"),
	(13, "ONNCST35D52L424A", NULL, NULL), (14, "ONNCST35D52L424A", NULL, NULL), (15, "ONNCST35D52L424A", NULL, NULL),
    (16, "ONNCST35D52L424A", "Votato", "19:20:00");

SELECT * FROM partecipazione;


########################################### TABELLA CITTÀ ###########################################
CREATE TABLE città(
	ID INT PRIMARY KEY,
	CAP INT(5) NOT NULL,
	Nome VARCHAR(45) NOT NULL,
    Regione VARCHAR(45),
    Nazione VARCHAR(45) NOT NULL
);

INSERT INTO città VALUES(34100, 34100, "Trieste", "FVG", "Italia");
INSERT INTO città VALUES(00101, 00101, "Lisbona", NULL, "Portogallo");
INSERT INTO città VALUES(34101, 34101, "Padova", "Veneto", "Italia");
INSERT INTO città VALUES(34102, 34102, "Venezia", "Veneto", "Italia");
INSERT INTO città VALUES(44101, 44101, "Vilnius", NULL, "Lituania");
INSERT INTO città VALUES(54101, 54101, "Barcelona", NULL, "Spagna");
INSERT INTO città VALUES(34103, 34103, "Cagliari", "Sardegna", "Italia");
INSERT INTO città VALUES(34104, 34104, "Udine", "FVG", "Italia");
INSERT INTO città VALUES(34105, 34105, "Pordenone", "FVG", "Italia");
INSERT INTO città VALUES(34150, 34150, "Bologna", "Emilia-Romagna", "Italia");
INSERT INTO città VALUES(34106, 34100, "Milano", "Lombardia", "Italia");
INSERT INTO città VALUES(64101, 64101, "Berlino", NULL, "Germania");

SELECT * FROM città;


########################################### TABELLA SEGGIO ###########################################
CREATE TABLE seggio(
	Codice INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(45) NOT NULL, 
    Tipo VARCHAR(45) NOT NULL
);

INSERT INTO seggio(nome, tipo) VALUES("pinco1", "fisico"), ("pinco2", "virtuale"), ("pallo", "fisico"),
	("zio", "virtuale"), ("scuola", "fisico"), ("scuolamaterna1", "fisico"),
    ("posta", "virtuale");
    
SELECT * FROM seggio;


########################################### TABELLA DICHIARAZIONE ###########################################
CREATE TABLE dichiarazione(
	Elezione INT(2),
	Codice INT NOT NULL,
    Votante CHAR(16),
    Orario TIME NOT  NULL,
    Descrizione VARCHAR(45), #CI ANDREBBE TESTO PIÙ LUNGO E SALVATO A PARTE
    PRIMARY KEY (elezione, votante),
    FOREIGN KEY (votante) REFERENCES votante(cf),
    FOREIGN KEY (elezione) REFERENCES elezione(legislatura)
);

INSERT INTO dichiarazione VALUES(1, 1234567, "VSNCST30D52L424A", "9:06:00", "SPERIAMO BENE"); 
INSERT INTO dichiarazione VALUES(2, 4234567, "MSNCST43D52L424A", "19:06:00", "gne"); 
INSERT INTO dichiarazione VALUES(3, 5234567, "VSNCST30D52L424A", "9:07:00", "ciaone"); 
INSERT INTO dichiarazione VALUES(4, 6234567, "GSNCST21D52L424A", "19:06:00", "gnegne"); 

SELECT * FROM dichiarazione;


########################################### TABELLA SCHEDA ###########################################
CREATE TABLE scheda(
	Numero INT(11) PRIMARY KEY AUTO_INCREMENT,
    Tipo VARCHAR(45) NOT NULL,
    Validità BOOL NOT NULL,
    Elezione INT(2),
    Seggio INT NOT NULL,
    FOREIGN KEY (elezione) REFERENCES elezione(legislatura),
    FOREIGN KEY (seggio) REFERENCES seggio(codice)
); 

INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 10, 1), ("Senato", TRUE, 10, 1), ("Senato", TRUE, 10, 1),
	("Senato", TRUE, 10, 2), ("Senato", FALSE, 10, 3), ("Senato", FALSE, 10, 4), ("Senato", FALSE, 10, 5), ("Camera", FALSE, 10, 6),
    ("Camera", TRUE, 10, 7), ("Camera", TRUE, 10, 7), ("Camera", TRUE, 10, 7), ("Camera", TRUE, 10, 2), ("Senato", FALSE, 10, 5),
	("Camera", TRUE, 10, 6), ("Camera", TRUE, 10, 7), ("Camera", TRUE, 10, 7);

INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 9, 1), ("Senato", TRUE, 9, 2), ("Senato", TRUE, 9, 4),
	("Senato", TRUE, 9, 6), ("Senato", FALSE, 9, 6), ("Senato", FALSE, 9, 6), ("Senato", FALSE, 9, 6), ("Camera", FALSE, 9, 7),
    ("Camera", TRUE, 9, 6), ("Camera", TRUE, 9, 3), ("Camera", TRUE, 9, 2), ("Camera", TRUE, 9, 2), ("Camera", TRUE, 9, 1), 
    ("Camera", TRUE, 9, 5), ("Senato", FALSE, 9, 6), ("Camera", TRUE, 9, 1);
    
INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 8, 2), ("Senato", TRUE, 8, 2), ("Senato", TRUE, 8, 5),
	("Senato", FALSE, 8, 4), ("Senato", FALSE, 8, 6), ("Senato", FALSE, 8, 7), ("Senato", FALSE, 8, 1), ("Camera", FALSE, 8, 3),
    ("Camera", FALSE, 8, 7), ("Camera", FALSE, 8, 3), ("Camera", TRUE, 8, 2), ("Camera", TRUE, 8, 6), ("Camera", TRUE, 8, 3), 
    ("Camera", TRUE, 8, 5), ("Senato", TRUE, 8, 1), ("Camera", TRUE, 8, 5);

INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 7, 2), ("Senato", TRUE, 7, 1), ("Senato", TRUE, 7, 4),
	("Senato", TRUE, 7, 3), ("Senato", FALSE, 7, 3), ("Senato", TRUE, 7, 5), ("Senato", TRUE, 7, 4), ("Camera", FALSE, 7, 1),
    ("Camera", TRUE, 7, 1), ("Camera", TRUE, 7, 6), ("Camera", TRUE, 7, 5), ("Camera", TRUE, 7, 3), ("Camera", TRUE, 7, 6),
    ("Camera", TRUE, 7, 6);
    
INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 6, 1), ("Senato", TRUE, 6, 3), ("Senato", TRUE, 6, 3),
	("Senato", TRUE, 6, 2), ("Senato", FALSE, 6, 3), ("Senato", TRUE, 6, 4), ("Senato", TRUE, 6, 5), ("Camera", FALSE, 6, 6),
    ("Camera", TRUE, 6, 2), ("Camera", TRUE, 6, 4), ("Camera", TRUE, 6, 1), ("Camera", TRUE, 6, 5), ("Senato", TRUE, 6, 7),
    ("Camera", TRUE, 6, 2), ("Camera", TRUE, 6, 3), ("Camera", TRUE, 6, 2);
    
INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 5, 2), ("Senato", TRUE, 5, 5), ("Senato", FALSE, 5, 6), 
    ("Camera", TRUE, 5, 7), ("Camera", TRUE, 5, 6), ("Camera", TRUE, 5, 5);
    
INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 4, 4), ("Senato", TRUE, 4, 5),
	("Senato", TRUE, 4, 3), ("Senato", FALSE, 4, 2), ("Senato", FALSE, 4, 1), ("Senato", FALSE, 4, 6), ("Camera", FALSE, 4, 7),
    ("Camera", TRUE, 4, 3), ("Camera", TRUE, 4, 1), ("Camera", TRUE, 4, 5), ("Camera", TRUE, 4, 5), ("Camera", TRUE, 4, 5);

INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", FALSE, 3, 3), ("Senato", TRUE, 3, 2), ("Senato", TRUE, 3, 1),
	("Camera", FALSE, 3, 4), ("Camera", TRUE, 3, 3), ("Camera", TRUE, 3, 7);
    
INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 2, 3), ("Senato", TRUE, 2, 2),
	("Camera", FALSE, 2, 5), ("Camera", TRUE, 2, 2);

INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 1, 1), ("Senato", TRUE, 1, 2), 
	("Camera", FALSE, 1, 4), ("Camera", TRUE, 1, 5);
    
INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 11, 1), ("Senato", TRUE, 11, 1), ("Senato", TRUE, 11, 1),
	("Senato", TRUE, 11, 2), ("Senato", FALSE, 11, 2), ("Senato", TRUE, 11, 4), ("Senato", FALSE, 11, 5), ("Camera", TRUE, 11, 6),
    ("Camera", TRUE, 11, 7), ("Camera", TRUE, 11, 7), ("Camera", TRUE, 11, 7), ("Camera", TRUE, 11, 2), ("Senato", FALSE, 11, 5),
	("Camera", TRUE, 11, 6), ("Camera", TRUE, 11, 7), ("Camera", TRUE, 11, 7);
    
INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 12, 1), ("Senato", TRUE, 12, 1), ("Senato", FALSE, 12, 1),
	("Senato", TRUE, 12, 2), ("Senato", TRUE, 12, 1), ("Senato", TRUE, 12, 4), ("Senato", FALSE, 12, 5), ("Camera", FALSE, 12, 6),
    ("Camera", TRUE, 12, 7), ("Camera", TRUE, 12, 7), ("Camera", TRUE, 12, 7), ("Camera", TRUE, 12, 2), ("Senato", FALSE, 12, 5),
	("Camera", TRUE, 12, 6), ("Camera", TRUE, 12, 7), ("Camera", TRUE, 12, 7);
    
INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 13, 1), ("Senato", TRUE, 13, 1), ("Senato", TRUE, 13, 1),
	("Senato", TRUE, 13, 2), ("Senato", FALSE, 13, 3), ("Camera", FALSE, 13, 6),
    ("Camera", TRUE, 13, 7), ("Camera", TRUE, 13, 7), 
	("Camera", TRUE, 13, 6), ("Camera", TRUE, 13, 7);

INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 14, 1), ("Senato", TRUE, 14, 1), ("Senato", TRUE, 14, 2),
	("Senato", TRUE, 14, 2), ("Senato", TRUE, 14, 3), ("Camera", TRUE, 14, 2),
    ("Camera", TRUE, 14, 7), ("Camera", TRUE, 14, 1), 
	("Camera", TRUE, 14, 6), ("Camera", TRUE, 14, 7);
    
INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 15, 1), ("Senato", TRUE, 15, 1), ("Senato", TRUE, 15, 2),
	("Senato", TRUE, 15, 2), ("Senato", TRUE, 15, 3), ("Camera", TRUE, 15, 3),
    ("Camera", TRUE, 15, 3), ("Camera", TRUE, 15, 1), 
	("Camera", TRUE, 15, 6), ("Camera", TRUE, 15, 3);
    
INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 16, 2), ("Senato", TRUE, 16, 6), 
    ("Camera", TRUE, 16, 7), ("Camera", TRUE, 16, 1);
    
INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 17, 3), ("Senato", TRUE, 17, 2), ("Senato", TRUE, 17, 1),
	("Camera", FALSE, 17, 4), ("Camera", TRUE, 17, 3), ("Camera", TRUE, 17, 7),
	("Camera", TRUE, 17, 2), ("Camera", TRUE, 17, 1), ("Camera", TRUE, 17, 5),
    ("Senato", TRUE, 17, 2), ("Senato", TRUE, 17, 2), ("Senato", TRUE, 17, 1);

INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", TRUE, 18, 5), ("Senato", FALSE, 18, 4), ("Senato", TRUE, 18, 5),
	("Camera", FALSE, 18, 4), ("Camera", TRUE, 18, 3), ("Camera", FALSE, 18, 7),
    ("Camera", FALSE, 18, 1), ("Camera", TRUE, 18, 3), ("Camera", TRUE, 18, 1),
    ("Senato", TRUE, 18, 5), ("Senato", FALSE, 18, 4), ("Senato", FALSE, 18, 2);

INSERT INTO scheda(tipo, validità, elezione, seggio) VALUES("Senato", FALSE, 19, 3), ("Camera", TRUE, 19, 7),
	("Senato", TRUE, 19, 4), ("Camera", TRUE, 19, 1), ("Senato", TRUE, 19, 5), ("Camera", TRUE, 19, 5),
	("Senato", TRUE, 19, 5), ("Camera", TRUE, 19, 4), ("Senato", FALSE, 19, 1), ("Camera", TRUE, 19, 5),
    ("Senato", TRUE, 19, 5), ("Camera", TRUE, 19, 5);
    
SELECT * FROM scheda;


########################################### TABELLA VOTO ###########################################
CREATE TABLE voto(
	Scheda INT(11) PRIMARY KEY,
    Partito VARCHAR(45) NOT NULL,
    Candidato VARCHAR(45),
    FOREIGN KEY (Scheda) REFERENCES scheda(numero)
);

INSERT INTO voto VALUES(1, "Sinistra", "Pluto");
INSERT INTO voto VALUES(2, "Sinistra", "Pluto");
INSERT INTO voto VALUES(3, "Sinistra", "Pluto");
INSERT INTO voto VALUES(4, "Sinistra", "Pluto");
INSERT INTO voto VALUES(9, "Sinistra", "Pluto");
INSERT INTO voto VALUES(10, "Sinistra", "Pippo");
INSERT INTO voto VALUES(11, "Sinistra", "Pippo");
INSERT INTO voto VALUES(12, "Sinistra", "Pippo");
INSERT INTO voto VALUES(14, "Sinistra", "Pippo");
INSERT INTO voto VALUES(15, "Sinistra", "Pippo");
INSERT INTO voto VALUES(16, "Sinistra", "Pippo");
INSERT INTO voto VALUES(17, "Sinistra", "Pippo");
INSERT INTO voto VALUES(18, "Sinistra", "Pippo");
INSERT INTO voto VALUES(19, "Sinistra", "Pippo");
INSERT INTO voto VALUES(20, "Sinistra", NULL);
INSERT INTO voto VALUES(25, "Sinistra", NULL);
INSERT INTO voto VALUES(26, "Sinistra", NULL);
INSERT INTO voto VALUES(27, "Sinistra", NULL);
INSERT INTO voto VALUES(28, "Sinistra", NULL);
INSERT INTO voto VALUES(29, "Sinistra", NULL);
INSERT INTO voto VALUES(30, "Sinistra", NULL);
INSERT INTO voto VALUES(32, "Sinistra", NULL);
INSERT INTO voto VALUES(33, "Sinistra", NULL);
INSERT INTO voto VALUES(34, "Sinistra", NULL);
INSERT INTO voto VALUES(35, "Sinistra", NULL);
INSERT INTO voto VALUES(43, "Sinistra", NULL);
INSERT INTO voto VALUES(44, "Sinistra", NULL);
INSERT INTO voto VALUES(45, "Sinistra", NULL);
INSERT INTO voto VALUES(46, "Sinistra", NULL);
INSERT INTO voto VALUES(47, "Sinistra", NULL);
INSERT INTO voto VALUES(48, "Sinistra", NULL);
INSERT INTO voto VALUES(49, "Destra", NULL);
INSERT INTO voto VALUES(50, "Destra", NULL);
INSERT INTO voto VALUES(51, "Sinistra", NULL);
INSERT INTO voto VALUES(52, "Destra", NULL);
INSERT INTO voto VALUES(54, "Sinistra", NULL);
INSERT INTO voto VALUES(55, "Destra", NULL);
INSERT INTO voto VALUES(57, "Destra", NULL);
INSERT INTO voto VALUES(58, "Centro", NULL);
INSERT INTO voto VALUES(59, "Centro", NULL);
INSERT INTO voto VALUES(60, "Centro", NULL);
INSERT INTO voto VALUES(61, "Centro", "Pallo");
INSERT INTO voto VALUES(62, "Centro", "Pallo");
INSERT INTO voto VALUES(63, "Centro", "Pallo");
INSERT INTO voto VALUES(64, "Destra", NULL);
INSERT INTO voto VALUES(65, "Centro", NULL);
INSERT INTO voto VALUES(66, "Centro", NULL);
INSERT INTO voto VALUES(68, "Centro", NULL);
INSERT INTO voto VALUES(69, "Centro", "Pallo");
INSERT INTO voto VALUES(71, "Centro", "Pallo");
INSERT INTO voto VALUES(72, "Sinistra", NULL);
INSERT INTO voto VALUES(73, "Destra", NULL);
INSERT INTO voto VALUES(74, "Sinistra", NULL);
INSERT INTO voto VALUES(75, "Destra", NULL);
INSERT INTO voto VALUES(76, "Destra", NULL);
INSERT INTO voto VALUES(77, "Centro", NULL);
INSERT INTO voto VALUES(78, "Sinistra", "Pippo");
INSERT INTO voto VALUES(79, "Sinistra", NULL);
INSERT INTO voto VALUES(80, "Sinistra", NULL);
INSERT INTO voto VALUES(82, "Sinistra", NULL);
INSERT INTO voto VALUES(83, "Destra", NULL);
INSERT INTO voto VALUES(84, "Sinistra", NULL);
INSERT INTO voto VALUES(85, "Destra", NULL);
INSERT INTO voto VALUES(86, "Destra", NULL);
INSERT INTO voto VALUES(87, "Centro", NULL);
INSERT INTO voto VALUES(92, "Centro", NULL);
INSERT INTO voto VALUES(93, "Centro", NULL);
INSERT INTO voto VALUES(94, "Centro", "Pallo");
INSERT INTO voto VALUES(95, "Centro", "Pallo");
INSERT INTO voto VALUES(96, "Centro", "Pallo");
INSERT INTO voto VALUES(98, "Destra", NULL);
INSERT INTO voto VALUES(99, "Centro", NULL);
INSERT INTO voto VALUES(101, "Sinistra", NULL), (102, "Destra", NULL),
	(103, "Sinistra", NULL);
INSERT INTO voto VALUES(104, "Sinistra", NULL);
INSERT INTO voto VALUES(106, "Destra", NULL);
INSERT INTO voto VALUES(107, "Destra", NULL);
INSERT INTO voto VALUES(108, "Centro", NULL);
INSERT INTO voto VALUES(110, "Centro", NULL);
INSERT INTO voto VALUES(111, "Centro", NULL);
INSERT INTO voto VALUES(112, "Centro", "Pallo");
INSERT INTO voto VALUES(113, "Centro", "Pallo");
INSERT INTO voto VALUES(114, "Centro", "Pallo");
INSERT INTO voto VALUES(116, "Destra", NULL);
INSERT INTO voto VALUES(118, "Centro", NULL);
INSERT INTO voto VALUES(119, "Centro", NULL);
INSERT INTO voto VALUES(120, "Sinistra", "Pippo");
INSERT INTO voto VALUES(121, "Sinistra", "Pippo");
INSERT INTO voto VALUES(122, "Sinistra", "Pippo");
INSERT INTO voto VALUES(124, "Sinistra", NULL);
INSERT INTO voto VALUES(125, "Sinistra", NULL);
INSERT INTO voto VALUES(126, "Sinistra", NULL);
INSERT INTO voto VALUES(127, "Sinistra", NULL);
INSERT INTO voto VALUES(128, "Sinistra", "Pippo");
INSERT INTO voto VALUES(130, "Sinistra", "Pippo");
INSERT INTO voto VALUES(131, "Sinistra", "Pippo");
INSERT INTO voto VALUES(132, "Sinistra", NULL);
INSERT INTO voto VALUES(135, "Sinistra", NULL);
INSERT INTO voto VALUES(136, "Sinistra", NULL);
INSERT INTO voto VALUES(137, "Sinistra", NULL);
INSERT INTO voto VALUES(138, "Destra", NULL);
INSERT INTO voto VALUES(140, "Sinistra", NULL);
INSERT INTO voto VALUES(141, "Destra", NULL);
INSERT INTO voto VALUES(142, "Destra", NULL);
INSERT INTO voto VALUES(143, "Centro", NULL);
INSERT INTO voto VALUES(144, "Centro", NULL);
INSERT INTO voto VALUES(145, "Sinistra", NULL);
INSERT INTO voto VALUES(146, "Sinistra", NULL);
INSERT INTO voto VALUES(149, "Sinistra", NULL);
INSERT INTO voto VALUES(150, "Destra", NULL);
INSERT INTO voto VALUES(151, "Destra", NULL);
INSERT INTO voto VALUES(152, "Centro", NULL);
INSERT INTO voto VALUES(153, "Centro", NULL);
INSERT INTO voto VALUES(154, "Sinistra", NULL);
INSERT INTO voto VALUES(155, "Sinistra", NULL);
INSERT INTO voto VALUES(156, "Centro", NULL);
INSERT INTO voto VALUES(157, "Sinistra", NULL), (158, "Destra", NULL),
	(159, "Sinistra", NULL);
INSERT INTO voto VALUES(160, "Sinistra", NULL);
INSERT INTO voto VALUES(161, "Destra", NULL);
INSERT INTO voto VALUES(162, "Destra", NULL);
INSERT INTO voto VALUES(163, "Centro", NULL);
INSERT INTO voto VALUES(164, "Centro", NULL);
INSERT INTO voto VALUES(165, "Centro", NULL);
INSERT INTO voto VALUES(166, "Centro", NULL);
INSERT INTO voto VALUES(167, "Sinistra", "Pippo");
INSERT INTO voto VALUES(168, "Sinistra", NULL);
INSERT INTO voto VALUES(169, "Sinistra", NULL);
INSERT INTO voto VALUES(170, "Sinistra", NULL);
INSERT INTO voto VALUES(171, "Destra", NULL);
INSERT INTO voto VALUES(172, "Sinistra", NULL);
INSERT INTO voto VALUES(173, "Destra", NULL);
INSERT INTO voto VALUES(174, "Centro", NULL);
INSERT INTO voto VALUES(175, "Sinistra", "Pippo");
INSERT INTO voto VALUES(176, "Sinistra", NULL);
INSERT INTO voto VALUES(177, "Sinistra", NULL);
INSERT INTO voto VALUES(178, "Sinistra", NULL);
INSERT INTO voto VALUES(179, "Destra", NULL);
INSERT INTO voto VALUES(181, "Sinistra", NULL);
INSERT INTO voto VALUES(182, "Destra", NULL);
INSERT INTO voto VALUES(183, "Sinistra", NULL);
INSERT INTO voto VALUES(184, "Sinistra", NULL);
INSERT INTO voto VALUES(185, "Centro", NULL);
INSERT INTO voto VALUES(186, "Sinistra", NULL), (187, "Destra", NULL),
	(188, "Sinistra", NULL);
INSERT INTO voto VALUES(189, "Sinistra", NULL);
INSERT INTO voto VALUES(191, "Destra", NULL);
INSERT INTO voto VALUES(193, "Destra", NULL);
INSERT INTO voto VALUES(196, "Centro", NULL);
INSERT INTO voto VALUES(197, "Sinistra", "Pippo");
INSERT INTO voto VALUES(198, "Sinistra", "Pippo");
INSERT INTO voto VALUES(202, "Sinistra", "Pippo");
INSERT INTO voto VALUES(203, "Sinistra", NULL);
INSERT INTO voto VALUES(204, "Sinistra", NULL);
INSERT INTO voto VALUES(205, "Sinistra", "Pippo");
INSERT INTO voto VALUES(206, "Sinistra", "Pippo");
INSERT INTO voto VALUES(207, "Sinistra", "Pippo");
INSERT INTO voto VALUES(208, "Sinistra", NULL);
INSERT INTO voto VALUES(210, "Sinistra", NULL);
INSERT INTO voto VALUES(211, "Destra", NULL);
INSERT INTO voto VALUES(212, "Centro", NULL);

SELECT * FROM voto;


########################################### TABELLA SEZIONE ###########################################
CREATE TABLE sezione(
	Numero INT AUTO_INCREMENT,
    Seggio INT(4),
    PRIMARY KEY (Numero, Seggio),
    FOREIGN KEY (Seggio) REFERENCES seggio(codice)
);

INSERT INTO sezione(seggio) VALUES (6), (2), (4), (7), (2), (1), (3), (6), (5),
	(7), (1), (6), (4), (3), (2), (6), (5), (3), (1);

SELECT * FROM sezione;



