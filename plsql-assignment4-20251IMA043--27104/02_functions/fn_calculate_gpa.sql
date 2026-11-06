CREATE OR REPLACE FUNCTION fn_calculate_student_gpa (
    p_student_id IN students.student_id%TYPE
) RETURN NUMBER AS
    v_student_exists NUMBER;
    v_total_points   NUMBER := 0;
    v_total_credits  NUMBER := 0;
    
    CURSOR c_grades IS
        SELECT e.score, c.credits
        FROM enrollments e
        JOIN courses c ON e.course_id = c.course_id
        WHERE e.student_id = p_student_id;
        
    v_rec c_grades%ROWTYPE; 
    e_invalid_student EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO v_student_exists FROM students WHERE student_id = p_student_id;
    IF v_student_exists = 0 THEN
        RAISE e_invalid_student;
    END IF;

    OPEN c_grades;
    LOOP
        FETCH c_grades INTO v_rec;
        EXIT WHEN c_grades%NOTFOUND;
        
        v_total_credits := v_total_credits + v_rec.credits;
        v_total_points  := v_total_points + (v_rec.score / 20) * v_rec.credits;
    END LOOP;
    CLOSE c_grades;

    IF v_total_credits = 0 THEN
        RETURN 0.00;
    END IF;

    RETURN ROUND(v_total_points / v_total_credits, 2);

EXCEPTION
    WHEN e_invalid_student THEN
        RAISE_APPLICATION_ERROR(-20002, 'Student ID ' || p_student_id || ' not found.');
    WHEN OTHERS THEN
        IF c_grades%ISOPEN THEN
            CLOSE c_grades;
        END IF;
        RAISE_APPLICATION_ERROR(-20098, 'GPA Calculation Error: ' || SQLERRM);
END fn_calculate_student_gpa;
/