DROP TABLE hospital_rank_by_care_final;
CREATE EXTERNAL TABLE IF NOT EXISTS hospital_rank_by_care_final
(FINAL_RANK int,
HOSPITAL_NAME varchar(52),
SCORE_CARE float,
SCORE_SD float
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/hospital/rank_by_care_final';

INSERT OVERWRITE TABLE hospital_rank_by_care_final
SELECT 
rank() OVER (ORDER BY score_care DESC, scored_sd ASC),
hospital_name, round(score_care,2), round(scored_sd,2) 
FROM hospital_care;

SELECT * FROM hospital_rank_by_care_final ORDER BY final_rank LIMIT 50;


