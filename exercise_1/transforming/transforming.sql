DROP TABLE state_table;
CREATE EXTERNAL TABLE state_table
(STATE varchar(4),
COUNTY_NAME varchar(22),
CITY varchar(22),
ZIP_CODE varchar(7),
PROVIDER_ID varchar(8),
HOSPITAL_NAME varchar (52)
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/state';


INSERT OVERWRITE TABLE state_table
SELECT state, county_name, city, zip_code, provider_id, hospital_name  FROM hospital_table;


DROP TABLE health_sys;
CREATE EXTERNAL TABLE health_sys
(STATE varchar(4),
COUNTY_NAME varchar(22),
CITY varchar(22),
ZIP_CODE varchar(7),
PROVIDER_ID varchar(8),
HOSPITAL_NAME varchar (52),
MEASURE_ID varchar(18),
MEASURE_NAME varchar (137),
SCORE varchar(44)
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/health';


INSERT OVERWRITE TABLE health_sys
SELECT s.state, s.county_name, s.city, s.zip_code, s.provider_id, s.hospital_name, e.measure_id, e.Measure_name, e.score  
FROM state_table s 
JOIN effective_table e ON (s.provider_id = e.provider_id);



SELECT state, sum(score), count(*), sum(score)/count(*) FROM health_sys GROUP BY state ORDER BY state;


DROP TABLE conditions;
CREATE EXTERNAL TABLE conditions
(CONDITION varchar(37),
MEASURE_ID varchar(18),
MEASURE_NAME varchar (137),
SCORE varchar(44),
PROVIDER_ID varchar(8)
)
STORED AS TEXTFILE
LOCATION '/hive_tables';

INSERT OVERWRITE TABLE conditions
SELECT condition, measure_id, measure_name, score, provider_id  
FROM effective_table;


DROP TABLE treatments;
CREATE EXTERNAL TABLE IF NOT EXISTS treatments
(MEASURE_ID varchar(18),
MEASURE_NAME varchar (137),
SCORE varchar(44),
PROVIDER_ID varchar(8)
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/treatments';



INSERT OVERWRITE TABLE treatments
SELECT measure_id, measure_name, score, provider_id  FROM effective_table;





DROP TABLE results;
CREATE EXTERNAL TABLE IF NOT EXISTS results
(RESULTS_ID varchar(20),
RESULTS_NAME varchar(89),
COMPARED_TO_NATIONAL varchar(37),
SCORE varchar(15),
PROVIDER_ID varchar(8)
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/results';


INSERT OVERWRITE TABLE results
SELECT measure_id, measure_name, compared_to_national, score, provider_id  FROM readmissions_table;


DROP TABLE response;
CREATE EXTERNAL TABLE IF NOT EXISTS response
(PROVIDER_ID varchar(8),
COMM_NURSES_ACHIEVEMENT_PTS varchar(15),
COMM_NURSES_IMPROVEMENT_PTS varchar(15),
COMM_NURSES_DIMENSION_SCORE varchar(15),
COMM_DOCTORS_ACHIEVEMENT_PTS varchar(15),
COMM_DOCTORS_IMPROVEMENT_PTS varchar(15),
COMM_DOCTORS_DIMENSION_SCORE varchar(15)
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/response';



INSERT OVERWRITE TABLE response
SELECT provider_id, 
comm_nurses_achievement_pts, comm_nurses_improvement_pts, comm_nurses_dimension_score,comm_doctors_achievement_pts, comm_doctors_improvement_pts, comm_doctors_dimension_score 
FROM survey_table;
