INSERT INTO students VALUES (101, 'John', 'Mugisha', 'john.m@auca.ac.rw', 3.20);
INSERT INTO students VALUES (102, 'Divine', 'Uwase', 'divine.u@auca.ac.rw', 3.85);
INSERT INTO students VALUES (103, 'Claude', 'Iradukunda', 'claude.i@auca.ac.rw', 2.90);
INSERT INTO students VALUES (104, 'Ketsia', 'Akamanzi', 'ketsia.a@auca.ac.rw', 3.70);

INSERT INTO courses VALUES ('INSY8311', 'Database Development with PL/SQL', 4);
INSERT INTO courses VALUES ('INSY8312', 'Computer Networking', 3);
INSERT INTO courses VALUES ('ACCT7101', 'Corporate Accounting Frameworks', 3);

INSERT INTO enrollments VALUES (seq_enrollment.NEXTVAL, 101, 'INSY8311', 85, 'A');
INSERT INTO enrollments VALUES (seq_enrollment.NEXTVAL, 102, 'INSY8311', 92, 'A');
INSERT INTO enrollments VALUES (seq_enrollment.NEXTVAL, 103, 'INSY8311', 68, 'C');
INSERT INTO enrollments VALUES (seq_enrollment.NEXTVAL, 104, 'INSY8311', 88, 'A');

COMMIT;
