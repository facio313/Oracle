2022-0823-01) 집계함수 사용 예시

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
--        SUM(PROD_SALE)              AS  "총 판매가격",
        ROUND(AVG(PROD_SALE), 2)    AS  상품총판매가평균, --30바이트까지 가능 / 한글은 한 글자 당 3바이트
        TO_CHAR(ROUND(AVG(PROD_SALE), 2), 'L9,999,999.00')
FROM    PROD
GROUP BY    PROD_LGU
ORDER BY    PROD_LGU;

사용예)
거래처테이블(BUYER)의 담당자(BUYER_CHARGER)를 컬럼으로 하여 COUNT집계 하시오.
Alias는 자료수(DISTINCT), 자료수, 자료수(*)

SELECT  COUNT(DISTINCT BUYER_CHARGER)   AS  "자료수(DISTINCT)", --"자료수(DISTINCT)"라고는 잘 안 함!
        COUNT(BUYER_CHARGER)            AS  자료수,
        COUNT(*)                        AS  "자료수(*)"
FROM    BUYER;

-- 행의 수 : 카디널리티
-- 열의 수 : 차수(DEGREE)
SELECT  COUNT(*), -- *는 ALL! 모든 행(*)의 수를 셈 ASTERISK
        COUNT(PROD_COLOR) -- COUNT 시 NULL은 숫자 안 셈
FROM    PROD;

사용예)
회원테이블(MEMBER)의 취미(MEM_LIKE)별 COUNT집계 하시오
Alias는 취미, 자료수, 자료수(*)

SELECT  MEM_LIKE        AS  취미,
        COUNT(MEM_ID)   AS  자료수, -- 기본 키로 찾는 게 좋음!! NOT NULL NO DUPLICATE
        COUNT(*)        AS  "자료수(*)" --"자료수(*)" 보통 이렇게 안 씀
FROM    MEMBER
GROUP BY    MEM_LIKE
ORDER BY    MEM_LIKE;

-- # _ $는 Alias에 들어갈 수 있음 BUT 첫 글자 XXXXX

사용예)
장바구니테이블의 회원별 최대구매수량을 검색하시오
Alias는 회원ID, 최대수량, 최소수량

SELECT  CART_MEMBER     AS  회원ID,
        MAX(CART_QTY)   AS  최대수량,
        MIN(CART_QTY)   AS  최소수량
FROM CART
GROUP BY    CART_MEMBER
ORDER BY    CART_MEMBER;

사용예)
오늘이 2020년도 7월 11일이라 가정하고 장바구니테이블(CART)에 발생될 추가 주문번호(CART_NO)를 검색하시오
Alias는 최고치주문번호 MAX(CART_NO), 추가주문번호MAX(CART_NO)+1

SELECT  MAX(CART_NO)    AS  최고치주문번호,
        MAX(CART_NO)+1  AS  추가주문번호
FROM    CART
WHERE   SUBSTR(CART_NO,1,8) = '20200711' 
AND     CART_NO LIKE '20200711%' -- LIKE와 함께 쓰인 '%(여러 글자)', '_(한 글자)' = 와일드카드
AND     CART_NO BETWEEN '202007110000' AND '202007119999';
--WHERE 세 개 다 같음!!!

사용예)
상품테이블에서 상품분류, 거래처별로 최고판매가, 최소판매가, 자료수를 검색하시오

SELECT  PROD_BUYER  AS  거래처,
        PROD_LGU    AS  상품분류,
        MAX(PROD_SALE) AS 최고판매가,
        MIN(PROD_SALE) AS 최소판매가,
        COUNT(*)    AS  자료수
FROM    PROD
GROUP BY    PROD_BUYER, PROD_LGU
ORDER BY    1;