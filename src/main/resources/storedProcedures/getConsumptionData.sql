CREATE DEFINER=`faspUser`@`localhost` PROCEDURE `getConsumptionData`(PROGRAM_ID INT(10), VERSION_ID INT (10))
BEGIN
	SET @programId = PROGRAM_ID;
    SET @versionId = VERSION_ID;
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
            rcpu.MULTIPLIER, pu.MULTIPLIER `CONVERSION_FACTOR`,
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
	ORDER BY ct.PLANNING_UNIT_ID, ct.REGION_ID, ct.CONSUMPTION_DATE, ct.ACTUAL_FLAG, bi.EXPIRY_DATE, bi.BATCH_ID;
END