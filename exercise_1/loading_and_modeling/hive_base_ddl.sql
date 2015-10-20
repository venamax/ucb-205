DROP TABLE hospital_table
CREATE EXTERNAL TABLE hospital_table
(PROVIDER_ID varchar(8),
HOSPITAL_NAME varchar(52),
ADDRESS varchar(52),
CITY varchar(22),
STATE varchar(4),
ZIP_CODE varchar(7),
COUNTY_NAME varchar(22),
PHONE_NUMBER varchar(12),
HOSPITAL_TYPE varchar(38),
HOSPITAL_OWNERSHIP varchar(45),
EMERGENCY_SERVICES varchar(5))
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
'separatorChar' = ',',
'quoteChar' = '"',
'escapeChar' = '\\'
)
STORED AS TEXTFILE
LOCATION '/hive_tables';

LOAD DATA LOCAL INPATH 'ucb-205/exercise_1/loading_and_modeling/hospital.csv'
OVERWRITE INTO TABLE hospital_table;


DROP TABLE effective_table
CREATE EXTERNAL TABLE effective_table
(PROVIDER_ID varchar(8),
HOSPITAL_NAME varchar(52),
ADDRESS varchar(52),
CITY varchar(22),
STATE varchar(4),
ZIP_CODE varchar(7),
COUNTY_NAME varchar(22),
PHONE_NUMBER varchar(12),
CONDITION varchar(37),
MEASURE_ID varchar(18),
MEASURE_NAME varchar(137),
SCORE varchar(44),
SAMPLE varchar(15),
FOOTNOTE varchar(181),
MEASURE_START_DATE varchar(12),
MEASURE_END_DATE varchar(12))
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
'separatorChar' = ',',
'quoteChar' = '"',
'escapeChar' = '\\'
)
STORED AS TEXTFILE
LOCATION '/hive_tables';

LOAD DATA LOCAL INPATH 'ucb-205/exercise_1/loading_and_modeling/effective_care.csv'
OVERWRITE INTO TABLE effective_table;

DROP TABLE readmissions_table
CREATE EXTERNAL TABLE readmissions_table
(PROVIDER_ID varchar(8),
HOSPITAL_NAME varchar(52),
ADDRESS varchar(45),
CITY varchar(21),
STATE varchar(4),
ZIP_CODE varchar(7),
COUNTY_NAME varchar(22),
PHONE_NUMBER varchar(12),
MEASURE_NAME varchar(89),
MEASURE_ID varchar(20),
COMPARED_TO_NATIONAL varchar(37),
DENOMINATOR varchar(15),
SCORE varchar(15),
LOWER_ESTIMATE varchar(15),
HIGHER_ESTIMATE varchar(15),
FOOTNOTE varchar(58),
MEASURE_START_DATE varchar(12),
MEASURE_END_DATE varchar(12))
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
'separatorChar' = ',',
'quoteChar' = '"',
'escapeChar' = '\\'
)
STORED AS TEXTFILE
LOCATION '/hive_tables';

LOAD DATA LOCAL INPATH 'ucb-205/exercise_1/loading_and_modeling/readmissions.csv'
OVERWRITE INTO TABLE readmissions_table;

DROP TABLE survey_table
CREATE EXTERNAL TABLE survey_table
(PROVIDER_ID varchar(8),
HOSPITAL_NAME varchar(52),
ADDRESS varchar(46),
CITY varchar(22),
STATE varchar(4),
ZIP_CODE varchar(12),
COUNTY_NAME varchar(22),
COMM_NURSES_ACHIEVEMENT_PTS varchar(15),
COMM_NURSES_IMPROVEMENT_PTS varchar(15),
COMM_NURSES_DIMENSION_SCORE varchar(15),
COMM_DOCTORS_ACHIEVEMENT_PTS varchar(15),
COMM_DOCTORS_IMPROVEMENT_PTS varchar(15),
COMM_DOCTORS_DIMENSION_SCORE varchar(15),
RESP_STAFF_ACHIEVEMENT_PTS varchar(15),
RESP_STAFF_IMPROVEMENT_PTS varchar(15),
RESP_STAFF_DIMENSION_SCORE varchar(15),
PAIN_MGMT_ACHIEVEMENT_PTS varchar(15),
PAIN_MGMT_IMPROVEMENT_PTS varchar(15),
PAIN_MGMT_DIMENSION_SCORE varchar(15),
COMM_MEDICINES_ACHIEVEMENT_PTS varchar(15),
COMM_MEDICINES_IMPROVEMENT_PTS varchar(15),
COMM_MEDICINES_DIMENSION_SCORE varchar(15),
CLEAN_QUIET_ACHIEVEMENT_PTS varchar(15),
CLEAN_QUIET_IMPROVEMENT_PTS varchar(15),
CLEAN_QUIET_DIMENSION_SCORE varchar(15),
DISCHARGE_INFO_ACHIEVEMENT_PTS varchar(15),
DISCHARGE_INFO_IMPROVEMENT_PTS varchar(15),
DISCHARGE_INFO_DIMENSION_SCORE varchar(15),
OVERALL_RATING_ACHIEVEMENT_PTS varchar(15),
OVERALL_RATING_IMPROVEMENT_PTS varchar(15),
OVERALL_RATING_DIMENSION_SCORE varchar(15),
HCAHPS_BASE_SCORE varchar(15),
HCAHPS_CONSISTENCY_SCORE varchar(15))
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
'separatorChar' = ',',
'quoteChar' = '"',
'escapeChar' = '\\'
)
STORED AS TEXTFILE
LOCATION '/hive_tables';

LOAD DATA LOCAL INPATH 'ucb-205/exercise_1/loading_and_modeling/surveys_responses.csv'
OVERWRITE INTO TABLE survey_table;

