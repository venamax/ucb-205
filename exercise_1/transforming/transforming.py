hospital = sc.textFile("file:////home/w205/ucb-205/exercise_1/loading_and_modeling/hospital.csv")
print hospital.count()

effective = sc.textFile("file:////home/w205/ucb-205/exercise_1/loading_and_modeling/effective_care.csv")
print effective.count()

readmissions = sc.textFile("file:////home/w205/ucb-205/exercise_1/loading_and_modeling/readmissions.csv")
print readmissions.count()

surveys = sc.textFile("file:////home/w205/ucb-205/exercise_1/loading_and_modeling/surveys_responses.csv")
print surveys.count()

