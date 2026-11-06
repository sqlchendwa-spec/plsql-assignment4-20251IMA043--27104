SET SERVEROUTPUT ON;

DROP TABLE employees CASCADE CONSTRAINTS;
DROP TABLE departments CASCADE CONSTRAINTS;

CREATE TABLE departments (
    department_id NUMBER(4) PRIMARY KEY,
    department_name VARCHAR2(30) NOT NULL
);

CREATE TABLE employees (
    employee_id NUMBER(6) PRIMARY KEY,
    first_name VARCHAR2(20),
    last_name VARCHAR2(25) NOT NULL,
    salary NUMBER(8,2),
    hire_date DATE NOT NULL,
    department_id NUMBER(4),
    CONSTRAINT fk_dept FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO departments VALUES (10, 'Administration');
INSERT INTO departments VALUES (20, 'Marketing');
INSERT INTO departments VALUES (30, 'Purchasing');
INSERT INTO departments VALUES (40, 'Human Resources');
INSERT INTO departments VALUES (50, 'Shipping');
INSERT INTO departments VALUES (60, 'IT');

INSERT INTO employees VALUES (100, 'Steven', 'Ishimwe', 24000, TO_DATE('2015-06-17', 'YYYY-MM-DD'), 90);
INSERT INTO employees VALUES (101, 'Grace', 'Niyonsaba', 17000, TO_DATE('2018-09-21', 'YYYY-MM-DD'), 20);
INSERT INTO employees VALUES (102, 'David', 'Mugisha', 17000, TO_DATE('2021-01-13', 'YYYY-MM-DD'), 30);
INSERT INTO employees VALUES (103, 'Alex', 'Irakiza', 9000, TO_DATE('2023-01-03', 'YYYY-MM-DD'), 60);
INSERT INTO employees VALUES (104, 'Brian', 'Kwizera', 6000, TO_DATE('2024-05-21', 'YYYY-MM-DD'), 60);

COMMIT;