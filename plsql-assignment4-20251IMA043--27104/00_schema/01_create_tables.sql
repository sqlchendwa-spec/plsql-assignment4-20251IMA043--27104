DROP TABLE enrollments CASCADE CONSTRAINTS;
DROP TABLE courses CASCADE CONSTRAINTS;
DROP TABLE students CASCADE CONSTRAINTS;

CREATE TABLE students (
    student_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    gpa NUMBER(3,2) DEFAULT 0.00
);

CREATE TABLE courses (
    course_id VARCHAR2(10) PRIMARY KEY,
    course_name VARCHAR2(100) NOT NULL,
    credits NUMBER DEFAULT 3 CHECK (credits > 0)
);

CREATE TABLE enrollments (
    enrollment_id NUMBER PRIMARY KEY,
    student_id NUMBER REFERENCES students(student_id),
    course_id VARCHAR2(10) REFERENCES courses(course_id),
    score NUMBER(5,2),
    grade VARCHAR2(2)
);

CREATE SEQUENCE seq_enrollment START WITH 1 INCREMENT BY 1;