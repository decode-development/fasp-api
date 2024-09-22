ALTER TABLE `fasp`.`rm_shipment_trans` 
CHANGE COLUMN `SHIPMENT_QTY` `SHIPMENT_QTY` DOUBLE(24,8) UNSIGNED NULL DEFAULT NULL COMMENT 'Qty of Logistics Unit in the Shipment' 
-- ,CHANGE COLUMN `SHIPMENT_RCPU_QTY` `SHIPMENT_RCPU_QTY` DOUBLE(24,8) NULL DEFAULT NULL 
;

-- ALTER TABLE `fasp`.`rm_shipment_trans_batch_info` CHANGE COLUMN `BATCH_SHIPMENT_QTY` `BATCH_SHIPMENT_QTY` DECIMAL(24,8) UNSIGNED NOT NULL ;

ALTER TABLE `fasp`.`rm_consumption_trans` 
CHANGE COLUMN `CONSUMPTION_QTY` `CONSUMPTION_QTY` DECIMAL(24,8) NOT NULL, CHANGE COLUMN `CONSUMPTION_RCPU_QTY` `CONSUMPTION_RCPU_QTY` DECIMAL(24,8) NOT NULL 
;

ALTER TABLE `fasp`.`rm_consumption_trans_batch_info` CHANGE COLUMN `CONSUMPTION_QTY` `CONSUMPTION_QTY` DECIMAL(24,8) NOT NULL ;

-- ALTER TABLE `fasp`.`rm_inventory_trans` 
-- CHANGE COLUMN `ACTUAL_QTY` `ACTUAL_QTY` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL COMMENT 'If only an Adjustment Qty is given then this was not an Inventory count but an Adjustment to Inventory. If the Actual Qty is mentioned then the Adjustment Qty was derived' ,
-- CHANGE COLUMN `ADJUSTMENT_QTY` `ADJUSTMENT_QTY` DECIMAL(24,8) NULL DEFAULT NULL COMMENT 'If only an Adjustment Qty is given then this was not an Inventory count but an Adjustment to Inventory. If the Actual Qty is mentioned then the Adjustment Qty was derived' ;

-- ALTER TABLE `fasp`.`rm_inventory_trans_batch_info` 
-- CHANGE COLUMN `ADJUSTMENT_QTY` `ADJUSTMENT_QTY` DECIMAL(24,8) NULL DEFAULT NULL ;

ALTER TABLE `fasp`.`rm_supply_plan_amc` 
CHANGE COLUMN `OPENING_BALANCE` `OPENING_BALANCE` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `OPENING_BALANCE_WPS` `OPENING_BALANCE_WPS` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `MANUAL_PLANNED_SHIPMENT_QTY` `MANUAL_PLANNED_SHIPMENT_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `MANUAL_SUBMITTED_SHIPMENT_QTY` `MANUAL_SUBMITTED_SHIPMENT_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `MANUAL_APPROVED_SHIPMENT_QTY` `MANUAL_APPROVED_SHIPMENT_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `MANUAL_SHIPPED_SHIPMENT_QTY` `MANUAL_SHIPPED_SHIPMENT_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `MANUAL_RECEIVED_SHIPMENT_QTY` `MANUAL_RECEIVED_SHIPMENT_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `MANUAL_ONHOLD_SHIPMENT_QTY` `MANUAL_ONHOLD_SHIPMENT_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `ERP_PLANNED_SHIPMENT_QTY` `ERP_PLANNED_SHIPMENT_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `ERP_SUBMITTED_SHIPMENT_QTY` `ERP_SUBMITTED_SHIPMENT_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `ERP_APPROVED_SHIPMENT_QTY` `ERP_APPROVED_SHIPMENT_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `ERP_SHIPPED_SHIPMENT_QTY` `ERP_SHIPPED_SHIPMENT_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `ERP_RECEIVED_SHIPMENT_QTY` `ERP_RECEIVED_SHIPMENT_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `ERP_ONHOLD_SHIPMENT_QTY` `ERP_ONHOLD_SHIPMENT_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `SHIPMENT_QTY` `SHIPMENT_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `FORECASTED_CONSUMPTION_QTY` `FORECASTED_CONSUMPTION_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `ACTUAL_CONSUMPTION_QTY` `ACTUAL_CONSUMPTION_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `ADJUSTED_CONSUMPTION_QTY` `ADJUSTED_CONSUMPTION_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `ADJUSTMENT_MULTIPLIED_QTY` `ADJUSTMENT_MULTIPLIED_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `STOCK_MULTIPLIED_QTY` `STOCK_MULTIPLIED_QTY` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `EXPIRED_STOCK` `EXPIRED_STOCK` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `EXPIRED_STOCK_WPS` `EXPIRED_STOCK_WPS` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `CLOSING_BALANCE` `CLOSING_BALANCE` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `CLOSING_BALANCE_WPS` `CLOSING_BALANCE_WPS` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `UNMET_DEMAND` `UNMET_DEMAND` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `UNMET_DEMAND_WPS` `UNMET_DEMAND_WPS` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `NATIONAL_ADJUSTMENT` `NATIONAL_ADJUSTMENT` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `NATIONAL_ADJUSTMENT_WPS` `NATIONAL_ADJUSTMENT_WPS` DECIMAL(24,8) NULL DEFAULT NULL ;


TRUNCATE TABLE tmp_nsp;

ALTER TABLE `fasp`.`tmp_nsp` 
CHANGE COLUMN `FORECASTED_CONSUMPTION` `FORECASTED_CONSUMPTION` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `ACTUAL_CONSUMPTION` `ACTUAL_CONSUMPTION` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `ADJUSTED_CONSUMPTION` `ADJUSTED_CONSUMPTION` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `ADJUSTMENT` `ADJUSTMENT` DECIMAL(24,8) NULL DEFAULT NULL ,
CHANGE COLUMN `STOCK` `STOCK` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `SHIPMENT` `SHIPMENT` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `SHIPMENT_WPS` `SHIPMENT_WPS` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `MANUAL_PLANNED_SHIPMENT` `MANUAL_PLANNED_SHIPMENT` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `MANUAL_SUBMITTED_SHIPMENT` `MANUAL_SUBMITTED_SHIPMENT` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `MANUAL_APPROVED_SHIPMENT` `MANUAL_APPROVED_SHIPMENT` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `MANUAL_SHIPPED_SHIPMENT` `MANUAL_SHIPPED_SHIPMENT` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `MANUAL_RECEIVED_SHIPMENT` `MANUAL_RECEIVED_SHIPMENT` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `MANUAL_ONHOLD_SHIPMENT` `MANUAL_ONHOLD_SHIPMENT` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `ERP_PLANNED_SHIPMENT` `ERP_PLANNED_SHIPMENT` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `ERP_SUBMITTED_SHIPMENT` `ERP_SUBMITTED_SHIPMENT` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `ERP_APPROVED_SHIPMENT` `ERP_APPROVED_SHIPMENT` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `ERP_SHIPPED_SHIPMENT` `ERP_SHIPPED_SHIPMENT` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `ERP_RECEIVED_SHIPMENT` `ERP_RECEIVED_SHIPMENT` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `ERP_ONHOLD_SHIPMENT` `ERP_ONHOLD_SHIPMENT` DECIMAL(24,8) UNSIGNED NULL DEFAULT NULL ;


-- ALTER TABLE `fasp`.`rm_supply_plan_batch_qty` 
-- CHANGE COLUMN `ACTUAL_CONSUMPTION_QTY` `ACTUAL_CONSUMPTION_QTY` DOUBLE(24,8) UNSIGNED NULL DEFAULT NULL ,
-- CHANGE COLUMN `SHIPMENT_QTY` `SHIPMENT_QTY` DOUBLE(24,8) UNSIGNED NOT NULL ,
-- CHANGE COLUMN `SHIPMENT_QTY_WPS` `SHIPMENT_QTY_WPS` DOUBLE(24,8) UNSIGNED NOT NULL ,
-- CHANGE COLUMN `ADJUSTMENT_MULTIPLIED_QTY` `ADJUSTMENT_MULTIPLIED_QTY` DOUBLE(24,8) NULL DEFAULT NULL ,
-- CHANGE COLUMN `STOCK_MULTIPLIED_QTY` `STOCK_MULTIPLIED_QTY` DOUBLE(24,8) NULL DEFAULT NULL ,
-- CHANGE COLUMN `OPENING_BALANCE` `OPENING_BALANCE` DOUBLE(24,8) NULL DEFAULT NULL ,
-- CHANGE COLUMN `OPENING_BALANCE_WPS` `OPENING_BALANCE_WPS` DOUBLE(24,8) NULL DEFAULT NULL ,
-- CHANGE COLUMN `EXPIRED_STOCK` `EXPIRED_STOCK` DOUBLE(24,8) NULL DEFAULT NULL ,
-- CHANGE COLUMN `EXPIRED_STOCK_WPS` `EXPIRED_STOCK_WPS` DOUBLE(24,8) NULL DEFAULT NULL ,
-- CHANGE COLUMN `CALCULATED_CONSUMPTION` `CALCULATED_CONSUMPTION` DOUBLE(24,8) NULL DEFAULT NULL ,
-- CHANGE COLUMN `CALCULATED_CONSUMPTION_WPS` `CALCULATED_CONSUMPTION_WPS` DOUBLE(24,8) NULL DEFAULT NULL ,
-- CHANGE COLUMN `CLOSING_BALANCE` `CLOSING_BALANCE` DOUBLE(24,8) NULL DEFAULT NULL ,
-- CHANGE COLUMN `CLOSING_BALANCE_WPS` `CLOSING_BALANCE_WPS` DOUBLE(24,8) NULL DEFAULT NULL ;


USE `fasp`;
DROP procedure IF EXISTS `buildNewSupplyPlanRegion`;

USE `fasp`;
DROP procedure IF EXISTS `fasp`.`buildNewSupplyPlanRegion`;
;

DELIMITER $$
USE `fasp`$$
CREATE DEFINER=`faspUser`@`%` PROCEDURE `buildNewSupplyPlanRegion`(VAR_PROGRAM_ID INT(10), VAR_VERSION_ID INT(10))
BEGIN
    SET @programId = VAR_PROGRAM_ID;
    SET @versionId = VAR_VERSION_ID;
    
    SELECT COUNT(*) INTO @currentCount FROM rm_supply_plan_amc spa WHERE spa.PROGRAM_ID=@programId AND spa.VERSION_ID=@versionId;
    -- Get the Region count for this Program
    SELECT count(*) INTO @regionCount FROM rm_program_region pr WHERE pr.PROGRAM_ID=@programId;
        
    DELETE tn.* FROM tmp_nsp tn WHERE tn.PROGRAM_ID=@programId AND tn.VERSION_ID=@versionId;
        
    -- DELETE nsps.* FROM rm_nsp_summary nsps WHERE nsps.PROGRAM_ID=@programId AND nsps.VERSION_ID=@versionId;
    -- DELETE nspr.* FROM rm_nsp_region nspr WHERE nspr.PROGRAM_ID=@programId AND nspr.VERSION_ID=@versionId;
    
    -- Populate the nsp_region table with all the raw data that we have for Consumption, Inventory and Shipment per Region
    INSERT INTO tmp_nsp (
        PROGRAM_ID, VERSION_ID, PLANNING_UNIT_ID, TRANS_DATE, REGION_ID, 
        FORECASTED_CONSUMPTION, ACTUAL_CONSUMPTION, ADJUSTED_CONSUMPTION, ADJUSTMENT, STOCK, REGION_COUNT, 
        MANUAL_PLANNED_SHIPMENT, MANUAL_SUBMITTED_SHIPMENT, MANUAL_APPROVED_SHIPMENT, MANUAL_SHIPPED_SHIPMENT, MANUAL_RECEIVED_SHIPMENT, MANUAL_ONHOLD_SHIPMENT, 
        ERP_PLANNED_SHIPMENT, ERP_SUBMITTED_SHIPMENT, ERP_APPROVED_SHIPMENT, ERP_SHIPPED_SHIPMENT, ERP_RECEIVED_SHIPMENT, ERP_ONHOLD_SHIPMENT 
    )
    SELECT 
        @programId `PROGRAM_ID`, @versionId, m.`PLANNING_UNIT_ID`, m.`TRANS_DATE`, o.`REGION_ID`, 
        SUM(o.`FORECASTED_CONSUMPTION`), SUM(o.`ACTUAL_CONSUMPTION`), SUM(o.`ADJUSTED_CONSUMPTION`), SUM(o.`ADJUSTMENT`), SUM(o.`STOCK`), @regionCount, 
        SUM(o.`MANUAL_PLANNED_SHIPMENT`), SUM(o.`MANUAL_SUBMITTED_SHIPMENT`), SUM(o.`MANUAL_APPROVED_SHIPMENT`), SUM(o.`MANUAL_SHIPPED_SHIPMENT`), SUM(o.`MANUAL_RECEIVED_SHIPMENT`), SUM(o.`MANUAL_ONHOLD_SHIPMENT`), 
        SUM(o.`ERP_PLANNED_SHIPMENT`), SUM(o.`ERP_SUBMITTED_SHIPMENT`), SUM(o.`ERP_APPROVED_SHIPMENT`), SUM(o.`ERP_SHIPPED_SHIPMENT`), SUM(o.`ERP_RECEIVED_SHIPMENT`), SUM(o.`ERP_ONHOLD_SHIPMENT`)
    FROM 
        (
        SELECT a3.PLANNING_UNIT_ID, mn.MONTH `TRANS_DATE` 
        FROM 
            (
            SELECT a2.PLANNING_UNIT_ID, MIN(a2.TRANS_DATE) `MIN_TRANS_DATE`, MAX(a2.TRANS_DATE) `MAX_TRANS_DATE` 
            FROM 
                (
                SELECT tc.`PLANNING_UNIT_ID`, `TRANS_DATE`
                FROM 
                    (
                    SELECT 
                        ct.PLANNING_UNIT_ID, LEFT(ct.`CONSUMPTION_DATE`,7) `TRANS_DATE`
                    FROM 
                        (
                        SELECT c.`CONSUMPTION_ID`, MAX(ct.`VERSION_ID`) `MAX_VERSION_ID` FROM rm_consumption c LEFT JOIN rm_consumption_trans ct ON c.`CONSUMPTION_ID`=ct.`CONSUMPTION_ID` WHERE c.`PROGRAM_ID`=@programId AND ct.`VERSION_ID`<=@versionId AND ct.`CONSUMPTION_TRANS_ID` IS NOT NULL GROUP BY c.`CONSUMPTION_ID`
                    ) tc
                    LEFT JOIN rm_consumption c ON c.`CONSUMPTION_ID`=tc.`CONSUMPTION_ID`
                    LEFT JOIN rm_consumption_trans ct ON c.`CONSUMPTION_ID`=ct.`CONSUMPTION_ID` AND tc.`MAX_VERSION_ID`=ct.`VERSION_ID`
                    WHERE ct.`ACTIVE`
                    GROUP BY c.`PROGRAM_ID`, ct.`PLANNING_UNIT_ID`, ct.`CONSUMPTION_DATE`, ct.`REGION_ID`
                ) tc 
                GROUP BY tc.`PLANNING_UNIT_ID`, tc.`TRANS_DATE`

                UNION

                SELECT 
                    st.PLANNING_UNIT_ID, LEFT(COALESCE(st.`RECEIVED_DATE`, st.`EXPECTED_DELIVERY_DATE`),7) `TRANS_DATE`
                    FROM 
                        (
                        SELECT s.PROGRAM_ID, s.SHIPMENT_ID, MAX(st.VERSION_ID) MAX_VERSION_ID FROM rm_shipment s LEFT JOIN rm_shipment_trans st ON s.SHIPMENT_ID=st.SHIPMENT_ID WHERE s.PROGRAM_ID=@programId AND st.VERSION_ID<=@versionId AND st.SHIPMENT_TRANS_ID IS NOT NULL GROUP BY s.SHIPMENT_ID
                    ) ts
                    LEFT JOIN rm_shipment s ON s.SHIPMENT_ID=ts.SHIPMENT_ID
                    LEFT JOIN rm_shipment_trans st ON s.SHIPMENT_ID=st.SHIPMENT_ID AND ts.MAX_VERSION_ID=st.VERSION_ID
                    WHERE st.ACTIVE AND st.ACCOUNT_FLAG AND st.SHIPMENT_STATUS_ID!=8 
                    GROUP BY st.PLANNING_UNIT_ID, COALESCE(st.RECEIVED_DATE, st.EXPECTED_DELIVERY_DATE)

                UNION

                SELECT 
                    rcpu.PLANNING_UNIT_ID, LEFT(it.INVENTORY_DATE,7) `TRANS_DATE`
                FROM 
                    (
                    SELECT i.PROGRAM_ID, i.INVENTORY_ID, MAX(it.VERSION_ID) MAX_VERSION_ID FROM rm_inventory i LEFT JOIN rm_inventory_trans it ON i.INVENTORY_ID=it.INVENTORY_ID WHERE i.PROGRAM_ID=@programId AND it.VERSION_ID<=@versionId AND it.INVENTORY_TRANS_ID IS NOT NULL GROUP BY i.INVENTORY_ID
                ) ti
                LEFT JOIN rm_inventory i ON i.INVENTORY_ID=ti.INVENTORY_ID
                LEFT JOIN rm_inventory_trans it ON i.INVENTORY_ID=it.INVENTORY_ID AND ti.MAX_VERSION_ID=it.VERSION_ID
                LEFT JOIN rm_realm_country_planning_unit rcpu ON it.REALM_COUNTRY_PLANNING_UNIT_ID=rcpu.REALM_COUNTRY_PLANNING_UNIT_ID
                WHERE it.ACTIVE
                GROUP BY rcpu.PLANNING_UNIT_ID, it.INVENTORY_DATE
            ) as a2 GROUP BY a2.PLANNING_UNIT_ID
        ) as a3 
        LEFT JOIN rm_program_planning_unit ppu ON ppu.PROGRAM_ID=@programId AND ppu.PLANNING_UNIT_ID=a3.PLANNING_UNIT_ID
        LEFT JOIN mn ON LEFT(mn.MONTH,7) BETWEEN LEFT(DATE_SUB(CONCAT(a3.MIN_TRANS_DATE,'-01'), INTERVAL ppu.MONTHS_IN_FUTURE_FOR_AMC+1 MONTH),7) AND LEFT(IF(DATE_ADD(CONCAT(a3.MAX_TRANS_DATE,'-01'), INTERVAL ppu.MONTHS_IN_PAST_FOR_AMC MONTH)<(DATE_ADD(DATE(now()),INTERVAL 60 MONTH)),(DATE_ADD(DATE(now()),INTERVAL 60 MONTH)),IF(DATE_ADD(DATE(now()),INTERVAL 120 MONTH) < DATE_ADD(CONCAT(a3.MAX_TRANS_DATE,'-01'), INTERVAL ppu.MONTHS_IN_PAST_FOR_AMC MONTH),(DATE_ADD(DATE(now()),INTERVAL 120 MONTH)),DATE_ADD(CONCAT(a3.MAX_TRANS_DATE,'-01'), INTERVAL ppu.MONTHS_IN_PAST_FOR_AMC MONTH))),7)
        WHERE ppu.PLANNING_UNIT_ID IS NOT NULL
    ) AS m 
    LEFT JOIN 
        (
        SELECT 
            tc.`PROGRAM_ID`, tc.`PLANNING_UNIT_ID`, LEFT(tc.`CONSUMPTION_DATE`, 7) `TRANS_DATE`, tc.`REGION_ID`, 
            SUM(tc.`FORECASTED_CONSUMPTION`) `FORECASTED_CONSUMPTION`, SUM(tc.`ACTUAL_CONSUMPTION`) `ACTUAL_CONSUMPTION`, SUM(tc.`ADJUSTED_CONSUMPTION`) `ADJUSTED_CONSUMPTION`, null `ADJUSTMENT`, null `STOCK`, 
            null `MANUAL_PLANNED_SHIPMENT`, null `MANUAL_SUBMITTED_SHIPMENT`, null `MANUAL_APPROVED_SHIPMENT`, null `MANUAL_SHIPPED_SHIPMENT`, null `MANUAL_RECEIVED_SHIPMENT`, null `MANUAL_ONHOLD_SHIPMENT`, 
            null `ERP_PLANNED_SHIPMENT`, null `ERP_SUBMITTED_SHIPMENT`, null `ERP_APPROVED_SHIPMENT`, null `ERP_SHIPPED_SHIPMENT`, null `ERP_RECEIVED_SHIPMENT`, null `ERP_ONHOLD_SHIPMENT`
        FROM 
            (
            SELECT 
                c.`PROGRAM_ID`, ct.`PLANNING_UNIT_ID`, ct.`CONSUMPTION_DATE`, ct.`REGION_ID`, 
                ct.`ACTIVE`, 
                SUM(IF(ct.`ACTUAL_FLAG`=0, ct.`CONSUMPTION_QTY`, null)) `FORECASTED_CONSUMPTION`,
                SUM(IF(ct.`ACTUAL_FLAG`=1, ct.`CONSUMPTION_QTY`, null)) `ACTUAL_CONSUMPTION`,
                SUM(IF(DAY(LAST_DAY(ct.`CONSUMPTION_DATE`)) - IFNULL(ct.DAYS_OF_STOCK_OUT, 0) <= 0, IF(ct.`ACTUAL_FLAG` = 1, ct.`CONSUMPTION_QTY`, NULL), IF(ct.`ACTUAL_FLAG` = 1, ct.`CONSUMPTION_QTY` * DAY(LAST_DAY(ct.`CONSUMPTION_DATE`)) / (DAY(LAST_DAY(ct.`CONSUMPTION_DATE`)) - IFNULL(ct.DAYS_OF_STOCK_OUT, 0)), NULL))) `ADJUSTED_CONSUMPTION`
                
            FROM 
                (
                SELECT c.`CONSUMPTION_ID`, MAX(ct.`VERSION_ID`) `MAX_VERSION_ID` FROM rm_consumption c LEFT JOIN rm_consumption_trans ct ON c.`CONSUMPTION_ID`=ct.`CONSUMPTION_ID` WHERE c.`PROGRAM_ID`=@programId AND ct.`VERSION_ID`<=@versionId AND ct.`CONSUMPTION_TRANS_ID` IS NOT NULL GROUP BY c.`CONSUMPTION_ID`
            ) tc
            LEFT JOIN rm_consumption c ON c.`CONSUMPTION_ID`=tc.`CONSUMPTION_ID`
            LEFT JOIN rm_consumption_trans ct ON c.`CONSUMPTION_ID`=ct.`CONSUMPTION_ID` AND tc.`MAX_VERSION_ID`=ct.`VERSION_ID`
            WHERE ct.`ACTIVE`
            GROUP BY c.`PROGRAM_ID`, ct.`PLANNING_UNIT_ID`, ct.`CONSUMPTION_DATE`, ct.`REGION_ID`
        ) tc 
        GROUP BY tc.`PROGRAM_ID`, tc.`PLANNING_UNIT_ID`, tc.`CONSUMPTION_DATE`, tc.`REGION_ID`

        UNION

        SELECT 
            s.`PROGRAM_ID`, st.`PLANNING_UNIT_ID`, LEFT(COALESCE(st.`RECEIVED_DATE`, st.`EXPECTED_DELIVERY_DATE`),7) `TRANS_DATE`, null `REGION_ID`,
            null `FORECASTED_CONSUMPTION`, null `ACTUAL_CONSUMPTION`, null `ADJUSTED_CONSUMPTION`, null `ADJUSTMENT`, null `STOCK`,
            SUM(IF((st.ERP_FLAG IS NULL OR st.ERP_FLAG=0) AND st.`SHIPMENT_STATUS_ID`=1, st.`SHIPMENT_QTY`, null )) `MANUAL_PLANNED_SHIPMENT`, 
            SUM(IF((st.ERP_FLAG IS NULL OR st.ERP_FLAG=0) AND st.`SHIPMENT_STATUS_ID`=3, st.`SHIPMENT_QTY`, null )) `MANUAL_SUBMITTED_SHIPMENT`, 
            SUM(IF((st.ERP_FLAG IS NULL OR st.ERP_FLAG=0) AND st.`SHIPMENT_STATUS_ID`=4, st.`SHIPMENT_QTY`, null )) `MANUAL_APPROVED_SHIPMENT`, 
            SUM(IF((st.ERP_FLAG IS NULL OR st.ERP_FLAG=0) AND st.`SHIPMENT_STATUS_ID` IN (5,6), st.`SHIPMENT_QTY`, null )) `MANUAL_SHIPPED_SHIPMENT`, 
            SUM(IF((st.ERP_FLAG IS NULL OR st.ERP_FLAG=0) AND st.`SHIPMENT_STATUS_ID`=7, st.`SHIPMENT_QTY`, null )) `MANUAL_RECEIVED_SHIPMENT`, 
            SUM(IF((st.ERP_FLAG IS NULL OR st.ERP_FLAG=0) AND st.`SHIPMENT_STATUS_ID`=9, st.`SHIPMENT_QTY`, null )) `MANUAL_ONHOLD_SHIPMENT`, 
            SUM(IF(st.`ERP_FLAG`=1 AND st.`SHIPMENT_STATUS_ID`=1, st.`SHIPMENT_QTY`, null )) `ERP_PLANNED_SHIPMENT`, 
            SUM(IF(st.`ERP_FLAG`=1 AND st.`SHIPMENT_STATUS_ID`=3, st.`SHIPMENT_QTY`, null )) `ERP_SUBMITTED_SHIPMENT`, 
            SUM(IF(st.`ERP_FLAG`=1 AND st.`SHIPMENT_STATUS_ID`=4, st.`SHIPMENT_QTY`, null )) `ERP_APPROVED_SHIPMENT`, 
            SUM(IF(st.`ERP_FLAG`=1 AND st.`SHIPMENT_STATUS_ID` IN (5,6), st.`SHIPMENT_QTY`, null )) `ERP_SHIPPED_SHIPMENT`, 
            SUM(IF(st.`ERP_FLAG`=1 AND st.`SHIPMENT_STATUS_ID` = 7, st.`SHIPMENT_QTY`, null )) `ERP_RECEIVED_SHIPMENT`, 
            SUM(IF(st.`ERP_FLAG`=1 AND st.`SHIPMENT_STATUS_ID`=9, st.`SHIPMENT_QTY`, null )) `ERP_ONHOLD_SHIPMENT`
        FROM 
            (
            SELECT s.PROGRAM_ID, s.SHIPMENT_ID, MAX(st.VERSION_ID) MAX_VERSION_ID FROM rm_shipment s LEFT JOIN rm_shipment_trans st ON s.SHIPMENT_ID=st.SHIPMENT_ID WHERE s.PROGRAM_ID=@programId AND st.VERSION_ID<=@versionId AND st.SHIPMENT_TRANS_ID IS NOT NULL GROUP BY s.SHIPMENT_ID
        ) ts
        LEFT JOIN rm_shipment s ON s.SHIPMENT_ID=ts.SHIPMENT_ID
        LEFT JOIN rm_shipment_trans st ON s.SHIPMENT_ID=st.SHIPMENT_ID AND ts.MAX_VERSION_ID=st.VERSION_ID
        WHERE st.ACTIVE AND st.ACCOUNT_FLAG AND st.SHIPMENT_STATUS_ID!=8 
        GROUP BY s.PROGRAM_ID, st.PLANNING_UNIT_ID, LEFT(COALESCE(st.RECEIVED_DATE, st.EXPECTED_DELIVERY_DATE),7)

        UNION

        SELECT 
            i.PROGRAM_ID, rcpu.PLANNING_UNIT_ID, LEFT(it.INVENTORY_DATE,7) `TRANS_DATE`, it.REGION_ID,
            null `FORECASTED_CONSUMPTION`, null `ACTUAL_CONSUMPTION`, null `ADJUSTED_CONSUMPTION`, SUM(it.ADJUSTMENT_QTY*IF(rcpu.CONVERSION_METHOD IS NULL OR rcpu.CONVERSION_METHOD=1, rcpu.CONVERSION_NUMBER, IF(rcpu.CONVERSION_METHOD=2,1/rcpu.CONVERSION_NUMBER,0))) `ADJUSTMENT`,  SUM(it.ACTUAL_QTY*IF(rcpu.CONVERSION_METHOD IS NULL OR rcpu.CONVERSION_METHOD=1, rcpu.CONVERSION_NUMBER, IF(rcpu.CONVERSION_METHOD=2,1/rcpu.CONVERSION_NUMBER,0))) `STOCK`,
            null `MANUAL_PLANNED_SHIPMENT`, null `MANUAL_SUBMITTED_SHIPMENT`, null `MANUAL_APPROVED_SHIPMENT`, null `MANUAL_SHIPPED_SHIPMENT`, null `MANUAL_RECEIVED_SHIPMENT`, null `MANUAL_ONHOLD_SHIPMENT`, 
            null `ERP_PLANNED_SHIPMENT`, null `ERP_SUBMITTED_SHIPMENT`, null `ERP_APPROVED_SHIPMENT`, null `ERP_SHIPPED_SHIPMENT`, null `ERP_RECEIVED_SHIPMENT`, null `ERP_ONHOLD_SHIPMENT`
        FROM 
            (
            SELECT i.PROGRAM_ID, i.INVENTORY_ID, MAX(it.VERSION_ID) MAX_VERSION_ID FROM rm_inventory i LEFT JOIN rm_inventory_trans it ON i.INVENTORY_ID=it.INVENTORY_ID WHERE i.PROGRAM_ID=@programId AND it.VERSION_ID<=@versionId AND it.INVENTORY_TRANS_ID IS NOT NULL GROUP BY i.INVENTORY_ID
        ) ti
        LEFT JOIN rm_inventory i ON i.INVENTORY_ID=ti.INVENTORY_ID
        LEFT JOIN rm_inventory_trans it ON i.INVENTORY_ID=it.INVENTORY_ID AND ti.MAX_VERSION_ID=it.VERSION_ID
        LEFT JOIN rm_realm_country_planning_unit rcpu ON it.REALM_COUNTRY_PLANNING_UNIT_ID=rcpu.REALM_COUNTRY_PLANNING_UNIT_ID
        WHERE it.ACTIVE
        GROUP BY i.PROGRAM_ID, rcpu.PLANNING_UNIT_ID, it.INVENTORY_DATE, it.REGION_ID
    ) AS o ON m.PLANNING_UNIT_ID=o.PLANNING_UNIT_ID AND LEFT(m.TRANS_DATE,7)=o.TRANS_DATE GROUP BY m.PLANNING_UNIT_ID, LEFT(m.TRANS_DATE,7), o.REGION_ID;
           
    -- Update the UseActualConsumption field = 1 
    -- IF All Regions have reported Consumption or if Sum(ActualConsumption)>Sum(ForecastedConsumption)
    -- ELSE UseActualConsumption field = 0
    UPDATE tmp_nsp tn LEFT JOIN (SELECT tn.PLANNING_UNIT_ID, tn.TRANS_DATE, SUM(IF(tn.ACTUAL_CONSUMPTION IS NOT NULL, 1,0)) `COUNT_OF_ACTUAL_CONSUMPTION`, SUM(tn.ACTUAL_CONSUMPTION) `TOTAL_ACTUAL_CONSUMPTION`, SUM(tn.FORECASTED_CONSUMPTION) `TOTAL_FORECASTED_CONSUMPTION` FROM tmp_nsp tn WHERE tn.PROGRAM_ID=@programId AND tn.VERSION_ID=@versionId AND tn.REGION_ID IS NOT NULL GROUP BY tn.PLANNING_UNIT_ID, tn.TRANS_DATE) rcount ON tn.PLANNING_UNIT_ID=rcount.PLANNING_UNIT_ID AND tn.TRANS_DATE=rcount.TRANS_DATE SET tn.USE_ACTUAL_CONSUMPTION=IF(rcount.COUNT_OF_ACTUAL_CONSUMPTION=@regionCount, 1, IF(rcount.TOTAL_ACTUAL_CONSUMPTION>rcount.TOTAL_FORECASTED_CONSUMPTION, 1, 0)) WHERE tn.PROGRAM_ID=@programId AND tn.VERSION_ID=@versionId AND tn.REGION_ID IS NOT NULL;
        
    -- Update the RegionStockCount field based on the number of Regions that have reported Stock
    UPDATE tmp_nsp tn LEFT JOIN (SELECT tn.PLANNING_UNIT_ID, tn.TRANS_DATE, COUNT(tn.STOCK) CNT FROM tmp_nsp tn WHERE tn.PROGRAM_ID=@programId AND tn.VERSION_ID=@versionId AND tn.REGION_ID IS NOT NULL GROUP BY tn.PLANNING_UNIT_ID, tn.TRANS_DATE, tn.REGION_ID) rcount ON tn.PLANNING_UNIT_ID=rcount.PLANNING_UNIT_ID AND tn.TRANS_DATE=rcount.TRANS_DATE SET tn.REGION_STOCK_COUNT = rcount.CNT WHERE tn.PROGRAM_ID=@programId AND tn.VERSION_ID=@versionId AND tn.REGION_ID IS NOT NULL;
        
    -- To get the range for AMC calculations
    -- SELECT MIN(sp.TRANS_DATE), ADDDATE(MAX(sp.TRANS_DATE), INTERVAL ppu.MONTHS_IN_PAST_FOR_AMC MONTH) INTO @startMonth, @stopMonth  FROM rm_supply_plan sp LEFT JOIN rm_program_planning_unit ppu ON sp.PROGRAM_ID=ppu.PROGRAM_ID AND sp.PLANNING_UNIT_ID=ppu.PLANNING_UNIT_ID WHERE sp.PROGRAM_ID=@programId and sp.VERSION_ID=@versionId;
    
    SELECT 
        tn.PLANNING_UNIT_ID, tn.TRANS_DATE, IFNULL(ppu.SHELF_LIFE, 24) SHELF_LIFE, tn.REGION_ID, tn.FORECASTED_CONSUMPTION, tn.ACTUAL_CONSUMPTION, tn.ADJUSTED_CONSUMPTION,
        tn.USE_ACTUAL_CONSUMPTION, tn.ADJUSTMENT, tn.STOCK, tn.REGION_STOCK_COUNT, tn.REGION_COUNT,
        tn.MANUAL_PLANNED_SHIPMENT, tn.MANUAL_SUBMITTED_SHIPMENT, tn.MANUAL_APPROVED_SHIPMENT, tn.MANUAL_SHIPPED_SHIPMENT, tn.MANUAL_RECEIVED_SHIPMENT, tn.MANUAL_ONHOLD_SHIPMENT, 
        tn.ERP_PLANNED_SHIPMENT, tn.ERP_SUBMITTED_SHIPMENT, tn.ERP_APPROVED_SHIPMENT, tn.ERP_SHIPPED_SHIPMENT, tn.ERP_RECEIVED_SHIPMENT, tn.ERP_ONHOLD_SHIPMENT
    FROM tmp_nsp tn LEFT JOIN rm_program_planning_unit ppu ON tn.PROGRAM_ID=ppu.PROGRAM_ID AND tn.PLANNING_UNIT_ID=ppu.PLANNING_UNIT_ID WHERE tn.PROGRAM_ID=@programId AND tn.VERSION_ID=@versionId 
    order by tn.PLANNING_UNIT_ID,tn.TRANS_DATE,tn.REGION_ID
    ; 

END$$

DELIMITER ;
;

USE `fasp`;
DROP procedure IF EXISTS `buildNewSupplyPlanBatch`;

USE `fasp`;
DROP procedure IF EXISTS `fasp`.`buildNewSupplyPlanBatch`;
;

DELIMITER $$
USE `fasp`$$
CREATE DEFINER=`faspUser`@`%` PROCEDURE `buildNewSupplyPlanBatch`(VAR_PROGRAM_ID INT(10), VAR_VERSION_ID INT(10))
BEGIN
    SET @programId = VAR_PROGRAM_ID;
    SET @versionId = VAR_VERSION_ID;
    
        SELECT 
        o.PROGRAM_ID, @versionId, o.PLANNING_UNIT_ID, DATE(CONCAT(o.TRANS_DATE,"-01")) `TRANS_DATE`, o.BATCH_ID, o.EXPIRY_DATE, o.SHELF_LIFE,
        SUM(o.FORECASTED_CONSUMPTION) `FORECASTED_CONSUMPTION`, SUM(o.ACTUAL_CONSUMPTION) `ACTUAL_CONSUMPTION`, 
        SUM(o.SHIPMENT) `SHIPMENT`, SUM(o.SHIPMENT_WPS) `SHIPMENT_WPS`, SUM(o.ADJUSTMENT) `ADJUSTMENT`, SUM(o.STOCK) `STOCK`, SUM(o.INVENTORY_QTY) `INVENTORY_QTY`  
        FROM ( 
            SELECT 
            tc.PROGRAM_ID, tc.CONSUMPTION_ID `TRANS_ID`, tc.PLANNING_UNIT_ID, LEFT(tc.CONSUMPTION_DATE, 7) `TRANS_DATE`, tc.BATCH_ID, tc.EXPIRY_DATE `EXPIRY_DATE`, tc.SHELF_LIFE,
            SUM(FORECASTED_CONSUMPTION) `FORECASTED_CONSUMPTION`, SUM(ACTUAL_CONSUMPTION) `ACTUAL_CONSUMPTION`, 
            null `SHIPMENT`, null `SHIPMENT_WPS`,null `ADJUSTMENT`, null  `STOCK`, 0 `INVENTORY_QTY` 
            FROM (
                SELECT 
                    c.PROGRAM_ID, c.CONSUMPTION_ID, ct.REGION_ID, ct.PLANNING_UNIT_ID, ct.CONSUMPTION_DATE, 
                    ctbi.BATCH_ID `BATCH_ID`, bi.EXPIRY_DATE, IFNULL(ppu.SHELF_LIFE,24) `SHELF_LIFE`,
                    SUM(IF(ct.ACTUAL_FLAG=1, COALESCE(ctbi.CONSUMPTION_QTY * IF(rcpu.CONVERSION_METHOD IS NULL OR rcpu.CONVERSION_METHOD=1, rcpu.CONVERSION_NUMBER, IF(rcpu.CONVERSION_METHOD=2,1/rcpu.CONVERSION_NUMBER,0)), ct.CONSUMPTION_QTY), null)) `ACTUAL_CONSUMPTION`, 
                    SUM(IF(ct.ACTUAL_FLAG=0, COALESCE(ctbi.CONSUMPTION_QTY * IF(rcpu.CONVERSION_METHOD IS NULL OR rcpu.CONVERSION_METHOD=1, rcpu.CONVERSION_NUMBER, IF(rcpu.CONVERSION_METHOD=2,1/rcpu.CONVERSION_NUMBER,0)), ct.CONSUMPTION_QTY), null)) `FORECASTED_CONSUMPTION`
                FROM (
                    SELECT c.CONSUMPTION_ID, MAX(ct.VERSION_ID) MAX_VERSION_ID FROM rm_consumption c LEFT JOIN rm_consumption_trans ct ON c.CONSUMPTION_ID=ct.CONSUMPTION_ID WHERE c.PROGRAM_ID=@programId AND ct.VERSION_ID<=@versionId AND ct.CONSUMPTION_TRANS_ID IS NOT NULL GROUP BY c.CONSUMPTION_ID
                ) tc
                LEFT JOIN rm_consumption c ON c.CONSUMPTION_ID=tc.CONSUMPTION_ID
                LEFT JOIN rm_consumption_trans ct ON c.CONSUMPTION_ID=ct.CONSUMPTION_ID AND tc.MAX_VERSION_ID=ct.VERSION_ID
                LEFT JOIN rm_consumption_trans_batch_info ctbi ON ct.CONSUMPTION_TRANS_ID=ctbi.CONSUMPTION_TRANS_ID
                LEFT JOIN rm_batch_info bi ON ctbi.BATCH_ID=bi.BATCH_ID
                LEFT JOIN rm_realm_country_planning_unit rcpu ON ct.REALM_COUNTRY_PLANNING_UNIT_ID=rcpu.REALM_COUNTRY_PLANNING_UNIT_ID
                LEFT JOIN rm_program_planning_unit ppu ON c.PROGRAM_ID=ppu.PROGRAM_ID AND ct.PLANNING_UNIT_ID=ppu.PLANNING_UNIT_ID
                WHERE ct.ACTIVE AND ctbi.BATCH_ID IS NOT NULL AND ppu.PLANNING_UNIT_ID IS NOT NULL 
                GROUP BY c.PROGRAM_ID, ct.REGION_ID, ct.PLANNING_UNIT_ID, ct.CONSUMPTION_DATE, ctbi.BATCH_ID
            ) tc 
            GROUP BY tc.PROGRAM_ID, tc.PLANNING_UNIT_ID, tc.CONSUMPTION_DATE, tc.BATCH_ID

            UNION

            SELECT 
                s.PROGRAM_ID, s.SHIPMENT_ID `TRANS_ID`, st.PLANNING_UNIT_ID, LEFT(COALESCE(st.RECEIVED_DATE, st.EXPECTED_DELIVERY_DATE),7) `TRANS_DATE`, stbi.BATCH_ID, bi.EXPIRY_DATE, IFNULL(ppu.SHELF_LIFE,24) `SHELF_LIFE`,
                null `FORECASTED_CONSUMPTION`, null `ACTUAL_CONSUMPTION`, 
                SUM(IF(st.SHIPMENT_STATUS_ID IN (1,3,4,5,6,7,9), COALESCE(stbi.BATCH_SHIPMENT_QTY * IF(rcpu.CONVERSION_METHOD IS NULL OR rcpu.CONVERSION_METHOD=1, rcpu.CONVERSION_NUMBER, IF(rcpu.CONVERSION_METHOD=2,1/rcpu.CONVERSION_NUMBER,0)) ,st.SHIPMENT_QTY),0)) `SHIPMENT`, 
                SUM(IF(st.SHIPMENT_STATUS_ID IN (3,4,5,6,7,9), COALESCE(stbi.BATCH_SHIPMENT_QTY * IF(rcpu.CONVERSION_METHOD IS NULL OR rcpu.CONVERSION_METHOD=1, rcpu.CONVERSION_NUMBER, IF(rcpu.CONVERSION_METHOD=2,1/rcpu.CONVERSION_NUMBER,0)) ,st.SHIPMENT_QTY), 0)) `SHIPMENT_WPS`, 
                null  `ADJUSTMENT_MULTIPLIED_QTY`, null  `STOCK_MULTIPLIED_QTY`, 0 `INVENTORY_QTY` 
            FROM (
                SELECT s.PROGRAM_ID, s.SHIPMENT_ID, MAX(st.VERSION_ID) MAX_VERSION_ID FROM rm_shipment s LEFT JOIN rm_shipment_trans st ON s.SHIPMENT_ID=st.SHIPMENT_ID WHERE s.PROGRAM_ID=@programId AND st.VERSION_ID<=@versionId AND st.SHIPMENT_TRANS_ID IS NOT NULL GROUP BY s.SHIPMENT_ID
            ) ts
            LEFT JOIN rm_shipment s ON s.SHIPMENT_ID=ts.SHIPMENT_ID
            LEFT JOIN rm_shipment_trans st ON s.SHIPMENT_ID=st.SHIPMENT_ID AND ts.MAX_VERSION_ID=st.VERSION_ID
            LEFT JOIN rm_shipment_trans_batch_info stbi ON st.SHIPMENT_TRANS_ID=stbi.SHIPMENT_TRANS_ID
            LEFT JOIN rm_batch_info bi ON stbi.BATCH_ID=bi.BATCH_ID
            LEFT JOIN rm_realm_country_planning_unit rcpu ON st.REALM_COUNTRY_PLANNING_UNIT_ID=rcpu.REALM_COUNTRY_PLANNING_UNIT_ID
            LEFT JOIN rm_program_planning_unit ppu ON s.PROGRAM_ID=ppu.PROGRAM_ID AND st.PLANNING_UNIT_ID=ppu.PLANNING_UNIT_ID
            WHERE st.ACTIVE AND st.ACCOUNT_FLAG AND st.SHIPMENT_STATUS_ID!=8 AND stbi.BATCH_ID IS NOT NULL  AND ppu.PLANNING_UNIT_ID IS NOT NULL 
            GROUP BY s.PROGRAM_ID, st.PLANNING_UNIT_ID, COALESCE(st.RECEIVED_DATE, st.EXPECTED_DELIVERY_DATE), stbi.BATCH_ID

            UNION

            SELECT 
                i.PROGRAM_ID, i.INVENTORY_ID `TRANS_ID`, rcpu.PLANNING_UNIT_ID, LEFT(it.INVENTORY_DATE,7) `TRANS_DATE`, itbi.BATCH_ID, bi.EXPIRY_DATE, IFNULL(ppu.SHELF_LIFE,24) `SHELF_LIFE`,
                null `FORECASTED_CONSUMPTION`, null `ACTUAL_CONSUMPTION`, 
                null `SHIPMENT`, null `SHIPMENT_WPS`, SUM(COALESCE(itbi.ADJUSTMENT_QTY, it.ADJUSTMENT_QTY)*IF(rcpu.CONVERSION_METHOD IS NULL OR rcpu.CONVERSION_METHOD=1, rcpu.CONVERSION_NUMBER, IF(rcpu.CONVERSION_METHOD=2,1/rcpu.CONVERSION_NUMBER,0))) `ADJUSTMENT`,  SUM(COALESCE(itbi.ACTUAL_QTY, it.ACTUAL_QTY)*IF(rcpu.CONVERSION_METHOD IS NULL OR rcpu.CONVERSION_METHOD=1, rcpu.CONVERSION_NUMBER, IF(rcpu.CONVERSION_METHOD=2,1/rcpu.CONVERSION_NUMBER,0))) `STOCK`, 0 `INVENTORY_QTY` 
            FROM (
                SELECT i.PROGRAM_ID, i.INVENTORY_ID, MAX(it.VERSION_ID) MAX_VERSION_ID FROM rm_inventory i LEFT JOIN rm_inventory_trans it ON i.INVENTORY_ID=it.INVENTORY_ID WHERE i.PROGRAM_ID=@programId AND it.VERSION_ID<=@versionId AND it.INVENTORY_TRANS_ID IS NOT NULL GROUP BY i.INVENTORY_ID
            ) ti
            LEFT JOIN rm_inventory i ON i.INVENTORY_ID=ti.INVENTORY_ID
            LEFT JOIN rm_inventory_trans it ON i.INVENTORY_ID=it.INVENTORY_ID AND ti.MAX_VERSION_ID=it.VERSION_ID
            LEFT JOIN rm_inventory_trans_batch_info itbi ON it.INVENTORY_TRANS_ID=itbi.INVENTORY_TRANS_ID
            LEFT JOIN rm_batch_info bi ON itbi.BATCH_ID=bi.BATCH_ID
            LEFT JOIN rm_realm_country_planning_unit rcpu ON it.REALM_COUNTRY_PLANNING_UNIT_ID=rcpu.REALM_COUNTRY_PLANNING_UNIT_ID
            LEFT JOIN rm_program_planning_unit ppu ON i.PROGRAM_ID=ppu.PROGRAM_ID AND rcpu.PLANNING_UNIT_ID=ppu.PLANNING_UNIT_ID
            WHERE it.ACTIVE AND itbi.BATCH_ID IS NOT NULL AND ppu.PLANNING_UNIT_ID IS NOT NULL 
            GROUP BY i.PROGRAM_ID, rcpu.PLANNING_UNIT_ID, it.INVENTORY_DATE, itbi.BATCH_ID

            UNION

            SELECT 
                bi.PROGRAM_ID, bi.BATCH_INVENTORY_ID `TRANS_ID`, bi.PLANNING_UNIT_ID, LEFT(bi.INVENTORY_DATE,7) `TRANS_DATE`, bt.BATCH_ID, rm_batch_info.EXPIRY_DATE, IFNULL(ppu.SHELF_LIFE,24) `SHELF_LIFE`,
                null `FORECASTED_CONSUMPTION`, null `ACTUAL_CONSUMPTION`, 
                null `SHIPMENT`, null `SHIPMENT_WPS`, null `ADJUSTMENT`,  null `STOCK`, bt.QTY `INVENTORY_QTY` 
            FROM (
                SELECT bi.PROGRAM_ID, bi.BATCH_INVENTORY_ID, MAX(bt.VERSION_ID) MAX_VERSION_ID FROM rm_batch_inventory bi LEFT JOIN rm_batch_inventory_trans bt ON bi.BATCH_INVENTORY_ID=bt.BATCH_INVENTORY_ID WHERE bi.PROGRAM_ID=@programId AND bt.VERSION_ID<=@versionId AND bt.BATCH_INVENTORY_TRANS_ID IS NOT NULL GROUP BY bi.BATCH_INVENTORY_ID
            ) tbi
            LEFT JOIN rm_batch_inventory bi ON bi.BATCH_INVENTORY_ID=tbi.BATCH_INVENTORY_ID
            LEFT JOIN rm_batch_inventory_trans bt ON bt.BATCH_INVENTORY_ID=bi.BATCH_INVENTORY_ID AND bt.VERSION_ID=tbi.MAX_VERSION_ID
            LEFT JOIN rm_batch_info ON bt.BATCH_ID=rm_batch_info.BATCH_ID
            LEFT JOIN rm_program_planning_unit ppu ON bi.PROGRAM_ID=ppu.PROGRAM_ID AND bi.PLANNING_UNIT_ID=ppu.PLANNING_UNIT_ID            
            WHERE bt.ACTIVE
        ) AS o 
        GROUP BY o.PROGRAM_ID, o.PLANNING_UNIT_ID, o.TRANS_DATE, o.BATCH_ID ORDER BY o.PROGRAM_ID, o.PLANNING_UNIT_ID, o.TRANS_DATE, IFNULL(o.EXPIRY_DATE,'2999-12-31');

END$$

DELIMITER ;
;

