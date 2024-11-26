CREATE DEFINER=`faspUser`@`localhost` PROCEDURE `getDashboardShipmentProblems`(VAR_PROGRAM_ID INT)
BEGIN

SELECT COUNT(DISTINCT(ppu.PROGRAM_PLANNING_UNIT_ID)) AS PU_COUNT, COUNT(DISTINCT(ppu.PROGRAM_PLANNING_UNIT_ID))-COUNT(DISTINCT CASE WHEN (prr.PROBLEM_STATUS_ID = 1 AND (prr.REALM_PROBLEM_ID = 3 OR prr.REALM_PROBLEM_ID = 4)) THEN prr.DATA3 END) AS GOOD_COUNT
FROM rm_problem_report prr 
LEFT JOIN vw_planning_unit pu ON prr.DATA3=pu.PLANNING_UNIT_ID 
LEFT JOIN vw_program prog ON prr.PROGRAM_ID=prog.PROGRAM_ID 
LEFT JOIN rm_program_planning_unit ppu ON ppu.PROGRAM_ID=prog.PROGRAM_ID AND ppu.PLANNING_UNIT_ID=pu.PLANNING_UNIT_ID                  
WHERE prr.PROGRAM_ID=VAR_PROGRAM_ID AND prr.VERSION_ID<=prog.CURRENT_VERSION_ID AND pu.ACTIVE AND ppu.ACTIVE;
END