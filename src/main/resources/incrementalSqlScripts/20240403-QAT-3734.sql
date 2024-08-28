/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/SQLTemplate.sql to edit this template
 */
/**
 * Author:  akil
 * Created: 04-Apr-2024
 */

ALTER TABLE `fasp`.`rm_realm_country_planning_unit` 
ADD COLUMN `CONVERSION_METHOD` INT UNSIGNED NOT NULL COMMENT '1 for Multiply and 2 for Divide' AFTER `UNIT_ID`,
CHANGE COLUMN `MULTIPLIER` `CONVERSION_NUMBER` DECIMAL(16,6) UNSIGNED NOT NULL ;

USE `fasp`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    DEFINER = `faspUser`@`%` 
    SQL SECURITY DEFINER
VIEW `vw_realm_country_planning_unit` AS
    SELECT 
        `rcpu`.`REALM_COUNTRY_PLANNING_UNIT_ID` AS `REALM_COUNTRY_PLANNING_UNIT_ID`,
        `rcpu`.`PLANNING_UNIT_ID` AS `PLANNING_UNIT_ID`,
        `rcpu`.`REALM_COUNTRY_ID` AS `REALM_COUNTRY_ID`,
        `rcpu`.`LABEL_ID` AS `LABEL_ID`,
        `rcpu`.`SKU_CODE` AS `SKU_CODE`,
        `rcpu`.`UNIT_ID` AS `UNIT_ID`,
        `rcpu`.`CONVERSION_METHOD` AS `CONVERSION_METHOD`,
        `rcpu`.`CONVERSION_NUMBER` AS `CONVERSION_NUMBER`,
        `rcpu`.`GTIN` AS `GTIN`,
        `rcpu`.`ACTIVE` AS `ACTIVE`,
        `rcpu`.`CREATED_BY` AS `CREATED_BY`,
        `rcpu`.`CREATED_DATE` AS `CREATED_DATE`,
        `rcpu`.`LAST_MODIFIED_BY` AS `LAST_MODIFIED_BY`,
        `rcpu`.`LAST_MODIFIED_DATE` AS `LAST_MODIFIED_DATE`,
        `rcpul`.`LABEL_EN` AS `LABEL_EN`,
        `rcpul`.`LABEL_FR` AS `LABEL_FR`,
        `rcpul`.`LABEL_SP` AS `LABEL_SP`,
        `rcpul`.`LABEL_PR` AS `LABEL_PR`
    FROM
        (`rm_realm_country_planning_unit` `rcpu`
        LEFT JOIN `ap_label` `rcpul` ON ((`rcpu`.`LABEL_ID` = `rcpul`.`LABEL_ID`)));


USE `fasp`;
DROP procedure IF EXISTS `getConsumptionData`;

USE `fasp`;
DROP procedure IF EXISTS `fasp`.`getConsumptionData`;
;

DELIMITER $$
USE `fasp`$$
CREATE DEFINER=`faspUser`@`%` PROCEDURE `getConsumptionData`(PROGRAM_ID INT(10), VERSION_ID INT (10), PLANNING_UNIT_ACTIVE TINYINT(1))
BEGIN
    SET @programId = PROGRAM_ID;
    SET @versionId = VERSION_ID;
    SET @planningUmitActive= PLANNING_UNIT_ACTIVE;
    IF @versionId = -1 THEN 
        SELECT MAX(pv.VERSION_ID) into @versionId FROM rm_program_version pv where pv.PROGRAM_ID=@programId;
    END IF;

    SELECT 
	ct.*, ctbi.CONSUMPTION_TRANS_BATCH_INFO_ID, bi.PLANNING_UNIT_ID `BATCH_PLANNING_UNIT_ID`, ctbi.BATCH_ID, bi.BATCH_NO, bi.AUTO_GENERATED, bi.EXPIRY_DATE, bi.CREATED_DATE `BATCH_CREATED_DATE`, ctbi.CONSUMPTION_QTY `BATCH_QTY`
    FROM (
	SELECT 
            cons.CONSUMPTION_ID, ct.CONSUMPTION_DATE, ct.CONSUMPTION_RCPU_QTY, ct.CONSUMPTION_QTY, ct.DAYS_OF_STOCK_OUT, ct.ACTUAL_FLAG, ct.VERSION_ID, ct.NOTES, ct.CONSUMPTION_TRANS_ID,
            p.PROGRAM_ID, p.LABEL_ID `PROGRAM_LABEL_ID`, p.LABEL_EN `PROGRAM_LABEL_EN`, p.LABEL_FR `PROGRAM_LABEL_FR`, p.LABEL_SP `PROGRAM_LABEL_SP`, p.LABEL_PR `PROGRAM_LABEL_PR`,
            r.REGION_ID, r.LABEL_ID `REGION_LABEL_ID`, r.LABEL_EN `REGION_LABEL_EN`, r.LABEL_FR `REGION_LABEL_FR`, r.LABEL_SP `REGION_LABEL_SP`, r.LABEL_PR `REGION_LABEL_PR`,
            rcpu.REALM_COUNTRY_PLANNING_UNIT_ID, rcpu.LABEL_ID `RCPU_LABEL_ID`, rcpu.LABEL_EN `RCPU_LABEL_EN`, rcpu.LABEL_FR `RCPU_LABEL_FR`, rcpu.LABEL_SP `RCPU_LABEL_SP`, rcpu.LABEL_PR `RCPU_LABEL_PR`, 
            rcpu.CONVERSION_METHOD, rcpu.CONVERSION_NUMBER, pu.MULTIPLIER `CONVERSION_FACTOR`,
            pu.PLANNING_UNIT_ID, pu.LABEL_ID `PLANNING_UNIT_LABEL_ID`, pu.LABEL_EN `PLANNING_UNIT_LABEL_EN`, pu.LABEL_FR `PLANNING_UNIT_LABEL_FR`, pu.LABEL_SP `PLANNING_UNIT_LABEL_SP`, pu.LABEL_PR `PLANNING_UNIT_LABEL_PR`,
            fu.FORECASTING_UNIT_ID, fu.LABEL_ID `FORECASTING_UNIT_LABEL_ID`, fu.LABEL_EN `FORECASTING_UNIT_LABEL_EN`, fu.LABEL_FR `FORECASTING_UNIT_LABEL_FR`, fu.LABEL_SP `FORECASTING_UNIT_LABEL_SP`, fu.LABEL_PR `FORECASTING_UNIT_LABEL_PR`,
            pc.PRODUCT_CATEGORY_ID, pc.LABEL_ID `PRODUCT_CATEGORY_LABEL_ID`, pc.LABEL_EN `PRODUCT_CATEGORY_LABEL_EN`, pc.LABEL_FR `PRODUCT_CATEGORY_LABEL_FR`, pc.LABEL_SP `PRODUCT_CATEGORY_LABEL_SP`, pc.LABEL_PR `PRODUCT_CATEGORY_LABEL_PR`,
            ds.DATA_SOURCE_ID, ds.LABEL_ID `DATA_SOURCE_LABEL_ID`, ds.LABEL_EN `DATA_SOURCE_LABEL_EN`, ds.LABEL_FR `DATA_SOURCE_LABEL_FR`, ds.LABEL_SP `DATA_SOURCE_LABEL_SP`, ds.LABEL_PR `DATA_SOURCE_LABEL_PR`,
            cb.USER_ID `CB_USER_ID`, cb.USERNAME `CB_USERNAME`, cons.CREATED_DATE, lmb.USER_ID `LMB_USER_ID`, lmb.USERNAME `LMB_USERNAME`, ct.LAST_MODIFIED_DATE, ct.ACTIVE
	FROM (SELECT ct.CONSUMPTION_ID, MAX(ct.VERSION_ID) MAX_VERSION_ID FROM rm_consumption c LEFT JOIN rm_consumption_trans ct ON c.CONSUMPTION_ID=ct.CONSUMPTION_ID WHERE (@versionId=-1 OR ct.VERSION_ID<=@versionId) AND c.PROGRAM_ID=@programId GROUP BY ct.CONSUMPTION_ID) tc 
	LEFT JOIN rm_consumption cons ON tc.CONSUMPTION_ID=cons.CONSUMPTION_ID
	LEFT JOIN rm_consumption_trans ct ON tc.CONSUMPTION_ID=ct.CONSUMPTION_ID AND tc.MAX_VERSION_ID=ct.VERSION_ID
	LEFT JOIN vw_program p ON cons.PROGRAM_ID=p.PROGRAM_ID
	LEFT JOIN vw_region r ON ct.REGION_ID=r.REGION_ID
        LEFT JOIN vw_realm_country_planning_unit rcpu ON ct.REALM_COUNTRY_PLANNING_UNIT_ID=rcpu.REALM_COUNTRY_PLANNING_UNIT_ID
	LEFT JOIN vw_planning_unit pu ON ct.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID
	LEFT JOIN vw_forecasting_unit fu ON pu.FORECASTING_UNIT_ID=fu.FORECASTING_UNIT_ID
	LEFT JOIN vw_product_category pc ON fu.PRODUCT_CATEGORY_ID=pc.PRODUCT_CATEGORY_ID
	LEFT JOIN vw_data_source ds ON ct.DATA_SOURCE_ID=ds.DATA_SOURCE_ID
	LEFT JOIN us_user cb ON cons.CREATED_BY=cb.USER_ID
	LEFT JOIN us_user lmb ON ct.LAST_MODIFIED_BY=lmb.USER_ID
    ) ct 
    LEFT JOIN rm_consumption_trans_batch_info ctbi ON ct.CONSUMPTION_TRANS_ID=ctbi.CONSUMPTION_TRANS_ID
    LEFT JOIN rm_batch_info bi ON ctbi.BATCH_ID=bi.BATCH_ID
    LEFT JOIN rm_program_planning_unit ppu ON ppu.PROGRAM_ID=@programId AND ppu.PLANNING_UNIT_ID=ct.PLANNING_UNIT_ID
    WHERE (@planningUmitActive = FALSE OR ppu.ACTIVE)
    ORDER BY ct.PLANNING_UNIT_ID, ct.REGION_ID, ct.CONSUMPTION_DATE, ct.ACTUAL_FLAG, bi.EXPIRY_DATE, bi.BATCH_ID;
END$$

DELIMITER ;
;


USE `fasp`;
DROP procedure IF EXISTS `getInventoryData`;

USE `fasp`;
DROP procedure IF EXISTS `fasp`.`getInventoryData`;
;

DELIMITER $$
USE `fasp`$$
CREATE DEFINER=`faspUser`@`%` PROCEDURE `getInventoryData`(PROGRAM_ID INT(10), VERSION_ID INT (10), PLANNING_UNIT_ACTIVE TINYINT(1))
BEGIN
    SET @programId = PROGRAM_ID;
    SET @versionId = VERSION_ID;
    SET @planningUnitActive = PLANNING_UNIT_ACTIVE;

    IF @versionId = -1 THEN
	SELECT MAX(pv.VERSION_ID) into @versionId FROM rm_program_version pv where pv.PROGRAM_ID=@programId;
    END IF;
    
    SET @oldRCPU = 0;
    SET @oldAdjustment = 0;
    SET @bal = 0;
    
    SELECT a.*, itbi.INVENTORY_TRANS_BATCH_INFO_ID, itbi.BATCH_ID, bi.PLANNING_UNIT_ID `BATCH_PLANNING_UNIT_ID`, bi.BATCH_NO, bi.AUTO_GENERATED, bi.EXPIRY_DATE, itbi.ACTUAL_QTY `BATCH_ACTUAL_QTY`, bi.CREATED_DATE `BATCH_CREATED_DATE`, itbi.ADJUSTMENT_QTY `BATCH_ADJUSTMENT_QTY` 
    FROM (
        SELECT 
            der.*, 
            @oldAdjustment:=IF(@oldRCPU!=der.REALM_COUNTRY_PLANNING_UNIT_ID, 0, @oldAdjustment) `oldAdjustment`,
            @bal:=IF(@oldRCPU!=der.REALM_COUNTRY_PLANNING_UNIT_ID, 0, @bal+@oldAdjustment) `EXPECTED_BAL`, 
            @oldRCPU := der.REALM_COUNTRY_PLANNING_UNIT_ID `oldRCPU`,
            @oldAdjustment:=der.ADJUSTMENT_QTY
        FROM (
            SELECT 
                it.INVENTORY_ID, it.INVENTORY_DATE, it.ACTUAL_QTY, it.ADJUSTMENT_QTY, rcpu.CONVERSION_METHOD, rcpu.CONVERSION_NUMBER, pu.MULTIPLIER `CONVERSION_FACTOR`, it.VERSION_ID, it.NOTES, it.INVENTORY_TRANS_ID,
                p.PROGRAM_ID, pl.LABEL_ID `PROGRAM_LABEL_ID`, pl.LABEL_EN `PROGRAM_LABEL_EN`, pl.LABEL_FR `PROGRAM_LABEL_FR`, pl.LABEL_SP `PROGRAM_LABEL_SP`, pl.LABEL_PR `PROGRAM_LABEL_PR`,
                r.REGION_ID, rl.LABEL_ID `REGION_LABEL_ID`, rl.LABEL_EN `REGION_LABEL_EN`, rl.LABEL_FR `REGION_LABEL_FR`, rl.LABEL_SP `REGION_LABEL_SP`, rl.LABEL_PR `REGION_LABEL_PR`,
                rcpu.REALM_COUNTRY_PLANNING_UNIT_ID, rcpul.LABEL_ID `REALM_COUNTRY_PLANNING_UNIT_LABEL_ID`, rcpul.LABEL_EN `REALM_COUNTRY_PLANNING_UNIT_LABEL_EN`, rcpul.LABEL_FR `REALM_COUNTRY_PLANNING_UNIT_LABEL_FR`, rcpul.LABEL_SP `REALM_COUNTRY_PLANNING_UNIT_LABEL_SP`, rcpul.LABEL_PR `REALM_COUNTRY_PLANNING_UNIT_LABEL_PR`,
                pu.PLANNING_UNIT_ID, pul.LABEL_ID `PLANNING_UNIT_LABEL_ID`, pul.LABEL_EN `PLANNING_UNIT_LABEL_EN`, pul.LABEL_FR `PLANNING_UNIT_LABEL_FR`, pul.LABEL_SP `PLANNING_UNIT_LABEL_SP`, pul.LABEL_PR `PLANNING_UNIT_LABEL_PR`,
                fu.FORECASTING_UNIT_ID, ful.LABEL_ID `FORECASTING_UNIT_LABEL_ID`, ful.LABEL_EN `FORECASTING_UNIT_LABEL_EN`, ful.LABEL_FR `FORECASTING_UNIT_LABEL_FR`, ful.LABEL_SP `FORECASTING_UNIT_LABEL_SP`, ful.LABEL_PR `FORECASTING_UNIT_LABEL_PR`,
                pc.PRODUCT_CATEGORY_ID, pcl.LABEL_ID `PRODUCT_CATEGORY_LABEL_ID`, pcl.LABEL_EN `PRODUCT_CATEGORY_LABEL_EN`, pcl.LABEL_FR `PRODUCT_CATEGORY_LABEL_FR`, pcl.LABEL_SP `PRODUCT_CATEGORY_LABEL_SP`, pcl.LABEL_PR `PRODUCT_CATEGORY_LABEL_PR`,
                ds.DATA_SOURCE_ID, dsl.LABEL_ID `DATA_SOURCE_LABEL_ID`, dsl.LABEL_EN `DATA_SOURCE_LABEL_EN`, dsl.LABEL_FR `DATA_SOURCE_LABEL_FR`, dsl.LABEL_SP `DATA_SOURCE_LABEL_SP`, dsl.LABEL_PR `DATA_SOURCE_LABEL_PR`,
                u.UNIT_ID, u.UNIT_CODE, ul.LABEL_ID `UNIT_LABEL_ID`, ul.LABEL_EN `UNIT_LABEL_EN`, ul.LABEL_FR `UNIT_LABEL_FR`, ul.LABEL_SP `UNIT_LABEL_SP`, ul.LABEL_PR `UNIT_LABEL_PR`,
                cb.USER_ID `CB_USER_ID`, cb.USERNAME `CB_USERNAME`, i.CREATED_DATE, lmb.USER_ID `LMB_USER_ID`, lmb.USERNAME `LMB_USERNAME`, it.LAST_MODIFIED_DATE, it.ACTIVE
            FROM (SELECT i.INVENTORY_ID, MAX(it.VERSION_ID) MAX_VERSION_ID FROM rm_inventory i LEFT JOIN rm_inventory_trans it ON i.INVENTORY_ID=it.INVENTORY_ID WHERE i.PROGRAM_ID=@programId AND (it.VERSION_ID<=@versionId OR @versionId=-1) GROUP BY i.INVENTORY_ID) tc 
            LEFT JOIN rm_inventory i ON tc.INVENTORY_ID=i.INVENTORY_ID
            LEFT JOIN rm_inventory_trans it ON tc.INVENTORY_ID=it.INVENTORY_ID AND tc.MAX_VERSION_ID=it.VERSION_ID
            LEFT JOIN rm_program p ON i.PROGRAM_ID=p.PROGRAM_ID
            LEFT JOIN ap_label pl ON p.LABEL_ID=pl.LABEL_ID
            LEFT JOIN rm_region r ON it.REGION_ID=r.REGION_ID
            LEFT JOIN ap_label rl ON r.LABEL_ID=rl.LABEL_ID
            LEFT JOIN rm_realm_country_planning_unit rcpu ON it.REALM_COUNTRY_PLANNING_UNIT_ID=rcpu.REALM_COUNTRY_PLANNING_UNIT_ID
            LEFT JOIN ap_label rcpul ON rcpu.LABEL_ID=rcpul.LABEL_ID
            LEFT JOIN rm_planning_unit pu ON rcpu.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID
            LEFT JOIN ap_label pul ON pu.LABEL_ID=pul.LABEL_ID
            LEFT JOIN rm_forecasting_unit fu ON pu.FORECASTING_UNIT_ID=fu.FORECASTING_UNIT_ID
            LEFT JOIN ap_label ful ON fu.LABEL_ID=ful.LABEL_ID
            LEFT JOIN rm_product_category pc ON fu.PRODUCT_CATEGORY_ID=pc.PRODUCT_CATEGORY_ID
            LEFT JOIN ap_label pcl ON pc.LABEL_ID=pcl.LABEL_ID
            LEFT JOIN rm_data_source ds ON it.DATA_SOURCE_ID=ds.DATA_SOURCE_ID
            LEFT JOIN ap_label dsl ON ds.LABEL_ID=dsl.LABEL_ID
            LEFT JOIN ap_unit u ON rcpu.UNIT_ID=u.UNIT_ID
            LEFT JOIN ap_label ul ON u.LABEL_ID=ul.LABEL_ID
            LEFT JOIN us_user cb ON i.CREATED_BY=cb.USER_ID
            LEFT JOIN us_user lmb ON it.LAST_MODIFIED_BY=lmb.USER_ID
        ) as der 
        ORDER BY der.PLANNING_UNIT_ID, der.REALM_COUNTRY_PLANNING_UNIT_ID, der.REGION_ID, der.INVENTORY_DATE
    ) a 
    LEFT JOIN rm_inventory_trans_batch_info itbi ON a.INVENTORY_TRANS_ID=itbi.INVENTORY_TRANS_ID
    LEFT JOIN rm_batch_info bi ON itbi.BATCH_ID=bi.BATCH_ID
    LEFT JOIN rm_program_planning_unit ppu ON a.PLANNING_UNIT_ID=ppu.PLANNING_UNIT_ID AND ppu.PROGRAM_ID=@programId
    WHERE (@planningUnitActive = FALSE OR ppu.ACTIVE)
    ORDER BY a.PLANNING_UNIT_ID, a.REALM_COUNTRY_PLANNING_UNIT_ID, a.REGION_ID, a.INVENTORY_DATE, bi.EXPIRY_DATE, bi.BATCH_ID;
END$$

DELIMITER ;
;


USE `fasp`;
DROP procedure IF EXISTS `getShipmentData`;

USE `fasp`;
DROP procedure IF EXISTS `fasp`.`getShipmentData`;
;

DELIMITER $$
USE `fasp`$$
CREATE DEFINER=`faspUser`@`%` PROCEDURE `getShipmentData`(PROGRAM_ID INT(10), VERSION_ID INT (10), SHIPMENT_ACTIVE TINYINT(1), PLANNING_UNIT_ACTIVE TINYINT(1))
BEGIN
    SET @programId = PROGRAM_ID;
    SET @versionId = VERSION_ID;
    SET @shipmentActive = SHIPMENT_ACTIVE;
    SET @planningUnitActive = PLANNING_UNIT_ACTIVE;
    SET @sql1 = "";	
    IF @versionId = -1 THEN
        SELECT MAX(pv.VERSION_ID) INTO @versionId FROM rm_program_version pv WHERE pv.PROGRAM_ID=@programId;
    END IF;
    
    SELECT 
        st.*, stbi.SHIPMENT_TRANS_BATCH_INFO_ID, stbi.BATCH_ID, bi.PLANNING_UNIT_ID `BATCH_PLANNING_UNIT_ID`, bi.BATCH_NO, bi.AUTO_GENERATED, bi.EXPIRY_DATE, bi.CREATED_DATE `BATCH_CREATED_DATE`, stbi.BATCH_SHIPMENT_QTY `BATCH_SHIPMENT_QTY` 
    FROM (
        SELECT
            s.SHIPMENT_ID, s.PARENT_SHIPMENT_ID, st.EXPECTED_DELIVERY_DATE, st.PLANNED_DATE, st.SUBMITTED_DATE, st.APPROVED_DATE, st.SHIPPED_DATE, st.ARRIVED_DATE, st.RECEIVED_DATE, st.SHIPMENT_QTY, st.SHIPMENT_RCPU_QTY, pu.MULTIPLIER `CONVERSION_FACTOR`, st.RATE, st.PRODUCT_COST, st.FREIGHT_COST, st.SHIPMENT_MODE, s.SUGGESTED_QTY, st.ACCOUNT_FLAG, st.ERP_FLAG, st.ORDER_NO, st.PRIME_LINE_NO, st.VERSION_ID, st.NOTES, st.SHIPMENT_TRANS_ID, st.PARENT_LINKED_SHIPMENT_ID,
            p.PROGRAM_ID, p.LABEL_ID `PROGRAM_LABEL_ID`, p.LABEL_EN `PROGRAM_LABEL_EN`, p.LABEL_FR `PROGRAM_LABEL_FR`, p.LABEL_SP `PROGRAM_LABEL_SP`, p.LABEL_PR `PROGRAM_LABEL_PR`,
            pa.PROCUREMENT_AGENT_ID, pa.PROCUREMENT_AGENT_CODE, pa.`COLOR_HTML_CODE`, pa.LABEL_ID `PROCUREMENT_AGENT_LABEL_ID`, pa.LABEL_EN `PROCUREMENT_AGENT_LABEL_EN`, pa.LABEL_FR `PROCUREMENT_AGENT_LABEL_FR`, pa.LABEL_SP `PROCUREMENT_AGENT_LABEL_SP`, pa.LABEL_PR `PROCUREMENT_AGENT_LABEL_PR`,
            pu.PLANNING_UNIT_ID, pu.LABEL_ID `PLANNING_UNIT_LABEL_ID`, pu.LABEL_EN `PLANNING_UNIT_LABEL_EN`, pu.LABEL_FR `PLANNING_UNIT_LABEL_FR`, pu.LABEL_SP `PLANNING_UNIT_LABEL_SP`, pu.LABEL_PR `PLANNING_UNIT_LABEL_PR`,
            fu.FORECASTING_UNIT_ID, fu.LABEL_ID `FORECASTING_UNIT_LABEL_ID`, fu.LABEL_EN `FORECASTING_UNIT_LABEL_EN`, fu.LABEL_FR `FORECASTING_UNIT_LABEL_FR`, fu.LABEL_SP `FORECASTING_UNIT_LABEL_SP`, fu.LABEL_PR `FORECASTING_UNIT_LABEL_PR`,
            pc.PRODUCT_CATEGORY_ID, pc.LABEL_ID `PRODUCT_CATEGORY_LABEL_ID`, pc.LABEL_EN `PRODUCT_CATEGORY_LABEL_EN`, pc.LABEL_FR `PRODUCT_CATEGORY_LABEL_FR`, pc.LABEL_SP `PRODUCT_CATEGORY_LABEL_SP`, pc.LABEL_PR `PRODUCT_CATEGORY_LABEL_PR`,
            pru.PROCUREMENT_UNIT_ID, pru.LABEL_ID `PROCUREMENT_UNIT_LABEL_ID`, pru.LABEL_EN `PROCUREMENT_UNIT_LABEL_EN`, pru.LABEL_FR `PROCUREMENT_UNIT_LABEL_FR`, pru.LABEL_SP `PROCUREMENT_UNIT_LABEL_SP`, pru.LABEL_PR `PROCUREMENT_UNIT_LABEL_PR`,
            rcpu.REALM_COUNTRY_PLANNING_UNIT_ID `RCPU_ID`, rcpu.LABEL_ID `RCPU_LABEL_ID`, rcpu.LABEL_EN `RCPU_LABEL_EN`, rcpu.LABEL_FR `RCPU_LABEL_FR`, rcpu.LABEL_SP `RCPU_LABEL_SP`, rcpu.LABEL_PR `RCPU_LABEL_PR`, rcpu.CONVERSION_NUMBER, rcpu.CONVERSION_METHOD,
            su.SUPPLIER_ID, su.LABEL_ID `SUPPLIER_LABEL_ID`, su.LABEL_EN `SUPPLIER_LABEL_EN`, su.LABEL_FR `SUPPLIER_LABEL_FR`, su.LABEL_SP `SUPPLIER_LABEL_SP`, su.LABEL_PR `SUPPLIER_LABEL_PR`,
            shs.SHIPMENT_STATUS_ID, shs.LABEL_ID `SHIPMENT_STATUS_LABEL_ID`, shs.LABEL_EN `SHIPMENT_STATUS_LABEL_EN`, shs.LABEL_FR `SHIPMENT_STATUS_LABEL_FR`, shs.LABEL_SP `SHIPMENT_STATUS_LABEL_SP`, shs.LABEL_PR `SHIPMENT_STATUS_LABEL_PR`,
            ds.DATA_SOURCE_ID, ds.LABEL_ID `DATA_SOURCE_LABEL_ID`, ds.LABEL_EN `DATA_SOURCE_LABEL_EN`, ds.LABEL_FR `DATA_SOURCE_LABEL_FR`, ds.LABEL_SP `DATA_SOURCE_LABEL_SP`, ds.LABEL_PR `DATA_SOURCE_LABEL_PR`,
            sc.CURRENCY_ID `SHIPMENT_CURRENCY_ID`, sc.`CURRENCY_CODE` `SHIPMENT_CURRENCY_CODE`, s.CONVERSION_RATE_TO_USD `SHIPMENT_CONVERSION_RATE_TO_USD`, 
            sc.LABEL_ID `SHIPMENT_CURRENCY_LABEL_ID`, sc.LABEL_EN `SHIPMENT_CURRENCY_LABEL_EN`, sc.LABEL_FR `SHIPMENT_CURRENCY_LABEL_FR`, sc.LABEL_SP `SHIPMENT_CURRENCY_LABEL_SP`, sc.LABEL_PR `SHIPMENT_CURRENCY_LABEL_PR`,
            st.EMERGENCY_ORDER, st.LOCAL_PROCUREMENT, 
            cb.USER_ID `CB_USER_ID`, cb.USERNAME `CB_USERNAME`, s.CREATED_DATE, lmb.USER_ID `LMB_USER_ID`, lmb.USERNAME `LMB_USERNAME`, st.LAST_MODIFIED_DATE, st.ACTIVE,
            bc.CURRENCY_ID `BUDGET_CURRENCY_ID`, bc.CURRENCY_CODE `BUDGET_CURRENCY_CODE`, b.CONVERSION_RATE_TO_USD `BUDGET_CURRENCY_CONVERSION_RATE_TO_USD`, bc.LABEL_ID `BUDGET_CURRENCY_LABEL_ID`, bc.LABEL_EN `BUDGET_CURRENCY_LABEL_EN`, bc.LABEL_FR `BUDGET_CURRENCY_LABEL_FR`, bc.LABEL_SP `BUDGET_CURRENCY_LABEL_SP`, bc.LABEL_PR `BUDGET_CURRENCY_LABEL_PR`, 
            b.BUDGET_ID, b.BUDGET_CODE, b.LABEL_ID `BUDGET_LABEL_ID`, b.LABEL_EN `BUDGET_LABEL_EN`, b.LABEL_FR `BUDGET_LABEL_FR`, b.LABEL_SP `BUDGET_LABEL_SP`, b.LABEL_PR `BUDGET_LABEL_PR`,
            fs.FUNDING_SOURCE_ID, fs.FUNDING_SOURCE_CODE, fs.LABEL_ID `FUNDING_SOURCE_LABEL_ID`, fs.LABEL_EN `FUNDING_SOURCE_LABEL_EN`, fs.LABEL_FR `FUNDING_SOURCE_LABEL_FR`, fs.LABEL_SP `FUNDING_SOURCE_LABEL_SP`, fs.LABEL_PR `FUNDING_SOURCE_LABEL_PR`
        FROM (
            SELECT st.SHIPMENT_ID, MAX(st.VERSION_ID) MAX_VERSION_ID FROM rm_shipment s LEFT JOIN rm_shipment_trans st ON s.SHIPMENT_ID=st.SHIPMENT_ID WHERE (@versiONId=-1 OR st.VERSION_ID<=@versiONId) AND s.PROGRAM_ID=@programId GROUP BY st.SHIPMENT_ID
        ) ts 
        LEFT JOIN rm_shipment s ON ts.SHIPMENT_ID=s.SHIPMENT_ID
        LEFT JOIN rm_shipment_trans st ON ts.SHIPMENT_ID=st.SHIPMENT_ID AND ts.MAX_VERSION_ID=st.VERSION_ID
        LEFT JOIN vw_program p ON s.PROGRAM_ID=p.PROGRAM_ID
        LEFT JOIN vw_procurement_agent pa ON st.PROCUREMENT_AGENT_ID=pa.PROCUREMENT_AGENT_ID
        LEFT JOIN vw_planning_unit pu ON st.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID
        LEFT JOIN vw_realm_country_planning_unit rcpu ON st.REALM_COUNTRY_PLANNING_UNIT_ID=rcpu.REALM_COUNTRY_PLANNING_UNIT_ID
        LEFT JOIN vw_forecasting_unit fu ON pu.FORECASTING_UNIT_ID=fu.FORECASTING_UNIT_ID
        LEFT JOIN vw_product_category pc ON fu.PRODUCT_CATEGORY_ID=pc.PRODUCT_CATEGORY_ID
        LEFT JOIN vw_procurement_unit pru ON st.PROCUREMENT_UNIT_ID=pru.PROCUREMENT_UNIT_ID
        LEFT JOIN vw_supplier su ON st.SUPPLIER_ID=su.SUPPLIER_ID
        LEFT JOIN vw_shipment_status shs ON st.SHIPMENT_STATUS_ID=shs.SHIPMENT_STATUS_ID
        LEFT JOIN vw_data_source ds ON st.DATA_SOURCE_ID=ds.DATA_SOURCE_ID
        LEFT JOIN us_user cb ON s.CREATED_BY=cb.USER_ID
        LEFT JOIN us_user lmb ON st.LAST_MODIFIED_BY=lmb.USER_ID
        LEFT JOIN vw_currency sc ON s.CURRENCY_ID=sc.CURRENCY_ID
        LEFT JOIN vw_budget b ON st.BUDGET_ID=b.BUDGET_ID
        LEFT JOIN vw_currency bc ON b.CURRENCY_ID=bc.CURRENCY_ID
        LEFT JOIN vw_funding_source fs ON st.FUNDING_SOURCE_ID=fs.FUNDING_SOURCE_ID 
        WHERE (@shipmentActive = FALSE OR st.ACTIVE)
    ) st  
    LEFT JOIN rm_shipment_trans_batch_info stbi ON st.SHIPMENT_TRANS_ID = stbi.SHIPMENT_TRANS_ID
    LEFT JOIN rm_program_planning_unit ppu ON st.PLANNING_UNIT_ID=ppu.PLANNING_UNIT_ID AND ppu.PROGRAM_ID=@programId
    LEFT JOIN rm_batch_info bi ON stbi.BATCH_ID=bi.BATCH_ID
    WHERE (@planningUnitActive = FALSE OR ppu.ACTIVE)
    ORDER BY st.PLANNING_UNIT_ID, COALESCE(st.RECEIVED_DATE, st.EXPECTED_DELIVERY_DATE), bi.EXPIRY_DATE, bi.BATCH_ID; 
END$$

DELIMITER ;
;

