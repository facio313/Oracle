2022-0901-02)집합연산자
- SELECT문의 결과를 대상으로 집합연산 수행
- UNION ALL, UNION, INTERSECT, MINUS 연산자 제공
- 집합연산자로 연결되는 SELECT문의 각 SELECT절의 컬럼의 갯수와 데이터 타입이 일치해야함
- ORDER BY절은 맨 마지막 SELECT문에만 사용 가능
- BLOB, CLOB, BFILE 타입의 컬럼은 집합연산자를 사용할 수 없음
- UNION, INTERSECT, MINUS연산자는 LONG타입형 컬럼에 사용할 수 없음
- GROUPING SETS(col1,col2,...) => UNION ALL 개념이 포함된 형태
   ex) GROUPING SETS(col1,col2,col3)
   =>((GROUP BY Col1) UNION ALL (GROUP BY col2) UNION ALL (GROUP BY col3)) 

1)UNION ALL
- 중복을 허용한 합집합의 결과를 반환

사용예) 회원테이블에서 직업이 주부인 회원과 마일리지가 3000이상인 모든 회원들의
회원번호, 회원명, 직업, 마일리지를 조회하시오.
-- 주부그룹과 마일리지 3000그룹
--> 두 번 출력해줘야 함. 이 때 사용하는 것이 UNION ALL
SELECT  MEM_ID      AS  회원번호, --> 첫 번째 별칭이 전체 별칭이 됨
        MEM_NAME    AS  회원명,
        MEM_JOB     AS  직업,
        MEM_MILEAGE AS  마일리지
FROM    MEMBER
WHERE   MEM_JOB = '주부' 
UNION   ALL
SELECT  MEM_ID,
        MEM_NAME,
        MEM_JOB,
        MEM_MILEAGE
--      TO_NUMBER(MEM_REGNO1) -- 데이터 타입만 같아도 출력은 됨. 벗! 정확한 값은 아님
--      MEM_REGNO01 -- 에러뜸! -> 타입이 달라서 그럼. MEM_REGNO1은 CHAR
FROM    MEMBER
WHERE   MEM_MILEAGE>=3000;

WITH    T1 AS
        (SELECT DISTINCT    DEPARTMENT_ID
        FROM    HR.EMPLOYEES
        UNION   ALL
        SELECT  COUNT(*)    AS  CNT
        FROM    HR.EMPLOYEES
        GROUP BY    DEPARTMENT_ID
        UNION   ALL
        SELECT  COUNT(*)    AS  TCNT
        FROM    HR.EMPLOYEES)
SELECT  (SELECT DEPARTMENT_ID
        FROM    HR.DEPARTMENTS B)   AS  부서코드,
        (SELECT DEPARTMENT_NAME
        FROM    HR.DEPARTMENTS B)   AS  부서명,    
        T1.CNT  AS  직원수
FROM    T1
ORDER BY    1;

사용예) 2020년 4,5,6,7월 구매액이 가장 많은 회원들의 회원번호, 회원명, 구매금액합계를 조회하시오
(WITH절을 사용한 경우)
WITH    T1  AS --VIEWER와 비슷함. 결과에 먼저 이름을 붙여놓는 것!
--T1테이블은 쿼리 아무 데나 사용할 수 있음
--맥스가 쓰이면 쉽지만 SUM함수 앞에 들어가야 해서 안 됨
        (SELECT '4월' AS MON,
                C.MEM_ID AS CID,
                C.MEM_NAME AS CNAME,  
                D.TOT1 AS CTOT1
        FROM    (SELECT A.CART_MEMBER AS AMID,
                        SUM(A.CART_QTY*B.PROD_PRICE)    AS  TOT1
                FROM    CART A, PROD B
                WHERE   A.CART_NO   LIKE    '202004%'
                AND     A.CART_PROD=B.PROD_ID
                GROUP BY    A.CART_MEMBER
                ORDER BY    2   DESC) D, MEMBER C
        WHERE   C.MEM_ID=D.AMID
        AND     ROWNUM=1 -- ORDER BY가 실행된 후 나와야 1등을 구할 수 있음!
UNION ALL -- UNION만 써도 됨
        SELECT '5월' AS MON,
                C.MEM_ID AS CID,
                C.MEM_NAME AS CNAME,  
                D.TOT1 AS CTOT1
        FROM    (SELECT A.CART_MEMBER AS AMID,
                        SUM(A.CART_QTY*B.PROD_PRICE)    AS  TOT1
                FROM    CART A, PROD B
                WHERE   A.CART_NO   LIKE    '202005%'
                AND     A.CART_PROD=B.PROD_ID
                GROUP BY    A.CART_MEMBER
                ORDER BY    2   DESC) D, MEMBER C
        WHERE   C.MEM_ID=D.AMID
        AND     ROWNUM=1
UNION ALL
        SELECT '6월' AS MON,
                C.MEM_ID AS CID,
                C.MEM_NAME AS CNAME,  
                D.TOT1 AS CTOT1
        FROM    (SELECT A.CART_MEMBER AS AMID,
                        SUM(A.CART_QTY*B.PROD_PRICE)    AS  TOT1
                FROM    CART A, PROD B
                WHERE   A.CART_NO   LIKE    '202006%'
                AND     A.CART_PROD=B.PROD_ID
                GROUP BY    A.CART_MEMBER
                ORDER BY    2   DESC) D, MEMBER C
        WHERE   C.MEM_ID=D.AMID
        AND     ROWNUM=1
UNION ALL
        SELECT '7월' AS MON,
                C.MEM_ID AS CID,
                C.MEM_NAME AS CNAME,  
                D.TOT1 AS CTOT1
        FROM    (SELECT A.CART_MEMBER AS AMID,
                        SUM(A.CART_QTY*B.PROD_PRICE)    AS  TOT1
                FROM    CART A, PROD B
                WHERE   A.CART_NO   LIKE    '202007%'
                AND     A.CART_PROD=B.PROD_ID
                GROUP BY    A.CART_MEMBER
                ORDER BY    2   DESC) D, MEMBER C
        WHERE   C.MEM_ID=D.AMID
        AND     ROWNUM=1)
SELECT  MON,
        CID      AS  회원번호,
        CNAME    AS  회원명,
        CTOT1    AS  구매금액
FROM    T1;

사용예) 4월과 7월에 판매된 모든 상품을 중복하지 않고 출력하시오
Alias는 상품콛, 상품명
    SELECT  DISTINCT A.CART_PROD AS 상품코드,
            B.PROD_NAME AS  상품명
    FROM    CART A, PROD B
    WHERE   A.CART_PROD=B.PROD_ID
    AND A.CART_NO LIKE '202006%'
UNION
    SELECT  DISTINCT A.CART_PROD AS 상품코드,
            B.PROD_NAME AS  상품명
    FROM    CART A, PROD B
    WHERE   A.CART_PROD=B.PROD_ID
    AND A.CART_NO LIKE '202007%'
ORDER BY    1; -- 여기만 적용되는 것이 아니라 전체에 적용됨

2) INTERSECT
- 교집합(공통부분)의 결과 반환

사용예) 2020년 매입상품 중 1월과 5월에 모두 매입된 상품의 상품코드, 상품명, 매입처명을 조회하시오
    SELECT  DISTINCT    A.BUY_PROD      AS  상품코드,
            C.PROD_NAME                 AS  상품명,
            B.BUYER_NAME                AS  매입처명
    FROM    BUYPROD A, BUYER B, PROD C
    WHERE   A.BUY_PROD=C.PROD_ID
    AND     C.PROD_BUYER=B.BUYER_ID
    AND     A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
INTERSECT
    SELECT  DISTINCT    A.BUY_PROD       AS  상품코드,
            C.PROD_NAME                  AS  상품명,
            B.BUYER_NAME                 AS  매입처명
    FROM    BUYPROD A, BUYER B, PROD C
    WHERE   A.BUY_PROD=C.PROD_ID
    AND     C.PROD_BUYER=B.BUYER_ID
    AND     A.BUY_DATE BETWEEN TO_DATE('20200501') AND TO_DATE('20200531')
    ORDER BY    1;
    
사용예) 1월 매입상품 중 5월 판매 수량 기준 5위 안에 존재하는 상품정보를 조회하시오.
SELECT  DISTINCT A.BUY_PROD     AS  상품코드,
                 B.CART_QTY     AS  판매수량,
                 A.BUY_DATE     AS  매입날짜
FROM    BUYPROD A, CART B
WHERE   A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
--AND     CART_NO LIKE '202005%'
AND     A.BUY_PROD=B.CART_PROD
ORDER BY 2 DESC;

--(1월 매입상품)
WITH    T1  AS
    (SELECT BUY_PROD
    FROM    BUYPROD
    WHERE   BUY_DATE  BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
INTERSECT
--(5월 판매 수량기준 1-5위 상품)
SELECT  A.CART_PROD
FROM    (SELECT CART_PROD,
                SUM(CART_QTY)
        FROM    CART
        WHERE   CART_NO LIKE    '202005%'
        GROUP BY    CART_PROD
        ORDER BY    2 DESC) A
WHERE     ROWNUM<=5)
SELECT  BUY_PROD    AS  상품코드,
        PROD_NAME   AS  상품명
FROM    T1, PROD
WHERE   T1.BUY_PROD=PROD_ID;