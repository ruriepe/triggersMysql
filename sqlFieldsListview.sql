#Verificar antes de correl el SQL el cvid en la tabla cvcolumnlist
UPDATE  `vtiger_cvcolumnlist` SET `columnname` = 'vtiger_boletos:localizadorid:localizadorid:Boletos_LBL_IDLOCALIZADOR:V' WHERE `vtiger_cvcolumnlist`.`cvid` = 143 AND `vtiger_cvcolumnlist`.`columnindex` = 1; 
UPDATE  `vtiger_cvcolumnlist` SET `columnname` = 'vtiger_boletos:passenger:passenger:Boletos_LBL_PASSENGER:V' WHERE `vtiger_cvcolumnlist`.`cvid` = 143 AND `vtiger_cvcolumnlist`.`columnindex` = 2; 
UPDATE  `vtiger_cvcolumnlist` SET `columnname` = 'vtiger_boletos:fecha_emision:fecha_emision:Boletos_FECHA_EMISION:V' WHERE `vtiger_cvcolumnlist`.`cvid` = 143 AND `vtiger_cvcolumnlist`.`columnindex` = 4; 
UPDATE  `vtiger_cvcolumnlist` SET `columnname` = 'vtiger_boletos:boleto1:boleto1:Boletos_NUM_BOLETO:V' WHERE `vtiger_cvcolumnlist`.`cvid` = 143 AND `vtiger_cvcolumnlist`.`columnindex` = 5; 
UPDATE  `vtiger_cvcolumnlist` SET `columnname` = 'vtiger_boletos:fee:fee:Boletos_LBL_FEE:N' WHERE `vtiger_cvcolumnlist`.`cvid` = 143 AND `vtiger_cvcolumnlist`.`columnindex` = 6; 
UPDATE  `vtiger_cvcolumnlist` SET `columnname` = 'vtiger_boletos:monto_base:monto_base:Boletos_LBL_MONTO_BASE:N' WHERE `vtiger_cvcolumnlist`.`cvid` = 143 AND `vtiger_cvcolumnlist`.`columnindex` = 7; 
UPDATE  `vtiger_cvcolumnlist` SET `columnname` = 'vtiger_boletos:amount:amount:Boletos_LBL_AMOUNT:V' WHERE `vtiger_cvcolumnlist`.`cvid` = 143 AND `vtiger_cvcolumnlist`.`columnindex` = 8; 
UPDATE  `vtiger_cvcolumnlist` SET `columnname` = 'vtiger_boletos:currency:currency:Boletos_LBL_CURRENCY:V' WHERE `vtiger_cvcolumnlist`.`cvid` = 143 AND `vtiger_cvcolumnlist`.`columnindex` = 9; 
UPDATE  `vtiger_cvcolumnlist` SET `columnname` = 'vtiger_boletos:status:status:Boletos_LBL_STATUS:V' WHERE `vtiger_cvcolumnlist`.`cvid` = 143 AND `vtiger_cvcolumnlist`.`columnindex` = 10;
