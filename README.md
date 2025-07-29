# Neo4j University Database Project

A comprehensive university database system built with Neo4j graph database, modeling relationships between departments, professors, courses, and students.

# Database Schema

## Nodes
- Department: University departments with department heads
- Professor: Faculty members with contact information  
- Course: Academic courses with descriptions
- Student: Enrolled students with contact information

## Relationships
- WORKS_IN: Professor → Department
- TEACHES: Professor → Course (with semester property)
- OFFERED_BY: Course → Department  
- MAJORS_IN: Student → Department (with year property)
- ENROLLS_IN: Student → Course (with semester and grade properties)

# Project Structure

```
neo4j-university-db/
├── README.md                     # This file
├── data/                         # CSV data files
│   ├── departments.csv           # Department information
│   ├── professors.csv            # Professor details
│   ├── courses.csv               # Course catalog
│   ├── students.csv              # Student records
│   └── relationships/            # Relationship data
│       ├── professor_works_in.csv
│       ├── course_offered_by.csv
│       ├── professor_teaches.csv
│       ├── student_majors_in.csv
│       └── student_enrolls_in.csv
└── scripts/
    ├── load_from_csv.cypher      # Load data from CSV files
    └── queries.cypher            # Sample queries and examples
```

# Quick Start

## Prerequisites
- Neo4j Desktop (recommended) or Neo4j Server
- Neo4j Browser for running queries

## Setup Instructions

### Step 1: Clone the repository
```bash
git clone 
cd neo4j-university-db
```

### Step 2: Copy CSV files to Neo4j import directory
```bash
# For Neo4j Desktop, copy files to:
# <Neo4j Home>/import/

# Or use Neo4j Desktop GUI:
# Open your database → Manage → Open Folder → Import
```

### Step 3: Load the database
- Open Neo4j Browser
- Copy and paste the content from scripts/load_from_csv.cypher
- Execute the script

### Step 4: Verify installation
```cypher
MATCH (n) RETURN labels(n), count(n)
```

# Sample Data Overview

- 7 Departments: Computer Science, Mathematics, Physics, Chemistry, Biology, English, History
- 10 Professors: Distributed across different departments
- 10 Courses: Including CS101, MATH101, PHYS101, and more
- 20 Students: With various majors and course enrollments


# Data Model Features

- Academic Hierarchy: Proper department-course-professor relationships
- Student Management: Major declarations and course enrollments
- Grade Tracking: Complete grading system for courses
- Semester Support: Temporal tracking of academic terms
- Cross-departmental: Students can enroll in courses outside their major
- Contact Information: Phone numbers and addresses for all persons

# Use Cases

- Student Enrollment Management: Track who's enrolled in what
- Academic Planning: Course scheduling and capacity planning
- Performance Analysis: Grade distributions and academic success
- Resource Allocation: Faculty workload and department resources
- Reporting: Generate academic reports and statistics
- Data Analytics: Identify patterns in student behavior

# File Descriptions

## Data Files
- departments.csv: Department names and heads
- professors.csv: Professor IDs, names, and contact info
- courses.csv: Course codes, names, and descriptions  
- students.csv: Student IDs, names, and contact info

## Relationship Files
- professor_works_in.csv: Which professors work in which departments
- course_offered_by.csv: Which department offers each course
- professor_teaches.csv: Teaching assignments with semesters
- student_majors_in.csv: Student major declarations with years
- student_enrolls_in.csv: Course enrollments with grades and semesters

# Acknowledgments

- Neo4j Community for excellent graph database tools
- University database design best practices
- Open source community for inspiration
