2022-0913-01)Ʈ����(trigger)
- Ư�� �̺�Ʈ�� �߻��Ǿ��� �� �� �̺�Ʈ �����̳� ���� �ڵ������� ����Ǵ� ���ν����� �ǹ�
- ���� ��� '�ڵ�'���� ����ǰ�, CART�� ���Եǰ�, REMAIN�� ���ó�� �ٲ��, MEMBER�� ���ϸ��� �ٲ��
- ���ν���(��ȯ�Ǵ� ���� ���� �������α׷�) VS �Լ�(��ȯ ���� �ִ�)
- �ڵ����� ����ǰ� ���� ��ȯ�� ���� �ʿ䰡 ����. �׳� �ڵ����� ����ǰ� ����Ǹ� ��.
(�������)
CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    Ʈ����Ÿ�̹�    AFTER|BEFORE �̺�Ʈ INSERT | UPDATE | DELETE -- |�� OR�� �ٲ� �� ����
    ON ���̺�� --�̺�Ʈ ���̺�! �̰� �߻��ϱ� �� �Ǵ� ��!
    [FOR EACH ROW]
    [WHEN ����] --Ʈ���Ű� �߻��Ǵ� ���ǿ��� �� �� ��ü���� ������ ���̴� ��
    [DECLARE
        �����(����, ���, Ŀ�� ����);
        ]
    BEGIN
        Ʈ���� ����; --TCL(Ŀ��, �ѹ�, ���̺�����Ʈ...) �� ��
    END;
    - Ʈ����Ÿ�̹� : Ʈ���� ������ ����� ����
        -AFTER : �̺�Ʈ�� �߻��� �� Ʈ���� ���� ���� --���� �� �̰��� EX) �����ڿ� ���� ����ó�� �� �������� ��
        -BEFORE : �̺�Ʈ�� �߻��Ǳ� �� Ʈ���� ���� ����
        --������(������̺� DELETE�� �̺�Ʈ, ������ ���� �� ����� ������ �ű��� ����. 
        --�׷��� ���� ���� ���� �����ؾ� ��. Ư���� ������ ����Ǿ����� ���� ��)
    - Ʈ���� �̺�Ʈ : Ʈ���Ÿ� ���߽�Ű�� DML������� OR�� �����ų �� ����
    INSERT OR DELETE OR UPDATE, INSERT OR UPDATE ��, Ʈ���� �Լ� INSERTING, UPDATING, DELETING ���(IF ��� �Ἥ ���� �߻��ƴ��� �� �� ����)
    -Ʈ���� ����
        -���� ���� Ʈ���� : 'FOR EACH ROW'�� ������ ���� �̺�Ʈ ���࿡ ���� ��! ��!�� Ʈ���� ����(���� ���� �̺�Ʈ�� �ִ���) 
        -�� ���� Ʈ���� : �̺�Ʈ�� ����� ���� �� ������ ������ �� �� �ึ!��! Ʈ���� ���� ���� --EX) 5�� INSERT�� �� �� ���� Ʈ���Ű� �̷����� ��
            'FOR EACH ROW' ����ؾ� ��. Ʈ���� �ǻ緹�ڵ� : OLD, NEW ��� ����
        --�ϳ��� Ʈ���Ű� �ϼ��Ǿ����� ���� �� �ٸ� Ʈ���Ű� ����Ǳ� ���� �б�Ǿ����� ���̺� ��ü �ϰ����� �ı��� ��
        --�ý��ۿ��� IMMUTABLE ���·� ����� ������ ������ �� ���� ���·� ��������
        --�ϳ��� Ʈ���Ű� �Ϸ�Ǳ� ���� �ٸ� Ʈ���Ű� �ߵ��� �� ����
        --IMMUTABLE�� ���� Ʈ���Ÿ� �� �Ⱦ���� ���� ���� Ʈ���Ÿ� ����ؾ� ��
        --SEQUENCE�� ���������� �ڽ����� �� ����ؾ� ��
        
��뿹)
�з����̺��� LPROD_ID�� 13���� �ڷḦ �����Ͻÿ�. ���� �� '�ڷᰡ �����Ǿ����ϴ�'��� �޽����� ����ϴ� Ʈ���Ÿ� �ۼ��Ͻÿ�
--�� �� ���� ���Ǳ� ������ ���� ���� Ʈ���Ű� ���Ǿ�� ��
CREATE OR REPLACE TRIGGER tg_delete_lprod
    AFTER DELETE ON LPROD
BEGIN
DBMS_OUTPUT.PUT_LINE('�ڷᰡ �����Ǿ����ϴ�.');
END;

ROLLBACK;

DELETE FROM LPROD WHERE LPROD_ID = 13;
SELECT * FROM LPROD;

DELETE FROM LPROD WHERE LPROD_ID = 13;
COMMIT;

��뿹) 2020�� 6�� 12���̶� ���� ��
��ǰ�ڵ�         ���԰���     ����
P201000019      210000      5
P201000009      28500       3
P202000012      55000       7 �� ������ ��� �̸� �������̺�(BUYPROD)�� ������ ��
���������̺��� �����ϴ� Ʈ���Ÿ� �ۼ��Ͻÿ�

CREATE OR REPLACE TRIGGER tg_buyprod_insert
    AFTER INSERT ON BUYPROD
    FOR EACH ROW
DECLARE
    V_PID PROD.PROD_ID%TYPE := (:NEW.BUY_PROD); --���Ի�ǰ�ڵ�
    V_QTY NUMBER := (:NEW.BUY_QTY); --���Լ���
BEGIN
    UPDATE  REMAIN A
    SET     A.REMAIN_I = A.REMAIN_I+V_QTY,
            A.REMAIN_J_99 = A.REMAIN_J_99 + V_QTY,
            A.REMAIN_DATE = SYSDATE
    WHERE   A.PROD_ID = V_PID;
END;
--:NEW�� ���Ӱ� UPDATE�� �� �� ���� ���ϴ� ��
    
(����)
INSERT INTO BUYPROD VALUES(SYSDATE, 'P201000019', 5, 210000);
    
(��뿹)
�����ȣ 190-194������ 5���� ����ó���Ͻÿ�
������ ������ ������̺��� �����ǰ� �ʿ� ������ ���������̺������Ͻÿ�
CREATE OR REPLACE TRIGGER tg_delete_emp
    BEFORE  DELETE  ON  EMPLOYEES
    FOR EACH ROW 
BEGIN
    INSERT INTO RETIRE(EMPLOYEE_ID, EMP_NAME, JOB_ID, HIRE_DATE, RETIRE_DATE, DEPARTMENT_ID)
    VALUES(:OLD.EMPLOYEE_ID, :OLD.EMP_NAME, :OLD.JOB_ID, :OLD.HIRE_DATE, SYSDATE, :OLD.DEPARTMENT_ID);
END;

DELETE  FROM EMPLOYEES
WHERE   EMPLOYEE_ID BETWEEN 190 AND 194;

(����)
SELECT  PROD_ID     AS  ��ǰ�ڵ�,
        PROD_NAME   AS  ��ǰ��,
        FN_SUM_BUYQTY('202002', PROD_ID)    AS  ���Լ���,
        FN_SUM_BUY('202002', PROD_ID)       AS  ���Աݾ��հ�
FROM    PROD;

��뿹)
���� �����ڷᰡ �߻��� ���� �۾��� Ʈ���ŷ� �ۼ��Ͻÿ�
    ����ȸ�� : ��ö��('k001', 5000 ����Ʈ)
    ���� ��ǰ�ڵ� : 'P2010000010' (2020 P2020000010 38 0 0 38 2020/01/01)
    ���ż��� : 5
    --���ż��� : 2
    - k001, 2020061200002, P2020000010, 2 => NEW
    --2�� ���� 8���� ����
    - k001, 2020061200002, P2020000010, 10 => NEW
    --8�� �ƴϰ� 10�� ��!
    --�̶� 2�� OLD�� ��!
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

(3�� ��ǰ)
UPDATE  CART
SET     CART_QTY = 2
WHERE   CART_NO = '2020061200002'
AND     CART_PROD = 'P202000010';

(������� : DELETE)
DELETE  FROM    CART
WHERE   CART_NO = '2020061200002'
AND     CART_PROD = 'P202000010';