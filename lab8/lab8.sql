DROP TABLE Web_Session_Log;
CREATE TABLE Web_Session_Log
(DATETIME varchar(500), 
USERID varchar(500),
SESSIONUD varchar(500),
PRODUCTID varchar(500),
REFERERURL varchar(500)
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t"
STORED AS textfile
tblproperties("skip.header.line.count"="1");

LOAD DATA LOCAL INPATH '/home/w205/ucb-205/lab8/weblog_lab.csv'
INTO TABLE Web_Session_Log;

SELECT REFERERURL, count(*)
FROM Web_Session_Log
GROUP BY REFERERURL;

