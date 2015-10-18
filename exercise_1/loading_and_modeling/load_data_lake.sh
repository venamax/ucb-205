#### This script loads data from Hospital Compare datasets
#### You can find it here:
#### https://data.medicare.gov/views/bg9k-emty/files/Ma46xU4I05xsIKuEqLLi-N-s7GoO2ZefzJ7SYyTIKjA?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip





cd raw_data

wget https://data.medicare.gov/views/bg9k-emty/files/Ma46xU4I05xsIKuEqLLi-N-s7GoO2ZefzJ7SYyTIKjA?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip 

unzip "Ma46xU4I05xsIKuEqLLi-N-s7GoO2ZefzJ7SYyTIKjA?content_type=application%2Fzip; charset=binary"

cd ..

tail -n +2 /root/raw_data/"Hospital General Information.csv" > /root/user/ale/hospital_compare/hospital.csv

tail -n +2 /root/raw_data/"Timely and Effective Care - Hospital.csv" > /root/user/ale/hospital_compare/effective_care.csv

tail -n +2 /root/raw_data/"Readmissions and Deaths - Hospital.csv" > /root/user/ale/hospital_compare/readmissions.csv

tail -n +2 /root/raw_data/hvbp_tps_08_06_2015.csv > /root/user/ale/hospital_compare/surveys_responses.csv

hadoop fs -mkdir hdfs
hadoop fs -mkdir hdfs/user
hadoop fs -mkdir hdfs/user/ale
hadoop fs -mkdir hdfs/user/ale/hospital_compare

hadoop fs -put /root/user/ale/hospital_compare/hospital.csv hdfs/user/ale/hospital_compare

hadoop fs -put /root/user/ale/hospital_compare/effective_care.csv hdfs/user/ale/hospital_compare

hadoop fs -put /root/user/ale/hospital_compare/readmissions.csv hdfs/user/ale/hospital_compare

hadoop fs -put /root/user/ale/hospital_compare/surveys_responses.csv hdfs/user/ale/hospital_compare
