CREATE DEFINER=`faspUser`@`%` PROCEDURE `getDashboardExpiriesList`(VAR_START_DATE DATE, VAR_STOP_DATE DATE, VAR_PROGRAM_ID INT, VAR_VERSION_ID INT)
BEGIN

    IF VAR_VERSION_ID = -1 THEN
        SELECT p.CURRENT_VERSION_ID INTO @versionId FROM rm_program p WHERE p.PROGRAM_ID=VAR_PROGRAM_ID;
    ELSE
        SET @versionId = VAR_VERSION_ID;
    END IF;

    SELECT p1.*, st.`RATE` 
    FROM (
        SELECT 
            p.PROGRAM_ID, pu.PLANNING_UNIT_ID, pu.LABEL_ID, pu.LABEL_EN, pu.LABEL_FR, pu.LABEL_SP, pu.LABEL_PR, 
            b.BATCH_ID, b.BATCH_NO, b.AUTO_GENERATED, spb.EXPIRY_DATE, SUM(spb.EXPIRED_STOCK) `EXPIRED_STOCK` 
        FROM vw_program p 
        LEFT JOIN rm_program_planning_unit ppu ON p.PROGRAM_ID=ppu.PROGRAM_ID AND ppu.ACTIVE 
        LEFT JOIN vw_planning_unit pu ON ppu.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID AND pu.ACTIVE 
        LEFT JOIN rm_supply_plan_batch_qty spb ON p.PROGRAM_ID=spb.PROGRAM_ID AND spb.VERSION_ID=@versionId AND spb.TRANS_DATE BETWEEN VAR_START_DATE and VAR_STOP_DATE AND pu.PLANNING_UNIT_ID=spb.PLANNING_UNIT_ID 
        LEFT JOIN rm_batch_info b ON spb.BATCH_ID=b.BATCH_ID 
        WHERE p.PROGRAM_ID=VAR_PROGRAM_ID AND spb.TRANS_DATE BETWEEN VAR_START_DATE and VAR_STOP_DATE AND spb.EXPIRED_STOCK>0 
        GROUP BY spb.PLANNING_UNIT_ID, spb.BATCH_ID
    ) p1 
    LEFT JOIN rm_shipment_trans_batch_info stbi ON p1.BATCH_ID=stbi.BATCH_ID 
    LEFT JOIN rm_shipment_trans st ON stbi.SHIPMENT_TRANS_ID=st.SHIPMENT_TRANS_ID AND st.VERSION_ID<=@versionId;
END