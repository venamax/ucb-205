
from pyspark import SparkContext
from pyspark.streaming import StreamingContext
import json


ssc = StreamingContext(sc, 10)
lines= ssc.textFileStream("hdfs:///tmp/datastreams/")
slines = lines.flatMap(lambda x: [ j['venue'] for j in json.loads('['+x+']') if 'venue' in j] )
cnt=slines.count()
slines.saveAsTextFiles("hdfs:///tmp/output/venue")
cnt.pprint()
slines.pprint()

ssc.start()