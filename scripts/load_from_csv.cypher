// Load University Database from CSV files
// Make sure CSV files are placed in Neo4j import directory

// Clear existing data (optional - use with caution)
// MATCH (n) DETACH DELETE n;

// Create Departments
LOAD CSV WITH HEADERS FROM 'file:///departments.csv' AS row
CREATE (d:Department {
  name: row.name,
  head: row.head
});

// Create Professors
LOAD CSV WITH HEADERS FROM 'file:///professors.csv' AS row
CREATE (p:Professor {
  id: row.id,
  name: row.name,
  phone: row.phone,
  address: row.address
});

// Create Courses
LOAD CSV WITH HEADERS FROM 'file:///courses.csv' AS row
CREATE (c:Course {
  id: row.id,
  name: row.name,
  description: row.description
});

// Create Students
LOAD CSV WITH HEADERS FROM 'file:///students.csv' AS row
CREATE (s:Student {
  id: row.id,
  name: row.name,
  phone: row.phone,
  address: row.address
});

// Create Professor WORKS_IN Department relationships
LOAD CSV WITH HEADERS FROM 'file:///professor_works_in.csv' AS row
MATCH (p:Professor {id: row.professor_id})
MATCH (d:Department {name: row.department_name})
CREATE (p)-[:WORKS_IN]->(d);

// Create Course OFFERED_BY Department relationships
LOAD CSV WITH HEADERS FROM 'file:///course_offered_by.csv' AS row
MATCH (c:Course {id: row.course_id})
MATCH (d:Department {name: row.department_name})
CREATE (c)-[:OFFERED_BY]->(d);

// Create Professor TEACHES Course relationships
LOAD CSV WITH HEADERS FROM 'file:///professor_teaches.csv' AS row
MATCH (p:Professor {id: row.professor_id})
MATCH (c:Course {id: row.course_id})
CREATE (p)-[:TEACHES {semester: row.semester}]->(c);

// Create Student MAJORS_IN Department relationships
LOAD CSV WITH HEADERS FROM 'file:///student_majors_in.csv' AS row
MATCH (s:Student {id: row.student_id})
MATCH (d:Department {name: row.department_name})
CREATE (s)-[:MAJORS_IN {year: row.year}]->(d);

// Create Student ENROLLS_IN Course relationships
LOAD CSV WITH HEADERS FROM 'file:///student_enrolls_in.csv' AS row
MATCH (s:Student {id: row.student_id})
MATCH (c:Course {id: row.course_id})
CREATE (s)-[:ENROLLS_IN {
  semester: row.semester,
  grade: CASE WHEN row.grade = '' THEN null ELSE row.grade END
}]->(c);

// Create indexes for better performance
CREATE INDEX FOR (d:Department) ON (d.name);
CREATE INDEX FOR (p:Professor) ON (p.id);
CREATE INDEX FOR (c:Course) ON (c.id);
CREATE INDEX FOR (s:Student) ON (s.id);