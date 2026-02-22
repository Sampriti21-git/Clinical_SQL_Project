Analysis of Adverse Drug Events in Hospitalized Patients

Overview:
This project provides a SQL-focused framework for analyzing drug safety and adverse events within a hospital setting. By leveraging a relational database schema, the project aims to track and quantify adverse events linked to drug prescriptions. The core of this analysis lies in a set of SQL scripts designed to uncover patterns and insights related to patient demographics, prescribed drugs, and departmental activities.

Project Purpose:
The primary goal is to provide a robust, data-driven approach to pharmacovigilance. By analyzing the frequency and nature of adverse events, healthcare institutions can:
1. Identify high-risk medications and patient groups.
2. Improve prescription protocols and patient safety measures.
3. Allocate resources more effectively to mitigate risks.
4. Understand trends in adverse events across different hospital departments.

Database Schema:
The project is built around a relational database model consisting of six main tables.

1. Patients
Stores demographic and medical history for each patient.
CREATE TABLE patients (
	Patient_id INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    Gender VARCHAR(8),
    Admission_date DATE,
    Discharge_date DATE,
    Comorbidities TEXT,
    Department_id INT,
    FOREIGN KEY (Department_id) REFERENCES departments (Department_id)
    );

2. Drugs_Prescribed
Tracks all drug prescriptions administered to patients.
CREATE TABLE drugs_prescribed (
	Prescription_id VARCHAR(20) PRIMARY KEY,
    Patient_id INT, 
    FOREIGN KEY (Patient_id) REFERENCES patients (Patient_id),
    Drug_name VARCHAR(100) NOT NULL,
    Dosage VARCHAR(100) NOT NULL,
    Frequency VARCHAR(50) NOT NULL,
    Start_date DATE NOT NULL,
    End_date DATE NOT NULL
    );

3. Adverse_Events
A log of all adverse events, linked to the patient who experienced them.
CREATE TABLE adverse_events (
	Event_id INT PRIMARY KEY,
    Patient_id INT, 
    FOREIGN KEY (Patient_id) REFERENCES patients (Patient_id),
    Event_name VARCHAR(100) NOT NULL,
    Event_date DATE NOT NULL,
    Severity VARCHAR(50)
    );

4. Departments
Represents the different departments within the hospital. 
CREATE TABLE departments (
	Department_id INT PRIMARY KEY,
	Department_name VARCHAR(50)
	);

5. Lab_Tests
Stores diagnostic test results associated with patients.
CREATE TABLE lab_tests (
	Test_id VARCHAR(10) PRIMARY KEY,
    Patient_id INT, 
    FOREIGN KEY (Patient_id) REFERENCES patients (Patient_id),
    Test_name VARCHAR(100),
    Test_date DATE,
    Result_value Decimal (5,2),
    Normal_range VARCHAR(50)
    );

6. Discharge_Summary
Captures summary information at the time of patient discharge.
CREATE TABLE discharge_summary (
	Summary_id VARCHAR(20) PRIMARY KEY,
    Patient_id INT, 
    FOREIGN KEY (Patient_id) REFERENCES patients (Patient_id),
    Discharge_date DATE,
    Condition_at_discharge VARCHAR(100),
    Follow_up_required BOOLEAN,
    Follow_up_date DATE
    );

Key SQL Analyses & Tasks:
This project focuses on answering critical questions about drug safety through targeted SQL queries. The main analytical tasks include:
1. Patient Admissions with Department Info: Listing patients along with their department names and admission dates.
2. Drug Usage Summary: Counting how many times each drug was prescribed across all patients.
3. Average Hospital Stay per Department: Calculating the average length of stay (in days) for each hospital department.
4. Rank Patients by Length of Stay: Ranking patients within each department based on their hospital stay duration.
5. Severe Adverse Events per Drug: Counting the number of severe adverse events reported for each prescribed drug.
6. Patient Age Group Classification: Categorizing patients into Child, Adult, or Senior groups based on age.
7. Rank Lab Test Results: Ranking each patient’s lab test results from highest to lowest per test type.
8. Patients with Above-Average Stay: Identifying patients whose hospital stay exceeded the overall average stay duration.
9. Adverse Events in Last 30 Days: Listing patients who experienced adverse events within the last 30 days.
10. Most Common Comorbidities: Identifying the most frequently occurring comorbid conditions among patients.

Repository Structure:
The project files are organized as follows:
├── sql_scripts/
│   ├── 01_create_tables.sql
│   ├── 02_insert_sample_data.sql
│   ├── 03_analysis_queries.sql
│   └── ...
├── results/
│   ├── events_per_drug.xlsx
│   ├── severity_by_age.xlsx
│   └── ...
└── README.md

 * sql_scripts/: Contains all the SQL scripts. This includes scripts for table creation, sample data insertion, and the main analysis queries.
 * results/: This directory is intended to store the exported results from the SQL queries in .xlsx format for further analysis or reporting.

How to Use:
To get started with this project, follow these steps:
  Prerequisites:
   - A running SQL database instance (e.g., PostgreSQL, MySQL, SQLite).
   - A SQL client or command-line tool to interact with your database.

Setup Instructions:
 - Get the Project Files
   Clone or download the repository to your local machine.
 - Create the Database and Tables
   Connect to your database instance using your preferred SQL client. Open and execute the 01_create_tables.sql script to set up the required table structure.
 - Populate with Data (Optional)
   To run the analyses, you'll need data. You can use the provided 02_insert_sample_data.sql script to populate the tables with sample records. Execute this script in your SQL client.
 - Run the Analysis
   Execute the queries within the 03_analysis_queries.sql script to perform the analysis. This script is designed to be run in its entirety or as individual queries.
 - Export Results
   Most SQL clients provide an option to export query results directly to a CSV file. Save your outputs in the results/ directory for further use.

Final Deliverables:
- SQL Scripts: A collection of .sql files for database setup and comprehensive analysis.
- Exported Data: .xlsx files containing the results from key queries, ready for visualization in tools like Excel, Tableau, or Python libraries (e.g., Pandas, Matplotlib).

Technologies Used:
- Language: SQL
- Database: Designed to be compatible with any standard relational database system (e.g., PostgreSQL, MySQL, SQL Server, SQLite).

Contributing:
Contributions are welcome! Please feel free to fork the repository, make improvements, and submit a pull request. If you find any issues or have suggestions, please open an issue.
