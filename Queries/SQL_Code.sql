-- Query 1: Patient Admissions with Department Info
-- Purpose: List patients with their department names and admission dates.

	SELECT p.Patient_id, p.Name, p.Admission_date, d.Department_name
	FROM patients AS p
	INNER JOIN departments AS d
	ON p.Department_id = d.Department_id
	ORDER BY Patient_id;

-- Query 2: Drug Usage Summary
-- Purpose: Count how many times each drug was prescribed across all patients.

	SELECT d.Drug_name,
	COUNT(*) AS Total_prescriptions
	FROM drugs_prescribed AS d
	INNER JOIN patients AS p
	ON d.Patient_id = p.Patient_id
	GROUP BY Drug_name
	ORDER BY Total_prescriptions;

-- Query 3: Average Hospital Stay per Department 
-- Purpose: Calculate average length of stay for each department.

	SELECT d.Department_name,
	CONCAT_WS (" ", ROUND (AVG (datediff(p.Discharge_date, p.Admission_date))), "days") 
	AS Average_length_of_stay
	FROM patients AS p
	INNER JOIN departments AS d
	ON p.Department_id = d.Department_id
	GROUP BY Department_name
	ORDER BY Average_length_of_stay;

-- Query 4: Rank Patients by Length of Stay
-- Purpose: Rank patients within each department based on hospital stay duration.

	SELECT p.Patient_id, p.Name, d.Department_name,
    datediff (p.Discharge_date, p.Admission_date) AS Length_of_stay,
    DENSE_RANK () OVER (PARTITION BY d.Department_name ORDER BY datediff(p.Discharge_date, p.Admission_date)) AS Ranking
    FROM patients AS p
    JOIN departments as d
    ON p.Department_id = d.Department_id;
    
-- Query 5: Severe Adverse Events per Drug
-- Purpose: Count number of severe adverse events per prescribed drug.

	SELECT d.Drug_name, 
    COUNT(a.event_id) AS Total_number_of_serious_adverse_events
    FROM adverse_events AS a
    INNER JOIN drugs_prescribed AS d
    ON a.patient_id = d.patient_id
    WHERE a.Severity = "Severe"
    GROUP BY d.Drug_name
	ORDER BY Total_number_of_serious_adverse_events;
       
-- Query 6: Patient Age Group Classification
-- Purpose: Categorize patients as ‘Child’, ‘Adult’, or ‘Senior’ based on age.

	SELECT Patient_id, Name, Age,
    CASE
		WHEN Age<18 THEN "Child"
        When Age>=18 and Age<65 THEN "Adult"
        ELSE "Senior"
	END AS "Category"
    FROM patients
    ORDER BY Category, Age;

-- Query 7: Rank Lab Test Results
-- Purpose: Rank each patient's lab test results from highest to lowest.
	
    SELECT Patient_id, Test_name, Result_value,
    DENSE_RANK() OVER (PARTITION BY Patient_id, Test_name ORDER BY Result_value DESC) AS Result_rank
    FROM lab_tests;
    
-- Query 8: Patients with Above-Average Stay
-- Purpose: Find patients whose hospital stay was longer than the overall average.

	SELECT Patient_id, Name, datediff(Discharge_date, Admission_date) AS "Hospital_stay_duration"
    FROM patients
    WHERE datediff(Discharge_date, Admission_date)> 
    (SELECT AVG(datediff(Discharge_date, Admission_date))
    FROM patients
    )
    ORDER BY Hospital_stay_duration;
	
-- Query 9: Adverse Events in Last 30 Days
-- Purpose: List all patients who had adverse events in the last 30 days.

	SELECT DISTINCT p.Patient_id, p.Name, a.Event_date
    FROM adverse_events AS a
    INNER JOIN patients AS p
    ON a.Patient_id = p.Patient_id
	WHERE a.Event_date>= CURDATE() - INTERVAL 30 DAY
    ORDER BY Event_date;

-- Query 10: Most Common Comorbidities
-- Purpose: Identify the most frequent comorbid condition(s) among patients.

	SELECT Comorbidities, COUNT(*) AS Total_occurence FROM patients
	GROUP BY comorbidities
	ORDER BY Total_occurence DESC;