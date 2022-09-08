2022-0907-02) Stored Procedure(Procedur) --중요한가봐
- 특정 로직을 처리하여 결과 값을 반환하지 않는 서브 프로그램
- 미리 컴파일되어 저장(실행의 효율성이 좋고, 네트워크를 통해 전달되는 자료의 양이 작다)
(사용형식)
CREATE [OR REPLACE] PROCEDURE 프로시져명[(
    변수명 [IN|OUT|INOUT]  데이터타입[:=디폴트값], --크기지정하는 것 아님!!!!아니라구!
            :
    변수명 [IN|OUT|INOUT]  데이터타입[:=디폴트값], --매개변수명
IS|AS --DECLARE와 같은 부분
    선언영역
BEGIN
    실행영역 -- SQL,반복,분기
END;
- '변수명' : 매개변수명
- 'IN|OUT|INOUT' : 매개변수의 역할 정의(IN : 입력용, OUT : 출력용, INOUT : 입출력 공용)
- '데이터타입' : 크기를 기술하면 오류
- '디폴트값' : 사용자가 매개변수를 기술하고 값을 배정하지 않았을 때 자동으로 할당될 값
--함수를 내가 만들어서 내가 쓰는 것
--반환값. SELECT문에 쓸 수 있느냐 없느냐
--OUT을 통해 나온 것은 반환값이 아니라 출력값임
--반환값은 프로시져나 함수에 대해 나온 값임
--IN,OUT은 너무 무리가 커서 안 쓰는 게 좋음
--DEFAULT값도 쓰지 마렁! 정확하게 지정해 걍!
--IN,OUT,INOUT다 생략하면 IN으로 취급됨

(실행문) 독립적으로 실행할 때
EXECUTE|EXEC    프로시저명[(매개변수list)];
또는 프로시저나 다른 블록에서 실행할 경우에는
프로시저명[(매개변수list)];

사용예)
부서번호를 입력받아 해당부서 부서장의 이름, 직책, 부서명, 급여를 출력하는 프로시져를 작성하시오
CREATE OR REPLACE PROCEDURE PROC_EMP01(
    P_DID   IN   HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
IS
    V_NAME  VARCHAR2(100);
    V_JOBID HR.JOBS.JOB_ID%TYPE;
    V_DNAME VARCHAR2(100);
    V_SAL   NUMBER := 0;
BEGIN
    SELECT  B.EMP_NAME, B.JOB_ID, A.DEPARTMENT_NAME, B.SALARY
    INTO    V_NAME, V_JOBID, V_DNAME, V_SAL
    FROM    HR.DEPARTMENTS A, HR.EMPLOYEES B
    WHERE   A.DEPARTMENT_ID =   P_DID
    AND     A.MANAGER_ID    =   B.EMPLOYEE_ID;
    DBMS_OUTPUT.PUT_LINE('부서코드 : '||P_DID);
    DBMS_OUTPUT.PUT_LINE('부서장 : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('직무코드 : '||V_JOBID);
    DBMS_OUTPUT.PUT_LINE('부서명 : '|| V_DNAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||V_SAL);
    DBMS_OUTPUT.PUT_LINE('----------------------------------');
END;

(실행)
EXECUTE PROC_EMP01(60);

사용예)
연도와 월을 입력받아 해당 기간에 가장 많은 구매액을 기록한 회원정보를 조회하시오
Alias는 회원번호, 회원명, 구매액, 주소
(프로시저)
    입력 : 연도와 월(하나의 문자열로)
    처리 : CART테이블에서 최대 구매액을 기록한 회원번호, 구매액 합계
    출력 : 회원번호, 구매액 합계
CREATE OR REPLACE PROCEDURE PROC_CART01(
    P_PERIOD    IN  VARCHAR2, --연월 입력 --크기 쓰면 안 됨!!
    P_MID       OUT MEMBER.MEM_ID%TYPE, --회원번호 출력 --IN은 안 써줘도 되지만 OUT은 반드시 써줘야 함
    P_SUM       OUT NUMBER) --구매금액 합계 출력 --별도의RETURN 없어도 밖으로 나감
IS
BEGIN --제일 많이 쓴 사람이니까 SUBQUERY를 안 쓸 수 없음 -> 구매금액을 쓴 사람들을 차례대로 쭉 나열하기 위해(ORDER BY절보다 WHERE절이 먼저 실행돼서 ROWNUM을 제대로 못 활용함 ㅜ)
    SELECT  TA.CID, TA.CSUM INTO P_MID, P_SUM--SUBQUERY는 INTO 안 써도 됨
    FROM   (SELECT  A.CART_MEMBER   AS  CID,
                    SUM(A.CART_QTY*B.PROD_PRICE)    AS  CSUM
            FROM    CART A, PROD B
            WHERE   A.CART_PROD = B.PROD_ID --B테이블에서 상품가격을 갖고 오기 위해서 조인함
            AND     SUBSTR(A.CART_NO,1,6) = P_PERIOD
            GROUP   BY  A.CART_MEMBER --회원'별' 정의된 기간동안 구매금액 합계를 계산하는 것
            ORDER   BY  2 DESC) TA
    WHERE   ROWNUM = 1;        

END;
    
(실행)
    입력 : 회원번호, 구매액 합계
    처리 : MEMBER테이블에서 회원번호, 회원명, 주소
    출력 : 회원번호, 회원명, 주소, 구매액 합계

DECLARE
    V_MID   MEMBER.MEM_ID%TYPE;
    V_SUM   NUMBER := 0;
    V_NAME  MEMBER.MEM_NAME%TYPE;
    V_ADDR  VARCHAR2(100);
BEGIN
    --EXECUTE PROC_CART01('202005', V_MID, V_SUM);
    PROC_CART01('202005', V_MID, V_SUM);
    SELECT  MEM_NAME, MEM_ADD1||' '||MEM_ADD2 INTO V_NAME, V_ADDR
    FROM    MEMBER
    WHERE   MEM_ID = V_MID;
    DBMS_OUTPUT.PUT_LINE('회원번호 : '||V_MID);
    DBMS_OUTPUT.PUT_LINE('회원명 : '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('회원주소 : '||V_ADDR);
    DBMS_OUTPUT.PUT_LINE('구매금액 : '||V_SUM);
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
END;

사용예) --숙제
직업이 '자영업'인 회원번호를 입력받아 2020년 상반기(1~6월) 구매현황을 출력하는 프로시저를 작성하시오
    Alias는 회원번호, 회원명, 구매금액 합계
CREATE OR REPLACE PROCEDURE PROC_MID(
    P_MID   IN   MEMBER.MEM_ID%TYPE)
IS
    V_MID  VARCHAR2(15);
    V_MNAME VARCHAR2(20);
    V_SUM NUMBER := 0;
BEGIN
--    SELECT  B.EMP_NAME, B.JOB_ID, A.DEPARTMENT_NAME, B.SALARY
--    INTO    V_NAME, V_JOBID, V_DNAME, V_SAL
--    FROM    HR.DEPARTMENTS A, HR.EMPLOYEES B
--    WHERE   A.DEPARTMENT_ID =   P_DID
--    AND     A.MANAGER_ID    =   B.EMPLOYEE_ID;
END;



사용예)
다음 자료를 판매한 경우 매출처리를 프로시저로 작성하시오
    판매자료
    -------------------------------------------
    구매회원번호   날짜         상품코드        수량
    -------------------------------------------
    n001        2020-07-28   P102000005     3
(프로시저)
    입력 : 구매회원번호, 날짜, 상품코드, 수량
    처리 : CART테이블
    출력 : 
--프로시저에서 해봐라
1. CART테이블에 등록(CART_NO)
2. 재고 판매한 거 해줘야 함
3. 마일리지 축적해줘야 함

CREATE  OR  REPLACE PROCEDURE   PROC_CART_INPUT(
    P_MID   IN  MEMBER.MEM_ID%TYPE,
    P_DATE  IN  DATE,
    P_PID   PROD.PROD_ID%TYPE,
    P_QTY   NUMBER)
IS
    V_CART_NO   CART.CART_NO%TYPE;
    V_FLAG      NUMBER := 0;
    V_DAY       CHAR(9) := TO_CHAR(P_DATE, 'YYYYMMDD')||'%';
BEGIN
    --CART에 저장
    SELECT  COUNT(*)    INTO  V_FLAG
    FROM    CART
    WHERE   CART_NO LIKE V_DAY;
    
    IF      V_FLAG = 0  THEN
            V_CART_NO := TO_CHAR(P_DATE, 'YYYYMMDD')||TRIM('00001');
    ELSE
        SELECT  MAX(CART_NO) + 1    INTO    V_CART_NO
        FROM    CART
        WHERE   CART_NO LIKE V_DAY;
    END IF;
    
    INSERT  INTO    CART    VALUES(P_MID, V_CART_NO, P_PID, P_QTY);
    COMMIT;
    --재고 조정
    UPDATE  REMAIN  A
    SET     A.REMAIN_O = A.REMAIN_O+P_QTY, 
            A.REMAIN_J_99 = A.REMAIN_J_99 - P_QTY,
            A.REMAIN_DATE = P_DATE
    WHERE   A.PROD_ID = P_PID
    AND     A.REMAIN_YEAR = '2020';
    COMMIT;
    --마일리지 부여
    UPDATE  MEMBER  A
    SET     A.MEM_MILEAGE =(SELECT A.MEM_MILEAGE + PROD_MILEAGE * P_QTY
                            FROM    PROD B
                            WHERE   B.PROD_ID = P_PID)
    WHERE   A.MEM_ID = P_MID;
    COMMIT;
END;

--원래 마일리지 2700 추가 마일리지 1060*3 3180 누적 마일리지 5880
--수량 8 -> 5

EXECUTE PROC_CART_INPUT('n001', TO_DATE('20200728'), 'P102000005', 3);

