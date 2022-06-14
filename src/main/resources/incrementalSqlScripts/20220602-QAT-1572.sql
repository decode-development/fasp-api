TRUNCATE TABLE us_can_create_role;	
INSERT INTO us_can_create_role VALUES										
('ROLE_APPLICATION_ADMIN', 'ROLE_APPLICATION_ADMIN'),					('ROLE_INTERNAL_USER', 'ROLE_APPLICATION_ADMIN'),						
('ROLE_APPLICATION_ADMIN', 'ROLE_DATASET_ADMIN'),	('ROLE_DATASET_ADMIN', 'ROLE_DATASET_ADMIN'),				('ROLE_INTERNAL_USER', 'ROLE_DATASET_ADMIN'),			('ROLE_REALM_ADMIN', 'ROLE_DATASET_ADMIN'),			
('ROLE_APPLICATION_ADMIN', 'ROLE_DATASET_USER'),	('ROLE_DATASET_ADMIN', 'ROLE_DATASET_USER'),	('ROLE_DATASET_USER', 'ROLE_DATASET_USER'),			('ROLE_INTERNAL_USER', 'ROLE_DATASET_USER'),			('ROLE_REALM_ADMIN', 'ROLE_DATASET_USER'),			
('ROLE_APPLICATION_ADMIN', 'ROLE_FORECAST_VIEWER'),	('ROLE_DATASET_ADMIN', 'ROLE_FORECAST_VIEWER'),		('ROLE_FORECAST_VIEWER', 'ROLE_FORECAST_VIEWER'),		('ROLE_INTERNAL_USER', 'ROLE_FORECAST_VIEWER'),			('ROLE_REALM_ADMIN', 'ROLE_FORECAST_VIEWER'),			
('ROLE_APPLICATION_ADMIN', 'ROLE_GUEST_USER'),				('ROLE_GUEST_USER', 'ROLE_GUEST_USER'),	('ROLE_INTERNAL_USER', 'ROLE_GUEST_USER'),	('ROLE_PROGRAM_ADMIN', 'ROLE_GUEST_USER'),		('ROLE_REALM_ADMIN', 'ROLE_GUEST_USER'),			
					('ROLE_INTERNAL_USER', 'ROLE_INTERNAL_USER'),	('ROLE_PROGRAM_ADMIN', 'ROLE_INTERNAL_USER'),					
('ROLE_APPLICATION_ADMIN', 'ROLE_PROGRAM_ADMIN'),					('ROLE_INTERNAL_USER', 'ROLE_PROGRAM_ADMIN'),	('ROLE_PROGRAM_ADMIN', 'ROLE_PROGRAM_ADMIN'),		('ROLE_REALM_ADMIN', 'ROLE_PROGRAM_ADMIN'),			
('ROLE_APPLICATION_ADMIN', 'ROLE_PROGRAM_USER'),					('ROLE_INTERNAL_USER', 'ROLE_PROGRAM_USER'),	('ROLE_PROGRAM_ADMIN', 'ROLE_PROGRAM_USER'),	('ROLE_PROGRAM_USER', 'ROLE_PROGRAM_USER'),	('ROLE_REALM_ADMIN', 'ROLE_PROGRAM_USER'),			
('ROLE_APPLICATION_ADMIN', 'ROLE_REALM_ADMIN'),					('ROLE_INTERNAL_USER', 'ROLE_REALM_ADMIN'),			('ROLE_REALM_ADMIN', 'ROLE_REALM_ADMIN'),			
('ROLE_APPLICATION_ADMIN', 'ROLE_REPORT_USER'),					('ROLE_INTERNAL_USER', 'ROLE_REPORT_USER'),	('ROLE_PROGRAM_ADMIN', 'ROLE_REPORT_USER'),		('ROLE_REALM_ADMIN', 'ROLE_REPORT_USER'),	('ROLE_REPORT_USER', 'ROLE_REPORT_USER'),		
('ROLE_APPLICATION_ADMIN', 'ROLE_SUPPLY_PLAN_REVIEWER'),					('ROLE_INTERNAL_USER', 'ROLE_SUPPLY_PLAN_REVIEWER'),			('ROLE_REALM_ADMIN', 'ROLE_SUPPLY_PLAN_REVIEWER'),		('ROLE_SUPPLY_PLAN_REVIEWER', 'ROLE_SUPPLY_PLAN_REVIEWER'),	
('ROLE_APPLICATION_ADMIN', 'ROLE_VIEW_DATA_ENTRY'),					('ROLE_INTERNAL_USER', 'ROLE_VIEW_DATA_ENTRY'),	('ROLE_PROGRAM_ADMIN', 'ROLE_VIEW_DATA_ENTRY'),		('ROLE_REALM_ADMIN', 'ROLE_VIEW_DATA_ENTRY'),			('ROLE_VIEW_DATA_ENTRY', 'ROLE_VIEW_DATA_ENTRY');
