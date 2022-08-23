2022-0822-02) 집계함수(다중행 함수)
- 대상 데이터를 특정 컬럼을 기준으로 그룹분할하고 각 그룹에 대해
합계(SUM), 평균(AVG), 자료 수(COUNT), 최대값(MAX), 최소값(MIN)을 반환하는 함수
- 컬럼 같은 놈들끼리 모으는 것
- 집계 : 그룹으로 묶는 것
- 함수 : 입력값 -> 연산 -> 출력값
- 내장함수(TO_CHAR, TO_NUMBER, EXTRACT 등등 이미 오라클에 있는 것)
기술형식)
SELECT  [컬럼명1 [,]
           :
        [컬럼명n][,]
        SUM|AVG|COUNT|MAX|MIN
FROM    테이블명
[WHDERE 조건]
[GROUP BY 컬럼명1,...,컬럼명n]
[HAVING 조건]
- SELECT 절에서 집계함수만 사용된 경우에는 GROUP BY절의 사용이 필요 없음
- SELECT 절에 집계함수 이외의 컬럼이 기술된 경우(일반함수 포함) 반드시 GROUP BY절이 기술되어야 하고 
GROUP BY 다음에 모든 일반컬럼을 ','로 구분하여 기술해야 함
- SELECT 절에 사용되지 않은 컬럼도 GROUP BY 절에 사용 가능 -- 이런 경우 거의 없음
- 집계함수에 조건이 부여될 때에는 반드시 HAVING절로 조건처리를 수행해야 함 -- WHERE절 아님!
-- 각 부서별 인원 수를 조회하되, 10명 이상인 부서의 인원 수만 조회하세용~
-- COUNT함수에 조건이 부여될 때에는 WHERE절이 아닌 HAVING절을 써랏!

1) SUM(column | expr)
- 기술된 컬럼의 값이나 수식의 결과를 모두 합한 결과 반환

2) AVG

사용예)

SELECT  PROD_COST
FROM    PROD
ORDER BY    1;

SELECT  AVG(DISTINCT PROD_COST)     AS  "중복값 제외 평균",
        AVG(ALL PROD_COST)          AS  "DEFAULT", -- 모든 값을 포함",
        AVG(PROD_COST)              AS  "매입가 평균" -- 이거 많이 씀
FROM    PROD;

사용예) 상품테이블의 상품분류별 매입가격 평균 값

SELECT  PROD_LGU AS "상품 분류 코드",
        ROUND(AVG(PROD_COST), 2)    AS "매입 단가"
FROM    PROD
GROUP BY    PROD_LGU--BY : ~절 --GROUP : 묶음
ORDER BY    PROD_LGU; --ASCENING(오름차순 생략가능) / DESCENDING(내림차순)

사용예) 상품분류별 구매가격 평균

SELECT  PROD_LGU                    AS  "상품 분류 코드",
        ROUND(AVG(PROD_SALE), 2)    AS  "구매가격 평균"
FROM    PROD
GROUP BY    PROD_LGU
ORDER BY    PROD_LGU; -- 보통 GROUP BY와 같은 걸로 함

사용예) 

SELECT  PROD_LGU                    AS "상품 분류 코드",
        PROD_BUYER                  AS 거래처,
        ROUND(AVG(PROD_COST), 2)    AS "매입가 평균",
        SUM(PROD_COST)              AS "매입가 합",
        MAX(PROD_COST)              AS "최대 매입가",
        MIN(PROD_COST)              AS "최소 매입가",
        COUNT(PROD_COST)            AS "매입 횟수"
FROM    PROD
GROUP BY    PROD_LGU, PROD_BUYER -- 2차로 한 번 더 묶어라! 그래서 두 번 씀
ORDER BY    1,2;

사용예)
상품테이블(PROD)의 총 판매가격(PROD_SALE), 평균 값 구하기
Alias는 상품분류(PROD_LGU), 상품총판매가평균

SELECT  PROD_LGU                    AS  상품분류,
        SUM(PROD_SALE)              AS  "총 판매가격",
        ROUND(AVG(PROD_SALE), 2)    AS  상품총판매가평균 --30바이트까지 가능 / 한글은 한 글자 당 3바이트
FROM    PROD
GROUP BY    PROD_LGU
ORDER BY    PROD_LGU;