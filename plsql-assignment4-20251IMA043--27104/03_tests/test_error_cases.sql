SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- TEST 3: Invalid Course Exception ---');
    process_student_grades('INVALID_999');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Caught Expected Error: ' || SQLERRM);
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- TEST 4: Non-existent Student GPA Exception ---');
    DBMS_OUTPUT.PUT_LINE('GPA: ' || fn_calculate_system_gpa(99999));
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Caught Expected Error: ' || SQLERRM);
END;
/