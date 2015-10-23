CREATE TABLE IF NOT EXISTS state_table
STORED AS TEXTFILE
AS
SELECT state, count(*) FROM hospital_table GROUP BY state ORDER BY state;


CREATE EXTERNAL TABLE health_sys
(STATE(4),
)



INSERT OVERWRITE LOCAL DIRECTORY '/Users/Lissette/Documents/datascience/datasets'
SELECT state_table.*
FROM state_table;
