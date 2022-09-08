2022-0908-01)함수(User Defined Function : Function)
- 목적 및 특징은 프로시저와 유사
- 프로시저와 차이점은 반환 값이 존재함
(SELECT 문의 SELECT절, WHERE절, UPDATE 및 DELETE, INSERT 문의 조건절에 사용 가능)

(사용형식)
CREATE [OR REPLACE] FUNCTION 함수명[(
    변수명 [IN|OUT|INOUT] 데이터타입[:=디폴트값],
                :
    변수명 [IN|OUT|INOUT] 데이터타입[:=디폴트값],
    RETURN 타입명 --타입명만 올 수 있음! 세미콜론(;) 안 옴 => 반환되어지는 데이터 타입이 뭐다!만 알려줌
IS|AS
    선언영역
BEGIN
    실행영역
    RETURN expr; --위 타입과 같은 타입이어야 함
END;
- 실행영역에 반드시 하나 이상의 RETURN문이 존재해야 함

사용예)
오늘이 2020년 5월 17일이라고 가정하고 오늘 날짜를 입력받아 장바구니번호를 생성하는 함수를 생성하시오.
입력 : 오늘 날짜 SYSDATE!
출력 : 반환해줄 값은 장바구니 번호

--CART_NO 만들기 함수
CREATE  OR  REPLACE FUNCTION    FN_CREATE_CARTNO(P_DATE  IN  DATE)
    RETURN  CHAR
IS
    V_CARTNO    CART.CART_NO%TYPE;
    V_FLAG      NUMBER := 0;
    V_DAY       CHAR(9) := TO_CHAR(P_DATE, 'YYYYMMDD')||TRIM('%');
BEGIN
    SELECT      COUNT(*)    INTO    V_FLAG
    FROM        CART
    WHERE       CART_NO     LIKE    V_DAY;
    
    IF          V_FLAG = 0  THEN
                V_CARTNO := TO_CHAR(P_DATE, 'YYYYMMDD')||TRIM('00001');
    ELSE
                SELECT  MAX(CART_NO) + 1    INTO    V_CARTNO
                FROM    CART
                WHERE   CART_NO LIKE    V_DAY;
    END IF;
    
    RETURN      V_CARTNO;
END;

(실행) 다음 자료를 CART테이블에 저장하시오
    구매회원 : 'j001'
    구매상품 : 'P201000012'
    구매수량 : 5
    구매일자 : 오늘
INSERT  INTO    CART(CART_MEMBER, CART_NO, CART_PROD, CART_QTY)
VALUES('j001', FN_CREATE_CARTNO(SYSDATE), 'P201000012', 5);

사용예)
연도와 월(기간)과 상품번호를 입력받아 해당 기간에 발생된 상품별 매입집계를 조회하시오
Alias는 상품번호, 상품명, 매입수량, 매입금액
--outer조인을 시키지 않아도 같은 역할을 하게 만들 수 있다
--매입수량, 매입금액 따로따로
--입력: 상품번호,
(매입수량)
CREATE  OR  REPLACE FUNCTION    FN_SUM_BUYQTY(
    P_PERIOD    IN  CHAR,
    P_PID       IN  VARCHAR2)
    RETURN  NUMBER
IS
    V_SUM   NUMBER := 0; --수량집계
    V_SDATE DATE := TO_DATE(P_PERIOD||'01');
    V_EDATE DATE := LAST_DAY(V_SDATE); --LAST_DAY 주어진 매개변수에 있는 월의 마지막 날짜를 반환해줌
BEGIN
    SELECT  NVL(SUM(BUY_QTY),0) INTO    V_SUM
    FROM    BUYPROD
    WHERE   BUY_DATE    BETWEEN V_SDATE AND V_EDATE
    AND     BUY_PROD = P_PID; --집계함수 썼는데 GROUP BY 안 써도 되나?
    RETURN  V_SUM;
END;

(실행)
SELECT  PROD_ID     AS  상품코드,
        PROD_NAME   AS  상품명,
        FN_SUM_BUYQTY('202002', PROD_ID)    AS  매입수량
FROM    PROD;

(매입금액)
CREATE  OR  REPLACE FUNCTION    FN_SUM_BUYCOST(
    P_PERIOD    IN  CHAR,
    P_PID       IN  VARCHAR2)
    RETURN  NUMBER
IS
    V_SUM   NUMBER := 0; --매입금액
    V_SDATE DATE := TO_DATE(P_PERIOD||'01');
    V_EDATE DATE := LAST_DAY(V_SDATE); --LAST_DAY 주어진 매개변수에 있는 월의 마지막 날짜를 반환해줌
BEGIN
    SELECT  NVL(SUM(BUY_QTY*BUY_COST),0) INTO    V_SUM
    FROM    BUYPROD
    WHERE   BUY_DATE    BETWEEN V_SDATE AND V_EDATE
    AND     BUY_PROD = P_PID; --집계함수 썼는데 GROUP BY 안 써도 되나?
    RETURN  V_SUM;
END;

(실행)
SELECT  PROD_ID     AS  상품코드,
        PROD_NAME   AS  상품명,
        FN_SUM_BUYQTY('202002', PROD_ID)    AS  매입수량,
        FN_SUM_BUYCOST('202002', PROD_ID)    AS  매입금액
FROM    PROD;

(한 줄로)
CREATE  OR  REPLACE FUNCTION    FN_SUM_BUY(
    P_PERIOD    IN  CHAR,
    P_PID       IN  VARCHAR2)
    RETURN  CHAR
IS
    V_RES   CHAR(100);    
    V_SDATE DATE := TO_DATE(P_PERIOD||'01');
    V_EDATE DATE := LAST_DAY(V_SDATE); --LAST_DAY 주어진 매개변수에 있는 월의 마지막 날짜를 반환해줌
BEGIN
    SELECT  NVL(SUM(BUY_QTY), 0)||', '||NVL(SUM(BUY_QTY*BUY_COST),0)    INTO    V_RES
    FROM    BUYPROD
    WHERE   BUY_DATE    BETWEEN V_SDATE AND V_EDATE
    AND     BUY_PROD = P_PID; --집계함수 썼는데 GROUP BY 안 써도 되나?
    RETURN  V_RES;
END;

(실행)
SELECT  PROD_ID     AS  상품코드,
        PROD_NAME   AS  상품명,
        FN_SUM_BUY('202002', PROD_ID)    AS  "매입수량, 금액"
FROM    PROD;