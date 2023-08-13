###########################################CORONA_PREDICTION_FINAL_PROJECT#########################################################################
use project;

select * from cleaned_covid_data;

##################################################################################################################################################
# 1. Find the number of corona patients who faced shortness of breath.

SELECT COUNT(*) 
FROM cleaned_covid_data 
WHERE Corona = 'positive' AND Shortness_of_breath = 'True';
#################################################################################################################################################
# 2. Find the number of negative corona patients who have fever and sore_throat.

SELECT COUNT(*) 
FROM cleaned_covid_data 
WHERE Corona = 'negative' AND Fever = 'True' AND Sore_throat = 'True';
######################################################################################################################################################
# 3. Group the data by month and rank the number of positive cases.

SELECT Month(Test_date) as Month, COUNT(*) as Positive_cases,
RANK() OVER (ORDER BY COUNT(*) DESC) as Ranking
FROM cleaned_covid_data  
WHERE Corona = 'positive' 
GROUP BY Month(Test_date) 
ORDER BY Positive_cases DESC;
#######################################################################################################################################################
# 4. Find the female negative corona patients who faced cough and headache.

SELECT COUNT(*) 
FROM cleaned_covid_data 
WHERE Corona = 'negative' AND Sex = 'female' AND Cough_symptoms = 'True' AND Headache = 'True';
#####################################################################################################################################################
# 5. How many elderly corona patients have faced breathing problems?

SELECT COUNT(*) 
FROM cleaned_covid_data 
WHERE Corona = 'positive' AND Age_60_above = 'Yes' AND Shortness_of_breath = 'True';
####################################################################################################################################################
# 6. Which three symptoms were more common among COVID positive patients?

SELECT symptom, COUNT(*) AS count 
FROM (
    SELECT 'cough_symptoms' AS symptom FROM cleaned_covid_data WHERE Corona='positive' AND cough_symptoms='TRUE' 
    UNION ALL
    SELECT 'Fever' AS symptom FROM cleaned_covid_data WHERE Corona='positive' AND Fever='TRUE'
    UNION ALL
    SELECT 'Sore_throat' AS symptom FROM cleaned_covid_data WHERE Corona='positive' AND Sore_throat='TRUE' 
    UNION ALL
    SELECT 'Shortness_of_breath' AS symptom FROM cleaned_covid_data WHERE Corona='positive' AND Shortness_of_breath='TRUE' 
    UNION ALL
    SELECT 'Headache' AS symptom FROM cleaned_covid_data WHERE Corona='positive' AND Headache='TRUE' 
) AS symptoms 
GROUP BY symptom 
ORDER BY count DESC 
LIMIT 3;
############################################################################################################################################################
# 7. Which symptom was less common among COVID negative people?

SELECT symptom, COUNT(*) AS count 
FROM (
    SELECT 'cough_symptoms' AS symptom FROM cleaned_covid_data WHERE Corona='negative' AND cough_symptoms='TRUE' 
    UNION ALL
    SELECT 'Fever' AS symptom FROM cleaned_covid_data WHERE Corona='negative' AND Fever='TRUE'
    UNION ALL
    SELECT 'Sore_throat' AS symptom FROM cleaned_covid_data WHERE Corona='negative' AND Sore_throat='TRUE' 
    UNION ALL
    SELECT 'Shortness_of_breath' AS symptom FROM cleaned_covid_data WHERE Corona='negative' AND Shortness_of_breath='TRUE' 
    UNION ALL
    SELECT 'Headache' AS symptom FROM cleaned_covid_data WHERE Corona='negative' AND Headache='TRUE' 
) AS symptoms 
GROUP BY symptom 
ORDER BY count ASC 
LIMIT 1;
#####################################################################################################################################################
# 8. What are the most common symptoms among COVID positive males whose known contact was abroad?

SELECT symptom, COUNT(*) AS count 
FROM (
    SELECT 'cough_symptoms' AS symptom FROM cleaned_covid_data WHERE Corona='positive' AND Sex= 'male' AND Known_contact= 'Abroad' AND cough_symptoms='TRUE' 
    UNION ALL
    SELECT 'Fever' AS symptom FROM cleaned_covid_data WHERE Corona='positive' AND Sex= 'male' AND Known_contact= 'Abroad' AND Fever='TRUE'
    UNION ALL
    SELECT 'Sore_throat' AS symptom FROM cleaned_covid_data WHERE Corona='positive' AND Sex= 'male' AND Known_contact= 'Abroad' AND Sore_throat='TRUE' 
    UNION ALL
    SELECT 'Shortness_of_breath' AS symptom FROM cleaned_covid_data WHERE Corona='positive' AND Sex= 'male' AND Known_contact= 'Abroad' AND Shortness_of_breath='TRUE' 
    UNION ALL
    SELECT 'Headache' AS symptom FROM cleaned_covid_data WHERE Corona='positive' AND Sex= 'male' AND Known_contact= 'Abroad' AND Headache='TRUE' 
) AS symptoms 
GROUP BY symptom 
ORDER BY count DESC 
;
#######################################################################################################################################################









