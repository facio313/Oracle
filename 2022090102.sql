2022-0901-02)���տ�����
- SELECT���� ����� ������� ���տ��� ����
- UNION ALL, UNION, INTERSECT, MINUS ������ ����
- ���տ����ڷ� ����Ǵ� SELECT���� �� SELECT���� �÷��� ������ ������ Ÿ���� ��ġ�ؾ���
- ORDER BY���� �� ������ SELECT������ ��� ����
- BLOB, CLOB, BFILE Ÿ���� �÷��� ���տ����ڸ� ����� �� ����
- UNION, INTERSECT, MINUS�����ڴ� LONGŸ���� �÷��� ����� �� ����
- GROUPING SETS(col1,col2,...) => UNION ALL ������ ���Ե� ����
   ex) GROUPING SETS(col1,col2,col3)
   =>((GROUP BY Col1) UNION ALL (GROUP BY col2) UNION ALL (GROUP BY col3)) 

1)UNION ALL
- �ߺ��� ����� �������� ����� ��ȯ

��뿹) ȸ�����̺��� ������ �ֺ��� ȸ���� ���ϸ����� 3000�̻��� ��� ȸ������
ȸ����ȣ, ȸ����, ����, ���ϸ����� ��ȸ�Ͻÿ�.
-- �ֺα׷�� ���ϸ��� 3000�׷�
--> �� �� �������� ��. �� �� ����ϴ� ���� UNION ALL
SELECT  MEM_ID      AS  ȸ����ȣ, --> ù ��° ��Ī�� ��ü ��Ī�� ��
        MEM_NAME    AS  ȸ����,
        MEM_JOB     AS  ����,
        MEM_MILEAGE AS  ���ϸ���
FROM    MEMBER
WHERE   MEM_JOB = '�ֺ�' 
UNION   ALL
SELECT  MEM_ID,
        MEM_NAME,
        MEM_JOB,
        MEM_MILEAGE
--      TO_NUMBER(MEM_REGNO1) -- ������ Ÿ�Ը� ���Ƶ� ����� ��. ��! ��Ȯ�� ���� �ƴ�
--      MEM_REGNO01 -- ������! -> Ÿ���� �޶� �׷�. MEM_REGNO1�� CHAR
FROM    MEMBER
WHERE   MEM_MILEAGE>=3000;

WITH    T1 AS
        (SELECT DISTINCT    DEPARTMENT_ID
        FROM    HR.EMPLOYEES
        UNION   ALL
        SELECT  COUNT(*)    AS  CNT
        FROM    HR.EMPLOYEES
        GROUP BY    DEPARTMENT_ID
        UNION   ALL
        SELECT  COUNT(*)    AS  TCNT
        FROM    HR.EMPLOYEES)
SELECT  (SELECT DEPARTMENT_ID
        FROM    HR.DEPARTMENTS B)   AS  �μ��ڵ�,
        (SELECT DEPARTMENT_NAME
        FROM    HR.DEPARTMENTS B)   AS  �μ���,    
        T1.CNT  AS  ������
FROM    T1
ORDER BY    1;

��뿹) 2020�� 4,5,6,7�� ���ž��� ���� ���� ȸ������ ȸ����ȣ, ȸ����, ���űݾ��հ踦 ��ȸ�Ͻÿ�
(WITH���� ����� ���)
WITH    T1  AS --VIEWER�� �����. ����� ���� �̸��� �ٿ����� ��!
--T1���̺��� ���� �ƹ� ���� ����� �� ����
--�ƽ��� ���̸� ������ SUM�Լ� �տ� ���� �ؼ� �� ��
        (SELECT '4��' AS MON,
                C.MEM_ID AS CID,
                C.MEM_NAME AS CNAME,  
                D.TOT1 AS CTOT1
        FROM    (SELECT A.CART_MEMBER AS AMID,
                        SUM(A.CART_QTY*B.PROD_PRICE)    AS  TOT1
                FROM    CART A, PROD B
                WHERE   A.CART_NO   LIKE    '202004%'
                AND     A.CART_PROD=B.PROD_ID
                GROUP BY    A.CART_MEMBER
                ORDER BY    2   DESC) D, MEMBER C
        WHERE   C.MEM_ID=D.AMID
        AND     ROWNUM=1 -- ORDER BY�� ����� �� ���;� 1���� ���� �� ����!
UNION ALL -- UNION�� �ᵵ ��
        SELECT '5��' AS MON,
                C.MEM_ID AS CID,
                C.MEM_NAME AS CNAME,  
                D.TOT1 AS CTOT1
        FROM    (SELECT A.CART_MEMBER AS AMID,
                        SUM(A.CART_QTY*B.PROD_PRICE)    AS  TOT1
                FROM    CART A, PROD B
                WHERE   A.CART_NO   LIKE    '202005%'
                AND     A.CART_PROD=B.PROD_ID
                GROUP BY    A.CART_MEMBER
                ORDER BY    2   DESC) D, MEMBER C
        WHERE   C.MEM_ID=D.AMID
        AND     ROWNUM=1
UNION ALL
        SELECT '6��' AS MON,
                C.MEM_ID AS CID,
                C.MEM_NAME AS CNAME,  
                D.TOT1 AS CTOT1
        FROM    (SELECT A.CART_MEMBER AS AMID,
                        SUM(A.CART_QTY*B.PROD_PRICE)    AS  TOT1
                FROM    CART A, PROD B
                WHERE   A.CART_NO   LIKE    '202006%'
                AND     A.CART_PROD=B.PROD_ID
                GROUP BY    A.CART_MEMBER
                ORDER BY    2   DESC) D, MEMBER C
        WHERE   C.MEM_ID=D.AMID
        AND     ROWNUM=1
UNION ALL
        SELECT '7��' AS MON,
                C.MEM_ID AS CID,
                C.MEM_NAME AS CNAME,  
                D.TOT1 AS CTOT1
        FROM    (SELECT A.CART_MEMBER AS AMID,
                        SUM(A.CART_QTY*B.PROD_PRICE)    AS  TOT1
                FROM    CART A, PROD B
                WHERE   A.CART_NO   LIKE    '202007%'
                AND     A.CART_PROD=B.PROD_ID
                GROUP BY    A.CART_MEMBER
                ORDER BY    2   DESC) D, MEMBER C
        WHERE   C.MEM_ID=D.AMID
        AND     ROWNUM=1)
SELECT  MON,
        CID      AS  ȸ����ȣ,
        CNAME    AS  ȸ����,
        CTOT1    AS  ���űݾ�
FROM    T1;

��뿹) 4���� 7���� �Ǹŵ� ��� ��ǰ�� �ߺ����� �ʰ� ����Ͻÿ�
Alias�� ��ǰ��, ��ǰ��
    SELECT  DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
            B.PROD_NAME AS  ��ǰ��
    FROM    CART A, PROD B
    WHERE   A.CART_PROD=B.PROD_ID
    AND A.CART_NO LIKE '202006%'
UNION
    SELECT  DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
            B.PROD_NAME AS  ��ǰ��
    FROM    CART A, PROD B
    WHERE   A.CART_PROD=B.PROD_ID
    AND A.CART_NO LIKE '202007%'
ORDER BY    1; -- ���⸸ ����Ǵ� ���� �ƴ϶� ��ü�� �����

2) INTERSECT
- ������(����κ�)�� ��� ��ȯ

��뿹) 2020�� ���Ի�ǰ �� 1���� 5���� ��� ���Ե� ��ǰ�� ��ǰ�ڵ�, ��ǰ��, ����ó���� ��ȸ�Ͻÿ�
    SELECT  DISTINCT    A.BUY_PROD      AS  ��ǰ�ڵ�,
            C.PROD_NAME                 AS  ��ǰ��,
            B.BUYER_NAME                AS  ����ó��
    FROM    BUYPROD A, BUYER B, PROD C
    WHERE   A.BUY_PROD=C.PROD_ID
    AND     C.PROD_BUYER=B.BUYER_ID
    AND     A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
INTERSECT
    SELECT  DISTINCT    A.BUY_PROD       AS  ��ǰ�ڵ�,
            C.PROD_NAME                  AS  ��ǰ��,
            B.BUYER_NAME                 AS  ����ó��
    FROM    BUYPROD A, BUYER B, PROD C
    WHERE   A.BUY_PROD=C.PROD_ID
    AND     C.PROD_BUYER=B.BUYER_ID
    AND     A.BUY_DATE BETWEEN TO_DATE('20200501') AND TO_DATE('20200531')
    ORDER BY    1;
    
��뿹) 1�� ���Ի�ǰ �� 5�� �Ǹ� ���� ���� 5�� �ȿ� �����ϴ� ��ǰ������ ��ȸ�Ͻÿ�.
SELECT  DISTINCT A.BUY_PROD     AS  ��ǰ�ڵ�,
                 B.CART_QTY     AS  �Ǹż���,
                 A.BUY_DATE     AS  ���Գ�¥
FROM    BUYPROD A, CART B
WHERE   A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
--AND     CART_NO LIKE '202005%'
AND     A.BUY_PROD=B.CART_PROD
ORDER BY 2 DESC;

--(1�� ���Ի�ǰ)
WITH    T1  AS
    (SELECT BUY_PROD
    FROM    BUYPROD
    WHERE   BUY_DATE  BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
INTERSECT
--(5�� �Ǹ� �������� 1-5�� ��ǰ)
SELECT  A.CART_PROD
FROM    (SELECT CART_PROD,
                SUM(CART_QTY)
        FROM    CART
        WHERE   CART_NO LIKE    '202005%'
        GROUP BY    CART_PROD
        ORDER BY    2 DESC) A
WHERE     ROWNUM<=5)
SELECT  BUY_PROD    AS  ��ǰ�ڵ�,
        PROD_NAME   AS  ��ǰ��
FROM    T1, PROD
WHERE   T1.BUY_PROD=PROD_ID;