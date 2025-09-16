CREATE DATABASE clinical_project;
USE clinical_project;

CREATE TABLE departments (
	Department_id INT PRIMARY KEY,
	Department_name VARCHAR(50)
	);
            
SELECT*FROM departments;

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
    
SELECT*FROM patients;
    
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

SELECT*FROM drugs_prescribed;

CREATE TABLE adverse_events (
	Event_id INT PRIMARY KEY,
    Patient_id INT, 
    FOREIGN KEY (Patient_id) REFERENCES patients (Patient_id),
    Event_name VARCHAR(100) NOT NULL,
    Event_date DATE NOT NULL,
    Severity VARCHAR(50)
    );
    
SELECT*FROM adverse_events;

CREATE TABLE lab_tests (
	Test_id VARCHAR(10) PRIMARY KEY,
    Patient_id INT, 
    FOREIGN KEY (Patient_id) REFERENCES patients (Patient_id),
    Test_name VARCHAR(100),
    Test_date DATE,
    Result_value Decimal (5,2),
    Normal_range VARCHAR(50)
    );
    
   SELECT*FROM lab_tests;

CREATE TABLE discharge_summary (
	Summary_id VARCHAR(20) PRIMARY KEY,
    Patient_id INT, 
    FOREIGN KEY (Patient_id) REFERENCES patients (Patient_id),
    Discharge_date DATE,
    Condition_at_discharge VARCHAR(100),
    Follow_up_required BOOLEAN,
    Follow_up_date DATE
    );
    
SELECT*FROM discharge_summary;

