2022-0824-01) 집계함수
-- ~별 ==> 집계함수
-- ~가 기준
-- ~별이 두 개일 때는 순서대로 그룹화! 대그룹-소그룹
-- SELECT절에 안 나와도 되지만 대부분 나와줘야 함!!!
사용예)
장바구니테이블에서 2020년 5월 제품별 판매집계를 조회하시오.
    Alias는 제품코드, 판매건수, 판매수량, 금액
    
SELECT  A.CART_PROD                     AS  제품코드,
        COUNT(*)                        AS  판매건수,
        SUM(A.CART_QTY)                 AS  판매수량,
        SUM(A.CART_QTY*B.PROD_PRICE)    AS  금액
FROM    CART A, PROD B
WHERE   A.CART_NO LIKE '202005%' -- SUBSTR(CART_NO,1,6) =   '202005'
AND     A.CART_PROD = B.PROD_ID -- 카타 어쩌고 뭐뭐라는데 조인에 사용됨
GROUP BY    A.CART_PROD
ORDER BY    1;
    
사용예)
장바구니테이블에서 2020년 5월 회원별 판매집계를 조회하시오.
    Alias는 회원번호, 구매수량, 구매금액
    
SELECT  A.CART_MEMBER                   AS  회원번호,
        SUM(A.CART_QTY)                 AS  구매수량,
        SUM(A.CART_QTY*B.PROD_PRICE)    AS  구매금액
FROM    CART A, PROD B
WHERE   A.CART_NO LIKE '202005%'
AND     A.CART_PROD = B.PROD_ID
GROUP BY    A.CART_MEMBER
ORDER BY    1;

사용예)
장바구니테이블에서 2020년 월별, 회원별 판매집계를 조회하시오.
    Alias는 월, 회원번호, 구매수량, 구매금액
    
SELECT  SUBSTR(A.CART_NO,5,2)       AS  월,
        A.CART_MEMBER               AS  회원번호,
        SUM(A.CART_QTY)             AS  구매수량,
        SUM(A.CART_QTY*B.PROD_PRICE) AS  구매금액
FROM    CART A, PROD B
WHERE   SUBSTR(A.CART_NO,1,4) = '2020' --A.CART_NO   LIKE    '2020%'
AND     A.CART_PROD = B.PROD_ID
GROUP BY    SUBSTR(A.CART_NO,5,2), A.CART_MEMBER -- SUBSTR왜?
ORDER BY    1;

사용예)
장바구니테이블에서 2020년 5월 제품별 판매집계를 조회하되 판매금액이 100만원 이상인 자료만 조회하시오.
    Alias는 제품코드, 판매수량, 금액
    
SELECT  A.CART_PROD                     AS  제품코드,
        SUM(A.CART_QTY)                 AS  판매수량,
        SUM(A.CART_QTY*B.PROD_PRICE)    AS  금액
FROM    CART A, PROD B
WHERE   A.CART_NO LIKE '202005%'
AND     A.CART_PROD = B.PROD_ID
HAVING  SUM(A.CART_QTY*B.PROD_PRICE) >= 1000000 --WHERE절에 집계함수 쓰면 에러남! 그룹함수 자체에 조건이 걸어질 때는 HAVING절에다가!!
GROUP BY    A.CART_PROD
ORDER BY    A.CART_PROD;

사용예)
2020년 상반기(1~6월) 매입액 기준 가장 많이 매입된 상품을 조회하시오.
    Alias는 상품코드, 매입수량, 매입금액
(1) 2020년 상반기(1~6월) 제품별 매입액을 계산하고 매입액을 많은 순으로 출력
    
SELECT  BUY_PROD                AS  상품코드,
        SUM(BUY_QTY)            AS  매입수량,
        SUM(BUY_QTY*BUY_COST)   AS  매입금액 -- 집계함수끼리는 중복될 수 없음 MAX(SUM(~ (X)
FROM    BUYPROD
WHERE   BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
-- AND     ROWNUM<=5 --> ROWNUM은 ORDER BY 등이 적용되지 않은 상태에서 나옴
-- 즉 각 절의 실행 순서(FROM - WHERE - GROUP BY - SELECT - ORDER BY) 때문에 그럼
GROUP BY    BUY_PROD
-- HAVING SUM(BUY_QTY*BUY_COST) >= 35000000
ORDER BY    3 DESC;
-- 결과에서 PSEUDO COLUMN이 생김(1~74) -> 이 컬럼명은 ROWNUM
-- SUBQUERY나 WITH절 사용!

사용예)
2020년 상반기(1~6월) 매입액 기준 가장 많이 매입된 상품 5개를 조회하시오.
    Alias는 상품코드, 매입수량, 매입금액

SELECT  *
FROM    (SELECT     BUY_PROD    AS  상품코드,
                    SUM(BUY_QTY)AS  매입수량,
                    SUM(BUY_QTY*BUY_COST)   AS  매입금액 
        FROM    BUYPROD
        WHERE   BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
        GROUP BY    BUY_PROD
        ORDER BY    3 DESC)
WHERE   ROWNUM <= 5;

문제] 사원테이블에서 부서별 평균급여를 조회하시오.

SELECT  DEPARTMENT_ID           AS  부서코드,
        ROUND(AVG(SALARY),0)    AS  평균급여
FROM    HR.EMPLOYEES
GROUP BY    DEPARTMENT_ID
ORDER BY    1;

문제] 사원테이블에서 부서별 가장 먼저 입사한 사원의 사원번호, 사원명, 부서번호, 입사일을 출력하시오.

SELECT  A.EMPLOYEE_ID     AS  사원번호,
        A.EMP_NAME        AS  사원명,
        B.DEPARTMENT_ID   AS  부서번호,
        B.HDATE           AS  입사일
FROM    HR.EMPLOYEES A, (SELECT DEPARTMENT_ID   AS  부서번호,
                                MIN(HIRE_DATE)  AS  HDATE
                        FROM    HR.EMPLOYEES
                        GROUP BY DEPARTMENT_ID) B;
WHERE   A.DEPARTMENT_ID = B.DEPARTMENT_ID
AND     A.HIRE_DATE = B.HDATE
ORDER BY    3;

SELECT  --EMPLOYEE_ID   AS  사원번호,
        --EMP_NAME      AS  사원명,
        DEPARTMENT_ID   AS  부서번호,
        MIN(HIRE_DATE)  AS  입사일
FROM    HR.EMPLOYEES
GROUP BY    DEPARTMENT_ID;

문제] 사원들의 평균급여보다 더 많이 받는 사원의 사원번호, 사원명, 부서번호, 급여를 출력하시오.

SELECT  AVG(SALARY) FROM    HR.EMPLOYEES;

SELECT  EMPLOYEE_ID     AS  사원번호,
        EMP_NAME        AS  사원명,
        DEPARTMENT_ID   AS  부서번호,
        SALARY          AS  급여
FROM    HR.EMPLOYEES
WHERE   SALARY > (SELECT  AVG(SALARY) FROM    HR.EMPLOYEES)
ORDER BY    4 DESC;
        

문제] 회원테이블에서 남녀회원별 마일리지 합계와 평균 마일리지를 조회하시오
    Alias는 구분, 마일리지합계, 평균마일리지

SELECT  CASE    WHEN    SUBSTR(MEM_REGNO2,1,1)  IN('1','3') 
                THEN    '남성회원'  
                ELSE    '여성회원'  END AS  구분,
        COUNT(*)                AS  회원수,
        SUM(MEM_MILEAGE)        AS  마일리지합계,
        AVG(MEM_MILEAGE)        AS  평균마일리지
FROM    MEMBER
GROUP BY    CASE    WHEN    SUBSTR(MEM_REGNO2,1,1)  IN('1','3') 
                    THEN    '남성회원'  
                    ELSE    '여성회원'  END
ORDER BY    1;