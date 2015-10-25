DROP TABLE state_care;
CREATE EXTERNAL TABLE IF NOT EXISTS state_care
(STATE varchar(4),
SCORE_CARE float,
SCORED_SD float
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/state/care';

INSERT OVERWRITE TABLE state_care
SELECT state, avg(score), stddev(score) 
FROM effective_table
WHERE score > 1 AND score <= 100
GROUP BY state
ORDER BY state;


DROP TABLE state_surveys;
CREATE EXTERNAL TABLE IF NOT EXISTS state_surveys
(STATE varchar(4),
SCORE_SURVEYS float
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/state/surveys';


INSERT OVERWRITE TABLE state_surveys
SELECT state, avg(hcahps_base_score) 
FROM survey_table
WHERE hcahps_base_score > 0 AND hcahps_base_score <= 100
GROUP BY state
ORDER BY state;




DROP TABLE state_results;
CREATE EXTERNAL TABLE IF NOT EXISTS state_results
(STATE varchar(4),
READMISSIONS_ID varchar(20),
SCORE_RESULTS float
)
PARTITIONED BY (ID STRING)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/state/results';



INSERT OVERWRITE TABLE state_results
PARTITION(ID="MORT_30_AMI")
SELECT state, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "MORT_30_AMI"
GROUP BY measure_id, state;


INSERT OVERWRITE TABLE state_results
PARTITION(ID="MORT_30_CABG")
SELECT state, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "MORT_30_CABG"
GROUP BY measure_id, state;

INSERT OVERWRITE TABLE state_results
PARTITION(ID="MORT_30_COPD")
SELECT state, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "MORT_30_COPD"
GROUP BY measure_id, state;

INSERT OVERWRITE TABLE state_results
PARTITION(ID="MORT_30_HF")
SELECT state, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "MORT_30_HF"
GROUP BY measure_id, state;

INSERT OVERWRITE TABLE state_results
PARTITION(ID="MORT_30_PN")
SELECT state, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "MORT_30_PN"
GROUP BY measure_id, state;

INSERT OVERWRITE TABLE state_results
PARTITION(ID="MORT_30_STK")
SELECT state, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "MORT_30_STK"
GROUP BY measure_id, state;

INSERT OVERWRITE TABLE state_results
PARTITION(ID="READM_30_AMI")
SELECT state, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "READM_30_AMI"
GROUP BY measure_id, state;


INSERT OVERWRITE TABLE state_results
PARTITION(ID="READM_30_CABG")
SELECT state, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "READM_30_CABG"
GROUP BY measure_id, state;


INSERT OVERWRITE TABLE state_results
PARTITION(ID="READM_30_COPD")
SELECT state, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "READM_30_COPD"
GROUP BY measure_id, state;


INSERT OVERWRITE TABLE state_results
PARTITION(ID="READM_30_HF")
SELECT state, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "READM_30_HF"
GROUP BY measure_id, state;


INSERT OVERWRITE TABLE state_results
PARTITION(ID="READM_30_HIP_KNEE")
SELECT state, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "READM_30_HIP_KNEE"
GROUP BY measure_id, state;


INSERT OVERWRITE TABLE state_results
PARTITION(ID="READM_30_HOSP_WIDE")
SELECT state, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "READM_30_HOSP_WIDE"
GROUP BY measure_id, state;


INSERT OVERWRITE TABLE state_results
PARTITION(ID="READM_30_PN")
SELECT state, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "READM_30_PN"
GROUP BY measure_id, state;


INSERT OVERWRITE TABLE state_results
PARTITION(ID="READM_30_STK")
SELECT state, measure_id, avg(score)
FROM readmissions_table
WHERE score > 0 AND score <= 100 AND
measure_id = "READM_30_STK"
GROUP BY measure_id, state;


