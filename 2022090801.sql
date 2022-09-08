2022-0908-01)�Լ�(User Defined Function : Function)
- ���� �� Ư¡�� ���ν����� ����
- ���ν����� �������� ��ȯ ���� ������
(SELECT ���� SELECT��, WHERE��, UPDATE �� DELETE, INSERT ���� �������� ��� ����)

(�������)
CREATE [OR REPLACE] FUNCTION �Լ���[(
    ������ [IN|OUT|INOUT] ������Ÿ��[:=����Ʈ��],
                :
    ������ [IN|OUT|INOUT] ������Ÿ��[:=����Ʈ��],
    RETURN Ÿ�Ը� --Ÿ�Ը� �� �� ����! �����ݷ�(;) �� �� => ��ȯ�Ǿ����� ������ Ÿ���� ����!�� �˷���
IS|AS
    ���𿵿�
BEGIN
    ���࿵��
    RETURN expr; --�� Ÿ�԰� ���� Ÿ���̾�� ��
END;
- ���࿵���� �ݵ�� �ϳ� �̻��� RETURN���� �����ؾ� ��

��뿹)
������ 2020�� 5�� 17���̶�� �����ϰ� ���� ��¥�� �Է¹޾� ��ٱ��Ϲ�ȣ�� �����ϴ� �Լ��� �����Ͻÿ�.
�Է� : ���� ��¥ SYSDATE!
��� : ��ȯ���� ���� ��ٱ��� ��ȣ

--CART_NO ����� �Լ�
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

(����) ���� �ڷḦ CART���̺� �����Ͻÿ�
    ����ȸ�� : 'j001'
    ���Ż�ǰ : 'P201000012'
    ���ż��� : 5
    �������� : ����
INSERT  INTO    CART(CART_MEMBER, CART_NO, CART_PROD, CART_QTY)
VALUES('j001', FN_CREATE_CARTNO(SYSDATE), 'P201000012', 5);

��뿹)
������ ��(�Ⱓ)�� ��ǰ��ȣ�� �Է¹޾� �ش� �Ⱓ�� �߻��� ��ǰ�� �������踦 ��ȸ�Ͻÿ�
Alias�� ��ǰ��ȣ, ��ǰ��, ���Լ���, ���Աݾ�
--outer������ ��Ű�� �ʾƵ� ���� ������ �ϰ� ���� �� �ִ�
--���Լ���, ���Աݾ� ���ε���
--�Է�: ��ǰ��ȣ,
(���Լ���)
CREATE  OR  REPLACE FUNCTION    FN_SUM_BUYQTY(
    P_PERIOD    IN  CHAR,
    P_PID       IN  VARCHAR2)
    RETURN  NUMBER
IS
    V_SUM   NUMBER := 0; --��������
    V_SDATE DATE := TO_DATE(P_PERIOD||'01');
    V_EDATE DATE := LAST_DAY(V_SDATE); --LAST_DAY �־��� �Ű������� �ִ� ���� ������ ��¥�� ��ȯ����
BEGIN
    SELECT  NVL(SUM(BUY_QTY),0) INTO    V_SUM
    FROM    BUYPROD
    WHERE   BUY_DATE    BETWEEN V_SDATE AND V_EDATE
    AND     BUY_PROD = P_PID; --�����Լ� ��µ� GROUP BY �� �ᵵ �ǳ�?
    RETURN  V_SUM;
END;

(����)
SELECT  PROD_ID     AS  ��ǰ�ڵ�,
        PROD_NAME   AS  ��ǰ��,
        FN_SUM_BUYQTY('202002', PROD_ID)    AS  ���Լ���
FROM    PROD;

(���Աݾ�)
CREATE  OR  REPLACE FUNCTION    FN_SUM_BUYCOST(
    P_PERIOD    IN  CHAR,
    P_PID       IN  VARCHAR2)
    RETURN  NUMBER
IS
    V_SUM   NUMBER := 0; --���Աݾ�
    V_SDATE DATE := TO_DATE(P_PERIOD||'01');
    V_EDATE DATE := LAST_DAY(V_SDATE); --LAST_DAY �־��� �Ű������� �ִ� ���� ������ ��¥�� ��ȯ����
BEGIN
    SELECT  NVL(SUM(BUY_QTY*BUY_COST),0) INTO    V_SUM
    FROM    BUYPROD
    WHERE   BUY_DATE    BETWEEN V_SDATE AND V_EDATE
    AND     BUY_PROD = P_PID; --�����Լ� ��µ� GROUP BY �� �ᵵ �ǳ�?
    RETURN  V_SUM;
END;

(����)
SELECT  PROD_ID     AS  ��ǰ�ڵ�,
        PROD_NAME   AS  ��ǰ��,
        FN_SUM_BUYQTY('202002', PROD_ID)    AS  ���Լ���,
        FN_SUM_BUYCOST('202002', PROD_ID)    AS  ���Աݾ�
FROM    PROD;

(�� �ٷ�)
CREATE  OR  REPLACE FUNCTION    FN_SUM_BUY(
    P_PERIOD    IN  CHAR,
    P_PID       IN  VARCHAR2)
    RETURN  CHAR
IS
    V_RES   CHAR(100);    
    V_SDATE DATE := TO_DATE(P_PERIOD||'01');
    V_EDATE DATE := LAST_DAY(V_SDATE); --LAST_DAY �־��� �Ű������� �ִ� ���� ������ ��¥�� ��ȯ����
BEGIN
    SELECT  NVL(SUM(BUY_QTY), 0)||', '||NVL(SUM(BUY_QTY*BUY_COST),0)    INTO    V_RES
    FROM    BUYPROD
    WHERE   BUY_DATE    BETWEEN V_SDATE AND V_EDATE
    AND     BUY_PROD = P_PID; --�����Լ� ��µ� GROUP BY �� �ᵵ �ǳ�?
    RETURN  V_RES;
END;

(����)
SELECT  PROD_ID     AS  ��ǰ�ڵ�,
        PROD_NAME   AS  ��ǰ��,
        FN_SUM_BUY('202002', PROD_ID)    AS  "���Լ���, �ݾ�"
FROM    PROD;