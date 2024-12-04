CREATE DEFINER=`faspUser`@`localhost` PROCEDURE `getDashboardShipmentProblemsForLoadProgram`(VAR_PROGRAM_ID INT, VAR_VERSION_ID INT, VAR_STOP_DATE DATE)
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
END