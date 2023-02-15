CREATE PROCEDURE LisaaSuoritus (
IN En VARCHAR(45),
IN Sn VARCHAR(45),
IN KK VARCHAR(45),
IN Arvos INT
)

-- Aliohjelman kutsu mysql:n komentoriviltä:
-- CALL LisaaSuoritus('Iines','Ankka','T200123',3);

 Aliohjelma:BEGIN -- Aliohjelma on LOOP-label,LEAVE:lla poistutaan

declare OpiskID INT DEFAULT 0;
declare OpjaksoID INT DEFAULT 0;

-- Määrittele itse lisää tarpeen mukaan...
-- Jos löytyi, opiskelijan päävain tallettuu muuttujaan OpiskID > 0
SELECT idOpiskelija INTO OpiskID FROM Opiskelija WHERE Etunimi=En AND Sukunimi=Sn;

-- Jos OpiskID jäi nollaksi, opiskelijaa ei löytynyt. Voidaan lopettaa suoritus.
IF OpiskID=0 then 
     SELECT 'Opiskelijaa ei ole'; -- TUlostetaan viesti käyttäjälle
     LEAVE Aliohjelma;
END IF;

-- Samanlainen juttu tehtävä opintojaksolle
SELECT idOpintojakso INTO OpjaksoID FROM Opintojakso WHERE Koodi=KK;
-- Tarkista, että muuttuja Arvos on välillä 0 - 5
IF OpjaksoID=0 then
	SELECT 'Opintojaksoa ei ole';
	LEAVE Aliohjelma;
END IF;

-- Lopuksi, jos opiskelija ja opintojakso on olemassa ja arvosana on järkevä
--  INSERT-lause, jolla syötät tiedot Arviointi-tauluun

INSERT INTO Arviointi VALUES(NULL,Arvos,CURDATE(),OpiskID,OpjaksoID);

END