2022-0905-04보강) JOIN
조인의 종류
Cartessian product : 행과 열이 모두 조합되는 것 열X행
Equi join : 조인조건이 같음(집합을 합치려면 조건이 있어야 됨. 연결고리!두 집합의 공통점)
Non-equi join : 
Outer join : 
Self join : 

1) 연결고리 찾기
1-ERD를 먼저 봐라!!
2-P.K + F.K(기본키와 외래키의 조합 = 조인조건) 찾기
3-조인조건

--Cartessian product
SELECT  *
FROM    LPROD, PROD; -- 12 * 74 = 888행

SELECT  *
FROM    CART, MEMBER;

--Equi join 동등,등가,일반,내부
SELECT  *
FROM    LPROD, PROD
WHERE   LPROD_GU = PROD_LGU; -- 교집합, 연결고리, 공통점(참조)

SELECT  *
FROM    CART, MEMBER
WHERE   CART_MEMBER = MEM_ID; -- 교집합, 연결고리, 공통점(참조)



SELECT  *
FROM    CART, MEMBER, PROD
WHERE   CART_MEMBER = MEM_ID
AND     CART_PROD = PROD_ID;

--PROD : 어떤 상품이 있는데,
--BUYER : 그 상품을 납품한 업체는?
--CART : 그 상품을 누가 장바구니에 담았는가?
--MEMBER : 누가가 누구인가?
(Equi join = 내부, 일반, 동등 조인)
SELECT  B.BUYER_ID  AS  거래처번호,
        B.BUYER_NAME    AS  거래처이름,
        P.PROD_ID   AS  상품번호,
        P.PROD_NAME AS  상품명,
        C.CART_PROD AS  장바구니상품,
        C.CART_MEMBER   AS  장바구니회원,
        C.CART_QTY  AS  수량,
        M.MEM_ID    AS  회원번호,
        M.MEM_NAME  AS  회원이름
FROM    BUYER B, PROD P, CART C, MEMBER M
WHERE   B.BUYER_ID = P.PROD_BUYER
AND     P.PROD_ID = C.CART_PROD
AND     C.CART_MEMBER = M.MEM_ID -- 조인조건의 개수 = 테이블 개수 - 1

(ANSI 표준)
-FROM에 ,부터 없애기
-조인조건을 INNER JOIN 으로 ON에 넣기
-뭉탱이로 만들고 다시 INNER JOIN 만들기
SELECT  B.BUYER_ID, B.BUYER_NAME, 
        P.PROD_ID, P.PROD_NAME, 
        C.CART_PROD, C.CART_MEMBER, C.CART_QTY, 
        M.MEM_ID, M.MEM_NAME
FROM    BUYER B INNER JOIN  PROD P      ON(B.BUYER_ID = P.PROD_BUYER)
                INNER JOIN  CART C      ON(P.PROD_ID = C.CART_PROD)
                INNER JOIN  MEMBER M    ON(C.CART_MEMBER = M.MEM_ID)
WHERE   P.PROD_NAME LIKE    '%샤넬%';