2022-0809-01)������
 1. ����(��) ������
 - �ڷ��� ��Ұ��踦 ���ϴ� �����ڷ� ����� ��(true)�� ����(false)�� ��ȯ --> ���ڷ� ��Ÿ���� �� �ƴ�
 - >,<,>=,<=,=,!= (<>���� �ʴ� - �ٸ� ������ ><�� ��)
 - ǥ���� ( CASE WHEN ~ THEN, DECODE)�̳� WHERE �������� ���
 
��뿹) ȸ�����̺�(MEMBER)���� ��� ȸ������ ȸ����ȣ, ȸ����, ����, ���ϸ����� ��ȸ�ϵ� ���ϸ����� ���� ȸ������ ��ȸ�Ͻÿ�.
--SORT ����? ������ -> ORDER BY
 SELECT MEM_ID AS ȸ����ȣ,
        MEM_NAME AS ȸ����,
        MEM_JOB AS ����,
        MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   --ORDER BY MEM_MILEAGE DESC;
   ORDER BY 4 DESC; -- ���� ������ �÷��� ��� ������ �Ἥ �ִ� �� ����!!
   


**EMPLOYEES ���̺� ���ο� �÷�(EMP_NAME), ������Ÿ���� VARCHAR2(80)�� �÷��� �߰�
    ALTER TABLE ���̺�� ADD (�÷��� ������Ÿ��[(ũ��)] [DEFAULT ��])
    ALTER TABLE EMPLOYEES ADD (EMP_NAME VARCHAR2(80));

���ο� �� INSERT INTO -> �� ��(Ʃ��)�� ��
�ִ� �� UPDATE -> �ִ� �ڷῡ�� �߰���

**UPDATE �� => ����� �ڷḦ ������ �� ���
(�������)
    UPDATE ���̺��
       SET �÷��� = ��[,]
           �÷��� = ��[,]
                :
           �÷��� = ��[,]
    [WHERE ����] --���� �� ��� ���� ���� ������ ����
    
    -- �ٸ� ���� ���̺��� ���� �ʹٸ�(�����ϰ� �ʹٸ�) "�ٸ�������.���̺�"

ROLLBACK;    
    UPDATE HR.EMPLOYEES
       SET EMP_NAME=FIRST_NAME||' '||LAST_NAME;
       -- 107�� �� �ؾ� �Ǵϱ� WHERE �� �ʿ� ����
       --"||" �ڹٿ��� "+"�� ���� ���ڸ� �� �� ����
       
SELECT EMPLOYEE_ID,
       EMP_NAME
    FROM EMPLOYEES;   
    
��뿹) ������̺�(HR.EMPLOYEES) �μ���ȣ�� 50���� ������� ��ȸ�Ͻÿ�.
    Alias�� �����ȣ, �����, �μ���ȣ, �޿��̴�.
    
SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �����,
       DEPARTMENT_ID AS �μ���ȣ,
       SALARY AS �޿�
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID=50;

��뿹) ȸ�����̺�(MEMVER)���� ������ �ֺ��� ȸ������ �����Ͻÿ�.
    Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ����̴�.

SELECT MEM_ID AS ȸ����ȣ,
       MEM_NAME AS ȸ����,
       MEM_JOB AS ����,
       MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
    WHERE MEM_JOB = '�ֺ�';
    
2. ���������
 - '+', '-', '*', '/' => 4Ģ ������ -- ���������� ����, ������ �����ڵ� ����(�Լ��� �� --> remainder) // infix/prefix/postfix
 - () : ������ �켱���� ����
 
��뿹) ������̺�(HR.EMPLOYEES)���� ���ʽ��� ����ϰ� ���޾��� �����Ͽ� ����Ͻÿ�
        ���ʽ�=����*���������� 30%
        ���޾�=����+���ʽ�
        Alias�� �����ȣ, �����, ����, ��������, ���ʽ�, ���޾�
        ��� ���� ���� �κи� ���
    --DEFAULT INITIAL VALUE
    --ǥ�� SQL�� ���� ���� �Ұ�
    
SELECT EMPLOYEE_ID AS �����ȣ, 
       EMP_NAME AS �����,
    -- FIRST_NAME||' '||LAST_NAME AS �����,
       SALARY AS ����,
       COMMISSION_PCT AS ��������,
       NVL(ROUND(SALARY * COMMISSION_PCT*0.3),0) AS ���ʽ�,
    -- ROUND() �Ҽ��� ù° �ڸ� �ݿø� /TRUNC --> ���� �� ������ ����
    -- NVL�� ����, �������� ���� �� �׳� ������ ����
       SALARY + NVL(ROUND(SALARY * COMMISSION_PCT*0.3),0) AS ���޾�
    -- ������ �� �Ἥ �̰��� �ٽ� ����� ��
    FROM HR.EMPLOYEES;
    -- NULL ���� ���꿡 ���Ǹ� �� �͵� ���� NULL ������ ��ȯ��
    
3. ��������
 - �� �� �̻��� ������� ����(AND, OR)�ϰų� ����(NOT) ��� ��ȯ
 - NOT(������), AND(����), OR(����)
 ---------------------------------
     �Է�       ���
    A    B     OR  AND
----------------------------------
    0    0     0    0
    0    1     1    0
    1    0     1    0
    1    1     1    1
��뿹) ��ǰ���̺�(PROD)���� �ǸŰ����� 30���� �̻��̰� ������� 5�� �̻��� ��ǰ�� 
        ��ǰ��ȣ, ��ǰ��, ���԰�, �ǸŰ��� ��ȸ�Ͻÿ�.

    SELECT PROD_ID    AS ��ǰ��ȣ,
           PROD_NAME  AS ��ǰ��,
           PROD_COST  AS ���԰�,
           PROD_PRICE AS �ǸŰ�
      FROM PROD
     WHERE PROD_PRICE >= 300000
       AND PROD_PROPERSTOCK >= 5
  ORDER BY 4;

��뿹) �������̺�(BUYPROD)���� �������� 2020�� 1���̰� ���Լ����� 10�� �̻���  ���������� ��ȸ�Ͻÿ�.
        Alias�� ������, ���Ի�ǰ, ���Լ���, ���Աݾ�

    SELECT BUY_DATE AS ������,
           BUY_PROD AS ���Ի�ǰ,
           BUY_QTY  AS ���Լ���,
           BUY_QTY*BUY_COST AS ���Աݾ�
      FROM BUYPROD
     WHERE BUY_DATE>=TO_DATE('20200101')
       AND BUY_DATE<=TO_DATE('20200131')
       AND BUY_QTY >= 10
  ORDER BY 1;
       --���ڿ��� HIERARCHY�� ���� ��¥-���ڿ� -> ��¥�� ��
       --TO_DATE('') ��¥�� ��ȯ�ϼ��� () �ȿ� �� '' ���ڷ� �־�� ��? ���ڴ�? �� �� => ���ڸ� ��¥�� �ٲٴ� ������!!
       --TO_DATE('20200101')<=BUY_DATE<=TO_DATE('20200131') => �̰� �� ��!!!!!!!

��뿹) ȸ�����̺��� ���ɴ밡 20���̰ų�  ���� ȸ���� ��ȸ�Ͻÿ�.
        Alias�� ȸ����ȣ, ȸ����, �ֹι�ȣ, ���ϸ���
        
    SELECT MEM_ID      AS ȸ����ȣ,
           MEM_NAME    AS ȸ����,
           MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
           TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1) AS ���ɴ�,
           MEM_MILEAGE AS ���ϸ���
      FROM MEMBER
     WHERE TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)=20
        OR SUBSTR(MEM_REGNO2,1,1) IN ('2','4');
        --SUBSTR() ���� ���� IN() ~�ȿ� ���Ե� /�Ǵ�/ 
        --SUBSTR(MEM_REGNO02,1,1)='2'
        --SUBSTR(MEM_REGNO02,1,1)='4'
        --SUBSTR(MEM_REGNO02,1,1)='2' OR SUBSTR(MEM_REGNO02,1,1)='4'
        --TRUNC( ,-1) == ���� �ڸ��� ������ => 20�� ����

        --case when(?)
��뿹) ȸ�����̺��� ���ɴ밡 20���̰ų� ���� ȸ���̸鼭 ���ϸ����� 2000�̻��� ȸ���� ��ȸ�Ͻÿ�.
        Alias�� ȸ����ȣ, ȸ����, �ֹι�ȣ, ���ϸ���
        
    SELECT MEM_ID      AS ȸ����ȣ,
           MEM_NAME    AS ȸ����,
           MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
           TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1) AS ���ɴ�,
           MEM_MILEAGE AS ���ϸ���
      FROM MEMBER
     WHERE TRUNC(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR),-1)=20
        OR SUBSTR(MEM_REGNO2,1,1) IN ('2','4')
       AND MEM_MILEAGE>=2000;
       
��뿹) Ű����� �⵵�� �Է¹޾� ����� ����� �Ǵ��Ͻÿ�.
        ���� : 4�� ����̸鼭 100�� ����� �ƴϰų�, �Ǵ� 400�� ����� �Ǵ� �⵵
    ACCEPT P_YEAR PROMPT '�⵵�Է�: '
    DECLARE
        V_YEAR NUMBER:=TO_NUMBER('&P_YEAR');
        V_RES VARCHAR2(100);
    BEGIN
        IF  (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0) OR (MOD(V_YEAR,400)=0) THEN -- MOD : ������ ���
            V_RES:=TO_CHAR(V_YEAR)||'�⵵�� �����Դϴ�.';
        ELSE
            V_RES:=TO_CHAR(V_YEAR)||'�⵵�� ����Դϴ�.';
        END IF;
        DBMS_OUTPUT.PUT_LINE(V_RES);
    END;