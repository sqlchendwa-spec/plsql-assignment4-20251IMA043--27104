CREATE OR REPLACE PROCEDURE process_student_grades (
    p_course_id IN courses.course_id%TYPE
) AS
    TYPE t_student_eval IS RECORD (
        student_id students.student_id%TYPE,
        full_name  VARCHAR2(100),
        score      enrollments.score%TYPE,
        status     VARCHAR2(20)
    );
    
    TYPE t_eval_list IS TABLE OF t_student_eval;
    v_evals t_eval_list := t_eval_list();
    
    TYPE t_num_array IS TABLE OF NUMBER;
    v_student_ids t_num_array;
    v_scores      t_num_array;
    
    e_course_not_found EXCEPTION;
    v_course_count     NUMBER;
    
    bulk_errors EXCEPTION;
    PRAGMA EXCEPTION_INIT(bulk_errors, -24381);
BEGIN
    SELECT COUNT(*) INTO v_course_count FROM courses WHERE course_id = p_course_id;
    IF v_course_count = 0 THEN
        RAISE e_course_not_found;
    END IF;

    SELECT student_id, score 
    BULK COLLECT INTO v_student_ids, v_scores
    FROM enrollments
    WHERE course_id = p_course_id;

    IF v_student_ids.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No enrollments found for course: ' || p_course_id);
        RETURN;
    END IF;

    v_evals.EXTEND(v_student_ids.COUNT);
    FOR i IN 1..v_student_ids.COUNT LOOP
        v_evals(i).student_id := v_student_ids(i);
        v_evals(i).score := v_scores(i);
        IF v_scores(i) >= 70 THEN
            v_evals(i).status := 'PASSED';
        ELSE
            v_evals(i).status := 'FAILED';
        END IF;
    END LOOP;

    FORALL i IN 1..v_student_ids.COUNT SAVE EXCEPTIONS
        UPDATE enrollments 
        SET grade = CASE WHEN v_scores(i) >= 90 THEN 'A'
                         WHEN v_scores(i) >= 80 THEN 'B'
                         WHEN v_scores(i) >= 70 THEN 'C'
                         ELSE 'F' END
        WHERE student_id = v_student_ids(i) AND course_id = p_course_id;

    DBMS_OUTPUT.PUT_LINE('Successfully updated ' || SQL%ROWCOUNT || ' enrollment records.');

EXCEPTION
    WHEN e_course_not_found THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error: Course code ' || p_course_id || ' does not exist.');
    WHEN bulk_errors THEN
        FOR i IN 1..SQL%BULK_EXCEPTIONS.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE('Error #' || i || ' at index ' || 
                                 SQL%BULK_EXCEPTIONS(i).ERROR_INDEX || 
                                 ': ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE));
        END LOOP;
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20099, 'Unexpected database error: ' || SQLERRM);
END process_student_grades;
/