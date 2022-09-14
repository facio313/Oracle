2022-0913-01)트리거(trigger)
- 특정 이벤트가 발생되었을 때 이 이벤트 이전이나 이후 자동적으로 실행되는 프로시저를 의미
- 물건 사면 '자동'으로 저장되고, CART에 삽입되고, REMAIN에 재고처리 바뀌고, MEMBER에 마일리지 바뀌고
- 프로시저(반환되는 값이 없는 서브프로그램) VS 함수(반환 값이 있다)
- 자동으로 실행되고 나면 반환할 값이 필요가 없음. 그냥 자동으로 실행되고 저장되면 끝.
(사용형식)
CREATE [OR REPLACE] TRIGGER 트리거명
    트리거타이밍    AFTER|BEFORE 이벤트 INSERT | UPDATE | DELETE -- |는 OR로 바꿀 수 있음
    ON 테이블명 --이벤트 테이블! 이게 발생하기 전 또는 후!
    [FOR EACH ROW]
    [WHEN 조건] --트리거가 발생되는 조건에서 좀 더 구체적인 조건을 붙이는 것
    [DECLARE
        선언부(변수, 상수, 커서 선언문);
        ]
    BEGIN
        트리거 본문; --TCL(커밋, 롤백, 세이브포인트...) 못 씀
    END;
    - 트리거타이밍 : 트리거 본문이 실행될 시점
        -AFTER : 이벤트가 발생된 후 트리거 본문 실행 --거의 다 이거임 EX) 퇴직자에 대한 재정처리 등 전반적인 것
        -BEFORE : 이벤트가 발생되기 전 트리거 본문 실행
        --퇴직자(사원테이블에 DELETE가 이벤트, 삭제한 다음 그 사람의 정보를 옮기지 못함. 
        --그래서 갖다 놓고 나서 삭제해야 함. 특정한 동작이 수행되어지기 전에 씀)
    - 트리거 이벤트 : 트리거를 유발시키는 DML명령으로 OR로 연결시킬 수 있음
    INSERT OR DELETE OR UPDATE, INSERT OR UPDATE 등, 트리거 함수 INSERTING, UPDATING, DELETING 사용(IF 명령 써서 뭐가 발생됐는지 알 수 있음)
    -트리거 유형
        -문장 단위 트리거 : 'FOR EACH ROW'가 생략된 경우로 이벤트 수행에 오직 한! 번!만 트리거 수행(여러 개으 이벤트가 있더라도) 
        -행 단위 트리거 : 이벤트의 결과가 복수 개 행으로 구성될 때 각 행마!다! 트리거 본문 수행 --EX) 5번 INSERT를 할 때 마다 트리거가 이뤄지는 것
            'FOR EACH ROW' 기술해야 함. 트리거 의사레코드 : OLD, NEW 사용 가능
        --하나의 트리거가 완성되어지기 전에 또 다른 트리거가 실행되기 위해 분기되어지면 테이블 전체 일관성이 파괴가 됨
        --시스템에서 IMMUTABLE 상태로 만들어 누구든 접근할 수 없는 상태로 만들어버림
        --하나의 트리거가 완료되기 전에 다른 트리거가 발동될 수 없다
        --IMMUTABLE일 때는 트리거를 다 걷어내던지 문장 단위 트리거를 사용해야 함
        --SEQUENCE와 마찬가지로 자신있을 때 사용해야 함
        
사용예)
분류테이블에서 LPROD_ID가 13번인 자료를 삭제하시오. 삭제 후 '자료가 삭제되었습니다'라는 메시지를 출력하는 트리거를 작성하시오
--딱 한 번만 사용되기 때문에 문장 단위 트리거가 사용되어야 함
CREATE OR REPLACE TRIGGER tg_delete_lprod
    AFTER DELETE ON LPROD
BEGIN
DBMS_OUTPUT.PUT_LINE('자료가 삭제되었습니다.');
END;

ROLLBACK;

DELETE FROM LPROD WHERE LPROD_ID = 13;
SELECT * FROM LPROD;

DELETE FROM LPROD WHERE LPROD_ID = 13;
COMMIT;

사용예) 2020년 6월 12일이라 했을 때
상품코드         매입가격     수량
P201000019      210000      5
P201000009      28500       3
P202000012      55000       7 을 매입한 경우 이를 매입테이블(BUYPROD)에 저장한 후
재고수불테이블을 수정하는 트리거를 작성하시오

CREATE OR REPLACE TRIGGER tg_buyprod_insert
    AFTER INSERT ON BUYPROD
    FOR EACH ROW
DECLARE
    V_PID PROD.PROD_ID%TYPE := (:NEW.BUY_PROD); --매입상품코드
    V_QTY NUMBER := (:NEW.BUY_QTY); --매입수량
BEGIN
    UPDATE  REMAIN A
    SET     A.REMAIN_I = A.REMAIN_I+V_QTY,
            A.REMAIN_J_99 = A.REMAIN_J_99 + V_QTY,
            A.REMAIN_DATE = SYSDATE
    WHERE   A.PROD_ID = V_PID;
END;
--:NEW는 새롭게 UPDATE된 저 네 개를 말하는 것
    
(실행)
INSERT INTO BUYPROD VALUES(SYSDATE, 'P201000019', 5, 210000);
    
(사용예)
사원번호 190-194번까지 5명을 퇴직처리하시오
퇴직자 정보는 사원테이블에서 삭제되고 필요 정보만 퇴직자테이블에저장하시오
CREATE OR REPLACE TRIGGER tg_delete_emp
    BEFORE  DELETE  ON  EMPLOYEES
    FOR EACH ROW 
BEGIN
    INSERT INTO RETIRE(EMPLOYEE_ID, EMP_NAME, JOB_ID, HIRE_DATE, RETIRE_DATE, DEPARTMENT_ID)
    VALUES(:OLD.EMPLOYEE_ID, :OLD.EMP_NAME, :OLD.JOB_ID, :OLD.HIRE_DATE, SYSDATE, :OLD.DEPARTMENT_ID);
END;

DELETE  FROM EMPLOYEES
WHERE   EMPLOYEE_ID BETWEEN 190 AND 194;

(실행)
SELECT  PROD_ID     AS  상품코드,
        PROD_NAME   AS  상품명,
        FN_SUM_BUYQTY('202002', PROD_ID)    AS  매입수량,
        FN_SUM_BUY('202002', PROD_ID)       AS  매입금액합계
FROM    PROD;

사용예)
다음 매출자료가 발생한 후의 작업을 트리거로 작성하시오
    구매회원 : 오철희('k001', 5000 포인트)
    구매 상품코드 : 'P2010000010' (2020 P2020000010 38 0 0 38 2020/01/01)
    구매수량 : 5
    --구매수량 : 2
    - k001, 2020061200002, P2020000010, 2 => NEW
    --2개 말고 8개로 변심
    - k001, 2020061200002, P2020000010, 10 => NEW
    --8이 아니고 10이 들어감!
    --이때 2는 OLD가 됨!
CREATE OR REPLACE TRIGGER tg_change_cart
    AFTER INSERT OR UPDATE OR DELETE ON CART
    FOR EACH ROW
DECLARE
    V_QTY NUMBER := 0;
    V_PID PROD.PROD_ID%TYPE;
    V_DATE DATE;
    V_MID MEMBER.MEM_ID%TYPE;
    V_MILE NUMBER := 0;
BEGIN
    IF INSERTING THEN
        V_QTY := (:NEW.CART_QTY);
        V_PID := (:NEW.CART_PROD);
        V_DATE := TO_DATE(SUBSTR(:NEW.CART_NO, 1, 8));
        V_MID := (:NEW.CART_MEMBER);
    ELSIF UPDATING THEN
        V_QTY := (:NEW.CART_QTY) - (:OLD.CART_QTY);
        V_PID := (:NEW.CART_PROD);
        V_DATE := TO_DATE(SUBSTR(:NEW.CART_NO, 1, 8));
        V_MID := (:NEW.CART_MEMBER);
    ELSIF DELETING THEN
        V_QTY := (:OLD.CART_QTY);
        V_PID := (:OLD.CART_PROD);
        V_DATE := TO_DATE(SUBSTR(:OLD.CART_NO, 1, 8));
        V_MID := (:OLD.CART_MEMBER);
    END IF;
    
    UPDATE  REMAIN
    SET     REMAIN_O = REMAIN_O + V_QTY,
            REMAIN_J_99 = REMAIN_J_99 - V_QTY,
            REMAIN_DATE = V_DATE
    WHERE   PROD_ID=V_PID;
    
    SELECT  V_QTY*PROD_MILEAGE INTO V_MILE
    FROM    PROD
    WHERE   PROD_ID = V_PID;
    
    UPDATE  MEMBER
    SET     MEM_MILEAGE = MEM_MILEAGE + V_MILE
    WHERE   MEM_ID = V_MID;
END;

INSERT INTO CART VALUES('k001', FN_CREATE_CARTNO(SYSDATE), 'P202000010', 5);
2022 P2020000010 38 0 5 33 2020/06/12

(3개 반품)
UPDATE  CART
SET     CART_QTY = 2
WHERE   CART_NO = '2020061200002'
AND     CART_PROD = 'P202000010';

(구매취소 : DELETE)
DELETE  FROM    CART
WHERE   CART_NO = '2020061200002'
AND     CART_PROD = 'P202000010';