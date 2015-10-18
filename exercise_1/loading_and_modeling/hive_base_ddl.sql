CREATE EXTERNAL TABLE IF NOT EXISTS Hospital
(PROVIDED_ID varchar(8),
HOSPITAL_NAME varchar(52),
ADDRESS varchar(52),
CITY varchar(22),
STATE varchar(4),
ZIP_CODE varchar(7),
COUNTY_NAME varchar(22),
PHONE_NUMEBER varchar(12),
HOSPITAL_TYPE varchar(38),
HOSPITAL_OWNERSHIP varchar(45),
EMERGENCY_SERVICES varchar(5))
row format delimited
fields terminated by 't'
stored as textfile
LOCATION 'ucb-205/exercise_1/loading_and_modeling/hive_base_ddl.sql';