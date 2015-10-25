DROP TABLE care_vs_surveys;
CREATE EXTERNAL TABLE IF NOT EXISTS care_vs_surveys
( STATE varchar(4),
RANK_CARE int,
RANK_SURVEYS int,
DIFF int
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/care_vs_surveys';

INSERT OVERWRITE TABLE care_vs_surveys
SELECT s.state, c.final_rank, s.final_rank,
c.final_rank - s.final_rank
FROM state_rank_by_care_final c 
JOIN  state_rank_by_surveys_final s ON (s.state = c.state);

SELECT * FROM care_vs_surveys ORDER BY diff ASC;
