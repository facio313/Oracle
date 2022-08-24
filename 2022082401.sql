2022-0824-01) �����Լ�
-- ~�� ==> �����Լ�
-- ~�� ����
-- ~���� �� ���� ���� ������� �׷�ȭ! ��׷�-�ұ׷�
-- SELECT���� �� ���͵� ������ ��κ� ������� ��!!!
��뿹)
��ٱ������̺��� 2020�� 5�� ��ǰ�� �Ǹ����踦 ��ȸ�Ͻÿ�.
    Alias�� ��ǰ�ڵ�, �ǸŰǼ�, �Ǹż���, �ݾ�
    
SELECT  A.CART_PROD                     AS  ��ǰ�ڵ�,
        COUNT(*)                        AS  �ǸŰǼ�,
        SUM(A.CART_QTY)                 AS  �Ǹż���,
        SUM(A.CART_QTY*B.PROD_PRICE)    AS  �ݾ�
FROM    CART A, PROD B
WHERE   A.CART_NO LIKE '202005%' -- SUBSTR(CART_NO,1,6) =   '202005'
AND     A.CART_PROD = B.PROD_ID -- īŸ ��¼�� ������µ� ���ο� ����
GROUP BY    A.CART_PROD
ORDER BY    1;
    
��뿹)
��ٱ������̺��� 2020�� 5�� ȸ���� �Ǹ����踦 ��ȸ�Ͻÿ�.
    Alias�� ȸ����ȣ, ���ż���, ���űݾ�
    
SELECT  A.CART_MEMBER                   AS  ȸ����ȣ,
        SUM(A.CART_QTY)                 AS  ���ż���,
        SUM(A.CART_QTY*B.PROD_PRICE)    AS  ���űݾ�
FROM    CART A, PROD B
WHERE   A.CART_NO LIKE '202005%'
AND     A.CART_PROD = B.PROD_ID
GROUP BY    A.CART_MEMBER
ORDER BY    1;

��뿹)
��ٱ������̺��� 2020�� ����, ȸ���� �Ǹ����踦 ��ȸ�Ͻÿ�.
    Alias�� ��, ȸ����ȣ, ���ż���, ���űݾ�
    
SELECT  SUBSTR(A.CART_NO,5,2)       AS  ��,
        A.CART_MEMBER               AS  ȸ����ȣ,
        SUM(A.CART_QTY)             AS  ���ż���,
        SUM(A.CART_QTY*B.PROD_PRICE) AS  ���űݾ�
FROM    CART A, PROD B
WHERE   SUBSTR(A.CART_NO,1,4) = '2020' --A.CART_NO   LIKE    '2020%'
AND     A.CART_PROD = B.PROD_ID
GROUP BY    SUBSTR(A.CART_NO,5,2), A.CART_MEMBER -- SUBSTR��?
ORDER BY    1;

��뿹)
��ٱ������̺��� 2020�� 5�� ��ǰ�� �Ǹ����踦 ��ȸ�ϵ� �Ǹűݾ��� 100���� �̻��� �ڷḸ ��ȸ�Ͻÿ�.
    Alias�� ��ǰ�ڵ�, �Ǹż���, �ݾ�
    
SELECT  A.CART_PROD                     AS  ��ǰ�ڵ�,
        SUM(A.CART_QTY)                 AS  �Ǹż���,
        SUM(A.CART_QTY*B.PROD_PRICE)    AS  �ݾ�
FROM    CART A, PROD B
WHERE   A.CART_NO LIKE '202005%'
AND     A.CART_PROD = B.PROD_ID
HAVING  SUM(A.CART_QTY*B.PROD_PRICE) >= 1000000 --WHERE���� �����Լ� ���� ������! �׷��Լ� ��ü�� ������ �ɾ��� ���� HAVING�����ٰ�!!
GROUP BY    A.CART_PROD
ORDER BY    A.CART_PROD;

��뿹)
2020�� ��ݱ�(1~6��) ���Ծ� ���� ���� ���� ���Ե� ��ǰ�� ��ȸ�Ͻÿ�.
    Alias�� ��ǰ�ڵ�, ���Լ���, ���Աݾ�
(1) 2020�� ��ݱ�(1~6��) ��ǰ�� ���Ծ��� ����ϰ� ���Ծ��� ���� ������ ���
    
SELECT  BUY_PROD                AS  ��ǰ�ڵ�,
        SUM(BUY_QTY)            AS  ���Լ���,
        SUM(BUY_QTY*BUY_COST)   AS  ���Աݾ� -- �����Լ������� �ߺ��� �� ���� MAX(SUM(~ (X)
FROM    BUYPROD
WHERE   BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
-- AND     ROWNUM<=5 --> ROWNUM�� ORDER BY ���� ������� ���� ���¿��� ����
-- �� �� ���� ���� ����(FROM - WHERE - GROUP BY - SELECT - ORDER BY) ������ �׷�
GROUP BY    BUY_PROD
-- HAVING SUM(BUY_QTY*BUY_COST) >= 35000000
ORDER BY    3 DESC;
-- ������� PSEUDO COLUMN�� ����(1~74) -> �� �÷����� ROWNUM
-- SUBQUERY�� WITH�� ���!

��뿹)
2020�� ��ݱ�(1~6��) ���Ծ� ���� ���� ���� ���Ե� ��ǰ 5���� ��ȸ�Ͻÿ�.
    Alias�� ��ǰ�ڵ�, ���Լ���, ���Աݾ�

SELECT  *
FROM    (SELECT     BUY_PROD    AS  ��ǰ�ڵ�,
                    SUM(BUY_QTY)AS  ���Լ���,
                    SUM(BUY_QTY*BUY_COST)   AS  ���Աݾ� 
        FROM    BUYPROD
        WHERE   BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200630')
        GROUP BY    BUY_PROD
        ORDER BY    3 DESC)
WHERE   ROWNUM <= 5;

����] ������̺��� �μ��� ��ձ޿��� ��ȸ�Ͻÿ�.

SELECT  DEPARTMENT_ID           AS  �μ��ڵ�,
        ROUND(AVG(SALARY),0)    AS  ��ձ޿�
FROM    HR.EMPLOYEES
GROUP BY    DEPARTMENT_ID
ORDER BY    1;

����] ������̺��� �μ��� ���� ���� �Ի��� ����� �����ȣ, �����, �μ���ȣ, �Ի����� ����Ͻÿ�.

SELECT  A.EMPLOYEE_ID     AS  �����ȣ,
        A.EMP_NAME        AS  �����,
        B.DEPARTMENT_ID   AS  �μ���ȣ,
        B.HDATE           AS  �Ի���
FROM    HR.EMPLOYEES A, (SELECT DEPARTMENT_ID   AS  �μ���ȣ,
                                MIN(HIRE_DATE)  AS  HDATE
                        FROM    HR.EMPLOYEES
                        GROUP BY DEPARTMENT_ID) B;
WHERE   A.DEPARTMENT_ID = B.DEPARTMENT_ID
AND     A.HIRE_DATE = B.HDATE
ORDER BY    3;

SELECT  --EMPLOYEE_ID   AS  �����ȣ,
        --EMP_NAME      AS  �����,
        DEPARTMENT_ID   AS  �μ���ȣ,
        MIN(HIRE_DATE)  AS  �Ի���
FROM    HR.EMPLOYEES
GROUP BY    DEPARTMENT_ID;

����] ������� ��ձ޿����� �� ���� �޴� ����� �����ȣ, �����, �μ���ȣ, �޿��� ����Ͻÿ�.

SELECT  AVG(SALARY) FROM    HR.EMPLOYEES;

SELECT  EMPLOYEE_ID     AS  �����ȣ,
        EMP_NAME        AS  �����,
        DEPARTMENT_ID   AS  �μ���ȣ,
        SALARY          AS  �޿�
FROM    HR.EMPLOYEES
WHERE   SALARY > (SELECT  AVG(SALARY) FROM    HR.EMPLOYEES)
ORDER BY    4 DESC;
        

����] ȸ�����̺��� ����ȸ���� ���ϸ��� �հ�� ��� ���ϸ����� ��ȸ�Ͻÿ�
    Alias�� ����, ���ϸ����հ�, ��ո��ϸ���

SELECT  CASE    WHEN    SUBSTR(MEM_REGNO2,1,1)  IN('1','3') 
                THEN    '����ȸ��'  
                ELSE    '����ȸ��'  END AS  ����,
        COUNT(*)                AS  ȸ����,
        SUM(MEM_MILEAGE)        AS  ���ϸ����հ�,
        AVG(MEM_MILEAGE)        AS  ��ո��ϸ���
FROM    MEMBER
GROUP BY    CASE    WHEN    SUBSTR(MEM_REGNO2,1,1)  IN('1','3') 
                    THEN    '����ȸ��'  
                    ELSE    '����ȸ��'  END
ORDER BY    1;