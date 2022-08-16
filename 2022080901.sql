2022-0809-01)연산자
 1. 관계(비교) 연산자
 - 자료의 대소관계를 비교하는 연산자로 결과는 참(true)와 거짓(false)로 반환 --> 숫자로 나타나는 거 아님
 - >,<,>=,<=,=,!= (<>같지 않다 - 다른 언어에서는 ><도 씀)
 - 표현식 ( CASE WHEN ~ THEN, DECODE)이나 WHERE 조건절에 사용
 
사용예) 회원테이블(MEMBER)에서 모든 회원들의 회원번호, 회원명, 직업, 마일리지를 조회하되 마일리지가 많은 회원부터 조회하시오.
--SORT 순차? 정해줌 -> ORDER BY
 SELECT MEM_ID AS 회원번호,
        MEM_NAME AS 회원명,
        MEM_JOB AS 직업,
        MEM_MILEAGE AS 마일리지
    FROM MEMBER
   --ORDER BY MEM_MILEAGE DESC;
   ORDER BY 4 DESC; -- 아주 복잡한 컬럼의 경우 순번을 써서 넣는 게 낫다!!
   


**EMPLOYEES 테이블에 새로운 컬럼(EMP_NAME), 데이터타입은 VARCHAR2(80)인 컬럼을 추가
    ALTER TABLE 테이블명 ADD (컬럼명 데이터타입[(크기)] [DEFAULT 값])
    ALTER TABLE EMPLOYEES ADD (EMP_NAME VARCHAR2(80));

새로운 거 INSERT INTO -> 한 줄(튜플)이 들어감
있는 거 UPDATE -> 있는 자료에서 추가함

**UPDATE 문 => 저장된 자료를 수정할 때 사용
(사용형식)
    UPDATE 테이블명
       SET 컬럼명 = 값[,]
           컬럼명 = 값[,]
                :
           컬럼명 = 값[,]
    [WHERE 조건] --생략 시 모든 행을 같은 값으로 적용
    
    -- 다른 계정 테이블을 쓰고 싶다면(접근하고 싶다면) "다른계정명.테이블"

ROLLBACK;    
    UPDATE HR.EMPLOYEES
       SET EMP_NAME=FIRST_NAME||' '||LAST_NAME;
       -- 107명 다 해야 되니까 WHERE 절 필요 없음
       --"||" 자바에서 "+"와 같이 문자를 두 개 붙임
       
SELECT EMPLOYEE_ID,
       EMP_NAME
    FROM EMPLOYEES;   
    
사용예) 사원테이블(HR.EMPLOYEES) 부서번호가 50번인 사원들을 조회하시오.
    Alias는 사원번호, 사원명, 부서번호, 급여이다.
    
SELECT EMPLOYEE_ID AS 사원번호,
       EMP_NAME AS 사원명,
       DEPARTMENT_ID AS 부서번호,
       SALARY AS 급여
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID=50;

사용예) 회원테이블(MEMVER)에서 직업이 주부인 회원들을 조쇠하시오.
    Alias는 회원번호, 회원명, 직업, 마일리지이다.

SELECT MEM_ID AS 회원번호,
       MEM_NAME AS 회원명,
       MEM_JOB AS 직업,
       MEM_MILEAGE AS 마일리지
    FROM MEMBER
    WHERE MEM_JOB = '주부';
    
2. 산술연산자
 - '+', '-', '*', '/' => 4칙 연산자 -- 증감연산자 없음, 나머지 연산자도 없음(함수로 씀 --> remainder) // infix/prefix/postfix
 - () : 연산의 우선순위 결정
 
사용예) 사원테이블(HR.EMPLOYEES)에서 보너스를 계산하고 지급액을 결정하여 출력하시오
        보너스=본봉*영업실적의 30%
        지급액=본봉+보너스
        Alias는 사원번호, 사원명, 본봉, 영업실적, 보너스, 지급액
        모든 값은 정수 부분만 출력
    --DEFAULT INITIAL VALUE
    --표준 SQL은 변수 설정 불가
    
SELECT EMPLOYEE_ID AS 사원번호, 
       EMP_NAME AS 사원명,
    -- FIRST_NAME||' '||LAST_NAME AS 사원명,
       SALARY AS 본봉,
       COMMISSION_PCT AS 영업실적,
       NVL(ROUND(SALARY * COMMISSION_PCT*0.3),0) AS 보너스,
    -- ROUND() 소숫점 첫째 자리 반올림 /TRUNC --> 쓰는 것 권하지 않음
    -- NVL을 쓰면, 영업실적 없을 때 그냥 본봉만 나옴
       SALARY + NVL(ROUND(SALARY * COMMISSION_PCT*0.3),0) AS 지급액
    -- 변수를 못 써서 이것을 다시 써줘야 함
    FROM HR.EMPLOYEES;
    -- NULL 값이 연산에 사용되면 볼 것도 없이 NULL 값으로 반환됨
    
3. 논리연산자
 - 두 개 이상의 관계식을 연결(AND, OR)하거나 반전(NOT) 결과 반환
 - NOT(논리부정), AND(논리곱), OR(논리합)
 ---------------------------------
     입력       출력
    A    B     OR  AND
----------------------------------
    0    0     0    0
    0    1     1    0
    1    0     1    0
    1    1     1    1
사용예) 상품테이블(PROD)에서 판매가격이 30만원 이상이고 적정재고가 5개 이상인 제품의 
        제품번호, 제품명, 매입가, 판매가를 조회하시오.

    SELECT PROD_ID    AS 제품번호,
           PROD_NAME  AS 제품명,
           PROD_COST  AS 매입가,
           PROD_PRICE AS 판매가
      FROM PROD
     WHERE PROD_PRICE >= 300000
       AND PROD_PROPERSTOCK >= 5
  ORDER BY 4;

사용예) 매입테이블(BUYPROD)에서 매입일이 2020년 1월이고 매입수량이 10개 이상인  매입정보를 조회하시오.
        Alias는 매입일, 매입상품, 매입수량, 매입금액

    SELECT BUY_DATE AS 매입일,
           BUY_PROD AS 매입상품,
           BUY_QTY  AS 매입수량,
           BUY_QTY*BUY_COST AS 매입금액
      FROM BUYPROD
     WHERE BUY_DATE>=TO_DATE('20200101')
       AND BUY_DATE<=TO_DATE('20200131')
       AND BUY_QTY >= 10
  ORDER BY 1;
       --문자열은 HIERARCHY가 낮음 날짜-문자열 -> 날짜가 승
       --TO_DATE('') 날짜로 변환하세요 () 안에 꼭 '' 문자로 넣어야 함? 숫자는? 안 됨 => 문자를 날짜로 바꾸는 조건임!!
       --TO_DATE('20200101')<=BUY_DATE<=TO_DATE('20200131') => 이건 안 됨!!!!!!!

사용예) 회원테이블에서 연령대가 20대이거나  여성 회원을 조회하시오.
        Alias는 회원번호, 회원명, 주민번호, 마일리지
        
    SELECT MEM_ID      AS 회원번호,
           MEM_NAME    AS 회원명,
           MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
           TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1) AS 연령대,
           MEM_MILEAGE AS 마일리지
      FROM MEMBER
     WHERE TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)=20
        OR SUBSTR(MEM_REGNO2,1,1) IN ('2','4');
        --SUBSTR() 문자 추출 IN() ~안에 포함됨 /또는/ 
        --SUBSTR(MEM_REGNO02,1,1)='2'
        --SUBSTR(MEM_REGNO02,1,1)='4'
        --SUBSTR(MEM_REGNO02,1,1)='2' OR SUBSTR(MEM_REGNO02,1,1)='4'
        --TRUNC( ,-1) == 일의 자리를 버려라 => 20대 추출

        --case when(?)
사용예) 회원테이블에서 연령대가 20대이거나 여성 회원이면서 마일리지가 2000이상인 회원을 조회하시오.
        Alias는 회원번호, 회원명, 주민번호, 마일리지
        
    SELECT MEM_ID      AS 회원번호,
           MEM_NAME    AS 회원명,
           MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
           TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1) AS 연령대,
           MEM_MILEAGE AS 마일리지
      FROM MEMBER
     WHERE TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)=20
        OR SUBSTR(MEM_REGNO2,1,1) IN ('2','4')
       AND MEM_MILEAGE>=2000;
       
사용예) 키보드로 년도를 입력받아 윤년과 평년을 판단하시오.
        윤년 : 4의 배수이면서 100의 배수가 아니거나, 또는 400의 배수가 되는 년도
    ACCEPT P_YEAR PROMPT '년도입력: '
    DECLARE
        V_YEAR NUMBER:=TO_NUMBER('&P_YEAR');
        V_RES VARCHAR2(100);
    BEGIN
        IF  (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0) OR (MOD(V_YEAR,400)=0) THEN -- MOD : 나머지 계산
            V_RES:=TO_CHAR(V_YEAR)||'년도는 윤년입니다.';
        ELSE
            V_RES:=TO_CHAR(V_YEAR)||'년도는 평년입니다.';
        END IF;
        DBMS_OUTPUT.PUT_LINE(V_RES);
    END;