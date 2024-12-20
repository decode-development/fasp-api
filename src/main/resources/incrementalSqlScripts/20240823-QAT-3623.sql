ALTER TABLE `fasp`.`rm_procurement_agent` 
ADD COLUMN `COLOR_HTML_DARK_CODE` VARCHAR(7) NOT NULL AFTER `COLOR_HTML_CODE`;

USE `fasp`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    DEFINER = `faspUser`@`%` 
    SQL SECURITY DEFINER
VIEW `vw_procurement_agent` AS
    SELECT 
        `pa`.`PROCUREMENT_AGENT_ID` AS `PROCUREMENT_AGENT_ID`,
        `pa`.`REALM_ID` AS `REALM_ID`,
        `pa`.`PROCUREMENT_AGENT_TYPE_ID` AS `PROCUREMENT_AGENT_TYPE_ID`,
        `pa`.`PROCUREMENT_AGENT_CODE` AS `PROCUREMENT_AGENT_CODE`,
        `pa`.`COLOR_HTML_CODE` AS `COLOR_HTML_CODE`,
        `pa`.`COLOR_HTML_DARK_CODE` AS `COLOR_HTML_DARK_CODE`,
        `pa`.`LABEL_ID` AS `LABEL_ID`,
        `pa`.`SUBMITTED_TO_APPROVED_LEAD_TIME` AS `SUBMITTED_TO_APPROVED_LEAD_TIME`,
        `pa`.`APPROVED_TO_SHIPPED_LEAD_TIME` AS `APPROVED_TO_SHIPPED_LEAD_TIME`,
        `pa`.`ACTIVE` AS `ACTIVE`,
        `pa`.`CREATED_BY` AS `CREATED_BY`,
        `pa`.`CREATED_DATE` AS `CREATED_DATE`,
        `pa`.`LAST_MODIFIED_BY` AS `LAST_MODIFIED_BY`,
        `pa`.`LAST_MODIFIED_DATE` AS `LAST_MODIFIED_DATE`,
        `pal`.`LABEL_EN` AS `LABEL_EN`,
        `pal`.`LABEL_FR` AS `LABEL_FR`,
        `pal`.`LABEL_SP` AS `LABEL_SP`,
        `pal`.`LABEL_PR` AS `LABEL_PR`
    FROM
        (`rm_procurement_agent` `pa`
        LEFT JOIN `ap_label` `pal` ON ((`pa`.`LABEL_ID` = `pal`.`LABEL_ID`)));

UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#d4bbff',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='1' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#ba4e00',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='2' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#fff1f1',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='3' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#EEE4B1',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='5' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#FAA3F7',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='6' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#F3B670',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='8' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#FAE5C3',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='9' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#A65D1C',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='10' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#95CEE9',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='11' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#8BB5B0',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='12' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#C5D2D0',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='13' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#88696F',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='14' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#E3734A',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='15' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#E3C267',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='16' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#BCB9B1',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='17' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#91ABCC',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='19' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#70DABF',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='20' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#D06213',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='21' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#13A48B',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='22' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#83996A',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='23' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#A5C185',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='24' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#A48F13',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='25' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#456B8D',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='26' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#991164',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='27' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#997659',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='28' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#AC947E',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='29' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#D01340',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='30' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#E88739',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='31' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#8E8411',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='32' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#EEF085',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='33' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#14B583',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='34' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#A46364',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='35' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#B28888',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='36' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#179153',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='37' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#89A071',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='38' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#F6F892',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='39' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#666EA2',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='40' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#C15F53',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='41' ;
UPDATE rm_procurement_agent pa SET pa.COLOR_HTML_DARK_CODE='#936E8C',pa.LAST_MODIFIED_DATE=now() WHERE pa.PROCUREMENT_AGENT_ID='42' ;

ALTER TABLE `fasp`.`us_user` ADD COLUMN `DEFAULT_THEME_ID` INT(10) UNSIGNED DEFAULT '1' NOT NULL COMMENT '1- Light Mode, 2- Dark Mode' AFTER `DEFAULT_MODULE_ID`; 