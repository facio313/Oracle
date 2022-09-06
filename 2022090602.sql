2022-0906-02)커서(CURSOR)
- 커서는 SQL의 DML명령으로 영향받은 행들의 집합
- SELECT문의 결과 집합
- 묵시적 커서와 명시적 커서로 구분
- VIEW = CURSOR
- 반복을 쓰는 이이유는 커서를 쓰기 위해서임
- 나머지 경우에서는 반복 거의 안 씀

1) 묵시적 커서(IMPLICIT CURSOR)
- 이름이 없는 커서
- 항상 커서가 CLOSE되어 있음 
- 개발자가 커서 내부에 접근할 수 없음 --> 그래서 그냥 거의 내비둠.... 타겟은 명시적 커서!
- 커서속성 -- FETCH 긁어오는 것(읽는 것)
----------------------------------------------------------------
속성                 의미
----------------------------------------------------------------
SQL%ISOPEN          커서가 OPEN 되었으면 참(TRUE) 반환, 항상 FALSE임
SQL%FOUND           커서 내부에 FETCH할 자료가 존재하면 참(TRUE)  -- WHILE의 반복을 결정할 때
SQL%NOTFOUND        커서 내부에 FETCH할 자료가 없으면 참(TRUE)    -- 루프문의 반복을 결정할 때
SQL%ROWCOUNT        커서 내부 행의 수 반환
----------------------------------------------------------------

2) 명시적 커서
- 이름이 부여된 커서
- 묵시적 커서 속성에서 'SQL' 대신 커서명을 사용
- 커서의 사용절차
    커서 선언(선언영역) => 커서 OPEN => FETCH(반복명령 내부) => CLOSE 
    --커서 선언은 DECLARE에서 함
    --OPEN ~ CLOSE는 BEGIN에서 함
    --OPEN과 CLOSE는 반복문 밖에 있음
    단, FOR문에서 사용되는 커서는 OPEN, FETCH, CLOSE명령이 불필요
(1) 커서 선언
CURSOR  커서명[(BIND변수명 데이터타입[,...])] IS -- BIND변수는 크기를 지정하면 안 됨
    SELECT문

사용예)
사원테이블에서 부서번호를 입력받아 그 부서에 속한 사원정보를 출력하는 커서를 작성하시오
ACCEPT  P_DID  PROMPT  '부서번호 : '
DECLARE
    CURSOR  EMP_NUR(P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS
    SELECT  EMPLOYEE_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM    HR.EMPLOYEES
    WHERE   DEPARTMENT_ID = P_DID;
BEGIN
    
END;



