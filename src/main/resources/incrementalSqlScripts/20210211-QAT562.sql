/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  altius
 * Created: 15-Feb-2021
 */

INSERT INTO `ap_static_label`(`STATIC_LABEL_ID`,`LABEL_CODE`,`ACTIVE`) VALUES ( NULL,'static.budget.budgetrange','1');
SELECT MAX(l.STATIC_LABEL_ID) INTO @MAX FROM ap_static_label l ;

INSERT INTO ap_static_label_languages VALUES(NULL,@MAX,1,'Budget Range');-- en
INSERT INTO ap_static_label_languages VALUES(NULL,@MAX,2,'Gamme de budget');-- fr
INSERT INTO ap_static_label_languages VALUES(NULL,@MAX,3,'Rango de presupuesto');-- sp
INSERT INTO ap_static_label_languages VALUES(NULL,@MAX,4,'Faixa de orçamento');-- pr