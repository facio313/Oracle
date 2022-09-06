2022-0906-01) PL/SQL --졸아서 다 못 들음. 다른 애들 것과 비교좀
- 표준 SQL이 가지고 있는 단점(변수, 반복문, 분기문 등이 없음)을 보완
- PROCEDUAL LANGUAGE SQL(절차적)
    -- 지금까지 배운 것 STRUCTURAL(구조적) / 변수, 상수 못 썼음 / 반복문, 분기문 못 썼음
- BLOCK 구조로 구성되어 있음
- 익명블록(Anonymous Block), Stored Procedure, user defined Function, Trigger, Package 등이 제공됨
- 모듈화 및 캡슐화 기능 제공 >> 중요해!!

1. 익명블록
- PL/SQL의 기본 구조 제공
- 이름이 없어 재실행(호출)이 불가능

(구성)
DECLARE
    선언부(변수, 상수, 커서 선언);
BEGIN
    실행부:처리할 비지니스 로직을 구현하기 위한 SQL구문, 반복문, 분기문 등으로 구성
    [EXCEPTION
        예외처리문
    ]
END;

- 실행영역에서 사용하는 SELECT문
SELECT  컬럼list
INTO    변수명[,변수명,...] -- 반드시!! 나와야 하매. 
FROM    테이블명
[WHERE  조건]
    **** 컬럼의 개수와 데이터 타입은 INTO절 변수의 개수 및 데이터 타입과 동일 ****
-- 컬럼은 그 개수가 다르지만 변수는 하나밖에 못 받음
SELECT  EMP_NAME INTO NAME -- EMP_NAME 컬럼은 5개를 갖지만 NAME이란 변수는 하나밖에 못 받음... -> 이래서 나온 게 커서!
FROM    HR.EMPLOYEES
WHERE   DEPARTMENT_ID = 60

1) 변수
- 개발 언어의 변수와 같은 개념
- SCLAR변수, REFERENCE 변수, COMPOSITE 변수, BINDING 변수 등이 제공
--BINDING : 기억장소가 마련되고 그 장소에 값을 집어넣는 매개변수(값을 전달하는 변수)
--IN, OUT, INOUT(입력, 출력, 입출력)용인지 반드시 기술해줘야 함
(사용형식)
변수명 [CONSTANCT] 데이터타입[(크기)] [:=초기값];
- 데이터타입 : SQL에서 제공하는 데이터 타입, PLS_INTEGER, BINARY_INTEGER, BOOLEAN(T/F/N) 등이 제공됨
- 'CONSTANT' = 상수 선언(반드시 초기값이 설정되어야 함) -- 상수는 = 왼쪽에 못 옴

** REFERENCE 변수
    변수명 테이블명.컬럼명%TYPE
    변수명 테이블명%ROWTYPE -- 전체 행 참조 --> 행.열명 특정 행의 열을 참조할 수 있음
    --  a.CART_NUMBER로 변수 사용 가능
사용예)
키보드로 부서를 입력받아 해당 부서에 가장 먼저 입사한 사원의 --1명만 출력하게따!
사원번호, 사원명, 직책코드, 입사일을 출력하시오
ACCEPT  P_DID   PROMPT  '부서번호 입력 : '
DECLARE
    V_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE;
    V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE; -- 사원번호
    V_NAME VARCHAR2(100); -- 사원명
    V_JID HR.JOBS.JOB_ID%TYPE; -- 직책코드
    V_HADTE DATE; -- 입사일
BEGIN
    V_DID := ('&P_DID');
    --파스칼에서 :=을 써왔음(자바에서 =)
    SELECT  EMPLOYEE_ID, EMP_NAME, JOB_ID, HIRE_DATE
    INTO    V_EID, V_NAME, V_JID, V_HDATE
    FROM    HR.EMPLOYEES
    WHERE   DEPARTMENT_ID = V_DID
    ORDER BY 4) A    
AND ROWNUM = 1
    DBMS_OUTPUT.PUT_LINE('사원번호: '||V_ERD);--Sysout과 같은 것
    DBMS_OUTPUT.PUT_LINE('사원명: '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('직책코드: '||V_JID);
    DBMS_OUTPUT.PUT_LINE('입사일: '||V_HDATE())
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
END;

사용예) 회원테이블에서 직업이 '주부'인 회원들의 2020년 5월 구매현황을 조회하시오
    Alias는 회원번호, 회원명, 직업, 구매급액합계
SELECT  A.MEM_ID    AS  회원번호,
        A.MEM_NAME  AS  회원명,
        A.MEM_JOB   AS  직업,
        D.BSUM      AS  구매금액합계
FROM   (SELECT  MEM_ID, MEM_NAME,   MEM_JOB
        FROM    MEMBER
        WHERE   MEM_JOB = '주부') A,
       (SELECT  B.CART_MEMBER   AS BMID,
                SUM(B.CART_QTY * C.PROD_PRICE)  AS BSUM
        FROM    CART B, PROD C
        WHERE   B.CART_PROD = C.PROD_ID
        AND     B.CART_NO LIKE '202005%'
        GROUP   BY  B.CART_MEMBER)D
WHERE   A.MEM_ID = D.BMID;

(익명블록)
DECLARE
    V_MID   MEMBER.MEM_ID%TYPE;
    V_NAME  VARCHAR2(100);
    V_JOB   MEMBER.MEM_JOB%TYPE;
    V_SUM   NUMBER := 0;
    CURSOR  CUR_MEM IS
        SELECT  MEM_ID, MEM_NAME,   MEM_JOB
        FROM    MEMBER
        WHERE   MEM_JOB = '주부';
BEGIN
    OPEN    CUR_MEM; --커서를 사용하기 위해서 적음
    LOOP
        FETCH   CUR_MEM  INTO    V_MID, V_NAME, V_JOB;
        EXIT WHEN CUR_MEM%NOTFOUND;
        SELECT  SUM(A.CART_QTY * B.PROD_PRICE)  INTO    V_SUM
        FROM    CART A, PROD B
        WHERE   A.CART_PROD = B.PROD_ID
        AND     A.CART_NO   LIKE    '202005%'
        AND     A.CART_MEMBER = V_MID;
        DBMS_OUTPUT.PUT_LINE('회원번호 : '||V_MID);
        DBMS_OUTPUT.PUT_LINE('회원명 : '||V_NAME);
        DBMS_OUTPUT.PUT_LINE('직업 : '||V_JOB);
        DBMS_OUTPUT.PUT_LINE('구매금액 : '||V_SUM);
        DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    END LOOP;
    CLOSE CUR_MEM;
END;

    --몇 자리인지 모르면 NUMBER만 써. 27자리까지는 지 알아서 잡아줌. BUT 반드시 초기화해야 함    
    --CURSOR은 VIEW와 비슷함
    --CURSOR을 사용하는 이유 : 변수에는 하나만 넣을 수 있는데 컬럼은 여러 값을 가져서 씀
    --FETCH : 한 줄 한 줄을 읽어오는 것

사용예)
년도를 입력받아 윤년인지 평년인지 구별하는 블록을 작성하시오
ACCEPT  P_YEAR  PROMPT  '년도입력 : '
DECLARE
    V_YEAR  NUMBER := TO_NUMBER('&P_YEAR');
    V_RES   VARCHAR2(200);
BEGIN
    IF      (MOD(V_YEAR, 4) = 0 AND MOD(V_YEAR, 100) != 0) OR (MOD(V_YEAR, 400) = 0)
    THEN    V_RES := V_YEAR||'년은 윤년입니다.';
    ELSE    V_RES := V_YEAR||'년은 평년입니다.';
    END IF;
    DBMS_OUTPUT.PUT_LINE(V_RES);
END;

사용예)
반지름을 입력받아 원의 넓이와 둘레를 구하시오
원의 넓이 : 반지름 * 반지름 * 원주율(3.1415926)
원둘레 : 지름 * 3.1415926
ACCEPT  P_RADIUS  PROMPT  '반지름 : '
DECLARE
    V_RADIUS    NUMBER := TO_NUMBER('&P_RADIUS');
    V_PI        CONSTANT NUMBER := 3.1415926;
    V_AREA      NUMBER := 0;
    V_CIRCUM    NUMBER := 0;
BEGIN
    V_AREA      := V_RADIUS * V_RADIUS * V_PI;
    V_CIRCUM    := V_RADIUS * 2 * V_PI;
    DBMS_OUTPUT.PUT_LINE('원의 넓이 = '||V_AREA);
    DBMS_OUTPUT.PUT_LINE('원의 둘레 = '||V_CIRCUM);
END;