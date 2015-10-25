DROP TABLE hospital_results_rank;
CREATE EXTERNAL TABLE IF NOT EXISTS hospital_results_rank
(READMISSIONS_ID varchar(20),
HOSPITAL_NAME varchar(52),
SCORE_RESULTS float,
RANK_PER_ID int
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/hospital/results_rank';

INSERT OVERWRITE TABLE hospital_results_rank
SELECT readmissions_id, hospital_name, score_results, 
rank() OVER (PARTITION BY readmissions_id 
ORDER BY score_results ASC) 
FROM hospital_results 
ORDER BY readmissions_id, score_results;