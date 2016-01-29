DROP TRIGGER IF EXISTS crm_boletos_update;
DELIMITER |
CREATE TRIGGER crm_boletos_update BEFORE UPDATE ON vtiger_boletos
FOR EACH ROW BEGIN 	
	DECLARE totBoletosBs DOUBLE(25,2);
	DECLARE totBoletosDol DOUBLE(25,2);
	SET NEW.totalboletos=NEW.fee + NEW.amount;			
END |
DELIMITER ;
DROP TRIGGER IF EXISTS crm_boletos_insert;
DELIMITER |
CREATE TRIGGER crm_boletos_insert BEFORE INSERT ON vtiger_boletos
FOR EACH ROW BEGIN  
	DECLARE totBoletos DOUBLE(25,2);
	SET NEW.totalboletos=NEW.fee + NEW.amount;	
END |
DELIMITER ;
DROP TRIGGER IF EXISTS crm_boletos_update_after;
DELIMITER |
CREATE TRIGGER crm_boletos_update_after AFTER UPDATE ON vtiger_boletos
FOR EACH ROW BEGIN 	
	DECLARE _totalloc DOUBLE(25,2);
	SET _totalloc=(SELECT SUM(totalboletos) FROM vtiger_boletos WHERE localizadorid=NEW.localizadorid);
	UPDATE vtiger_localizadores SET totalloc=_totalloc WHERE localizadoresid=NEW.localizadorid;
	CALL setCrmEntityRel("RegistroDeVentas","Localizadores",0,NEW.localizadorid);	
END |
DELIMITER ;