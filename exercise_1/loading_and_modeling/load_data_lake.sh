#### This script loads data from Hospital Compare datasets
#### You can find it here:
#### https://data.medicare.gov/views/bg9k-emty/files/Ma46xU4I05xsIKuEqLLi-N-s7GoO2ZefzJ7SYyTIKjA?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip






wget https://data.medicare.gov/views/bg9k-emty/files/Ma46xU4I05xsIKuEqLLi-N-s7GoO2ZefzJ7SYyTIKjA?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip 

unzip "Ma46xU4I05xsIKuEqLLi-N-s7GoO2ZefzJ7SYyTIKjA?content_type=application%2Fzip; charset=binary"



tail -n +2 "Hospital General Information.csv" > hospital.csv

tail -n +2 "Timely and Effective Care - Hospital.csv" > effective_care.csv

tail -n +2 "Readmissions and Deaths - Hospital.csv" > readmissions.csv

tail -n +2 hvbp_tps_08_06_2015.csv > surveys_responses.csv

cd /data/

hadoop fs -mkdir hospital_compare

hadoop fs -put /home/w205/ucb-205/exercise_1/loading_and_modeling/hospital.csv hospital_compare

hadoop fs -put /home/w205/ucb-205/exercise_1/loading_and_modeling/effective_care.csv hospital_compare

hadoop fs -put /home/w205/ucb-205/exercise_1/loading_and_modeling/readmissions.csv hospital_compare

hadoop fs -put /home/w205/ucb-205/exercise_1/loading_and_modeling/surveys_responses.csv hospital_compare

hadoop fs -ls hospital_compare
