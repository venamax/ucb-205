DROP TABLE hospital_care;
CREATE EXTERNAL TABLE IF NOT EXISTS hospital_care
(HOSPITAL_NAME varchar(52),
SCORE_CARE float,
SCORED_SD float
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/hospital/care';

INSERT OVERWRITE TABLE hospital_care
SELECT hospital_name, avg(score), stddev(score)
FROM effective_table
WHERE score > 1 AND score <= 100
GROUP BY hospital_name
ORDER BY hospital_name;


DROP TABLE hospital_surveys;
CREATE EXTERNAL TABLE IF NOT EXISTS hospital_surveys
(HOSPITAL_NAME varchar(52),
SCORE_SURVEYS float
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/hospital/surveys';


INSERT OVERWRITE TABLE hospital_surveys
SELECT hospital_name, avg(hcahps_base_score) 
FROM survey_table
WHERE hcahps_base_score > 0 AND hcahps_base_score <= 100
GROUP BY hospital_name
ORDER BY hospital_name;




DROP TABLE hospital_results;
CREATE EXTERNAL TABLE IF NOT EXISTS hospital_results
(HOSPITAL_NAME varchar(52),
READMISSIONS_ID varchar(20),
SCORE_RESULTS float
)
PARTITIONED BY (ID STRING)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/hospital/results';




INSERT OVERWRITE TABLE hospital_results
PARTITION(ID="MORT_30_AMI")
SELECT hospital_name, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "MORT_30_AMI"
GROUP BY measure_id, hospital_name;


INSERT OVERWRITE TABLE hospital_results
PARTITION(ID="MORT_30_CABG")
SELECT hospital_name, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "MORT_30_CABG"
GROUP BY measure_id, hospital_name;

INSERT OVERWRITE TABLE hospital_results
PARTITION(ID="MORT_30_COPD")
SELECT hospital_name, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "MORT_30_COPD"
GROUP BY measure_id, hospital_name;

INSERT OVERWRITE TABLE hospital_results
PARTITION(ID="MORT_30_HF")
SELECT hospital_name, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "MORT_30_HF"
GROUP BY measure_id, hospital_name;

INSERT OVERWRITE TABLE hospital_results
PARTITION(ID="MORT_30_PN")
SELECT hospital_name, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "MORT_30_PN"
GROUP BY measure_id, hospital_name;

INSERT OVERWRITE TABLE hospital_results
PARTITION(ID="MORT_30_STK")
SELECT hospital_name, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "MORT_30_STK"
GROUP BY measure_id, hospital_name;

INSERT OVERWRITE TABLE hospital_results
PARTITION(ID="READM_30_AMI")
SELECT hospital_name, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "READM_30_AMI"
GROUP BY measure_id, hospital_name;


INSERT OVERWRITE TABLE hospital_results
PARTITION(ID="READM_30_CABG")
SELECT hospital_name, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "READM_30_CABG"
GROUP BY measure_id, hospital_name;


INSERT OVERWRITE TABLE hospital_results
PARTITION(ID="READM_30_COPD")
SELECT hospital_name, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "READM_30_COPD"
GROUP BY measure_id, hospital_name;


INSERT OVERWRITE TABLE hospital_results
PARTITION(ID="READM_30_HF")
SELECT hospital_name, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "READM_30_HF"
GROUP BY measure_id, hospital_name;


INSERT OVERWRITE TABLE hospital_results
PARTITION(ID="READM_30_HIP_KNEE")
SELECT hospital_name, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "READM_30_HIP_KNEE"
GROUP BY measure_id, hospital_name;


INSERT OVERWRITE TABLE hospital_results
PARTITION(ID="READM_30_HOSP_WIDE")
SELECT hospital_name, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "READM_30_HOSP_WIDE"
GROUP BY measure_id, hospital_name;


INSERT OVERWRITE TABLE hospital_results
PARTITION(ID="READM_30_PN")
SELECT hospital_name, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "READM_30_PN"
GROUP BY measure_id, hospital_name;


INSERT OVERWRITE TABLE hospital_results
PARTITION(ID="READM_30_STK")
SELECT hospital_name, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "READM_30_STK"
GROUP BY measure_id, hospital_name;


