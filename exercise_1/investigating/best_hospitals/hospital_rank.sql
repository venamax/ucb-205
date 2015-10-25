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


DROP TABLE hospital_rank_by_results;
CREATE EXTERNAL TABLE IF NOT EXISTS hospital_rank_by_results
(HOSPITAL_NAME varchar(52),
AVG_RANK float
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/hospital/rank_by_results';

INSERT OVERWRITE TABLE hospital_rank_by_results
SELECT hospital_name, avg(rank_per_id)
FROM hospital_results_rank
GROUP BY hospital_name;

DROP TABLE hospital_rank_by_results_final;
CREATE EXTERNAL TABLE IF NOT EXISTS hospital_rank_by_results_final
(FINAL_RANK int,
HOSPITAL_NAME varchar(52)
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/hospital/rank_by_results_final';

INSERT OVERWRITE TABLE hospital_rank_by_results_final
SELECT 
rank() OVER (ORDER BY avg_rank),
hospital_name
FROM hospital_rank_by_results;



DROP TABLE hospital_rank_by_surveys_final;
CREATE EXTERNAL TABLE IF NOT EXISTS hospital_rank_by_surveys_final
(FINAL_RANK int,
HOSPITAL_NAME varchar(52),
SCORE_SURVEYS float
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/hospital/rank_by_surveys_final';

INSERT OVERWRITE TABLE hospital_rank_by_surveys_final
SELECT 
rank() OVER (ORDER BY score_surveys DESC),
hospital_name, round(score_surveys,2)
FROM hospital_surveys;


DROP TABLE hospital_summary_rank;
CREATE EXTERNAL TABLE IF NOT EXISTS hospital_summary_rank
(HOSPITAL_NAME varchar(52),
RANK_CARE int,
RANK_RESULTS int,
RANK_SURVEY int,
RANK_SCORE int
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/hospital/summary_rank';

INSERT OVERWRITE TABLE hospital_summary_rank
SELECT 
r.hospital_name, 
c.final_rank, r.final_rank, s.final_rank,
r.final_rank + c.final_rank + s.final_rank
FROM 
hospital_rank_by_results_final r,
hospital_rank_by_care_final c,
hospital_rank_by_surveys_final s
WHERE 
r.hospital_name = c.hospital_name AND
c.hospital_name = s.hospital_name;



DROP TABLE hospital_final_rank;
CREATE EXTERNAL TABLE IF NOT EXISTS hospital_final_rank
(FINAL_RANK int,
HOSPITAL_NAME varchar(52),
RANK_RESULTS int,
RANK_CARE int,
RANK_SURVEY int
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/hospital/final_rank';

INSERT OVERWRITE TABLE hospital_final_rank
SELECT 
rank() OVER (ORDER BY rank_score ASC),
hospital_name, rank_results, rank_care, rank_survey
FROM hospital_summary_rank;


SELECT * FROM hospital_final_rank ORDER BY final_rank LIMIT 50;
