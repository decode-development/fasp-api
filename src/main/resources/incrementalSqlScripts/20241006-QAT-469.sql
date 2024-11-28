DELETE ccr.* FROM us_can_create_role ccr WHERE ccr.ROLE_ID='ROLE_PROGRAM_ADMIN' AND (ccr.CAN_CREATE_ROLE='ROLE_INTERNAL_USER' OR ccr.CAN_CREATE_ROLE='ROLE_GUEST_USER');

INSERT INTO ap_label VALUES (null, 'SP - View Update Planning Units', null, null, null, 1, now(), 1, now(), 1);
INSERT INTO us_business_function values ('ROLE_BF_LIST_PROGRAM_PRODUCT', last_insert_id(), 1, now(), 1, now());
insert into us_role_business_function values (null,'ROLE_PROGRAM_USER','ROLE_BF_LIST_PROGRAM_PRODUCT',1,now(),1,now());
insert into us_role_business_function values (null,'ROLE_PROGRAM_USER','ROLE_BF_LIST_PROGRAM',1,now(),1,now());

INSERT INTO `ap_security` VALUES (4,1,'/api/budget','ROLE_BF_DROPDOWN_SP'),(3,1,'/api/budget','ROLE_BF_LIST_BUDGET'),(5,1,'/api/budget/*','ROLE_BF_LIST_BUDGET'),(7,1,'/api/budget/realmId/*','ROLE_BF_LIST_BUDGET'),(8,1,'/api/businessFunction','ROLE_BF_ADD_ROLE'),(338,1,'/api/commit/sendNotification/*','ROLE_BF_COMMIT_DATASET'),(339,1,'/api/commit/sendNotification/*','ROLE_BF_COMMIT_VERSION'),(11,1,'/api/country','ROLE_BF_DROPDOWN_FC'),(10,1,'/api/country','ROLE_BF_DROPDOWN_SP'),(9,1,'/api/country','ROLE_BF_LIST_COUNTRY'),(17,1,'/api/country/*','ROLE_BF_DROPDOWN_FC'),(16,1,'/api/country/*','ROLE_BF_DROPDOWN_SP'),(14,1,'/api/country/*','ROLE_BF_LIST_COUNTRY'),(21,1,'/api/currency','ROLE_BF_DROPDOWN_FC'),(20,1,'/api/currency','ROLE_BF_DROPDOWN_SP'),(19,1,'/api/currency','ROLE_BF_LIST_CURRENCY'),(25,1,'/api/currency/*','ROLE_BF_DROPDOWN_SP'),(23,1,'/api/currency/*','ROLE_BF_LIST_CURRENCY'),(26,1,'/api/dashboard/applicationLevel**','ROLE_BF_APPLICATION_DASHBOARD'),(28,1,'/api/dashboard/realmLevel','ROLE_BF_APPLICATION_DASHBOARD'),(29,1,'/api/dashboard/realmLevel/userList','ROLE_BF_APPLICATION_DASHBOARD'),(30,1,'/api/dashboard/supplyPlanReviewerLevel','ROLE_BF_APPLICATION_DASHBOARD'),(345,1,'/api/dataset','ROLE_BF_DROPDOWN_FC'),(347,1,'/api/dataset/*','ROLE_BF_DROPDOWN_FC'),(346,1,'/api/dataset/*','ROLE_BF_LIST_DATASET'),(352,1,'/api/datasetData/programId/**','ROLE_BF_COMMIT_DATASET'),(354,1,'/api/datasetData/programId/**','ROLE_BF_LOGGED_IN'),(36,1,'/api/dataSource','ROLE_BF_DROPDOWN_FC'),(35,1,'/api/dataSource','ROLE_BF_DROPDOWN_SP'),(34,1,'/api/dataSource','ROLE_BF_LIST_DATA_SOURCE'),(41,1,'/api/dataSource/**','ROLE_BF_DROPDOWN_FC'),(40,1,'/api/dataSource/**','ROLE_BF_DROPDOWN_SP'),(38,1,'/api/dataSource/**','ROLE_BF_LIST_DATA_SOURCE'),(47,1,'/api/dataSourceType','ROLE_BF_DROPDOWN_FC'),(46,1,'/api/dataSourceType','ROLE_BF_DROPDOWN_SP'),(45,1,'/api/dataSourceType','ROLE_BF_LIST_DATA_SOURCE_TYPE'),(52,1,'/api/dataSourceType/**','ROLE_BF_DROPDOWN_FC'),(51,1,'/api/dataSourceType/**','ROLE_BF_DROPDOWN_SP'),(49,1,'/api/dataSourceType/**','ROLE_BF_LIST_DATA_SOURCE_TYPE'),(58,1,'/api/dimension','ROLE_BF_DROPDOWN_FC'),(57,1,'/api/dimension','ROLE_BF_DROPDOWN_SP'),(56,1,'/api/dimension','ROLE_BF_LIST_DIMENSION'),(59,1,'/api/dimension/*','ROLE_BF_LIST_DIMENSION'),(404,1,'/api/dropdown/budget/program/*','ROLE_BF_DROPDOWN_SP'),(398,1,'/api/dropdown/equivalencyUnit','ROLE_BF_DROPDOWN_FC'),(397,1,'/api/dropdown/equivalencyUnit','ROLE_BF_DROPDOWN_SP'),(379,1,'/api/dropdown/forecastingUnit','ROLE_BF_DROPDOWN_FC'),(378,1,'/api/dropdown/forecastingUnit','ROLE_BF_DROPDOWN_SP'),(377,1,'/api/dropdown/forecastingUnit/autocomplete/filter/tracerCategory/**','ROLE_BF_DROPDOWN_FC'),(376,1,'/api/dropdown/forecastingUnit/autocomplete/filter/tracerCategory/**','ROLE_BF_DROPDOWN_SP'),(394,1,'/api/dropdown/fundingSource','ROLE_BF_DROPDOWN_SP'),(385,1,'/api/dropdown/healthArea/realm/*','ROLE_BF_DROPDOWN_FC'),(384,1,'/api/dropdown/healthArea/realm/*','ROLE_BF_DROPDOWN_SP'),(387,1,'/api/dropdown/organisation/realm/*','ROLE_BF_DROPDOWN_FC'),(386,1,'/api/dropdown/organisation/realm/*','ROLE_BF_DROPDOWN_SP'),(389,1,'/api/dropdown/organisation/realmCountryId/*','ROLE_BF_DROPDOWN_FC'),(388,1,'/api/dropdown/organisation/realmCountryId/*','ROLE_BF_DROPDOWN_SP'),(373,1,'/api/dropdown/planningUnit','ROLE_BF_DROPDOWN_FC'),(372,1,'/api/dropdown/planningUnit','ROLE_BF_DROPDOWN_SP'),(371,1,'/api/dropdown/planningUnit/autocomplete/filter/productCategory/**','ROLE_BF_DROPDOWN_FC'),(370,1,'/api/dropdown/planningUnit/autocomplete/filter/productCategory/**','ROLE_BF_DROPDOWN_SP'),(411,1,'/api/dropdown/planningUnit/basic','ROLE_BF_DROPDOWN_FC'),(410,1,'/api/dropdown/planningUnit/basic','ROLE_BF_DROPDOWN_SP'),(395,1,'/api/dropdown/procurementAgent','ROLE_BF_DROPDOWN_SP'),(361,1,'/api/dropdown/program/all/expanded/realm/*','ROLE_BF_DROPDOWN_FC'),(360,1,'/api/dropdown/program/all/expanded/realm/*','ROLE_BF_DROPDOWN_SP'),(358,1,'/api/dropdown/program/dataset/realm/*','ROLE_BF_DROPDOWN_FC'),(363,1,'/api/dropdown/program/fc/expanded/realm/*','ROLE_BF_DROPDOWN_FC'),(362,1,'/api/dropdown/program/sp/expanded/realm/*','ROLE_BF_DROPDOWN_SP'),(359,1,'/api/dropdown/program/supplyPlan/realm/*','ROLE_BF_DROPDOWN_SP'),(415,1,'/api/dropdown/program/versionStatus/**','ROLE_BF_DROPDOWN_FC'),(414,1,'/api/dropdown/program/versionStatus/**','ROLE_BF_DROPDOWN_SP'),(383,1,'/api/dropdown/realmCountry/realm/*','ROLE_BF_DROPDOWN_FC'),(382,1,'/api/dropdown/realmCountry/realm/*','ROLE_BF_DROPDOWN_SP'),(391,1,'/api/dropdown/tracerCategory','ROLE_BF_DROPDOWN_FC'),(390,1,'/api/dropdown/tracerCategory','ROLE_BF_DROPDOWN_SP'),(409,1,'/api/dropdown/treeTemplate','ROLE_BF_DROPDOWN_FC'),(400,1,'/api/dropdown/user','ROLE_BF_DROPDOWN_FC'),(399,1,'/api/dropdown/user','ROLE_BF_DROPDOWN_SP'),(406,1,'/api/dropdown/version/filter/fc/programId/*','ROLE_BF_DROPDOWN_FC'),(405,1,'/api/dropdown/version/filter/sp/programId/*','ROLE_BF_DROPDOWN_SP'),(63,1,'/api/equivalencyUnit','ROLE_BF_DROPDOWN_FC'),(62,1,'/api/equivalencyUnit','ROLE_BF_DROPDOWN_SP'),(61,1,'/api/equivalencyUnit','ROLE_BF_LIST_EQUIVALENCY_UNIT'),(67,1,'/api/equivalencyUnit/**','ROLE_BF_DROPDOWN_FC'),(66,1,'/api/equivalencyUnit/**','ROLE_BF_DROPDOWN_SP'),(65,1,'/api/equivalencyUnit/**','ROLE_BF_LIST_EQUIVALENCY_UNIT'),(69,1,'/api/equivalencyUnit/mapping','ROLE_BF_LIST_EQUIVALENCY_UNIT_MAPPING'),(71,1,'/api/equivalencyUnit/mapping/**','ROLE_BF_LIST_EQUIVALENCY_UNIT_MAPPING'),(417,1,'/api/erpLinking/**','ROLE_BF_DELINKING'),(416,1,'/api/erpLinking/**','ROLE_BF_MANUAL_TAGGING'),(421,1,'/api/erpLinking/productCategory/realmCountryId/*','ROLE_BF_DELINKING'),(420,1,'/api/erpLinking/productCategory/realmCountryId/*','ROLE_BF_MANUAL_TAGGING'),(76,1,'/api/forecastingUnit','ROLE_BF_DROPDOWN_FC'),(75,1,'/api/forecastingUnit','ROLE_BF_DROPDOWN_SP'),(74,1,'/api/forecastingUnit','ROLE_BF_LIST_FORECASTING_UNIT'),(80,1,'/api/forecastingUnit/**','ROLE_BF_DROPDOWN_FC'),(79,1,'/api/forecastingUnit/**','ROLE_BF_DROPDOWN_SP'),(77,1,'/api/forecastingUnit/**','ROLE_BF_LIST_FORECASTING_UNIT'),(89,1,'/api/forecastMethod','ROLE_BF_DROPDOWN_FC'),(88,1,'/api/forecastMethod','ROLE_BF_LIST_FORECAST_METHOD'),(93,1,'/api/forecastMethod/*','ROLE_BF_DROPDOWN_FC'),(92,1,'/api/forecastMethod/*','ROLE_BF_DROPDOWN_SP'),(91,1,'/api/forecastMethod/*','ROLE_BF_LIST_FORECAST_METHOD'),(101,1,'/api/fundingSource','ROLE_BF_DROPDOWN_FC'),(100,1,'/api/fundingSource','ROLE_BF_DROPDOWN_SP'),(99,1,'/api/fundingSource','ROLE_BF_LIST_FUNDING_SOURCE'),(102,1,'/api/fundingSource/**','ROLE_BF_LIST_FUNDING_SOURCE'),(107,1,'/api/fundingSourceType','ROLE_BF_LIST_FUNDING_SOURCE'),(109,1,'/api/fundingSourceType/**','ROLE_BF_DROPDOWN_SP'),(108,1,'/api/fundingSourceType/**','ROLE_BF_LIST_FUNDING_SOURCE'),(451,1,'/api/getDatabaseLabelsListAll','ROLE_BUSINESS_FUNCTION_EDIT_APPLICATION_LABELS'),(453,1,'/api/getDatabaseLabelsListAll','ROLE_BUSINESS_FUNCTION_EDIT_PROGRAM_LABELS'),(452,1,'/api/getDatabaseLabelsListAll','ROLE_BUSINESS_FUNCTION_EDIT_REALM_LABELS'),(454,1,'/api/getStaticLabelsListAll','ROLE_BF_LABEL_TRANSLATIONS'),(115,1,'/api/healthArea','ROLE_BF_DROPDOWN_FC'),(114,1,'/api/healthArea','ROLE_BF_DROPDOWN_SP'),(113,1,'/api/healthArea','ROLE_BF_LIST_HEALTH_AREA'),(123,1,'/api/healthArea/**','ROLE_BF_DROPDOWN_FC'),(122,1,'/api/healthArea/**','ROLE_BF_DROPDOWN_SP'),(116,1,'/api/healthArea/**','ROLE_BF_LIST_HEALTH_AREA'),(124,1,'/api/integration','ROLE_BF_LIST_INTEGRATION'),(127,1,'/api/integration/*','ROLE_BF_LIST_INTEGRATION'),(129,1,'/api/integrationProgram','ROLE_BF_ADD_INTEGRATION_PROGRAM'),(131,1,'/api/integrationProgram/**','ROLE_BF_ADD_INTEGRATION_PROGRAM'),(461,1,'/api/language','ROLE_BF_DROPDOWN_FC'),(460,1,'/api/language','ROLE_BF_DROPDOWN_SP'),(459,1,'/api/language','ROLE_BF_LIST_LANGUAGE'),(466,1,'/api/language/*','ROLE_BF_DROPDOWN_FC'),(465,1,'/api/language/*','ROLE_BF_DROPDOWN_SP'),(464,1,'/api/language/*','ROLE_BF_EDIT_LANGUAGE'),(355,1,'/api/loadDataset','ROLE_BF_LOAD_DELETE_DATASET'),(356,1,'/api/loadDataset/**','ROLE_BF_LOAD_DELETE_DATASET'),(536,1,'/api/loadProgram','ROLE_BF_DOWNLOAD_PROGARM'),(537,1,'/api/loadProgram/**','ROLE_BF_DOWNLOAD_PROGARM'),(467,1,'/api/locales/**','ROLE_BF_LOGGED_IN'),(134,1,'/api/logout','ROLE_BF_LOGGED_IN'),(135,1,'/api/master/*','ROLE_BF_LIST_MASTER_DATA'),(142,1,'/api/modelingType','ROLE_BF_DROPDOWN_FC'),(141,1,'/api/modelingType','ROLE_BF_LIST_MODELING_TYPE'),(146,1,'/api/modelingType/*','ROLE_BF_DROPDOWN_FC'),(145,1,'/api/modelingType/*','ROLE_BF_DROPDOWN_SP'),(144,1,'/api/modelingType/*','ROLE_BF_LIST_MODELING_TYPE'),(151,1,'/api/organisation','ROLE_BF_DROPDOWN_FC'),(150,1,'/api/organisation','ROLE_BF_DROPDOWN_SP'),(149,1,'/api/organisation','ROLE_BF_LIST_ORGANIZATION'),(152,1,'/api/organisation/**','ROLE_BF_LIST_ORGANIZATION'),(156,1,'/api/organisationType','ROLE_BF_LIST_ORGANIZATION_TYPE'),(160,1,'/api/organisationType/**','ROLE_BF_DROPDOWN_FC'),(159,1,'/api/organisationType/**','ROLE_BF_DROPDOWN_SP'),(157,1,'/api/organisationType/**','ROLE_BF_LIST_ORGANIZATION_TYPE'),(469,1,'/api/pipeline','ROLE_BF_PIPELINE_PROGRAM_IMPORT'),(470,1,'/api/pipeline/**','ROLE_BF_PIPELINE_PROGRAM_IMPORT'),(173,1,'/api/planningUnit','ROLE_BF_DROPDOWN_FC'),(172,1,'/api/planningUnit','ROLE_BF_DROPDOWN_SP'),(171,1,'/api/planningUnit','ROLE_BF_LIST_PLANNING_UNIT'),(168,1,'/api/planningUnit/**','ROLE_BF_DROPDOWN_FC'),(167,1,'/api/planningUnit/**','ROLE_BF_DROPDOWN_SP'),(165,1,'/api/planningUnit/**','ROLE_BF_LIST_PLANNING_UNIT'),(175,1,'/api/planningUnit/capacity/**','ROLE_BF_LIST_PLANNING_UNIT_CAPACITY'),(357,1,'/api/planningUnit/programId/**','ROLE_BF_EDIT_DATASET'),(494,1,'/api/problemStatus','ROLE_BF_SUPPLY_PLAN_VERSION_AND_REVIEW'),(199,1,'/api/procurementAgent','ROLE_BF_DROPDOWN_FC'),(198,1,'/api/procurementAgent','ROLE_BF_DROPDOWN_SP'),(197,1,'/api/procurementAgent','ROLE_BF_LIST_PROCUREMENT_AGENT'),(200,1,'/api/procurementAgent/**','ROLE_BF_LIST_PROCUREMENT_AGENT'),(217,1,'/api/procurementAgentType','ROLE_BF_DROPDOWN_FC'),(216,1,'/api/procurementAgentType','ROLE_BF_DROPDOWN_SP'),(215,1,'/api/procurementAgentType','ROLE_BF_LIST_PROCUREMENT_AGENT'),(218,1,'/api/procurementAgentType/**','ROLE_BF_LIST_PROCUREMENT_AGENT'),(223,1,'/api/procurementUnit','ROLE_BF_DROPDOWN_SP'),(222,1,'/api/procurementUnit','ROLE_BF_LIST_PROCUREMENT_UNIT'),(226,1,'/api/procurementUnit/**','ROLE_BF_DROPDOWN_SP'),(224,1,'/api/procurementUnit/**','ROLE_BF_LIST_PROCUREMENT_UNIT'),(232,1,'/api/productCategory/**','ROLE_BF_LIST_PRODUCT_CATEGORY'),(233,1,'/api/productCategory/**','ROLE_BF_LOGGED_IN'),(517,1,'/api/program','ROLE_BF_DROPDOWN_FC'),(516,1,'/api/program','ROLE_BF_DROPDOWN_SP'),(515,1,'/api/program','ROLE_BF_LIST_PROGRAM'),(533,1,'/api/program/*','ROLE_BF_UPDATE_PROGRAM'),(523,1,'/api/program/**','ROLE_BF_DROPDOWN_FC'),(522,1,'/api/program/**','ROLE_BF_DROPDOWN_SP'),(521,1,'/api/program/**','ROLE_BF_LIST_PROGRAM'),(520,1,'/api/program/all','ROLE_BF_DROPDOWN_FC'),(519,1,'/api/program/all','ROLE_BF_DROPDOWN_SP'),(518,1,'/api/program/all','ROLE_BF_LIST_PROGRAM'),(505,1,'/api/program/data/version/trans/programId/**','ROLE_BF_PROBLEM_AND_ACTION_REPORT'),(504,1,'/api/program/data/version/trans/programId/**','ROLE_BF_SUPPLY_PLAN_VERSION_AND_REVIEW'),(510,1,'/api/programData/getLastModifiedDateForProgram/**','ROLE_BF_COMMIT_VERSION'),(508,1,'/api/programData/getLatestVersionForProgram/*','ROLE_BF_COMMIT_DATASET'),(509,1,'/api/programData/getLatestVersionForProgram/*','ROLE_BF_COMMIT_VERSION'),(495,1,'/api/programData/programId/**','ROLE_BF_COMMIT_VERSION'),(496,1,'/api/programData/programId/**','ROLE_BF_SUPPLY_PLAN_VERSION_AND_REVIEW'),(500,1,'/api/programData/shipmentSync/programId/**','ROLE_BF_MASTER_DATA_SYNC'),(498,1,'/api/programVersion/programId/**','ROLE_BF_DOWNLOAD_PROGARM'),(473,1,'/api/qatTemp/**','ROLE_BF_PIPELINE_PROGRAM_IMPORT'),(240,1,'/api/realm','ROLE_BF_DROPDOWN_FC'),(239,1,'/api/realm','ROLE_BF_DROPDOWN_SP'),(238,1,'/api/realm','ROLE_BF_LIST_REALM'),(241,1,'/api/realm/*','ROLE_BF_LIST_REALM'),(246,1,'/api/realmCountry','ROLE_BF_DROPDOWN_FC'),(245,1,'/api/realmCountry','ROLE_BF_DROPDOWN_SP'),(244,1,'/api/realmCountry','ROLE_BF_LIST_REALM_COUNTRY'),(254,1,'/api/realmCountry/**','ROLE_BF_DROPDOWN_FC'),(249,1,'/api/realmCountry/**','ROLE_BF_DROPDOWN_SP'),(247,1,'/api/realmCountry/**','ROLE_BF_LIST_REALM_COUNTRY'),(248,1,'/api/realmCountry/**','ROLE_BF_MANAGE_REALM_COUNTRY_PLANNING_UNIT'),(265,1,'/api/region','ROLE_BF_DROPDOWN_FC'),(264,1,'/api/region','ROLE_BF_DROPDOWN_SP'),(263,1,'/api/region','ROLE_BF_MAP_REGION'),(269,1,'/api/region/**','ROLE_BF_DROPDOWN_FC'),(270,1,'/api/region/**','ROLE_BF_DROPDOWN_SP'),(268,1,'/api/region/**','ROLE_BF_EDIT_PROGRAM'),(266,1,'/api/region/**','ROLE_BF_MAP_REGION'),(576,1,'/api/report/updateProgramInfo/**','ROLE_BF_LIST_ALTERNATE_REPORTING_UNIT'),(577,1,'/api/report/updateProgramInfo/**','ROLE_BF_LIST_DATASET'),(578,1,'/api/report/updateProgramInfo/**','ROLE_BF_LIST_PROGRAM'),(271,1,'/api/role','ROLE_BF_ADD_ROLE'),(273,1,'/api/role','ROLE_BF_DROPDOWN_FC'),(272,1,'/api/role','ROLE_BF_DROPDOWN_SP'),(276,1,'/api/role/*','ROLE_BF_ADD_ROLE'),(280,1,'/api/supplier','ROLE_BF_DROPDOWN_SP'),(279,1,'/api/supplier','ROLE_BF_LIST_SUPPLIER'),(281,1,'/api/supplier/**','ROLE_BF_LIST_SUPPLIER'),(579,1,'/api/sync/language/*','ROLE_BF_LOGGED_IN'),(450,1,'/api/ticket/openIssues','ROLE_BF_LOGGED_IN'),(287,1,'/api/tracerCategory','ROLE_BF_DROPDOWN_FC'),(286,1,'/api/tracerCategory','ROLE_BF_DROPDOWN_SP'),(285,1,'/api/tracerCategory','ROLE_BF_LIST_TRACER_CATEGORY'),(291,1,'/api/tracerCategory/**','ROLE_BF_DROPDOWN_FC'),(290,1,'/api/tracerCategory/**','ROLE_BF_DROPDOWN_SP'),(288,1,'/api/tracerCategory/**','ROLE_BF_LIST_TRACER_CATEGORY'),(583,1,'/api/treeTemplate','ROLE_BF_LOGGED_IN'),(582,1,'/api/treeTemplate','ROLE_BF_VIEW_TREE_TEMPLATES'),(587,1,'/api/treeTemplate/*','ROLE_BF_LOGGED_IN'),(586,1,'/api/treeTemplate/*','ROLE_BF_VIEW_TREE_TEMPLATES'),(303,1,'/api/unit','ROLE_BF_DROPDOWN_FC'),(302,1,'/api/unit','ROLE_BF_DROPDOWN_SP'),(301,1,'/api/unit','ROLE_BF_LIST_UNIT'),(307,1,'/api/unit/**','ROLE_BF_DROPDOWN_FC'),(306,1,'/api/unit/**','ROLE_BF_DROPDOWN_SP'),(304,1,'/api/unit/**','ROLE_BF_LIST_UNIT'),(309,1,'/api/usagePeriod','ROLE_BF_DROPDOWN_FC'),(308,1,'/api/usagePeriod','ROLE_BF_LIST_USAGE_PERIOD'),(313,1,'/api/usagePeriod/**','ROLE_BF_DROPDOWN_FC'),(312,1,'/api/usagePeriod/**','ROLE_BF_DROPDOWN_SP'),(311,1,'/api/usagePeriod/**','ROLE_BF_LIST_USAGE_PERIOD'),(314,1,'/api/usageTemplate','ROLE_BF_LIST_USAGE_TEMPLATE'),(318,1,'/api/usageTemplate/**','ROLE_BF_LIST_USAGE_TEMPLATE'),(320,1,'/api/user','ROLE_BF_LIST_USER'),(324,1,'/api/user/*','ROLE_BF_LIST_USER'),(325,1,'/api/user/accessControls','ROLE_BF_LIST_USER'),(323,1,'/api/user/details','ROLE_BF_LOGGED_IN'),(334,1,'/api/user/programId/*','ROLE_BF_EDIT_PROGRAM'),(333,1,'/api/user/programId/*','ROLE_BF_LIST_USER'),(337,1,'/api/user/realmId/*','ROLE_BF_DROPDOWN_FC'),(336,1,'/api/user/realmId/*','ROLE_BF_DROPDOWN_SP'),(335,1,'/api/user/realmId/*','ROLE_BF_LIST_USER'),(447,1,'/file/*','ROLE_BF_LOGGED_IN'),(1,2,'/api/budget','ROLE_BF_ADD_BUDGET'),(6,2,'/api/budget/programIds','ROLE_BF_LIST_BUDGET'),(340,2,'/api/commit/getCommitRequest/*','ROLE_BF_COMMIT_DATASET'),(341,2,'/api/commit/getCommitRequest/*','ROLE_BF_COMMIT_VERSION'),(342,2,'/api/commit/getCommitRequest/*','ROLE_BF_LOGGED_IN'),(12,2,'/api/country','ROLE_BF_ADD_COUNTRY'),(18,2,'/api/currency','ROLE_BF_ADD_CURRENCY'),(32,2,'/api/dashboard/supplyPlanBottom','ROLE_BF_SP_DASHBOARD'),(31,2,'/api/dashboard/supplyPlanTop','ROLE_BF_SP_DASHBOARD'),(350,2,'/api/dataset','ROLE_BF_ADD_DATASET'),(348,2,'/api/dataset/versions**','ROLE_BF_LIST_DATASET'),(349,2,'/api/datasetData','ROLE_BF_LIST_DATASET'),(33,2,'/api/dataSource','ROLE_BF_ADD_DATA_SOURCE'),(44,2,'/api/dataSourceType','ROLE_BF_ADD_DATA_SOURCE_TYPE'),(54,2,'/api/dimension','ROLE_BF_ADD_DIMENSION'),(403,2,'/api/dropdown/budget/filter/multipleFundingSources','ROLE_BF_DROPDOWN_SP'),(375,2,'/api/dropdown/forecastingUnit/autocomplete','ROLE_BF_DROPDOWN_FC'),(374,2,'/api/dropdown/forecastingUnit/autocomplete','ROLE_BF_DROPDOWN_SP'),(381,2,'/api/dropdown/forecastingUnit/filter/pcAndTc','ROLE_BF_DROPDOWN_FC'),(380,2,'/api/dropdown/forecastingUnit/filter/pcAndTc','ROLE_BF_DROPDOWN_SP'),(412,2,'/api/dropdown/fundingSource/programs','ROLE_BF_DROPDOWN_SP'),(413,2,'/api/dropdown/fundingSourceType/programs','ROLE_BF_DROPDOWN_SP'),(369,2,'/api/dropdown/planningUnit/autocomplete','ROLE_BF_DROPDOWN_FC'),(368,2,'/api/dropdown/planningUnit/autocomplete','ROLE_BF_DROPDOWN_SP'),(402,2,'/api/dropdown/planningUnit/dataset/filter/programAndVersion','ROLE_BF_DROPDOWN_FC'),(401,2,'/api/dropdown/planningUnit/program/filter/multipleProgramAndTracerCategory','ROLE_BF_DROPDOWN_SP'),(396,2,'/api/dropdown/procurementAgent/filter/multiplePrograms','ROLE_BF_DROPDOWN_SP'),(365,2,'/api/dropdown/program/fc/filter/healthAreaAndRealmCountry/realm/*','ROLE_BF_DROPDOWN_FC'),(367,2,'/api/dropdown/program/fc/filter/multipleRealmCountry','ROLE_BF_DROPDOWN_FC'),(364,2,'/api/dropdown/program/sp/filter/healthAreaAndRealmCountry/realm/*','ROLE_BF_DROPDOWN_SP'),(366,2,'/api/dropdown/program/sp/filter/multipleRealmCountry','ROLE_BF_DROPDOWN_SP'),(393,2,'/api/dropdown/tracerCategory/filter/multiplePrograms','ROLE_BF_DROPDOWN_FC'),(392,2,'/api/dropdown/tracerCategory/filter/multiplePrograms','ROLE_BF_DROPDOWN_SP'),(408,2,'/api/dropdown/version/filter/fc/programs','ROLE_BF_DROPDOWN_FC'),(407,2,'/api/dropdown/version/filter/sp/programs','ROLE_BF_DROPDOWN_SP'),(64,2,'/api/equivalencyUnit','ROLE_BF_ADD_EQUIVALENCY_UNIT'),(70,2,'/api/equivalencyUnit/mapping','ROLE_BF_ADD_EQUIVALENCY_UNIT_MAPPING'),(424,2,'/api/erpLinking/**','ROLE_BF_DELINKING'),(423,2,'/api/erpLinking/**','ROLE_BF_MANUAL_TAGGING'),(419,2,'/api/erpLinking/linkedShipments/programId/**','ROLE_BF_DELINKING'),(418,2,'/api/erpLinking/linkedShipments/programId/**','ROLE_BF_MANUAL_TAGGING'),(422,2,'/api/erpLinking/shipmentSync','ROLE_BF_LOGGED_IN'),(445,2,'/api/export/dataset/**','ROLE_BF_COUNTRY_INTEGRATION_FC'),(446,2,'/api/export/supplyPlan/**','ROLE_BF_COUNTRY_INTEGRATION_SP'),(72,2,'/api/forecastingUnit','ROLE_BF_ADD_FORECASTING_UNIT'),(81,2,'/api/forecastingUnit/**','ROLE_BF_LIST_FORECASTING_UNIT'),(90,2,'/api/forecastMethod','ROLE_BF_ADD_FORECAST_METHOD'),(94,2,'/api/forecastStats/*','ROLE_BF_COMMIT_DATASET'),(97,2,'/api/fundingSource','ROLE_BF_ADD_FUNDING_SOURCE'),(105,2,'/api/fundingSourceType','ROLE_BF_ADD_FUNDING_SOURCE'),(111,2,'/api/healthArea','ROLE_BF_ADD_HEALTH_AREA'),(125,2,'/api/integration','ROLE_BF_ADD_INTEGRATION'),(132,2,'/api/integrationProgram/**','ROLE_BF_MANUAL_INTEGRATION'),(462,2,'/api/language','ROLE_BF_ADD_LANGUAGE'),(143,2,'/api/modelingType','ROLE_BF_ADD_MODELING_TYPE'),(147,2,'/api/organisation','ROLE_BF_ADD_ORGANIZATION'),(154,2,'/api/organisationType','ROLE_BF_ADD_ORGANIZATION_TYPE'),(468,2,'/api/pipeline/**','ROLE_BF_PIPELINE_PROGRAM_IMPORT'),(169,2,'/api/planningUnit','ROLE_BF_ADD_PLANNING_UNIT'),(174,2,'/api/planningUnit/**','ROLE_BF_LIST_PLANNING_UNIT'),(190,2,'/api/planningUnit/productCategoryList/active/realmCountryId/*','ROLE_BF_MANUAL_TAGGING'),(164,2,'/api/planningUnit/programs','ROLE_BF_LIST_ALTERNATE_REPORTING_UNIT'),(493,2,'/api/problemReport/createManualProblem','ROLE_BF_SUPPLY_PLAN_VERSION_AND_REVIEW'),(195,2,'/api/procurementAgent','ROLE_BF_ADD_PROCUREMENT_AGENT'),(204,2,'/api/procurementAgent/**','ROLE_BF_ADD_PROCUREMENT_AGENT'),(213,2,'/api/procurementAgentType','ROLE_BF_ADD_PROCUREMENT_AGENT'),(220,2,'/api/procurementUnit','ROLE_BF_ADD_PROCUREMENT_UNIT'),(527,2,'/api/program/**','ROLE_BF_LIST_IMPORT_FROM_QAT_SUPPLY_PLAN'),(524,2,'/api/program/**','ROLE_BF_LIST_PROGRAM'),(525,2,'/api/program/**','ROLE_BF_MANUAL_TAGGING'),(511,2,'/api/program/actualConsumptionReport','ROLE_BF_LIST_IMPORT_FROM_QAT_SUPPLY_PLAN'),(535,2,'/api/program/initialize','ROLE_BF_CREATE_A_PROGRAM'),(530,2,'/api/program/planningUnit/procurementAgent','ROLE_BF_MAP_COUNTRY_SPECIFIC_PRICES'),(539,2,'/api/program/productCategoryList','ROLE_BF_DROPDOWN_SP'),(514,2,'/api/program/realmCountryList','ROLE_BF_DROPDOWN_FC'),(513,2,'/api/program/realmCountryList','ROLE_BF_DROPDOWN_SP'),(538,2,'/api/programAndPlanningUnit/programs','ROLE_BF_MAP_COUNTRY_SPECIFIC_PRICES'),(497,2,'/api/programData','ROLE_BF_DOWNLOAD_PROGARM'),(501,2,'/api/programData/checkNewerVersions','ROLE_BF_MASTER_DATA_SYNC'),(502,2,'/api/programData/getLatestVersionForPrograms','ROLE_BF_MASTER_DATA_SYNC'),(472,2,'/api/qatTemp/**','ROLE_BF_PIPELINE_PROGRAM_IMPORT'),(540,2,'/api/quantimed/quantimedImport/*','ROLE_BF_QUANTIMED_IMPORT'),(236,2,'/api/realm','ROLE_BF_CREATE_REALM'),(242,2,'/api/realmCountry','ROLE_BF_MAP_REALM_COUNTRY'),(257,2,'/api/realmCountry/**','ROLE_BF_LIST_ALTERNATE_REPORTING_UNIT'),(256,2,'/api/realmCountry/**','ROLE_BF_MANAGE_REALM_COUNTRY_PLANNING_UNIT'),(258,2,'/api/realmCountry/**','ROLE_BF_SUPPLY_PLAN_VERSION_AND_REVIEW'),(564,2,'/api/report/aggregateShipmentByProduct','ROLE_BF_SHIPMENT_COST_DETAILS_REPORT'),(563,2,'/api/report/annualShipmentCost','ROLE_BF_ANNUAL_SHIPMENT_COST_REPORT'),(567,2,'/api/report/budgetReport','ROLE_BF_BUDGET_REPORT'),(542,2,'/api/report/consumptionForecastVsActual','ROLE_BF_CONSUMPTION_REPORT'),(548,2,'/api/report/costOfInventory','ROLE_BF_COST_OF_INVENTORY_REPORT'),(550,2,'/api/report/expiredStock','ROLE_BF_EXPIRIES_REPORT'),(569,2,'/api/report/forecastErrorNew','ROLE_BF_FORECAST_ERROR_OVER_TIME_REPORT'),(545,2,'/api/report/forecastMetricsComparision','ROLE_BF_FORECAST_MATRIX_REPORT'),(544,2,'/api/report/forecastMetricsMonthly','ROLE_BF_FORECAST_ERROR_OVER_TIME_REPORT'),(574,2,'/api/report/forecastSummary','ROLE_BF_COMPARE_VERSION'),(572,2,'/api/report/forecastSummary','ROLE_BF_LIST_FORECAST_SUMMARY'),(573,2,'/api/report/forecastSummary','ROLE_BF_VIEW_FORECAST_SUMMARY'),(555,2,'/api/report/fundingSourceShipmentReport','ROLE_BF_FUNDER_REPORT'),(554,2,'/api/report/fundingSourceShipmentReport','ROLE_BF_SHIPMENT_COST_DETAILS_REPORT'),(543,2,'/api/report/globalConsumption','ROLE_BF_CONSUMPTION_GLOBAL_VIEW_REPORT'),(549,2,'/api/report/inventoryTurns','ROLE_BF_INVENTORY_TURNS_REPORT'),(575,2,'/api/report/manualJson','ROLE_BF_MANUAL_INTEGRATION'),(571,2,'/api/report/monthlyForecast','ROLE_BF_LIST_MONTHLY_FORECAST'),(570,2,'/api/report/monthlyForecast','ROLE_BF_SUPPLY_PLAN_IMPORT'),(552,2,'/api/report/procurementAgentShipmentReport','ROLE_BF_SHIPMENT_COST_DETAILS_REPORT'),(553,2,'/api/report/programLeadTimes','ROLE_BF_PROCUREMENT_AGENT_REPORT'),(541,2,'/api/report/programProductCatalog','ROLE_BF_PRODUCT_CATALOG_REPORT'),(560,2,'/api/report/shipmentDetails','ROLE_BF_SHIPMENT_DETAILS_REPORT'),(562,2,'/api/report/shipmentGlobalDemand','ROLE_BF_GLOBAL_DEMAND_REPORT'),(561,2,'/api/report/shipmentOverview','ROLE_BF_SHIPMENT_OVERVIEW_REPORT'),(551,2,'/api/report/stockAdjustmentReport','ROLE_BF_STOCK_ADJUSTMENT_REPORT'),(568,2,'/api/report/stockStatusAcrossProducts','ROLE_BF_STOCK_STATUS_GLOBAL_VIEW_REPORT'),(565,2,'/api/report/stockStatusForProgram','ROLE_BF_STOCK_STATUS_GLOBAL_VIEW_REPORT'),(566,2,'/api/report/stockStatusForProgram','ROLE_BF_STOCK_STATUS_REPORT'),(559,2,'/api/report/stockStatusMatrix','ROLE_BF_STOCK_STATUS_MATRIX_REPORT'),(558,2,'/api/report/stockStatusOverTime','ROLE_BF_STOCK_STATUS_OVER_TIME_REPORT'),(557,2,'/api/report/stockStatusVertical','ROLE_BF_SUPPLY_PLAN_REPORT'),(556,2,'/api/report/stockStatusVertical/dropdowns','ROLE_BF_SUPPLY_PLAN_REPORT'),(547,2,'/api/report/warehouseByCountry','ROLE_BF_REGION'),(546,2,'/api/report/warehouseCapacityReport','ROLE_BF_WAREHOUSE_CAPACITY_REPORT'),(274,2,'/api/role','ROLE_BF_ADD_ROLE'),(277,2,'/api/supplier','ROLE_BF_ADD_SUPPLIER'),(580,2,'/api/sync/allMasters/forPrograms/*','ROLE_BF_LOGGED_IN'),(581,2,'/api/sync/treeAnchor','ROLE_BF_LOGGED_IN'),(448,2,'/api/ticket/addIssue','ROLE_BF_LOGGED_IN'),(449,2,'/api/ticket/addIssueAttachment/*','ROLE_BF_LOGGED_IN'),(283,2,'/api/tracerCategory','ROLE_BF_ADD_TRACER_CATEGORY'),(295,2,'/api/tracerCategory/**','ROLE_BF_DROPDOWN_FC'),(294,2,'/api/tracerCategory/**','ROLE_BF_DROPDOWN_SP'),(293,2,'/api/tracerCategory/**','ROLE_BF_LIST_TRACER_CATEGORY'),(584,2,'/api/treeTemplate','ROLE_BF_ADD_TREE_TEMPLATE'),(299,2,'/api/unit','ROLE_BF_ADD_UNIT'),(310,2,'/api/usagePeriod','ROLE_BF_ADD_USAGE_PERIOD'),(315,2,'/api/usageTemplate','ROLE_BF_EDIT_USAGE_TEMPLATE'),(316,2,'/api/usageTemplate','ROLE_BF_EDIT_USAGE_TEMPLATE_ALL'),(317,2,'/api/usageTemplate','ROLE_BF_EDIT_USAGE_TEMPLATE_OWN'),(321,2,'/api/user','ROLE_BF_ADD_USER'),(327,2,'/api/user/agreement','ROLE_BF_LOGGED_IN'),(328,2,'/api/user/changePassword','ROLE_BF_LOGGED_IN'),(330,2,'/api/user/language','ROLE_BF_LOGGED_IN'),(331,2,'/api/user/module/*','ROLE_BF_LOGGED_IN'),(332,2,'/api/user/theme/*','ROLE_BF_LOGGED_IN'),(2,3,'/api/budget','ROLE_BF_EDIT_BUDGET'),(343,3,'/api/commit/datasetData/*','ROLE_BF_COMMIT_DATASET'),(344,3,'/api/commit/programData/*','ROLE_BF_COMMIT_VERSION'),(13,3,'/api/country','ROLE_BF_EDIT_COUNTRY'),(22,3,'/api/currency','ROLE_BF_EDIT_CURRENCY'),(351,3,'/api/dataset','ROLE_BF_EDIT_DATASET'),(37,3,'/api/dataSource','ROLE_BF_EDIT_DATA_SOURCE'),(48,3,'/api/dataSourceType','ROLE_BF_EDIT_DATA_SOURCE_TYPE'),(55,3,'/api/dimension','ROLE_BF_EDIT_DIMENSION'),(444,3,'/api/erpLinking/**','ROLE_BF_DELINKING'),(443,3,'/api/erpLinking/**','ROLE_BF_MANUAL_TAGGING'),(73,3,'/api/forecastingUnit','ROLE_BF_EDIT_FORECASTING_UNIT'),(98,3,'/api/fundingSource','ROLE_BF_EDIT_FUNDING_SOURCE'),(106,3,'/api/fundingSourceType','ROLE_BF_EDIT_FUNDING_SOURCE'),(112,3,'/api/healthArea','ROLE_BF_EDIT_HEALTH_AREA'),(126,3,'/api/integration','ROLE_BF_EDIT_INTEGRATION'),(130,3,'/api/integrationProgram','ROLE_BF_ADD_INTEGRATION_PROGRAM'),(463,3,'/api/language','ROLE_BF_EDIT_LANGUAGE'),(148,3,'/api/organisation','ROLE_BF_EDIT_ORGANIZATION'),(155,3,'/api/organisationType','ROLE_BF_EDIT_ORGANIZATION_TYPE'),(475,3,'/api/pipeline/**','ROLE_BF_PIPELINE_PROGRAM_IMPORT'),(170,3,'/api/planningUnit','ROLE_BF_EDIT_PLANNING_UNIT'),(178,3,'/api/planningUnit/capacity','ROLE_BF_MAP_PLANNING_UNIT_CAPACITY'),(196,3,'/api/procurementAgent','ROLE_BF_EDIT_PROCUREMENT_AGENT'),(205,3,'/api/procurementAgent/**','ROLE_BF_EDIT_PROCUREMENT_AGENT'),(202,3,'/api/procurementAgent/**','ROLE_BF_LIST_PROCUREMENT_AGENT'),(214,3,'/api/procurementAgentType','ROLE_BF_EDIT_PROCUREMENT_AGENT'),(221,3,'/api/procurementUnit','ROLE_BF_EDIT_PROCUREMENT_UNIT'),(231,3,'/api/productCategory','ROLE_BF_MANAGE_PRODUCT_CATEGORY'),(512,3,'/api/program','ROLE_BF_UPDATE_PROGRAM'),(529,3,'/api/program/planningUnit','ROLE_BF_ADD_PROGRAM_PRODUCT'),(531,3,'/api/program/planningUnit/procurementAgent','ROLE_BF_MAP_COUNTRY_SPECIFIC_PRICES'),(499,3,'/api/programVersion/programId/**','ROLE_BF_SUPPLY_PLAN_VERSION_AND_REVIEW'),(503,3,'/api/programVersion/resetProblem','ROLE_BF_SUPPLY_PLAN_VERSION_AND_REVIEW'),(237,3,'/api/realm','ROLE_BF_EDIT_REALM'),(243,3,'/api/realmCountry','ROLE_BF_MAP_REALM_COUNTRY'),(251,3,'/api/realmCountry/**','ROLE_BF_MANAGE_REALM_COUNTRY_PLANNING_UNIT'),(262,3,'/api/region','ROLE_BF_MAP_REGION'),(275,3,'/api/role','ROLE_BF_ADD_ROLE'),(455,3,'/api/saveDatabaseLabels','ROLE_BUSINESS_FUNCTION_EDIT_APPLICATION_LABELS'),(457,3,'/api/saveDatabaseLabels','ROLE_BUSINESS_FUNCTION_EDIT_PROGRAM_LABELS'),(456,3,'/api/saveDatabaseLabels','ROLE_BUSINESS_FUNCTION_EDIT_REALM_LABELS'),(458,3,'/api/saveStaticLabels','ROLE_BF_LABEL_TRANSLATIONS'),(278,3,'/api/supplier','ROLE_BF_EDIT_SUPPLIER'),(284,3,'/api/tracerCategory','ROLE_BF_EDIT_TRACER_CATEGORY'),(585,3,'/api/treeTemplate','ROLE_BF_EDIT_TREE_TEMPLATE'),(300,3,'/api/unit','ROLE_BF_EDIT_UNIT'),(322,3,'/api/user','ROLE_BF_EDIT_USER'),(326,3,'/api/user/accessControls','ROLE_BF_LIST_USER');
