DROP TABLE care_variability;
CREATE EXTERNAL TABLE IF NOT EXISTS care_variability
(MEASURE_ID varchar(18),
MEASURE_NAME varchar(137),
SCORE float,
STANDARD_DEV float
)
STORED AS TEXTFILE
LOCATION '/user/w205/hive_tables/variability';

INSERT OVERWRITE TABLE care_variability
SELECT measure_id, measure_name, avg(score), stddev(score)
FROM effective_table
WHERE score > 1 AND score <= 100
GROUP BY measure_id, measure_name;
