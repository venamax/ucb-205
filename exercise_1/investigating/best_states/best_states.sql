DROP TABLE state_rank_by_care_final;
CREATE EXTERNAL TABLE IF NOT EXISTS state_rank_by_care_final
(FINAL_RANK int,
STATE varchar(4),
SCORE_CARE float,
SCORE_SD float
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/state/rank_by_care_final';

INSERT OVERWRITE TABLE state_rank_by_care_final
SELECT 
rank() OVER (ORDER BY score_care DESC, scored_sd ASC),
state, round(score_care,2), round(scored_sd,2) 
FROM state_care;

SELECT * FROM state_rank_by_care_final ORDER BY final_rank;


