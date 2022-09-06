2022-0905-04����) JOIN
������ ����
Cartessian product : ��� ���� ��� ���յǴ� �� ��X��
Equi join : ���������� ����(������ ��ġ���� ������ �־�� ��. �����!�� ������ ������)
Non-equi join : 
Outer join : 
Self join : 

1) ����� ã��
1-ERD�� ���� ����!!
2-P.K + F.K(�⺻Ű�� �ܷ�Ű�� ���� = ��������) ã��
3-��������

--Cartessian product
SELECT  *
FROM    LPROD, PROD; -- 12 * 74 = 888��

SELECT  *
FROM    CART, MEMBER;

--Equi join ����,�,�Ϲ�,����
SELECT  *
FROM    LPROD, PROD
WHERE   LPROD_GU = PROD_LGU; -- ������, �����, ������(����)

SELECT  *
FROM    CART, MEMBER
WHERE   CART_MEMBER = MEM_ID; -- ������, �����, ������(����)



SELECT  *
FROM    CART, MEMBER, PROD
WHERE   CART_MEMBER = MEM_ID
AND     CART_PROD = PROD_ID;

--PROD : � ��ǰ�� �ִµ�,
--BUYER : �� ��ǰ�� ��ǰ�� ��ü��?
--CART : �� ��ǰ�� ���� ��ٱ��Ͽ� ��Ҵ°�?
--MEMBER : ������ �����ΰ�?
(Equi join = ����, �Ϲ�, ���� ����)
SELECT  B.BUYER_ID  AS  �ŷ�ó��ȣ,
        B.BUYER_NAME    AS  �ŷ�ó�̸�,
        P.PROD_ID   AS  ��ǰ��ȣ,
        P.PROD_NAME AS  ��ǰ��,
        C.CART_PROD AS  ��ٱ��ϻ�ǰ,
        C.CART_MEMBER   AS  ��ٱ���ȸ��,
        C.CART_QTY  AS  ����,
        M.MEM_ID    AS  ȸ����ȣ,
        M.MEM_NAME  AS  ȸ���̸�
FROM    BUYER B, PROD P, CART C, MEMBER M
WHERE   B.BUYER_ID = P.PROD_BUYER
AND     P.PROD_ID = C.CART_PROD
AND     C.CART_MEMBER = M.MEM_ID -- ���������� ���� = ���̺� ���� - 1

(ANSI ǥ��)
-FROM�� ,���� ���ֱ�
-���������� INNER JOIN ���� ON�� �ֱ�
-�����̷� ����� �ٽ� INNER JOIN �����
SELECT  B.BUYER_ID, B.BUYER_NAME, 
        P.PROD_ID, P.PROD_NAME, 
        C.CART_PROD, C.CART_MEMBER, C.CART_QTY, 
        M.MEM_ID, M.MEM_NAME
FROM    BUYER B INNER JOIN  PROD P      ON(B.BUYER_ID = P.PROD_BUYER)
                INNER JOIN  CART C      ON(P.PROD_ID = C.CART_PROD)
                INNER JOIN  MEMBER M    ON(C.CART_MEMBER = M.MEM_ID)
WHERE   P.PROD_NAME LIKE    '%����%';