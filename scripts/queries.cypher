// Sample Queries for University Database

// 1. Find all students in Computer Science department
MATCH (s:Student)-[:MAJORS_IN]->(d:Department {name: "Computer Science"})
RETURN s.name AS student_name, s.id AS student_id;

// 2. Find all courses taught by professors in Computer Science department
MATCH (p:Professor)-[:WORKS_IN]->(d:Department {name: "Computer Science"})
MATCH (p)-[:TEACHES]->(c:Course)
RETURN p.name AS professor, c.name AS course, c.id AS course_id;

// 3. Find students with their enrolled courses and grades
MATCH (s:Student)-[e:ENROLLS_IN]->(c:Course)
RETURN s.name AS student, c.name AS course, e.grade AS grade, e.semester AS semester
ORDER BY s.name, c.name;

// 4. Count students per department
MATCH (s:Student)-[:MAJORS_IN]->(d:Department)
RETURN d.name AS department, count(s) AS student_count
ORDER BY student_count DESC;

// 5. Find professors teaching multiple courses
MATCH (p:Professor)-[:TEACHES]->(c:Course)
WITH p, count(c) AS course_count
WHERE course_count > 1
RETURN p.name AS professor, course_count;

// 6. Find cross-departmental enrollments (students taking courses outside their major)
MATCH (s:Student)-[:MAJORS_IN]->(major:Department)
MATCH (s)-[:ENROLLS_IN]->(c:Course)-[:OFFERED_BY]->(course_dept:Department)
WHERE major.name <> course_dept.name
RETURN s.name AS student, major.name AS major_dept, c.name AS course, course_dept.name AS course_dept;

// 7. Find students with A grades
MATCH (s:Student)-[e:ENROLLS_IN {grade: "A"}]->(c:Course)
RETURN s.name AS student, c.name AS course, e.semester AS semester;

// 8. Department heads and their department statistics
MATCH (d:Department)
OPTIONAL MATCH (p:Professor)-[:WORKS_IN]->(d)
OPTIONAL MATCH (s:Student)-[:MAJORS_IN]->(d)
OPTIONAL MATCH (c:Course)-[:OFFERED_BY]->(d)
RETURN d.name AS department, d.head AS department_head, 
       count(DISTINCT p) AS professors, 
       count(DISTINCT s) AS students, 
       count(DISTINCT c) AS courses;

// 9. Find students enrolled in Fall 2024
MATCH (s:Student)-[e:ENROLLS_IN {semester: "Fall 2024"}]->(c:Course)
RETURN s.name AS student, collect(c.name) AS courses;

// 10. Course prerequisites analysis (based on course numbering)
MATCH (c:Course)
WHERE c.id CONTAINS "101"
RETURN c.name AS introductory_courses, c.description AS description;