# Database-Management-System
Database application with Tkinter GUI and PostgreSQL integration for managing students, exams, and results using SQL queries.

<img width="599" height="467" alt="image" src="https://github.com/user-attachments/assets/7b8d9781-e67b-4fa8-b023-cbf87ce789b1" />


# Database Management System (Python + PostgreSQL)

## Overview:
This project is a database-driven application developed as part of a university Database Systems module. It provides a graphical user interface (GUI) built with Tkinter to interact with a PostgreSQL database, enabling management of students, examinations, and exam results.

The system demonstrates practical use of SQL and database integration within a Python application, including data manipulation, querying, and transaction handling.

## Features:
* Add and manage student records
* Add and manage exam records
* Register students for examinations
* Update exam grades
* Delete students with cascading entry handling
* Conditional exam deletion based on active entries
* Generate student examination timetables
* View exam results with classification (Distinction, Pass, Fail, Not Taken)

## Tech Stack:
* Python
* Tkinter (GUI)
* PostgreSQL
* psycopg2

## Database Concepts:
* SQL operations: INSERT, UPDATE, DELETE, SELECT
* JOIN queries across multiple tables
* Conditional logic using CASE statements
* Transaction handling (commit and rollback)
* Data integrity and relational structure

## Project Structure:
* `main.py` – main application (GUI + database interaction)
* `sql/schema.sql` – database schema (tables and constraints)
* `sql/data.sql` – sample/test data
* `sql/queries.sql` – SQL queries for reporting and analysis

## How to Run:
1. Install dependencies:
   ```bash
   pip install psycopg2
   ```

2. Configure database connection in `main.py`:
   * database name
   * username
   * password
   * host and port

3. Run the application:
   ```bash
   python main.py
   ```

## Notes:
* This project was developed as part of university coursework.
* Database credentials are not included for security reasons.
* The application requires access to a PostgreSQL database with the appropriate schema and data loaded.
