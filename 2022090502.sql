2022-0905-02)동의어 객체(SYNONYM)
- 오라클 객체에 별칭을 부여할 때 사용
- 다른 소유자의 객체에 접근하는 경우 "스키마명.객체명" 형식으로 접근해야 함
    => 이를 사용하기 쉽고 기억이 용이한 단어로 대신 할 수 있는 방법 제공
    
(사용형식)
CREATE [OR REPLACE] SYNONYM 별칭
FOR     원본 객체명

사용예)
HR 계정의 EMPLOYEES 테이블과 DEPARTMENTS 테이블을 EMP 및 DEPT로 별칭을 부여하시오

DROP SYNONYM EMP;

SELECT * FROM EMP;

CREATE  OR  REPLACE SYNONYM    EMPL     FOR HR.EMPLOYEES;--EMP로 할랬는데 다른 테이블 존재하는가봄;;; 나만 안 돼

SELECT  *   FROM    EMPL;

CREATE  OR  REPLACE SYNONYM    DEPT    FOR HR.DEPARTMENTS;

SELECT  *   FROM    DEPT;

SELECT  A.EMPLOYEE_ID,
        A.EMP_NAME,
        B.DEPARTMENT_NAME
FROM    EMPL A, DEPT B
WHERE   B.DEPARTMENT_ID IN (20, 30, 50, 60)
AND     A.DEPARTMENT_ID = B.DEPARTMENT_ID;
