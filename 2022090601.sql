2022-0906-01) PL/SQL --���Ƽ� �� �� ����. �ٸ� �ֵ� �Ͱ� ����
- ǥ�� SQL�� ������ �ִ� ����(����, �ݺ���, �б⹮ ���� ����)�� ����
- PROCEDUAL LANGUAGE SQL(������)
    -- ���ݱ��� ��� �� STRUCTURAL(������) / ����, ��� �� ���� / �ݺ���, �б⹮ �� ����
- BLOCK ������ �����Ǿ� ����
- �͸���(Anonymous Block), Stored Procedure, user defined Function, Trigger, Package ���� ������
- ���ȭ �� ĸ��ȭ ��� ���� >> �߿���!!

1. �͸���
- PL/SQL�� �⺻ ���� ����
- �̸��� ���� �����(ȣ��)�� �Ұ���

(����)
DECLARE
    �����(����, ���, Ŀ�� ����);
BEGIN
    �����:ó���� �����Ͻ� ������ �����ϱ� ���� SQL����, �ݺ���, �б⹮ ������ ����
    [EXCEPTION
        ����ó����
    ]
END;

- ���࿵������ ����ϴ� SELECT��
SELECT  �÷�list
INTO    ������[,������,...] -- �ݵ��!! ���;� �ϸ�. 
FROM    ���̺��
[WHERE  ����]
    **** �÷��� ������ ������ Ÿ���� INTO�� ������ ���� �� ������ Ÿ�԰� ���� ****
-- �÷��� �� ������ �ٸ����� ������ �ϳ��ۿ� �� ����
SELECT  EMP_NAME INTO NAME -- EMP_NAME �÷��� 5���� ������ NAME�̶� ������ �ϳ��ۿ� �� ����... -> �̷��� ���� �� Ŀ��!
FROM    HR.EMPLOYEES
WHERE   DEPARTMENT_ID = 60

1) ����
- ���� ����� ������ ���� ����
- SCLAR����, REFERENCE ����, COMPOSITE ����, BINDING ���� ���� ����
--BINDING : �����Ұ� ���õǰ� �� ��ҿ� ���� ����ִ� �Ű�����(���� �����ϴ� ����)
--IN, OUT, INOUT(�Է�, ���, �����)������ �ݵ�� �������� ��
(�������)
������ [CONSTANCT] ������Ÿ��[(ũ��)] [:=�ʱⰪ];
- ������Ÿ�� : SQL���� �����ϴ� ������ Ÿ��, PLS_INTEGER, BINARY_INTEGER, BOOLEAN(T/F/N) ���� ������
- 'CONSTANT' = ��� ����(�ݵ�� �ʱⰪ�� �����Ǿ�� ��) -- ����� = ���ʿ� �� ��

** REFERENCE ����
    ������ ���̺��.�÷���%TYPE
    ������ ���̺��%ROWTYPE -- ��ü �� ���� --> ��.���� Ư�� ���� ���� ������ �� ����
    --  a.CART_NUMBER�� ���� ��� ����
��뿹)
Ű����� �μ��� �Է¹޾� �ش� �μ��� ���� ���� �Ի��� ����� --1�� ����ϰԵ�!
�����ȣ, �����, ��å�ڵ�, �Ի����� ����Ͻÿ�
ACCEPT  P_DID   PROMPT  '�μ���ȣ �Է� : '
DECLARE
    V_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE;
    V_EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE; -- �����ȣ
    V_NAME VARCHAR2(100); -- �����
    V_JID HR.JOBS.JOB_ID%TYPE; -- ��å�ڵ�
    V_HADTE DATE; -- �Ի���
BEGIN
    V_DID := ('&P_DID');
    --�Ľ�Į���� :=�� �����(�ڹٿ��� =)
    SELECT  EMPLOYEE_ID, EMP_NAME, JOB_ID, HIRE_DATE
    INTO    V_EID, V_NAME, V_JID, V_HDATE
    FROM    HR.EMPLOYEES
    WHERE   DEPARTMENT_ID = V_DID
    ORDER BY 4) A    
AND ROWNUM = 1
    DBMS_OUTPUT.PUT_LINE('�����ȣ: '||V_ERD);--Sysout�� ���� ��
    DBMS_OUTPUT.PUT_LINE('�����: '||V_NAME);
    DBMS_OUTPUT.PUT_LINE('��å�ڵ�: '||V_JID);
    DBMS_OUTPUT.PUT_LINE('�Ի���: '||V_HDATE())
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
END;

��뿹) ȸ�����̺��� ������ '�ֺ�'�� ȸ������ 2020�� 5�� ������Ȳ�� ��ȸ�Ͻÿ�
    Alias�� ȸ����ȣ, ȸ����, ����, ���ű޾��հ�
SELECT  A.MEM_ID    AS  ȸ����ȣ,
        A.MEM_NAME  AS  ȸ����,
        A.MEM_JOB   AS  ����,
        D.BSUM      AS  ���űݾ��հ�
FROM   (SELECT  MEM_ID, MEM_NAME,   MEM_JOB
        FROM    MEMBER
        WHERE   MEM_JOB = '�ֺ�') A,
       (SELECT  B.CART_MEMBER   AS BMID,
                SUM(B.CART_QTY * C.PROD_PRICE)  AS BSUM
        FROM    CART B, PROD C
        WHERE   B.CART_PROD = C.PROD_ID
        AND     B.CART_NO LIKE '202005%'
        GROUP   BY  B.CART_MEMBER)D
WHERE   A.MEM_ID = D.BMID;

(�͸���)
DECLARE
    V_MID   MEMBER.MEM_ID%TYPE;
    V_NAME  VARCHAR2(100);
    V_JOB   MEMBER.MEM_JOB%TYPE;
    V_SUM   NUMBER := 0;
    CURSOR  CUR_MEM IS
        SELECT  MEM_ID, MEM_NAME,   MEM_JOB
        FROM    MEMBER
        WHERE   MEM_JOB = '�ֺ�';
BEGIN
    OPEN    CUR_MEM; --Ŀ���� ����ϱ� ���ؼ� ����
    LOOP
        FETCH   CUR_MEM  INTO    V_MID, V_NAME, V_JOB;
        EXIT WHEN CUR_MEM%NOTFOUND;
        SELECT  SUM(A.CART_QTY * B.PROD_PRICE)  INTO    V_SUM
        FROM    CART A, PROD B
        WHERE   A.CART_PROD = B.PROD_ID
        AND     A.CART_NO   LIKE    '202005%'
        AND     A.CART_MEMBER = V_MID;
        DBMS_OUTPUT.PUT_LINE('ȸ����ȣ : '||V_MID);
        DBMS_OUTPUT.PUT_LINE('ȸ���� : '||V_NAME);
        DBMS_OUTPUT.PUT_LINE('���� : '||V_JOB);
        DBMS_OUTPUT.PUT_LINE('���űݾ� : '||V_SUM);
        DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    END LOOP;
    CLOSE CUR_MEM;
END;

    --�� �ڸ����� �𸣸� NUMBER�� ��. 27�ڸ������� �� �˾Ƽ� �����. BUT �ݵ�� �ʱ�ȭ�ؾ� ��    
    --CURSOR�� VIEW�� �����
    --CURSOR�� ����ϴ� ���� : �������� �ϳ��� ���� �� �ִµ� �÷��� ���� ���� ������ ��
    --FETCH : �� �� �� ���� �о���� ��

��뿹)
�⵵�� �Է¹޾� �������� ������� �����ϴ� ����� �ۼ��Ͻÿ�
ACCEPT  P_YEAR  PROMPT  '�⵵�Է� : '
DECLARE
    V_YEAR  NUMBER := TO_NUMBER('&P_YEAR');
    V_RES   VARCHAR2(200);
BEGIN
    IF      (MOD(V_YEAR, 4) = 0 AND MOD(V_YEAR, 100) != 0) OR (MOD(V_YEAR, 400) = 0)
    THEN    V_RES := V_YEAR||'���� �����Դϴ�.';
    ELSE    V_RES := V_YEAR||'���� ����Դϴ�.';
    END IF;
    DBMS_OUTPUT.PUT_LINE(V_RES);
END;

��뿹)
�������� �Է¹޾� ���� ���̿� �ѷ��� ���Ͻÿ�
���� ���� : ������ * ������ * ������(3.1415926)
���ѷ� : ���� * 3.1415926
ACCEPT  P_RADIUS  PROMPT  '������ : '
DECLARE
    V_RADIUS    NUMBER := TO_NUMBER('&P_RADIUS');
    V_PI        CONSTANT NUMBER := 3.1415926;
    V_AREA      NUMBER := 0;
    V_CIRCUM    NUMBER := 0;
BEGIN
    V_AREA      := V_RADIUS * V_RADIUS * V_PI;
    V_CIRCUM    := V_RADIUS * 2 * V_PI;
    DBMS_OUTPUT.PUT_LINE('���� ���� = '||V_AREA);
    DBMS_OUTPUT.PUT_LINE('���� �ѷ� = '||V_CIRCUM);
END;