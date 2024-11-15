
ALTER TABLE `fasp`.`rm_realm` ADD COLUMN `NO_OF_MONTHS_IN_PAST_FOR_BOTTOM_DASHBOARD` INT UNSIGNED NOT NULL DEFAULT 18 AFTER `LAST_MODIFIED_DATE`;
ALTER TABLE `fasp`.`rm_realm` CHANGE COLUMN `NO_OF_MONTHS_IN_PAST_FOR_BOTTOM_DASHBOARD` `NO_OF_MONTHS_IN_PAST_FOR_BOTTOM_DASHBOARD` INT UNSIGNED NOT NULL DEFAULT '18' AFTER `MIN_PERC_FOR_MODE`;

ALTER TABLE `fasp`.`rm_realm` ADD COLUMN `NO_OF_MONTHS_IN_FUTURE_FOR_BOTTOM_DASHBOARD` INT UNSIGNED NOT NULL DEFAULT 18 AFTER `LAST_MODIFIED_DATE`;
ALTER TABLE `fasp`.`rm_realm` CHANGE COLUMN `NO_OF_MONTHS_IN_FUTURE_FOR_BOTTOM_DASHBOARD` `NO_OF_MONTHS_IN_FUTURE_FOR_BOTTOM_DASHBOARD` INT UNSIGNED NOT NULL DEFAULT '18' AFTER `NO_OF_MONTHS_IN_PAST_FOR_BOTTOM_DASHBOARD`;
USE `fasp`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    DEFINER = `faspUser`@`%` 
    SQL SECURITY DEFINER
VIEW `vw_realm` AS
    SELECT 
        `r`.`REALM_ID` AS `REALM_ID`,
        `r`.`REALM_CODE` AS `REALM_CODE`,
        `r`.`LABEL_ID` AS `LABEL_ID`,
        `r`.`DEFAULT_REALM` AS `DEFAULT_REALM`,
        `r`.`MIN_MOS_MIN_GAURDRAIL` AS `MIN_MOS_MIN_GAURDRAIL`,
        `r`.`MIN_MOS_MAX_GAURDRAIL` AS `MIN_MOS_MAX_GAURDRAIL`,
        `r`.`MAX_MOS_MAX_GAURDRAIL` AS `MAX_MOS_MAX_GAURDRAIL`,
        `r`.`MIN_QPL_TOLERANCE` AS `MIN_QPL_TOLERANCE`,
        `r`.`MIN_QPL_TOLERANCE_CUT_OFF` AS `MIN_QPL_TOLERANCE_CUT_OFF`,
        `r`.`MAX_QPL_TOLERANCE` AS `MAX_QPL_TOLERANCE`,
        `r`.`ACTUAL_CONSUMPTION_MONTHS_IN_PAST` AS `ACTUAL_CONSUMPTION_MONTHS_IN_PAST`,
        `r`.`FORECAST_CONSUMPTION_MONTH_IN_PAST` AS `FORECAST_CONSUMPTION_MONTH_IN_PAST`,
        `r`.`INVENTORY_MONTHS_IN_PAST` AS `INVENTORY_MONTHS_IN_PAST`,
        `r`.`MIN_COUNT_FOR_MODE` AS `MIN_COUNT_FOR_MODE`,
        `r`.`MIN_PERC_FOR_MODE` AS `MIN_PERC_FOR_MODE`,
        `r`.`NO_OF_MONTHS_IN_PAST_FOR_BOTTOM_DASHBOARD` AS `NO_OF_MONTHS_IN_PAST_FOR_BOTTOM_DASHBOARD`,
        `r`.`NO_OF_MONTHS_IN_FUTURE_FOR_BOTTOM_DASHBOARD` AS `NO_OF_MONTHS_IN_FUTURE_FOR_BOTTOM_DASHBOARD`,
        `r`.`ACTIVE` AS `ACTIVE`,
        `r`.`CREATED_BY` AS `CREATED_BY`,
        `r`.`CREATED_DATE` AS `CREATED_DATE`,
        `r`.`LAST_MODIFIED_BY` AS `LAST_MODIFIED_BY`,
        `r`.`LAST_MODIFIED_DATE` AS `LAST_MODIFIED_DATE`,
        `rl`.`LABEL_EN` AS `LABEL_EN`,
        `rl`.`LABEL_FR` AS `LABEL_FR`,
        `rl`.`LABEL_SP` AS `LABEL_SP`,
        `rl`.`LABEL_PR` AS `LABEL_PR`
    FROM
        (`rm_realm` `r`
        LEFT JOIN `ap_label` `rl` ON ((`r`.`LABEL_ID` = `rl`.`LABEL_ID`)));



ALTER TABLE `fasp`.`rm_program` ADD COLUMN `NO_OF_MONTHS_IN_PAST_FOR_BOTTOM_DASHBOARD` INT UNSIGNED NULL AFTER `ARRIVED_TO_DELIVERED_LEAD_TIME`;
ALTER TABLE `fasp`.`rm_program` ADD COLUMN `NO_OF_MONTHS_IN_FUTURE_FOR_BOTTOM_DASHBOARD` INT UNSIGNED NULL AFTER `NO_OF_MONTHS_IN_PAST_FOR_BOTTOM_DASHBOARD`;

USE `fasp`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    DEFINER = `faspUser`@`%` 
    SQL SECURITY DEFINER
VIEW `vw_program` AS
    SELECT 
        `p`.`PROGRAM_ID` AS `PROGRAM_ID`,
        `p`.`PROGRAM_CODE` AS `PROGRAM_CODE`,
        `p`.`REALM_COUNTRY_ID` AS `REALM_COUNTRY_ID`,
        GROUP_CONCAT(`pha`.`HEALTH_AREA_ID`
            SEPARATOR ',') AS `HEALTH_AREA_ID`,
        `p`.`ORGANISATION_ID` AS `ORGANISATION_ID`,
        `p`.`LABEL_ID` AS `LABEL_ID`,
        `p`.`PROGRAM_MANAGER_USER_ID` AS `PROGRAM_MANAGER_USER_ID`,
        `p`.`PROGRAM_NOTES` AS `PROGRAM_NOTES`,
        `p`.`AIR_FREIGHT_PERC` AS `AIR_FREIGHT_PERC`,
        `p`.`SEA_FREIGHT_PERC` AS `SEA_FREIGHT_PERC`,
        `p`.`ROAD_FREIGHT_PERC` AS `ROAD_FREIGHT_PERC`,
        `p`.`PLANNED_TO_SUBMITTED_LEAD_TIME` AS `PLANNED_TO_SUBMITTED_LEAD_TIME`,
        `p`.`SUBMITTED_TO_APPROVED_LEAD_TIME` AS `SUBMITTED_TO_APPROVED_LEAD_TIME`,
        `p`.`APPROVED_TO_SHIPPED_LEAD_TIME` AS `APPROVED_TO_SHIPPED_LEAD_TIME`,
        `p`.`SHIPPED_TO_ARRIVED_BY_AIR_LEAD_TIME` AS `SHIPPED_TO_ARRIVED_BY_AIR_LEAD_TIME`,
        `p`.`SHIPPED_TO_ARRIVED_BY_SEA_LEAD_TIME` AS `SHIPPED_TO_ARRIVED_BY_SEA_LEAD_TIME`,
        `p`.`SHIPPED_TO_ARRIVED_BY_ROAD_LEAD_TIME` AS `SHIPPED_TO_ARRIVED_BY_ROAD_LEAD_TIME`,
        `p`.`ARRIVED_TO_DELIVERED_LEAD_TIME` AS `ARRIVED_TO_DELIVERED_LEAD_TIME`,
        `p`.`NO_OF_MONTHS_IN_PAST_FOR_BOTTOM_DASHBOARD` AS `NO_OF_MONTHS_IN_PAST_FOR_BOTTOM_DASHBOARD`,
        `p`.`NO_OF_MONTHS_IN_FUTURE_FOR_BOTTOM_DASHBOARD` AS `NO_OF_MONTHS_IN_FUTURE_FOR_BOTTOM_DASHBOARD`,
        `p`.`CURRENT_VERSION_ID` AS `CURRENT_VERSION_ID`,
        `p`.`ACTIVE` AS `ACTIVE`,
        `p`.`CREATED_BY` AS `CREATED_BY`,
        `p`.`CREATED_DATE` AS `CREATED_DATE`,
        `p`.`LAST_MODIFIED_BY` AS `LAST_MODIFIED_BY`,
        `p`.`LAST_MODIFIED_DATE` AS `LAST_MODIFIED_DATE`,
        `pl`.`LABEL_EN` AS `LABEL_EN`,
        `pl`.`LABEL_FR` AS `LABEL_FR`,
        `pl`.`LABEL_SP` AS `LABEL_SP`,
        `pl`.`LABEL_PR` AS `LABEL_PR`,
        `p`.`PROGRAM_TYPE_ID` AS `PROGRAM_TYPE_ID`
    FROM
        ((`rm_program` `p`
        LEFT JOIN `rm_program_health_area` `pha` ON ((`p`.`PROGRAM_ID` = `pha`.`PROGRAM_ID`)))
        LEFT JOIN `ap_label` `pl` ON ((`p`.`LABEL_ID` = `pl`.`LABEL_ID`)))
    WHERE
        (`p`.`PROGRAM_TYPE_ID` = 1)
    GROUP BY `p`.`PROGRAM_ID`;

USE `fasp`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    DEFINER = `faspUser`@`%` 
    SQL SECURITY DEFINER
VIEW `vw_dataset` AS
    SELECT 
        `p`.`PROGRAM_ID` AS `PROGRAM_ID`,
        `p`.`PROGRAM_CODE` AS `PROGRAM_CODE`,
        `p`.`REALM_COUNTRY_ID` AS `REALM_COUNTRY_ID`,
        GROUP_CONCAT(`pha`.`HEALTH_AREA_ID`
            SEPARATOR ',') AS `HEALTH_AREA_ID`,
        `p`.`ORGANISATION_ID` AS `ORGANISATION_ID`,
        `p`.`LABEL_ID` AS `LABEL_ID`,
        `p`.`PROGRAM_MANAGER_USER_ID` AS `PROGRAM_MANAGER_USER_ID`,
        `p`.`PROGRAM_NOTES` AS `PROGRAM_NOTES`,
        `p`.`AIR_FREIGHT_PERC` AS `AIR_FREIGHT_PERC`,
        `p`.`SEA_FREIGHT_PERC` AS `SEA_FREIGHT_PERC`,
        `p`.`ROAD_FREIGHT_PERC` AS `ROAD_FREIGHT_PERC`,
        `p`.`PLANNED_TO_SUBMITTED_LEAD_TIME` AS `PLANNED_TO_SUBMITTED_LEAD_TIME`,
        `p`.`SUBMITTED_TO_APPROVED_LEAD_TIME` AS `SUBMITTED_TO_APPROVED_LEAD_TIME`,
        `p`.`APPROVED_TO_SHIPPED_LEAD_TIME` AS `APPROVED_TO_SHIPPED_LEAD_TIME`,
        `p`.`SHIPPED_TO_ARRIVED_BY_AIR_LEAD_TIME` AS `SHIPPED_TO_ARRIVED_BY_AIR_LEAD_TIME`,
        `p`.`SHIPPED_TO_ARRIVED_BY_SEA_LEAD_TIME` AS `SHIPPED_TO_ARRIVED_BY_SEA_LEAD_TIME`,
        `p`.`SHIPPED_TO_ARRIVED_BY_ROAD_LEAD_TIME` AS `SHIPPED_TO_ARRIVED_BY_ROAD_LEAD_TIME`,
        `p`.`ARRIVED_TO_DELIVERED_LEAD_TIME` AS `ARRIVED_TO_DELIVERED_LEAD_TIME`,
        `p`.`NO_OF_MONTHS_IN_PAST_FOR_BOTTOM_DASHBOARD` AS `NO_OF_MONTHS_IN_PAST_FOR_BOTTOM_DASHBOARD`,
        `p`.`NO_OF_MONTHS_IN_FUTURE_FOR_BOTTOM_DASHBOARD` AS `NO_OF_MONTHS_IN_FUTURE_FOR_BOTTOM_DASHBOARD`,
        `p`.`CURRENT_VERSION_ID` AS `CURRENT_VERSION_ID`,
        `p`.`ACTIVE` AS `ACTIVE`,
        `p`.`CREATED_BY` AS `CREATED_BY`,
        `p`.`CREATED_DATE` AS `CREATED_DATE`,
        `p`.`LAST_MODIFIED_BY` AS `LAST_MODIFIED_BY`,
        `p`.`LAST_MODIFIED_DATE` AS `LAST_MODIFIED_DATE`,
        `pl`.`LABEL_EN` AS `LABEL_EN`,
        `pl`.`LABEL_FR` AS `LABEL_FR`,
        `pl`.`LABEL_SP` AS `LABEL_SP`,
        `pl`.`LABEL_PR` AS `LABEL_PR`,
        `p`.`PROGRAM_TYPE_ID` AS `PROGRAM_TYPE_ID`
    FROM
        ((`rm_program` `p`
        LEFT JOIN `rm_program_health_area` `pha` ON ((`p`.`PROGRAM_ID` = `pha`.`PROGRAM_ID`)))
        LEFT JOIN `ap_label` `pl` ON ((`p`.`LABEL_ID` = `pl`.`LABEL_ID`)))
    WHERE
        (`p`.`PROGRAM_TYPE_ID` = 2)
    GROUP BY `p`.`PROGRAM_ID`;


USE `fasp`;
DROP procedure IF EXISTS `getDashboardStockStatusForLoadProgram`;

USE `fasp`;
DROP procedure IF EXISTS `fasp`.`getDashboardStockStatusForLoadProgram`;
;

DELIMITER $$
USE `fasp`$$
CREATE DEFINER=`faspUser`@`%` PROCEDURE `getDashboardStockStatusForLoadProgram`(VAR_START_DATE DATE, VAR_STOP_DATE DATE, VAR_PROGRAM_ID INT, VAR_VERSION_ID INT)
BEGIN
    
    SELECT COUNT(mn.MONTH) INTO @monthCount FROM mn WHERE mn.MONTH BETWEEN VAR_START_DATE AND VAR_STOP_DATE;
    
    SELECT 
        pu.PLANNING_UNIT_ID, 
        SUM(p2.`COUNT_OF_STOCK_OUT`) `COUNT_OF_STOCK_OUT`, 
        SUM(p2.`COUNT_OF_UNDER_STOCK`) `COUNT_OF_UNDER_STOCK`, 
        SUM(p2.`COUNT_OF_ADEQUATE_STOCK`) `COUNT_OF_ADEQUATE_STOCK`, 
        SUM(p2.`COUNT_OF_OVER_STOCK`) `COUNT_OF_OVER_STOCK`, 
        @monthCount - (SUM(p2.`COUNT_OF_STOCK_OUT`)+SUM(p2.`COUNT_OF_UNDER_STOCK`)+SUM(p2.`COUNT_OF_ADEQUATE_STOCK`)+SUM(p2.`COUNT_OF_OVER_STOCK`)) `COUNT_OF_NA`,
        @monthCount `COUNT_OF_TOTAL`
    FROM vw_program p 
    LEFT JOIN rm_program_planning_unit ppu ON p.PROGRAM_ID=ppu.PROGRAM_ID AND ppu.ACTIVE
    LEFT JOIN vw_planning_unit pu ON ppu.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID AND pu.ACTIVE 
    LEFT JOIN (
        SELECT 
            p1.PLANNING_UNIT_ID, 
            SUM(IF(p1.STOCK_CONDITION=0, 1, 0)) `COUNT_OF_STOCK_OUT`, 
            SUM(IF(STOCK_CONDITION=1, 1, 0)) `COUNT_OF_UNDER_STOCK`, 
            SUM(IF(STOCK_CONDITION=2, 1, 0)) `COUNT_OF_ADEQUATE_STOCK`, 
            SUM(IF(STOCK_CONDITION=3, 1, 0)) `COUNT_OF_OVER_STOCK`, 
            SUM(IF(STOCK_CONDITION=4, 1, 0)) `COUNT_OF_NA`,
            SUM(IF(STOCK_CONDITION=5, 1, 0)) `COUNT_OF_UNK`
        FROM ( 
        SELECT 
            amc.PLANNING_UNIT_ID, amc.`TRANS_DATE`,
            CASE
                WHEN amc.MOS is null THEN 4 -- NA
                WHEN amc.MOS=0 THEN 0 -- StockOut
                WHEN amc.MOS < IF(ppu.PLAN_BASED_ON=1,ppu.MIN_MONTHS_OF_STOCK,ppu.MIN_QTY) THEN 1 -- UnderStock
                WHEN amc.MOS <= IF(ppu.PLAN_BASED_ON=1,(ppu.MIN_MONTHS_OF_STOCK+ppu.REORDER_FREQUENCY_IN_MONTHS),ROUND(amc.MAX_STOCK_QTY)) THEN 2 -- Adequate Stock
                WHEN amc.MOS > IF(ppu.PLAN_BASED_ON=1,(ppu.MIN_MONTHS_OF_STOCK+ppu.REORDER_FREQUENCY_IN_MONTHS),ROUND(amc.MAX_STOCK_QTY)) THEN 3 -- Over Stock
                ELSE 5 -- Unknown
            END `STOCK_CONDITION`
        FROM vw_program p 
        LEFT JOIN rm_program_planning_unit ppu ON p.PROGRAM_ID=ppu.PROGRAM_ID
        LEFT JOIN rm_planning_unit pu ON ppu.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID 
        LEFT JOIN rm_supply_plan_amc amc ON p.PROGRAM_ID=amc.PROGRAM_ID AND amc.VERSION_ID=VAR_VERSION_ID AND ppu.PLANNING_UNIT_ID=amc.PLANNING_UNIT_ID
        WHERE p.PROGRAM_ID=VAR_PROGRAM_ID AND amc.TRANS_DATE BETWEEN VAR_START_DATE AND VAR_STOP_DATE and ppu.ACTIVE AND pu.ACTIVE
        ) p1 GROUP BY p1.PLANNING_UNIT_ID) p2 ON pu.PLANNING_UNIT_ID=p2.PLANNING_UNIT_ID
    WHERE p.PROGRAM_ID = VAR_PROGRAM_ID AND pu.PLANNING_UNIT_ID IS NOT NULL
    GROUP BY p.PROGRAM_ID, pu.PLANNING_UNIT_ID;
END$$

DELIMITER ;
;

USE `fasp`;
DROP procedure IF EXISTS `getDashboardShipmentDetailsReportByForLoadProgram`;

DELIMITER $$
USE `fasp`$$
CREATE DEFINER=`faspUser`@`%` PROCEDURE `getDashboardShipmentDetailsReportByForLoadProgram`(VAR_START_DATE DATE, VAR_STOP_DATE DATE, VAR_PROGRAM_ID INT, VAR_VERSION_ID INT, VAR_DISPLAY_SHIPMENTS_BY INT)
BEGIN

    SET @verVersionId = VAR_VERSION_ID;
    
    IF VAR_DISPLAY_SHIPMENTS_BY = 1 THEN -- FundingSource
        SELECT 
            st.PLANNING_UNIT_ID, 
            fs.`FUNDING_SOURCE_ID` `REPORT_BY_ID`, fs.FUNDING_SOURCE_CODE `REPORT_BY_CODE`, fs.LABEL_ID `RB_LABEL_ID`, fs.LABEL_EN `RB_LABEL_EN`, fs.LABEL_FR `RB_LABEL_FR`, fs.LABEL_SP `RB_LABEL_SP`, fs.LABEL_PR `RB_LABEL_PR`, 
            COUNT(st.SHIPMENT_ID) `ORDER_COUNT`, 
            SUM(st.SHIPMENT_QTY) `QUANTITY`, 
            SUM((IFNULL(st.PRODUCT_COST,0) + IFNULL(st.FREIGHT_COST,0)) * s.CONVERSION_RATE_TO_USD) `COST` , NULL `COLOR_HTML_CODE`, NULL `COLOR_HTML_DARK_CODE`
        FROM 
            ( 
            SELECT 
                s.SHIPMENT_ID, MAX(st.VERSION_ID) MAX_VERSION_ID, s.CONVERSION_RATE_TO_USD 
            FROM rm_shipment s 
            LEFT JOIN rm_shipment_trans st ON s.SHIPMENT_ID=st.SHIPMENT_ID 
            WHERE 
                s.PROGRAM_ID=VAR_PROGRAM_ID
                AND st.VERSION_ID<=@varVersionId
                AND st.SHIPMENT_TRANS_ID IS NOT NULL 
            GROUP BY s.SHIPMENT_ID 
        ) AS s 
        LEFT JOIN rm_shipment s1 ON s.SHIPMENT_ID=s1.SHIPMENT_ID 
        LEFT JOIN rm_shipment_trans st ON s.SHIPMENT_ID=st.SHIPMENT_ID AND s.MAX_VERSION_ID=st.VERSION_ID 
        LEFT JOIN vw_funding_source fs ON st.FUNDING_SOURCE_ID=fs.FUNDING_SOURCE_ID 
        LEFT JOIN vw_planning_unit pu ON st.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID 
        LEFT JOIN rm_program_planning_unit ppu ON s1.PROGRAM_ID=ppu.PROGRAM_ID AND st.PLANNING_UNIT_ID=ppu.PLANNING_UNIT_ID 
        WHERE 
            st.ACTIVE AND st.ACCOUNT_FLAG AND ppu.ACTIVE AND pu.ACTIVE 
            AND st.SHIPMENT_STATUS_ID!=8 
            AND COALESCE(st.RECEIVED_DATE, st.EXPECTED_DELIVERY_DATE) BETWEEN VAR_START_DATE AND VAR_STOP_DATE 
        GROUP BY st.PLANNING_UNIT_ID, st.FUNDING_SOURCE_ID;
    ELSEIF VAR_DISPLAY_SHIPMENTS_BY = 2 THEN -- ProcurementAgent
        SELECT 
            st.PLANNING_UNIT_ID, 
            pa.`PROCUREMENT_AGENT_ID` `REPORT_BY_ID`, pa.PROCUREMENT_AGENT_CODE `REPORT_BY_CODE`, pa.LABEL_ID `RB_LABEL_ID`, pa.LABEL_EN `RB_LABEL_EN`, pa.LABEL_FR `RB_LABEL_FR`, pa.LABEL_SP `RB_LABEL_SP`, pa.LABEL_PR `RB_LABEL_PR`, 
            COUNT(st.SHIPMENT_ID) `ORDER_COUNT`, 
            SUM(st.SHIPMENT_QTY) `QUANTITY`, 
            SUM((IFNULL(st.PRODUCT_COST,0) + IFNULL(st.FREIGHT_COST,0)) * s.CONVERSION_RATE_TO_USD) `COST` , pa.COLOR_HTML_CODE, pa.COLOR_HTML_DARK_CODE
        FROM 
            ( 
            SELECT 
                s.SHIPMENT_ID, MAX(st.VERSION_ID) MAX_VERSION_ID, s.CONVERSION_RATE_TO_USD 
            FROM rm_shipment s 
            LEFT JOIN rm_shipment_trans st ON s.SHIPMENT_ID=st.SHIPMENT_ID 
            WHERE 
                s.PROGRAM_ID=VAR_PROGRAM_ID
                AND st.VERSION_ID<=@varVersionId
                AND st.SHIPMENT_TRANS_ID IS NOT NULL 
            GROUP BY s.SHIPMENT_ID 
        ) AS s 
        LEFT JOIN rm_shipment s1 ON s.SHIPMENT_ID=s1.SHIPMENT_ID 
        LEFT JOIN rm_shipment_trans st ON s.SHIPMENT_ID=st.SHIPMENT_ID AND s.MAX_VERSION_ID=st.VERSION_ID 
        LEFT JOIN vw_procurement_agent pa ON st.PROCUREMENT_AGENT_ID=pa.PROCUREMENT_AGENT_ID 
        LEFT JOIN vw_planning_unit pu ON st.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID 
        LEFT JOIN rm_program_planning_unit ppu ON s1.PROGRAM_ID=ppu.PROGRAM_ID AND st.PLANNING_UNIT_ID=ppu.PLANNING_UNIT_ID 
        WHERE 
            st.ACTIVE AND st.ACCOUNT_FLAG AND ppu.ACTIVE AND pu.ACTIVE 
            AND st.SHIPMENT_STATUS_ID!=8 
            AND COALESCE(st.RECEIVED_DATE, st.EXPECTED_DELIVERY_DATE) BETWEEN VAR_START_DATE AND VAR_STOP_DATE 
        GROUP BY st.PLANNING_UNIT_ID, st.PROCUREMENT_AGENT_ID;
    ELSEIF VAR_DISPLAY_SHIPMENTS_BY = 3 THEN -- Status
        SELECT 
            st.PLANNING_UNIT_ID, 
            ss.`SHIPMENT_STATUS_ID` `REPORT_BY_ID`, ss.LABEL_EN `REPORT_BY_CODE`, ss.LABEL_ID `RB_LABEL_ID`, ss.LABEL_EN `RB_LABEL_EN`, ss.LABEL_FR `RB_LABEL_FR`, ss.LABEL_SP `RB_LABEL_SP`, ss.LABEL_PR `RB_LABEL_PR`, 
            COUNT(st.SHIPMENT_ID) `ORDER_COUNT`, 
            SUM(st.SHIPMENT_QTY) `QUANTITY`, 
            SUM((IFNULL(st.PRODUCT_COST,0) + IFNULL(st.FREIGHT_COST,0)) * s.CONVERSION_RATE_TO_USD) `COST` , NULL `COLOR_HTML_CODE`, NULL `COLOR_HTML_DARK_CODE`
        FROM 
            ( 
            SELECT 
                s.SHIPMENT_ID, MAX(st.VERSION_ID) MAX_VERSION_ID, s.CONVERSION_RATE_TO_USD 
            FROM rm_shipment s 
            LEFT JOIN rm_shipment_trans st ON s.SHIPMENT_ID=st.SHIPMENT_ID 
            WHERE 
                s.PROGRAM_ID=VAR_PROGRAM_ID
                AND st.VERSION_ID<=@varVersionId
                AND st.SHIPMENT_TRANS_ID IS NOT NULL 
            GROUP BY s.SHIPMENT_ID 
        ) AS s 
        LEFT JOIN rm_shipment s1 ON s.SHIPMENT_ID=s1.SHIPMENT_ID 
        LEFT JOIN rm_shipment_trans st ON s.SHIPMENT_ID=st.SHIPMENT_ID AND s.MAX_VERSION_ID=st.VERSION_ID 
        LEFT JOIN vw_shipment_status ss ON st.SHIPMENT_STATUS_ID=ss.SHIPMENT_STATUS_ID 
        LEFT JOIN vw_planning_unit pu ON st.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID 
        LEFT JOIN rm_program_planning_unit ppu ON s1.PROGRAM_ID=ppu.PROGRAM_ID AND st.PLANNING_UNIT_ID=ppu.PLANNING_UNIT_ID 
        WHERE 
            st.ACTIVE AND st.ACCOUNT_FLAG AND ppu.ACTIVE AND pu.ACTIVE 
            AND st.SHIPMENT_STATUS_ID!=8 
            AND COALESCE(st.RECEIVED_DATE, st.EXPECTED_DELIVERY_DATE) BETWEEN VAR_START_DATE AND VAR_STOP_DATE 
        GROUP BY st.PLANNING_UNIT_ID, st.SHIPMENT_STATUS_ID;
    END IF;
END$$

DELIMITER ;


USE `fasp`;
DROP procedure IF EXISTS `getDashboardForecastErrorForLoadProgram`;

DELIMITER $$
USE `fasp`$$
CREATE DEFINER=`faspUser`@`%` PROCEDURE `getDashboardForecastErrorForLoadProgram`(VAR_START_DATE DATE, VAR_STOP_DATE DATE, VAR_PROGRAM_ID INT, VAR_VERSION_ID INT)
BEGIN

    
    SELECT GROUP_CONCAT(pu.PLANNING_UNIT_ID) INTO @varPuList
    FROM vw_program p 
    LEFT JOIN rm_program_planning_unit ppu ON p.PROGRAM_ID=ppu.PROGRAM_ID
    LEFT JOIN rm_planning_unit pu ON ppu.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID
    WHERE p.PROGRAM_ID=VAR_PROGRAM_ID AND ppu.ACTIVE AND pu.ACTIVE;
    
    SELECT COUNT(pr.REGION_ID) into @varRegionCount FROM rm_program_region pr WHERE pr.PROGRAM_ID=VAR_PROGRAM_ID;


    SELECT 
        c4.PLANNING_UNIT_ID, c4.LABEL_ID, c4.LABEL_EN, c4.LABEL_FR, c4.LABEL_SP, c4.LABEL_PR, AVG(FORECAST_ERROR) `ERROR_PERC`, COUNT(c4.ACTUAL_CONSUMPTION) `NO_OF_MONTHS`
    FROM (
        SELECT 
            mn.MONTH, pu.PLANNING_UNIT_ID, pu.LABEL_ID, pu.LABEL_EN, pu.LABEL_FR, pu.LABEL_SP, pu.LABEL_PR, c2.CONSUMPTION_DATE, c2.FORECAST_CONSUMPTION, c2.ACTUAL_CONSUMPTION, 
            IF(c2.FORECAST_CONSUMPTION IS NOT NULL AND c2.ACTUAL_CONSUMPTION IS NOT NULL, SUM(ABS(c3.`FORECAST_CONSUMPTION`-c3.`ACTUAL_CONSUMPTION`))/SUM(c3.`ACTUAL_CONSUMPTION`), null) `FORECAST_ERROR`
        FROM mn 
        LEFT JOIN vw_program p ON p.PROGRAM_ID=VAR_PROGRAM_ID
        LEFT JOIN rm_program_planning_unit ppu ON p.PROGRAM_ID=ppu.PROGRAM_ID
        LEFT JOIN vw_planning_unit pu ON ppu.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID
        LEFT JOIN (
            SELECT c1.PLANNING_UNIT_ID, c1.CONSUMPTION_DATE, COUNT(c1.REGION_ID) `REGION_COUNT`, SUM(c1.`FORECAST_CONSUMPTION`) `FORECAST_CONSUMPTION`, SUM(c1.`ACTUAL_CONSUMPTION`) `ACTUAL_CONSUMPTION` 
            FROM (
                SELECT ct.PLANNING_UNIT_ID, ct.REGION_ID, ct.CONSUMPTION_DATE, SUM(IF(ct.ACTUAL_FLAG, ct.CONSUMPTION_QTY, null)) `ACTUAL_CONSUMPTION`, SUM(IF(ct.ACTUAL_FLAG=0, ct.CONSUMPTION_QTY, null)) `FORECAST_CONSUMPTION`
                FROM (
                    SELECT ct.CONSUMPTION_ID, MAX(ct.VERSION_ID) MAX_VERSION_ID FROM rm_consumption c LEFT JOIN rm_consumption_trans ct ON c.CONSUMPTION_ID=ct.CONSUMPTION_ID WHERE ct.VERSION_ID<=VAR_VERSION_ID AND c.PROGRAM_ID=VAR_PROGRAM_ID GROUP BY ct.CONSUMPTION_ID
                ) tc 
                LEFT JOIN rm_consumption cons ON tc.CONSUMPTION_ID=cons.`CONSUMPTION_ID`
                LEFT JOIN rm_consumption_trans ct ON cons.CONSUMPTION_ID=ct.CONSUMPTION_ID AND tc.MAX_VERSION_ID=ct.VERSION_ID
                WHERE ct.CONSUMPTION_DATE BETWEEN VAR_START_DATE AND VAR_STOP_DATE AND FIND_IN_SET(ct.PLANNING_UNIT_ID, @varPuList)
                GROUP BY ct.PLANNING_UNIT_ID, ct.REGION_ID, ct.CONSUMPTION_DATE
    --            ORDER BY ct.PLANNING_UNIT_ID, ct.REGION_ID, ct.CONSUMPTION_DATE
            ) c1 GROUP BY c1.PLANNING_UNIT_ID, c1.CONSUMPTION_DATE HAVING REGION_COUNT=@varRegionCount
        ) c2 ON pu.PLANNING_UNIT_ID=c2.PLANNING_UNIT_ID AND mn.MONTH=c2.CONSUMPTION_DATE
        LEFT JOIN (
            SELECT ct.PLANNING_UNIT_ID, ct.CONSUMPTION_DATE, SUM(IF(ct.ACTUAL_FLAG=0, ct.CONSUMPTION_QTY, null)) `FORECAST_CONSUMPTION`, SUM(IF(ct.ACTUAL_FLAG, ct.CONSUMPTION_QTY, null)) `ACTUAL_CONSUMPTION`
            FROM (
                SELECT ct.CONSUMPTION_ID, MAX(ct.VERSION_ID) MAX_VERSION_ID FROM rm_consumption c LEFT JOIN rm_consumption_trans ct ON c.CONSUMPTION_ID=ct.CONSUMPTION_ID WHERE ct.VERSION_ID<=VAR_VERSION_ID AND c.PROGRAM_ID=VAR_PROGRAM_ID GROUP BY ct.CONSUMPTION_ID
            ) tc 
            LEFT JOIN rm_consumption cons ON tc.CONSUMPTION_ID=cons.`CONSUMPTION_ID`
            LEFT JOIN rm_consumption_trans ct ON cons.CONSUMPTION_ID=ct.CONSUMPTION_ID AND tc.MAX_VERSION_ID=ct.VERSION_ID
            WHERE ct.CONSUMPTION_DATE BETWEEN SUBDATE(VAR_START_DATE, INTERVAL 5 MONTH) AND VAR_STOP_DATE AND FIND_IN_SET(ct.PLANNING_UNIT_ID, @varPuList)
            GROUP BY ct.PLANNING_UNIT_ID, ct.CONSUMPTION_DATE
        ) c3 ON c3.CONSUMPTION_DATE BETWEEN SUBDATE(mn.`MONTH`, INTERVAL 5 MONTH) AND mn.`MONTH` AND c3.PLANNING_UNIT_ID=c2.PLANNING_UNIT_ID
        WHERE mn.MONTH BETWEEN VAR_START_DATE AND VAR_STOP_DATE AND p.PROGRAM_ID=VAR_PROGRAM_ID AND pu.ACTIVE AND c2.PLANNING_UNIT_ID IS NOT NULL
        GROUP BY pu.PLANNING_UNIT_ID, mn.`MONTH`
    --    ORDER BY pu.PLANNING_UNIT_ID, mn.`MONTH`
    ) c4 GROUP BY c4.PLANNING_UNIT_ID ORDER BY `ERROR_PERC` DESC;
END$$

DELIMITER ;

USE `fasp`;
DROP procedure IF EXISTS `getDashboardForecastConsumptionProblemsForLoadProgram`;

DELIMITER $$
USE `fasp`$$
CREATE DEFINER=`faspUser`@`%` PROCEDURE `getDashboardForecastConsumptionProblemsForLoadProgram`(VAR_PROGRAM_ID INT, VAR_VERSION_ID INT, VAR_CUR_DATE DATE)
BEGIN

    SET @varStartDate = VAR_CUR_DATE;
    SET @varStopDate = DATE_ADD(@varStartDate, INTERVAL 18 MONTH);
    SELECT COUNT(*) into @regionCount FROM rm_program_region pr LEFT JOIN rm_region r ON pr.REGION_ID=r.REGION_ID where pr.PROGRAM_ID=VAR_PROGRAM_ID AND pr.ACTIVE AND r.ACTIVE;
    
    SELECT 
        ct.PLANNING_UNIT_ID, 
        19*@regionCount `REQUIRED_COUNT`,
        SUM(IF(ct.ACTUAL_FLAG=0, IF(ct.CONSUMPTION_QTY is not null, 1, 0), 0)) `FORECAST_COUNT`
    FROM (
        SELECT ct.CONSUMPTION_ID, MAX(ct.VERSION_ID) MAX_VERSION_ID 
        FROM rm_consumption c 
        LEFT JOIN rm_consumption_trans ct ON c.CONSUMPTION_ID=ct.CONSUMPTION_ID 
        WHERE ct.VERSION_ID<=VAR_VERSION_ID AND c.PROGRAM_ID=VAR_PROGRAM_ID 
        GROUP BY ct.CONSUMPTION_ID
    ) tc 
    LEFT JOIN rm_consumption cons ON tc.CONSUMPTION_ID=cons.CONSUMPTION_ID
    LEFT JOIN rm_consumption_trans ct ON tc.CONSUMPTION_ID=ct.CONSUMPTION_ID AND tc.MAX_VERSION_ID=ct.VERSION_ID
    LEFT JOIN vw_planning_unit pu ON ct.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID
    LEFT JOIN rm_program_planning_unit ppu ON ppu.PROGRAM_ID=cons.PROGRAM_ID AND ppu.PLANNING_UNIT_ID=ct.PLANNING_UNIT_ID
    WHERE ppu.ACTIVE AND pu.ACTIVE AND ct.ACTIVE AND ct.CONSUMPTION_DATE BETWEEN @varStartDate and @varStopDate
    GROUP BY ct.PLANNING_UNIT_ID;
END$$

DELIMITER ;

USE `fasp`;
DROP procedure IF EXISTS `getDashboardInventoryProblemsForLoadProgram`;

USE `fasp`;
DROP procedure IF EXISTS `fasp`.`getDashboardInventoryProblemsForLoadProgram`;
;

DELIMITER $$
USE `fasp`$$
CREATE DEFINER=`faspUser`@`%` PROCEDURE `getDashboardInventoryProblemsForLoadProgram`(VAR_PROGRAM_ID INT, VAR_VERSION_ID INT, VAR_STOP_DATE DATE)
BEGIN

    SET @stopDate = VAR_STOP_DATE;
    SET @startDate = DATE_SUB(CONCAT(LEFT(@stopDate,7),"-01"), INTERVAL 3 MONTH);
    SELECT COUNT(*) into @regionCount FROM rm_program_region pr LEFT JOIN rm_region r ON pr.REGION_ID=r.REGION_ID where pr.PROGRAM_ID=VAR_PROGRAM_ID AND pr.ACTIVE AND r.ACTIVE;
    
    SELECT p2.PLANNING_UNIT_ID, SUM(IF(p2.INVENTORY_COUNT=@regionCount, 1, 0)) `INVENTORY_COUNT`
    FROM (
        SELECT 
            it.INVENTORY_DATE, rcpu.PLANNING_UNIT_ID, COUNT(it.ACTUAL_QTY) `INVENTORY_COUNT`
        FROM (SELECT i.INVENTORY_ID, MAX(it.VERSION_ID) MAX_VERSION_ID FROM rm_inventory i LEFT JOIN rm_inventory_trans it ON i.INVENTORY_ID=it.INVENTORY_ID WHERE i.PROGRAM_ID=VAR_PROGRAM_ID AND it.VERSION_ID<=VAR_VERSION_ID GROUP BY i.INVENTORY_ID) tc 
        LEFT JOIN rm_inventory i ON tc.INVENTORY_ID=i.INVENTORY_ID
        LEFT JOIN rm_inventory_trans it ON tc.INVENTORY_ID=it.INVENTORY_ID AND tc.MAX_VERSION_ID=it.VERSION_ID
        LEFT JOIN rm_realm_country_planning_unit rcpu ON rcpu.REALM_COUNTRY_PLANNING_UNIT_ID=it.REALM_COUNTRY_PLANNING_UNIT_ID
        WHERE it.ACTIVE AND it.INVENTORY_DATE BETWEEN @startDate AND @stopDate AND it.ACTUAL_QTY IS NOT NULL
        GROUP BY rcpu.PLANNING_UNIT_ID, it.INVENTORY_DATE
    ) p2 GROUP BY p2.PLANNING_UNIT_ID; 
END$$

DELIMITER ;
;

USE `fasp`;
DROP procedure IF EXISTS `getDashboardShipmentProblemsForLoadProgram`;

USE `fasp`;
DROP procedure IF EXISTS `fasp`.`getDashboardShipmentProblemsForLoadProgram`;
;

DELIMITER $$
USE `fasp`$$
CREATE DEFINER=`faspUser`@`%` PROCEDURE `getDashboardShipmentProblemsForLoadProgram`(VAR_PROGRAM_ID INT, VAR_VERSION_ID INT, VAR_STOP_DATE DATE)
BEGIN

    SELECT
        st.PLANNING_UNIT_ID, 
        SUM(IF(st.SHIPMENT_STATUS_ID!=7 AND COALESCE(st.RECEIVED_DATE, st.EXPECTED_DELIVERY_DATE)<VAR_STOP_DATE, 1, 0)) `RECEIVED_DATE_IN_PAST_COUNT`, 
        SUM(IF(st.SHIPMENT_STATUS_ID in (1,2) AND VAR_STOP_DATE > DATE_SUB(COALESCE(st.RECEIVED_DATE, st.EXPECTED_DELIVERY_DATE),INTERVAL IF(
                st.LOCAL_PROCUREMENT=1,
                COALESCE(ppupa1.LOCAL_PROCUREMENT_LEAD_TIME, ppupa2.LOCAL_PROCUREMENT_LEAD_TIME, ppu.LOCAL_PROCUREMENT_LEAD_TIME),
                COALESCE(
                    (ppupa1.ARRIVED_TO_DELIVERED_LEAD_TIME+IF(st.SHIPMENT_MODE='Air', ppupa1.SHIPPED_TO_ARRIVED_BY_AIR_LEAD_TIME, IF(st.SHIPMENT_MODE='Sea', ppupa1.SHIPPED_TO_ARRIVED_BY_SEA_LEAD_TIME, IF(st.SHIPMENT_MODE='Road', ppupa1.SHIPPED_TO_ARRIVED_BY_ROAD_LEAD_TIME, NULL)))+COALESCE(ppupa1.APPROVED_TO_SHIPPED_LEAD_TIME,pa.APPROVED_TO_SHIPPED_LEAD_TIME)+COALESCE(ppupa1.SUBMITTED_TO_APPROVED_LEAD_TIME,pa.SUBMITTED_TO_APPROVED_LEAD_TIME)), 
                    (ppupa2.ARRIVED_TO_DELIVERED_LEAD_TIME+IF(st.SHIPMENT_MODE='Air', ppupa2.SHIPPED_TO_ARRIVED_BY_AIR_LEAD_TIME, IF(st.SHIPMENT_MODE='Sea', ppupa2.SHIPPED_TO_ARRIVED_BY_SEA_LEAD_TIME, IF(st.SHIPMENT_MODE='Road', ppupa2.SHIPPED_TO_ARRIVED_BY_ROAD_LEAD_TIME, NULL)))+COALESCE(ppupa2.APPROVED_TO_SHIPPED_LEAD_TIME,pa.APPROVED_TO_SHIPPED_LEAD_TIME)+COALESCE(ppupa2.SUBMITTED_TO_APPROVED_LEAD_TIME,pa.SUBMITTED_TO_APPROVED_LEAD_TIME)), 
                    (p.ARRIVED_TO_DELIVERED_LEAD_TIME+IF(st.SHIPMENT_MODE='Air', p.SHIPPED_TO_ARRIVED_BY_AIR_LEAD_TIME, IF(st.SHIPMENT_MODE='Sea', p.SHIPPED_TO_ARRIVED_BY_SEA_LEAD_TIME, IF(st.SHIPMENT_MODE='Road', p.SHIPPED_TO_ARRIVED_BY_ROAD_LEAD_TIME, NULL)))+COALESCE(pa.APPROVED_TO_SHIPPED_LEAD_TIME,p.APPROVED_TO_SHIPPED_LEAD_TIME)+COALESCE(pa.SUBMITTED_TO_APPROVED_LEAD_TIME,p.SUBMITTED_TO_APPROVED_LEAD_TIME))
                )
        ) MONTH), 1, 0)) `SHOULD_HAVE_SUBMITTED_COUNT` 
        FROM (
            SELECT st.SHIPMENT_ID, MAX(st.VERSION_ID) MAX_VERSION_ID FROM rm_shipment s LEFT JOIN rm_shipment_trans st ON s.SHIPMENT_ID=st.SHIPMENT_ID WHERE st.VERSION_ID<=VAR_VERSION_ID AND s.PROGRAM_ID=VAR_PROGRAM_ID GROUP BY st.SHIPMENT_ID
        ) ts 
        LEFT JOIN rm_shipment s ON ts.SHIPMENT_ID=s.SHIPMENT_ID
        LEFT JOIN rm_shipment_trans st ON ts.SHIPMENT_ID=st.SHIPMENT_ID AND ts.MAX_VERSION_ID=st.VERSION_ID
        LEFT JOIN rm_program p ON s.PROGRAM_ID=p.PROGRAM_ID
        LEFT JOIN rm_program_planning_unit ppu ON s.PROGRAM_ID=ppu.PROGRAM_ID AND st.PLANNING_UNIT_ID=ppu.PLANNING_UNIT_ID
        LEFT JOIN rm_planning_unit pu ON ppu.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID
        LEFT JOIN rm_program_planning_unit_procurement_agent ppupa1 ON ppu.PROGRAM_ID=ppupa1.PROGRAM_ID AND ppu.PLANNING_UNIT_ID=ppupa1.PLANNING_UNIT_ID AND st.PROCUREMENT_AGENT_ID=ppupa1.PROCUREMENT_AGENT_ID
        LEFT JOIN rm_program_planning_unit_procurement_agent ppupa2 ON ppu.PROGRAM_ID=ppupa2.PROGRAM_ID AND ppupa2.PLANNING_UNIT_ID=-1 AND st.PROCUREMENT_AGENT_ID=ppupa2.PROCUREMENT_AGENT_ID
        LEFT JOIN rm_procurement_agent pa ON st.PROCUREMENT_AGENT_ID=pa.PROCUREMENT_AGENT_ID
        WHERE st.ACTIVE AND st.ACCOUNT_FLAG AND st.SHIPMENT_STATUS_ID!=8 AND ppu.ACTIVE AND pu.ACTIVE
        GROUP BY pu.PLANNING_UNIT_ID;
END$$

DELIMITER ;
;

USE `fasp`;
DROP procedure IF EXISTS `getDashboardActualConsumptionListForLoadProgram`;

DELIMITER $$
USE `fasp`$$
CREATE DEFINER=`faspUser`@`localhost` PROCEDURE `getDashboardActualConsumptionListForLoadProgram`(VAR_PROGRAM_ID INT, VAR_VERSION_ID INT, VAR_CUR_DATE DATE)
BEGIN

    SET @stopDate = CONCAT(SUBSTRING(VAR_CUR_DATE,1,7),"-01");
    SET @startDate = DATE_SUB(@stopDate, INTERVAL 6 MONTH);
    SELECT COUNT(pr.REGION_ID) into @regionCount FROM rm_program_region pr LEFT JOIN rm_region r ON pr.REGION_ID=r.REGION_ID WHERE pr.PROGRAM_ID=VAR_PROGRAM_ID AND pr.ACTIVE AND r.ACTIVE;
    
    SELECT pu.PLANNING_UNIT_ID, mn.`MONTH` `CONSUMPTION_DATE` , IF(c1.ACTUAL_COUNT IS NULL, NULL, IF(c1.ACTUAL_COUNT=@regionCount, 1, 0)) `ACTUAL_COUNT`
    FROM vw_program p 
    LEFT JOIN rm_program_planning_unit ppu ON ppu.PROGRAM_ID=VAR_PROGRAM_ID AND ppu.ACTIVE
    LEFT JOIN vw_planning_unit pu ON ppu.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID AND pu.ACTIVE
    LEFT JOIN mn ON mn.MONTH BETWEEN @startDate and @stopDate
    LEFT JOIN (
        SELECT 
            ct.PLANNING_UNIT_ID, ct.CONSUMPTION_DATE, SUM(IF(ct.CONSUMPTION_QTY IS NOT NULL, 1, 0)) `ACTUAL_COUNT` 
        FROM (SELECT c.PROGRAM_ID, ct.CONSUMPTION_ID, MAX(ct.VERSION_ID) MAX_VERSION_ID FROM rm_consumption c LEFT JOIN rm_consumption_trans ct ON c.CONSUMPTION_ID=ct.CONSUMPTION_ID WHERE ct.VERSION_ID<=VAR_VERSION_ID AND c.PROGRAM_ID=VAR_PROGRAM_ID GROUP BY ct.CONSUMPTION_ID) tc
        LEFT JOIN rm_consumption cons ON tc.CONSUMPTION_ID=cons.CONSUMPTION_ID
        LEFT JOIN rm_consumption_trans ct ON tc.CONSUMPTION_ID=ct.CONSUMPTION_ID AND tc.MAX_VERSION_ID=ct.VERSION_ID
        WHERE ct.ACTIVE AND ct.ACTUAL_FLAG=1 AND ct.CONSUMPTION_DATE BETWEEN @startDate and @stopDate
        GROUP BY ct.PLANNING_UNIT_ID, ct.CONSUMPTION_DATE
    ) c1 ON pu.PLANNING_UNIT_ID=c1.PLANNING_UNIT_ID AND mn.MONTH=c1.CONSUMPTION_DATE
    WHERE p.PROGRAM_ID=VAR_PROGRAM_ID
    ORDER BY pu.PLANNING_UNIT_ID, mn.MONTH DESC;
END$$

DELIMITER ;

