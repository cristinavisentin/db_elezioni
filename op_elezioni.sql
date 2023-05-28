USE db_elezioni;

# UDF che calcola la percentuale
delimiter $$
CREATE FUNCTION percentuale(totale INT, parziale INT) RETURNS DOUBLE
DETERMINISTIC
BEGIN
	IF totale = 0 THEN 
		SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = "Error: il totale risulta 0";
    ELSE
	RETURN (parziale * 100) / totale;
    END IF;
END $$
delimiter ;

# VISTA che elenca tutte le elezioni con il relativo anno di svolgimento,
# numero di elettori e numero di votanti 
CREATE VIEW elencoElezioni AS 
	SELECT e.legislatura AS Legislatura, 
		e.annosvolgimento AS AnnoElezione,   
		count(*) AS Elettori, 
        count(p.espressione) AS Votanti
	FROM partecipazione p
    INNER JOIN elezione e ON e.legislatura = p.elezione
	GROUP BY e.legislatura
    ORDER BY e.legislatura;

#OPERAZIONE 1
# mostra la VISTA creata sopra
SELECT * 
FROM elencoElezioni;

#OPERAZIONE N° 2
# Data una legislatura ritorna l'anno di svolgimento e la percentuale di affluenza
# N.B. usa la UDF ed interroga la VISTA definite sopra
delimiter $$
CREATE PROCEDURE affluenza_totale_per_elezione(num_legislatura INT(2))
BEGIN
	SELECT Legislatura, 
		AnnoElezione, 
        percentuale(elettori, votanti) AS Affluenza 
	FROM elencoElezioni
	WHERE legislatura = num_legislatura;
END $$
delimiter ;    

SET @numero_elezione = 13;
CALL affluenza_totale_per_elezione(@numero_elezione);

#OPERAZIONE N° 3
# Data una legislatura ritorna il numero di elettori residenti all'estero,
# il numero di votanti residenti all'estero e la percentuale di affluenza
# usa la UDF definita sopra
delimiter $$
CREATE PROCEDURE affluenza_estero_per_elezione(legislatura INT(2))
BEGIN
	SELECT count(*) AS Elettori, 
		count(p.espressione) AS Votanti, 
		percentuale(count(*), count(p.espressione)) AS Affluenza
	FROM partecipazione p
    INNER JOIN votante v ON v.cf = p.votante
    INNER JOIN città c ON v.città = c.id
	WHERE p.elezione = legislatura AND c.nazione <> "Italia";
END $$
delimiter ;

CALL affluenza_estero_per_elezione(@numero_elezione);

#OPERAZIONE N° 4
# Mostra solo le elezioni che si sono svolte regolarmente, 
# cioè dopo 5 anni da quella precedente
# per ognuna mostra anno previsto e data effettiva di svolgimento
delimiter $$
CREATE PROCEDURE regolarità_elezioni()
BEGIN
	SELECT legislatura AS NumeroLegislatura,
		annosvolgimento AS AnnoPrevisto, 
		dataeffettiva AS DataDiSvolgimento
    FROM elezione
    WHERE annosvolgimento = year(dataeffettiva)
    ORDER BY legislatura;
END $$
delimiter ;

CALL regolarità_elezioni();

#OPERAZIONE N° 5
# Al contrario dell'operazione 4, mostra le elezioni anticipate
delimiter $$
CREATE PROCEDURE elezioni_anticipate()
BEGIN
	SELECT legislatura AS NumeroLegislatura,
		annosvolgimento AS AnnoPrevisto, 
        dataeffettiva AS DataDiSvolgimento
    FROM elezione
    WHERE annosvolgimento <> year(dataeffettiva)
    ORDER BY legislatura;
END $$
delimiter ;

CALL elezioni_anticipate();

#OPERAZIONE N° 6
# Dato un seggio restituisce, per ogni legislatura, il numero di schede scrutinate,
# il numero di schede valide e non valide
delimiter $$
CREATE PROCEDURE num_schede_per_seggio(seggio INT)
BEGIN
	SELECT e.legislatura AS Legislatura, count(*) AS NumeroSchede,
		sum(CASE WHEN validità = TRUE THEN 1 ELSE 0 END) AS Valide,
        sum(CASE WHEN validità = FALSE THEN 1 ELSE 0 END) AS NonValide
	FROM scheda s
	INNER JOIN elezione e ON e.legislatura = s.elezione
	WHERE s.seggio = seggio
	GROUP BY e.legislatura
    ORDER BY e.legislatura;
END $$
delimiter ;    

SET @codice_seggio = 1;
CALL num_schede_per_seggio(@codice_seggio);

#OPERAZIONE N° 7
# Dato un seggio elenca tutte le dichiarazioni messe a verbale
delimiter $$
CREATE PROCEDURE elenco_dichiarazioni(seggio INT)
BEGIN
	SELECT d.codice AS Codice, 
		d.votante AS Votante, 
		d.orario AS OraRilascio, 
        d.descrizione AS Descrizione,
        d.elezione AS Elezione
    FROM dichiarazione d
    INNER JOIN votante v ON v.cf = d.votante
    INNER JOIN seggio s ON s.codice = v.seggio
    WHERE s.codice = seggio;
END $$
delimiter ;

CALL elenco_dichiarazioni(@codice_seggio);

#OPERAZIONE N° 8
# Data una regione ritorna, per ogni legislatura, il numero di votanti
# il numero di votanti divisi per genere e l'età media
delimiter $$
CREATE PROCEDURE dati_per_regione(regione VARCHAR(45))
BEGIN
	SELECT e.legislatura AS Legislatura, 
		count(p.espressione) AS Votanti,
		sum(CASE WHEN genere = 'M' THEN 1 ELSE 0 END) AS Num_uomini,
		sum(CASE WHEN genere = 'F' THEN 1 ELSE 0 END) AS Num_donne,
		avg(year(e.dataeffettiva) - year(v.datadinascita)) AS Età_Media
    FROM votante v
    INNER JOIN partecipazione p ON v.cf = p.votante
    INNER JOIN elezione e ON e.legislatura = p.elezione
    INNER JOIN città c ON v.città = c.id
    WHERE p.espressione IS NOT NULL AND c.regione = regione
    GROUP BY e.legislatura
    ORDER BY e.legislatura;
END $$
delimiter ;

SET @regione = "FVG";
CALL dati_per_regione(@regione);

#OPERAZIONE N° 9
# Data una legislatura si vuole conoscere le affluenze parziali in percentuale sul totale
# di elettori alle ore 12:00, 18:00 e 21:00 più l'affluenza totale
# usa la UDF e tre subquery
delimiter $$
CREATE PROCEDURE affluenze_parziali(num_legislatura INT(2))
BEGIN
	SELECT percentuale(count(*), (
			SELECT count(espressione) FROM partecipazione
			WHERE orario < "12:00:00" AND elezione = num_legislatura)) AS Affluenza_ore_12,
		percentuale(count(*), (
			SELECT count(espressione) FROM partecipazione
			WHERE orario < "18:00:00" AND elezione = num_legislatura)) AS Affluenza_ore_18,
		percentuale(count(*), (
			SELECT count(espressione) FROM partecipazione
			WHERE orario < "21:00:00" AND elezione = num_legislatura)) AS Affluenza_ore_21,
		percentuale(count(*), count(espressione)) AS Affluenza_totale
    FROM partecipazione
    WHERE elezione = num_legislatura;
END $$
delimiter ;

SET @num_elezione = 5;
CALL affluenze_parziali(@num_elezione);

#OPERAZIONE N° 10
# Si vuole elencare i risultati elettorali di ogni elezione
delimiter $$
CREATE PROCEDURE risultati()
BEGIN
	SELECT s.elezione AS Legislatura, 
		sum(CASE WHEN v.partito = "Sinistra" THEN 1 ELSE 0 END) AS Sinistra,
		sum(CASE WHEN v.partito = "Destra" THEN 1 ELSE 0 END) AS Destra,
        sum(CASE WHEN v.partito = "Centro" THEN 1 ELSE 0 END) AS Centro
    FROM voto v
    INNER JOIN scheda s ON s.numero = v.scheda
    GROUP BY s.elezione
    ORDER BY s.elezione;
END $$
delimiter ;

CALL risultati();

#TRIGGER N° 1
# controlla che un votante abbia la maggiore età per partecipare ad una elezione
delimiter $$
CREATE TRIGGER maggioreEtà BEFORE INSERT ON partecipazione
FOR EACH ROW 
BEGIN
	DECLARE annosvolgimento DATE;
    DECLARE annovotante DATE;
    
    SELECT dataeffettiva INTO annosvolgimento 
		FROM elezione 
        WHERE legislatura = new.elezione;
    SELECT datadinascita INTO annovotante 
		FROM votante 
        WHERE cf = new.votante;
    
	IF year(annosvolgimento) - year(annovotante) < 18
		THEN SIGNAL SQLSTATE '45001' 
		SET MESSAGE_TEXT = "Error: votante inserito non maggiorenne";
	END IF;
END $$
delimiter ;

#prova 1 (inserimento bloccato)
INSERT INTO partecipazione VALUES(18, "WSNCST11D52L424A", "Votato", "19:05:00");

#prova 2 (inserimento concesso)
DELETE FROM partecipazione WHERE elezione = 19 AND votante = "ESNCST04D52L424A";
INSERT INTO partecipazione VALUES(19, "ESNCST04D52L424A", "Votato", "07:08:00");


#TRIGGER N° 2
delimiter $$
CREATE TRIGGER validità_voto BEFORE INSERT ON voto
FOR EACH ROW 
BEGIN
	DECLARE val BOOL;
	SELECT validità INTO val 
	FROM scheda 
	WHERE numero = new.scheda;
	IF val IS FALSE 
		THEN 
			SIGNAL SQLSTATE '45001' 
			SET MESSAGE_TEXT = "Error: scheda non valida";
	END IF;
END $$
delimiter ;

#prova 1 (inserimento bloccato)
INSERT INTO voto VALUES(5, "Sinistra", "Pluto");

#prova 2 (inserimento concesso)
DELETE FROM voto WHERE scheda = 212;
INSERT INTO voto VALUES(212, "Centro", NULL);
