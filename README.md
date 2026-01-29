Banking Fraud Detection Using SQL 
Project Overview:
1. This project focuses on identifying potentially fraudulent banking transactions using SQL-based rule detection and risk scoring.
2. The system helps fraud investigation teams by flagging high-risk transactions based on transaction behavior such as amount, time, location, and failed attempts.

Objective:
1. Analyze transaction data to detect suspicious patterns
2. Apply rule-based fraud indicators
3. Assign risk scores to transactions
4. Classify transactions into Low, Medium, and High Risk categories

Tools & Technologies:
1. Database: MySQL
2. Language: SQL

SQL Concepts Used:
1. Views
2. CASE Statements
3. Window Functions
4. Aggregations
5. Joins

Dataset Description: 
Each transaction record includes:
1. Transaction ID
2. Transaction Date
3. Transaction Time
4. Transaction Amount
5. Transaction Status (SUCCESS, FAILED, PENDING)
6. Transaction Location

Project Flow:
Phase 1: Data Preparation
1. Created a transactions table
2. Inserted sample transaction records
3. Verified data integrity
Phase 2: Base Transaction View
1. Created a base_transactions view
2. This view serves as the foundation for all fraud detection rules
Phase 3: Fraud Rule Indicators
The following fraud rules were implemented using SQL views:
1. High Transaction Amount
2. Flags transactions with unusually high amounts
3. Late Night Transactions
4. Flags transactions occurring between 12:00 AM and 5:00 AM
5. Repeated Failed Attempts
6. Flags successful transactions that were preceded by multiple failed attempts
7. Multiple Location Transactions
8. Flags transactions occurring from more than one location on the same day

Risk Scoring Logic :
Each fraud indicator contributes to the final risk score:
1. High Transaction Amount: 30 points
2. Late Night Transaction: 15 points
3. Multiple Locations: 25 points
4. Failed Attempts Before Success: 20 points
Final Risk Score is calculated as the sum of all applicable risk points.

Risk Classification:
1. High Risk: Risk Score greater than or equal to 60
2. Medium Risk: Risk Score between 30 and 59
3. Low Risk: Risk Score less than 30

Final Output:
1. A consolidated view named transaction_risk_score
2. Displays:
      Fraud indicator flags
      Total risk score
      Risk category (Low, Medium, High)
