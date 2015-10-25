DROP TABLE state_results_rank;
CREATE EXTERNAL TABLE IF NOT EXISTS state_results_rank
(READMISSIONS_ID varchar(20),
STATE varchar(4),
SCORE_RESULTS float,
RANK_PER_ID int
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/state/results_rank';

INSERT OVERWRITE TABLE state_results_rank
SELECT readmissions_id, state, score_results, 
rank() OVER (PARTITION BY readmissions_id 
ORDER BY score_results ASC) 
FROM state_results 
ORDER BY readmissions_id, score_results;



DROP TABLE state_rank_by_results;
CREATE EXTERNAL TABLE IF NOT EXISTS state_rank_by_results
(STATE varchar(4),
AVG_RANK float
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/state/rank_by_results';

INSERT OVERWRITE TABLE state_rank_by_results
SELECT state, avg(rank_per_id)
FROM state_results_rank
GROUP BY state;



DROP TABLE state_rank_by_results_final;
CREATE EXTERNAL TABLE IF NOT EXISTS state_rank_by_results_final
(FINAL_RANK int,
STATE varchar(4)
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/state/rank_by_results_final';

INSERT OVERWRITE TABLE state_rank_by_results_final
SELECT 
rank() OVER (ORDER BY avg_rank),
state
FROM state_rank_by_results;

SELECT * FROM state_rank_by_results_final ORDER BY final_rank;


DROP TABLE state_rank_by_surveys_final;
CREATE EXTERNAL TABLE IF NOT EXISTS state_rank_by_surveys_final
(FINAL_RANK int,
STATE varchar(4),
SCORE_SURVEYS float
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/state/rank_by_surveys_final';

INSERT OVERWRITE TABLE state_rank_by_surveys_final
SELECT 
rank() OVER (ORDER BY score_surveys DESC),
state, round(score_surveys,2)
FROM state_surveys;

SELECT * FROM state_rank_by_surveys_final ORDER BY final_rank;


DROP TABLE state_summary_rank;
CREATE EXTERNAL TABLE IF NOT EXISTS state_summary_rank
(STATE varchar(4),
RANK_CARE int,
RANK_RESULTS int,
RANK_SURVEY int,
RANK_SCORE int
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/state/summary_rank';

INSERT OVERWRITE TABLE state_summary_rank
SELECT 
r.state, 
c.final_rank, r.final_rank, s.final_rank,
c.final_rank + r.final_rank+ s.final_rank
FROM 
state_rank_by_results_final r,
state_rank_by_care_final c,
state_rank_by_surveys_final s
WHERE 
r.state = c.state AND
c.state = s.state;

SELECT * FROM state_summary_rank ORDER BY rank_care, rank_results;

DROP TABLE state_final_rank;
CREATE EXTERNAL TABLE IF NOT EXISTS state_final_rank
(FINAL_RANK int,
STATE varchar(4),
RANK_RESULTS int,
RANK_CARE int,
RANK_SURVEY int
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/state/final_rank';

INSERT OVERWRITE TABLE state_final_rank
SELECT 
rank() OVER (ORDER BY rank_score ASC),
state, rank_results, rank_care, rank_survey
FROM state_summary_rank;


SELECT * FROM state_final_rank ORDER BY final_rank;