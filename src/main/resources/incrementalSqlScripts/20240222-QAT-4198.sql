/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/SQLTemplate.sql to edit this template
 */
/**
 * Author:  akil
 * Created: 22-Feb-2024
 */

USE `fasp`;
DROP procedure IF EXISTS `stockStatusReportVertical`;

USE `fasp`;
DROP procedure IF EXISTS `fasp`.`stockStatusReportVertical`;
;

DELIMITER $$
USE `fasp`$$
CREATE DEFINER=`faspUser`@`%` PROCEDURE `stockStatusReportVertical`(VAR_START_DATE DATE, VAR_STOP_DATE DATE, VAR_PROGRAM_ID INT(10), VAR_VERSION_ID INT, VAR_PLANNING_UNIT_ID INT(10))
BEGIN
    -- %%%%%%%%%%%%%%%%%%%%%
    -- Report no 16
    -- %%%%%%%%%%%%%%%%%%%%%
    
    SET @startDate = VAR_START_DATE; 
    SET @stopDate = VAR_STOP_DATE;
    SET @programId = VAR_PROGRAM_ID;
    SET @versionId = VAR_VERSION_ID;
    SET @planningUnitId = VAR_PLANNING_UNIT_ID;

    IF @versionId = -1 THEN 
	SELECT MAX(pv.VERSION_ID) INTO @versionId FROM rm_program_version pv WHERE pv.PROGRAM_ID=@programId;
    END IF;
    DROP TEMPORARY TABLE IF EXISTS `tmp_supply_plan_amc`;
    CREATE TEMPORARY TABLE `tmp_supply_plan_amc` (
      `SUPPLY_PLAN_AMC_ID` int unsigned NOT NULL AUTO_INCREMENT,
      `PROGRAM_ID` int unsigned NOT NULL,
      `VERSION_ID` int unsigned NOT NULL,
      `PLANNING_UNIT_ID` int unsigned NOT NULL,
      `TRANS_DATE` date NOT NULL,
      `AMC` decimal(24,8) DEFAULT NULL,
      `AMC_COUNT` int DEFAULT NULL,
      `MOS` decimal(24,8) DEFAULT NULL,
      `MOS_WPS` decimal(24,8) DEFAULT NULL,
      `MIN_STOCK_QTY` decimal(24,8) DEFAULT NULL,
      `MIN_STOCK_MOS` decimal(24,8) DEFAULT NULL,
      `MAX_STOCK_QTY` decimal(24,8) DEFAULT NULL,
      `MAX_STOCK_MOS` decimal(24,8) DEFAULT NULL,
      `OPENING_BALANCE` bigint DEFAULT NULL,
      `OPENING_BALANCE_WPS` bigint DEFAULT NULL,
      `MANUAL_PLANNED_SHIPMENT_QTY` bigint DEFAULT NULL,
      `MANUAL_SUBMITTED_SHIPMENT_QTY` bigint DEFAULT NULL,
      `MANUAL_APPROVED_SHIPMENT_QTY` bigint DEFAULT NULL,
      `MANUAL_SHIPPED_SHIPMENT_QTY` bigint DEFAULT NULL,
      `MANUAL_RECEIVED_SHIPMENT_QTY` bigint DEFAULT NULL,
      `MANUAL_ONHOLD_SHIPMENT_QTY` bigint DEFAULT NULL,
      `ERP_PLANNED_SHIPMENT_QTY` bigint DEFAULT NULL,
      `ERP_SUBMITTED_SHIPMENT_QTY` bigint DEFAULT NULL,
      `ERP_APPROVED_SHIPMENT_QTY` bigint DEFAULT NULL,
      `ERP_SHIPPED_SHIPMENT_QTY` bigint DEFAULT NULL,
      `ERP_RECEIVED_SHIPMENT_QTY` bigint DEFAULT NULL,
      `ERP_ONHOLD_SHIPMENT_QTY` bigint DEFAULT NULL,
      `SHIPMENT_QTY` bigint DEFAULT NULL,
      `FORECASTED_CONSUMPTION_QTY` bigint DEFAULT NULL,
      `ACTUAL_CONSUMPTION_QTY` bigint DEFAULT NULL,
      `ADJUSTED_CONSUMPTION_QTY` bigint DEFAULT NULL,
      `ACTUAL` tinyint(1) DEFAULT NULL,
      `ADJUSTMENT_MULTIPLIED_QTY` bigint DEFAULT NULL,
      `STOCK_MULTIPLIED_QTY` bigint DEFAULT NULL,
      `REGION_COUNT` int unsigned NOT NULL,
      `REGION_COUNT_FOR_STOCK` int unsigned NOT NULL,
      `EXPIRED_STOCK` bigint DEFAULT NULL,
      `EXPIRED_STOCK_WPS` bigint DEFAULT NULL,
      `CLOSING_BALANCE` bigint DEFAULT NULL,
      `CLOSING_BALANCE_WPS` bigint DEFAULT NULL,
      `UNMET_DEMAND` bigint DEFAULT NULL,
      `UNMET_DEMAND_WPS` bigint DEFAULT NULL,
      `NATIONAL_ADJUSTMENT` bigint DEFAULT NULL,
      `NATIONAL_ADJUSTMENT_WPS` bigint DEFAULT NULL,
      PRIMARY KEY (`SUPPLY_PLAN_AMC_ID`),
      KEY `idx_tmp_supply_plan_amc_programId` (`PROGRAM_ID`),
      KEY `idx_tmp_supply_plan_amc_planningUnitId` (`PLANNING_UNIT_ID`),
      KEY `idx_rm_supply_plan_amc_transDate` (`TRANS_DATE`),
      KEY `idx_rm_supply_plan_amc_versionId` (`VERSION_ID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

    INSERT INTO tmp_supply_plan_amc SELECT sma.* FROM rm_supply_plan_amc sma  WHERE sma.PROGRAM_ID = @programId AND sma.VERSION_ID = @versionId AND sma.PLANNING_UNIT_ID = @planningUnitId AND sma.TRANS_DATE BETWEEN @startDate AND @stopDate;

    SET @prvMonthClosingBal = 0;
    SELECT 
        s2.`TRANS_DATE`, 
        s2.`PLANNING_UNIT_ID`, s2.`PLANNING_UNIT_LABEL_ID`, s2.`PLANNING_UNIT_LABEL_EN`, s2.`PLANNING_UNIT_LABEL_FR`, s2.`PLANNING_UNIT_LABEL_SP`, s2.`PLANNING_UNIT_LABEL_PR`,
        COALESCE(s2.`FINAL_OPENING_BALANCE`, @prvMonthClosingBal) `FINAL_OPENING_BALANCE`,
        s2.`ACTUAL_CONSUMPTION_QTY`, s2.`FORECASTED_CONSUMPTION_QTY`, 
        IF(s2.`ACTUAL`, s2.`ACTUAL_CONSUMPTION_QTY`,s2.`FORECASTED_CONSUMPTION_QTY`) `FINAL_CONSUMPTION_QTY`,
        s2.`ACTUAL`,
        s2.`SQTY` ,
        s2.`ADJUSTMENT`,
        s2.`NATIONAL_ADJUSTMENT`,
        s2.EXPIRED_STOCK,
        COALESCE(s2.`FINAL_CLOSING_BALANCE`, @prvMonthClosingBal) `FINAL_CLOSING_BALANCE`,
        s2.AMC, s2.UNMET_DEMAND,s2.REGION_COUNT,s2.REGION_COUNT_FOR_STOCK,
        s2.`MoS`,
        s2.`MIN_MONTHS_OF_STOCK`,
        s2.`MAX_MONTHS_OF_STOCK`,
        s2.MIN_STOCK_QTY,
        s2.MAX_STOCK_QTY,
        s2.PLAN_BASED_ON,s2.DISTRIBUTION_LEAD_TIME,
        s2.`SHIPMENT_ID`, s2.`SHIPMENT_QTY`, s2.`EDD`, s2.`NOTES`, s2.`ORDER_NO`, s2.`PRIME_LINE_NO`, s2. `RO_NO`, s2.`RO_PRIME_LINE_NO`,
        s2.`FUNDING_SOURCE_ID`, s2.`FUNDING_SOURCE_CODE`, s2.`FUNDING_SOURCE_LABEL_ID`, s2.`FUNDING_SOURCE_LABEL_EN`, s2.`FUNDING_SOURCE_LABEL_FR`, s2.`FUNDING_SOURCE_LABEL_SP`, s2.`FUNDING_SOURCE_LABEL_PR`, 
        s2.PROCUREMENT_AGENT_ID, s2.PROCUREMENT_AGENT_CODE, s2.`PROCUREMENT_AGENT_LABEL_ID`, s2.`PROCUREMENT_AGENT_LABEL_EN`, s2.`PROCUREMENT_AGENT_LABEL_FR`, s2.`PROCUREMENT_AGENT_LABEL_SP`, s2.`PROCUREMENT_AGENT_LABEL_PR`, 
        s2.DATA_SOURCE_ID, s2.`DATA_SOURCE_LABEL_ID`, s2.`DATA_SOURCE_LABEL_EN`, s2.`DATA_SOURCE_LABEL_FR`, s2.`DATA_SOURCE_LABEL_SP`, s2.`DATA_SOURCE_LABEL_PR`, 
        s2.SHIPMENT_STATUS_ID, s2.`SHIPMENT_STATUS_LABEL_ID`, s2.`SHIPMENT_STATUS_LABEL_EN`, s2.`SHIPMENT_STATUS_LABEL_FR`, s2.`SHIPMENT_STATUS_LABEL_SP`, s2.`SHIPMENT_STATUS_LABEL_PR`,
        @prvMonthClosingBal:=COALESCE(s2.`FINAL_CLOSING_BALANCE`, s2.`FINAL_OPENING_BALANCE`, @prvMonthClosingBal) `PRV_CLOSING_BAL`
    FROM (
	SELECT 
        mn.MONTH `TRANS_DATE`, 
        pu.`PLANNING_UNIT_ID`, pu.`LABEL_ID` `PLANNING_UNIT_LABEL_ID`, pu.`LABEL_EN` `PLANNING_UNIT_LABEL_EN`, pu.`LABEL_FR` `PLANNING_UNIT_LABEL_FR`, pu.`LABEL_SP` `PLANNING_UNIT_LABEL_SP`, pu.`LABEL_PR` `PLANNING_UNIT_LABEL_PR`,
        sma.OPENING_BALANCE `FINAL_OPENING_BALANCE`, 
        sma.ACTUAL_CONSUMPTION_QTY, sma.FORECASTED_CONSUMPTION_QTY, 
        sma.ACTUAL,
        sma.SHIPMENT_QTY SQTY,
        sma.ADJUSTMENT_MULTIPLIED_QTY `ADJUSTMENT`,
        sma.`NATIONAL_ADJUSTMENT`,
        sma.EXPIRED_STOCK,
        sma.CLOSING_BALANCE `FINAL_CLOSING_BALANCE`,
        sma.AMC, sma.UNMET_DEMAND,sma.REGION_COUNT,sma.REGION_COUNT_FOR_STOCK,
        sma.MOS `MoS`,
        ppu.PLAN_BASED_ON,
        ppu.DISTRIBUTION_LEAD_TIME,
        IF(ppu.MIN_MONTHS_OF_STOCK<r.MIN_MOS_MIN_GAURDRAIL, r.MIN_MOS_MIN_GAURDRAIL, ppu.MIN_MONTHS_OF_STOCK) `MIN_MONTHS_OF_STOCK`, 
        IF(
            IF(ppu.MIN_MONTHS_OF_STOCK<r.MIN_MOS_MIN_GAURDRAIL, r.MIN_MOS_MIN_GAURDRAIL, ppu.MIN_MONTHS_OF_STOCK)+ppu.REORDER_FREQUENCY_IN_MONTHS<r.MIN_MOS_MAX_GAURDRAIL, 
            r.MIN_MOS_MAX_GAURDRAIL, 
            IF(
                IF(ppu.MIN_MONTHS_OF_STOCK<r.MIN_MOS_MIN_GAURDRAIL, r.MIN_MOS_MIN_GAURDRAIL, ppu.MIN_MONTHS_OF_STOCK)+ppu.REORDER_FREQUENCY_IN_MONTHS>r.MAX_MOS_MAX_GAURDRAIL,
                r.MAX_MOS_MAX_GAURDRAIL,
                IF(ppu.MIN_MONTHS_OF_STOCK<r.MIN_MOS_MIN_GAURDRAIL, r.MIN_MOS_MIN_GAURDRAIL, ppu.MIN_MONTHS_OF_STOCK)+ppu.REORDER_FREQUENCY_IN_MONTHS
            )
        ) `MAX_MONTHS_OF_STOCK`,
        sma.MIN_STOCK_QTY,
        sma.MAX_STOCK_QTY,
        sh.SHIPMENT_ID, sh.SHIPMENT_QTY, sh.`EDD`, sh.`NOTES`, sh.`ORDER_NO`, sh.`PRIME_LINE_NO`, sl.`RO_NO`, sl.`RO_PRIME_LINE_NO`,
        fs.FUNDING_SOURCE_ID, fs.FUNDING_SOURCE_CODE, fs.LABEL_ID `FUNDING_SOURCE_LABEL_ID`, fs.LABEL_EN `FUNDING_SOURCE_LABEL_EN`, fs.LABEL_FR `FUNDING_SOURCE_LABEL_FR`, fs.LABEL_SP `FUNDING_SOURCE_LABEL_SP`, fs.LABEL_PR `FUNDING_SOURCE_LABEL_PR`, 
        pa.PROCUREMENT_AGENT_ID, pa.PROCUREMENT_AGENT_CODE, pa.LABEL_ID `PROCUREMENT_AGENT_LABEL_ID`, pa.LABEL_EN `PROCUREMENT_AGENT_LABEL_EN`, pa.LABEL_FR `PROCUREMENT_AGENT_LABEL_FR`, pa.LABEL_SP `PROCUREMENT_AGENT_LABEL_SP`, pa.LABEL_PR `PROCUREMENT_AGENT_LABEL_PR`, 
        ds.DATA_SOURCE_ID, ds.LABEL_ID `DATA_SOURCE_LABEL_ID`, ds.LABEL_EN `DATA_SOURCE_LABEL_EN`, ds.LABEL_FR `DATA_SOURCE_LABEL_FR`, ds.LABEL_SP `DATA_SOURCE_LABEL_SP`, ds.LABEL_PR `DATA_SOURCE_LABEL_PR`, 
        ss.SHIPMENT_STATUS_ID, ss.LABEL_ID `SHIPMENT_STATUS_LABEL_ID`, ss.LABEL_EN `SHIPMENT_STATUS_LABEL_EN`, ss.LABEL_Fr `SHIPMENT_STATUS_LABEL_FR`, ss.LABEL_SP `SHIPMENT_STATUS_LABEL_SP`, ss.LABEL_PR `SHIPMENT_STATUS_LABEL_PR`
    FROM
        mn 
        LEFT JOIN tmp_supply_plan_amc sma ON mn.MONTH=sma.TRANS_DATE 
        LEFT JOIN 
            (
            SELECT COALESCE(st.RECEIVED_DATE, st.EXPECTED_DELIVERY_DATE) `EDD`, s.SHIPMENT_ID, st.SHIPMENT_QTY , st.FUNDING_SOURCE_ID, st.PROCUREMENT_AGENT_ID, st.SHIPMENT_STATUS_ID, st.NOTES, st.ORDER_NO, st.PRIME_LINE_NO, st.DATA_SOURCE_ID
            FROM 
                (
                SELECT s.SHIPMENT_ID, MAX(st.VERSION_ID) MAX_VERSION_ID FROM rm_shipment s LEFT JOIN rm_shipment_trans st ON s.SHIPMENT_ID=st.SHIPMENT_ID WHERE s.PROGRAM_ID=@programId AND st.VERSION_ID<=@versionId AND st.SHIPMENT_TRANS_ID IS NOT NULL GROUP BY s.SHIPMENT_ID 
            ) AS s 
            LEFT JOIN rm_shipment_trans st ON s.SHIPMENT_ID=st.SHIPMENT_ID AND s.MAX_VERSION_ID=st.VERSION_ID 
            WHERE 
                st.ACTIVE 
                AND st.SHIPMENT_STATUS_ID != 8 
                AND st.ACCOUNT_FLAG
                AND COALESCE(st.RECEIVED_DATE, st.EXPECTED_DELIVERY_DATE) BETWEEN @startDate AND @stopDate 
                AND st.PLANNING_UNIT_ID =@planningUnitId
        ) sh ON LEFT(sma.TRANS_DATE,7)=LEFT(sh.EDD,7)
        LEFT JOIN rm_shipment_linking sl ON sh.SHIPMENT_ID=sl.CHILD_SHIPMENT_ID AND sl.ACTIVE
        LEFT JOIN vw_funding_source fs ON sh.FUNDING_SOURCE_ID=fs.FUNDING_SOURCE_ID
        LEFT JOIN vw_procurement_agent pa ON sh.PROCUREMENT_AGENT_ID=pa.PROCUREMENT_AGENT_ID
        LEFT JOIN vw_data_source ds ON sh.DATA_SOURCE_ID=ds.DATA_SOURCE_ID
        LEFT JOIN vw_shipment_status ss ON sh.SHIPMENT_STATUS_ID=ss.SHIPMENT_STATUS_ID
        LEFT JOIN rm_program_planning_unit ppu ON ppu.PROGRAM_ID=@programId AND ppu.PLANNING_UNIT_ID=@planningUnitId
        LEFT JOIN vw_planning_unit pu ON ppu.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID
        LEFT JOIN rm_program p ON p.PROGRAM_ID=@programId
        LEFT JOIN rm_realm_country rc ON p.REALM_COUNTRY_ID=rc.REALM_COUNTRY_ID
        LEFT JOIN rm_realm r ON rc.REALM_ID=r.REALM_ID
    WHERE
        mn.MONTH BETWEEN @startDate AND @stopDate 
    ORDER BY mn.MONTH, sh.sHIPMENT_ID) AS s2;
    
END$$

DELIMITER ;
;

