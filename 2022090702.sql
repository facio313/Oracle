2022-0907-02) Stored Procedure(Procedur)
- 특정 로직을 처리하여 결과 값을 반환하지 않는 서브 프로그램
- 미리 컴파일되어 저장(실행의 효율성이 좋고, 네트워크를 통해 전달되는 자료의 양이 작다)
(사용형식)
CREATE [OR REPLACE] PROCEDURE 프로시져명[(
    변수명 [IN|OUT|INOUT]  데이터타입[:=디폴트값], --크기지정하는 것 아님!!!!아니라구!
            :
    변수명 [IN|OUT|INOUT]  데이터타입[:=디폴트값],
IS|AS --DECLARE와 같은 부분
    선언영역
BEGIN
    실행영역 -- SQL,반복,분기
END;
- '변수명' : 매개변수명
- 'IN|OUT|INOUT' : 매개변수의 역할 정의(IN : 입력용, OUT : 출력용, INOUT : 입출력 공용)
- '데이터타입' : 크기를 기술하면 오류
- '디폴트값' : 사용자가 매개변수를 기술하고 값을 배정하지 않았을 때 자동으로 할당될 값
--함수를 내가 만들어서 내가 쓰는 것
--반환값. SELECT문에 쓸 수 있느냐 없느냐
--OUT을 통해 나온 것은 반환값이 아니라 출력값임
--반환값은 프로시져나 함수에 대해 나온 값임
--IN,OUT은 너무 무리가 커서 안 쓰는 게 좋음
--DEFAULT값도 쓰지 마렁! 정확하게 지정해 걍!
--IN,OUT,INOUT다 생략하면 IN으로 취급됨

(실행문) 독립적으로 실행할 때
EXECUTE|EXEC    프로시저명[(매개변수list)];
또는 프로시저나 다른 블록에서 실행할 경우
프로시저명[(매개변수list)];

사용예)
부서번호를 입력받아 해당부서 부서장의 이름, 직책, 부서명, 급여를 출력하는 프로시져를 작성하시오
CREATE OR REPLACE PROCEDURE PROC_EMP01(
    P_DID   IN   HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
IS
    V_NAME  VARCHAR2(100);
    V_JOBID HR.JOBS.JOB_ID%TYPE;
    V_DNAME VARCHAR2(100);
    V_SAL   NUMBER := 0;
BEGIN
    SELECT  B.EMP_NAME, B.JOB_ID, A.DEPARTMENT_NAME, B.SALARY
    INTO    V_NAME, V_JOBID, V_DNAME, V_SAL
    FROM    HR.DEPARTMENTS A, HR.EMPLOYEES B
    WHERE   A.DEPARTMENT_ID =   P_DID
    AND     A.MANAGER_ID    =   B.EMPLOYEE_ID;
    DBMS_OUTPUT.PUT_LINE('부서코드 : '||P_DID);
    DBMS_OUTPUT.PUT_LINE('부서장 : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('직무코드 : '||V_JOBID);
    DBMS_OUTPUT.PUT_LINE('부서명 : '|| V_DNAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||V_SAL);
    DBMS_OUTPUT.PUT_LINE('----------------------------------');
END;

(실행)
EXECUTE PROC_EMP01(60);