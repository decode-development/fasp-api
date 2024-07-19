INSERT INTO `fasp`.`ap_static_label`(`STATIC_LABEL_ID`,`LABEL_CODE`,`ACTIVE`) VALUES ( NULL,'static.message.planningUnitAlreadExists','1'); 
SELECT MAX(l.STATIC_LABEL_ID) INTO @MAX FROM ap_static_label l ;

INSERT INTO ap_static_label_languages VALUES(NULL,@MAX,1,'Planning Unit already exists');-- en
INSERT INTO ap_static_label_languages VALUES(NULL,@MAX,2,'L`unité de prévision existe déjà');-- fr
INSERT INTO ap_static_label_languages VALUES(NULL,@MAX,3,'La Unidad de Previsión ya existe');-- sp
INSERT INTO ap_static_label_languages VALUES(NULL,@MAX,4,'A unidade de previsão já existe');-- pr

INSERT INTO `fasp`.`ap_static_label`(`STATIC_LABEL_ID`,`LABEL_CODE`,`ACTIVE`) VALUES ( NULL,'static.message.procurementUnitAlreadExists','1'); 
SELECT MAX(l.STATIC_LABEL_ID) INTO @MAX FROM ap_static_label l ;

INSERT INTO ap_static_label_languages VALUES(NULL,@MAX,1,'Procurement Unit already exists');-- en
INSERT INTO ap_static_label_languages VALUES(NULL,@MAX,2,'L`unité de prévision existe déjà');-- fr
INSERT INTO ap_static_label_languages VALUES(NULL,@MAX,3,'La Unidad de Previsión ya existe');-- sp
INSERT INTO ap_static_label_languages VALUES(NULL,@MAX,4,'A unidade de previsão já existe');-- pr