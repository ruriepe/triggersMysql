DROP PROCEDURE IF EXISTS setCrmEntityRel;
DELIMITER |
CREATE DEFINER=`root`@`localhost` PROCEDURE `setCrmEntityRel`(
	IN _modulo VARCHAR(250), 
	IN _modulorel VARCHAR(250), 
	IN _crmid VARCHAR(25), 
	IN _crmidrel VARCHAR(25)	
	)
BEGIN 
DECLARE totBoletosBs DOUBLE(25,2);
DECLARE totBoletosDol DOUBLE(25,2);
DECLARE totProductosBs DOUBLE(25,2);
DECLARE totProductosDol DOUBLE(25,2);
DECLARE totBs DOUBLE(25,2);
DECLARE totDol DOUBLE(25,2);
DECLARE numRows INT DEFAULT 0; 

IF (_modulo="Localizadores" AND _modulorel="Boletos") THEN
	SET numRows=(SELECT COUNT(*) FROM vtiger_crmentityrel WHERE crmid=_crmid AND module= _modulo AND relcrmid=_crmidrel AND relmodule=_modulorel);
	IF (numRows=0) THEN
		INSERT INTO vtiger_crmentityrel VALUES (_crmid, "Localizadores", _crmidrel, "Boletos");
	END IF;
END IF;

IF (_modulo="RegistroDeVentas" AND _modulorel="Localizadores") THEN
	IF (_crmid=0) THEN
		SET _crmid=(SELECT registrodeventasid FROM vtiger_localizadores WHERE localizadoresid=_crmidrel LIMIT 1);
	END IF;
	SET totBoletosBs	=(SELECT SUM(totalboletos) FROM vtiger_localizadores AS l INNER JOIN vtiger_boletos AS b ON l.localizadoresid = b.localizadorid WHERE b.currency = "VEF" AND l.registrodeventasid=_crmid AND b.boletosid NOT IN (SELECT crmid FROM vtiger_crmentity WHERE deleted=1));	
	SET totBoletosDol	=(SELECT SUM(totalboletos) FROM vtiger_localizadores AS l INNER JOIN vtiger_boletos AS b ON l.localizadoresid = b.localizadorid WHERE b.currency = "USD" AND l.registrodeventasid=_crmid AND b.boletosid NOT IN (SELECT crmid FROM vtiger_crmentity WHERE deleted=1));	
	
	SET totProductosBs	=(SELECT IF(ISNULL(SUM(amount)),0,SUM(amount)) AS totProdBs  FROM vtiger_ventadeproductos WHERE currency='VEF' AND registrodeventasid = _crmid);	
	SET totProductosDol	=(SELECT IF(ISNULL(SUM(amount)),0,SUM(amount)) AS totProdDs  FROM vtiger_ventadeproductos WHERE currency='USD' AND registrodeventasid = _crmid);	

	SET totBs =totBoletosBs+totProductosBs;
	SET totDol=totBoletosDol+totProductosDol;

	UPDATE 	vtiger_registrodeventas 
	SET 	totalventabs			=totBs, 
			totalventadolares		=totDol, 
			totalpendientebs		=totBs, 
			totalpendientedolares	=totDol 
	WHERE 	registrodeventasid		= _crmid;

	IF ROW_COUNT()>0 THEN		
		UPDATE vtiger_localizadores SET registrodeventasid=_crmid, procesado=1 WHERE localizadoresid=_crmidrel;
		IF ROW_COUNT()>0 THEN	
			/*VERIFICAMOS SI ES GDS SERVI PARA ACTUALIZAR STATUS DE VENTA SOTO*/
			SET numRows=(SELECT COUNT(*) FROM vtiger_localizadores WHERE localizadoresid=_crmidrel AND gds='Servi');
			IF (numRows>0) THEN
				UPDATE 	vtiger_registrodeventas 
				SET 	statussoto='Reservado'
				WHERE 	registrodeventasid=_crmid AND (statussoto='' OR statussoto IS NULL);
			END IF;
			/*FIN STATUS SOTO*/
		END IF;	
	END IF;	

	CALL totVentasPagadas(_crmid);	
END IF;


END |
DELIMITER ;