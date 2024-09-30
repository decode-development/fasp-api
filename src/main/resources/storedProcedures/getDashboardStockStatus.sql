CREATE DEFINER=`faspUser`@`localhost` PROCEDURE `getDashboardStockStatus`(VAR_START_DATE DATE, VAR_STOP_DATE DATE, VAR_PROGRAM_ID INT)
BEGIN
    
    SELECT COUNT(mn.MONTH) INTO @monthCount FROM mn WHERE mn.MONTH BETWEEN VAR_START_DATE AND VAR_STOP_DATE;
    SELECT COUNT(*) INTO @puCount FROM rm_program_planning_unit ppu LEFT JOIN rm_planning_unit pu ON ppu.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID where ppu.PROGRAM_ID=VAR_PROGRAM_ID AND ppu.ACTIVE AND pu.ACTIVE;
    
    SELECT 
        SUM(p2.`COUNT_OF_STOCK_OUT`) `COUNT_OF_STOCK_OUT`, 
        SUM(p2.`COUNT_OF_UNDER_STOCK`) `COUNT_OF_UNDER_STOCK`, 
        SUM(p2.`COUNT_OF_ADEQUATE_STOCK`) `COUNT_OF_ADEQUATE_STOCK`, 
        SUM(p2.`COUNT_OF_OVER_STOCK`) `COUNT_OF_OVER_STOCK`, 
        @puCount*@monthCount - (SUM(p2.`COUNT_OF_STOCK_OUT`)+SUM(p2.`COUNT_OF_UNDER_STOCK`)+SUM(p2.`COUNT_OF_ADEQUATE_STOCK`)+SUM(p2.`COUNT_OF_OVER_STOCK`)) `COUNT_OF_NA`,
        @puCount*@monthCount `COUNT_OF_TOTAL`
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
                WHEN ROUND(amc.MOS,1) is null THEN 4 -- NA
                WHEN ROUND(amc.MOS,1)=0 THEN 0 -- StockOut
                WHEN ROUND(amc.MOS,1) < IF(ppu.PLAN_BASED_ON=1,ppu.MIN_MONTHS_OF_STOCK,ppu.MIN_QTY) THEN 1 -- UnderStock
                WHEN ROUND(amc.MOS,1) <= IF(ppu.PLAN_BASED_ON=1,(ppu.MIN_MONTHS_OF_STOCK+ppu.REORDER_FREQUENCY_IN_MONTHS),ROUND(amc.MAX_STOCK_QTY)) THEN 2 -- Adequate Stock
                WHEN ROUND(amc.MOS,1) > IF(ppu.PLAN_BASED_ON=1,(ppu.MIN_MONTHS_OF_STOCK+ppu.REORDER_FREQUENCY_IN_MONTHS),ROUND(amc.MAX_STOCK_QTY)) THEN 3 -- Over Stock
                ELSE 5 -- Unknown
            END `STOCK_CONDITION`
        FROM vw_program p 
        LEFT JOIN rm_program_planning_unit ppu ON p.PROGRAM_ID=ppu.PROGRAM_ID
        LEFT JOIN rm_planning_unit pu ON ppu.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID 
        LEFT JOIN rm_supply_plan_amc amc ON p.PROGRAM_ID=amc.PROGRAM_ID AND p.CURRENT_VERSION_ID=amc.VERSION_ID AND ppu.PLANNING_UNIT_ID=amc.PLANNING_UNIT_ID
        WHERE p.PROGRAM_ID=VAR_PROGRAM_ID AND amc.TRANS_DATE BETWEEN VAR_START_DATE AND VAR_STOP_DATE and ppu.ACTIVE AND pu.ACTIVE
        ) p1 GROUP BY p1.PLANNING_UNIT_ID) p2 ON pu.PLANNING_UNIT_ID=p2.PLANNING_UNIT_ID
    WHERE p.PROGRAM_ID = VAR_PROGRAM_ID AND pu.PLANNING_UNIT_ID IS NOT NULL
    GROUP BY p.PROGRAM_ID;
END