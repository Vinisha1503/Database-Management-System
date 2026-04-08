# Database-Management-System
Database application with Tkinter GUI and PostgreSQL integration for managing students, exams, and results using SQL queries.

## Overview
This project is a database-driven application developed as part of a university Database Systems module. It uses Python and Tkinter to provide a graphical interface for interacting with a PostgreSQL database.

The system manages students, exams, and exam entries, supporting data insertion, deletion, updates, and complex SQL queries.

## Features
- Add and manage student records
- Add and manage exam records
- Register students for exams
- Update exam grades
- Delete students and associated entries
- Conditional exam deletion based on active entries
- Generate student timetables
- View exam results and classifications (Pass/Fail/Distinction)

## Tech Stack
- Python
- Tkinter (GUI)
- PostgreSQL
- psycopg2

## Database Concepts Used
- SQL queries (INSERT, UPDATE, DELETE, SELECT)
- JOIN operations across multiple tables
- Transaction handling (commit / rollback)
- Data integrity constraints
- Conditional queries and filtering

## How to Run
1. Ensure PostgreSQL is set up and accessible
2. Install dependencies:

```bash
pip install psycopg2
