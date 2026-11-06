SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- TEST 1: Running process_student_grades ---');
    process_student_grades('INSY8311');
    
    DBMS_OUTPUT.PUT_LINE('--- TEST 2: Running fn_calculate_student_gpa ---');
    DBMS_OUTPUT.PUT_LINE('Calculated GPA for Student 101: ' || fn_calculate_student_gpa(101));
END;
/