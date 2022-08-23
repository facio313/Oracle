2022-0823-01) �����Լ� ��� ����

��뿹)

SELECT  PROD_COST
FROM    PROD
ORDER BY    1;

SELECT  AVG(DISTINCT PROD_COST)     AS  "�ߺ��� ���� ���",
        AVG(ALL PROD_COST)          AS  "DEFAULT", -- ��� ���� ����",
        AVG(PROD_COST)              AS  "���԰� ���" -- �̰� ���� ��
FROM    PROD;

��뿹) ��ǰ���̺��� ��ǰ�з��� ���԰��� ��� ��

SELECT  PROD_LGU AS "��ǰ �з� �ڵ�",
        ROUND(AVG(PROD_COST), 2)    AS "���� �ܰ�"
FROM    PROD
GROUP BY    PROD_LGU--BY : ~�� --GROUP : ����
ORDER BY    PROD_LGU; --ASCENING(�������� ��������) / DESCENDING(��������)

��뿹) ��ǰ�з��� ���Ű��� ���

SELECT  PROD_LGU                    AS  "��ǰ �з� �ڵ�",
        ROUND(AVG(PROD_SALE), 2)    AS  "���Ű��� ���"
FROM    PROD
GROUP BY    PROD_LGU
ORDER BY    PROD_LGU; -- ���� GROUP BY�� ���� �ɷ� ��

��뿹) 

SELECT  PROD_LGU                    AS "��ǰ �з� �ڵ�",
        PROD_BUYER                  AS �ŷ�ó,
        ROUND(AVG(PROD_COST), 2)    AS "���԰� ���",
        SUM(PROD_COST)              AS "���԰� ��",
        MAX(PROD_COST)              AS "�ִ� ���԰�",
        MIN(PROD_COST)              AS "�ּ� ���԰�",
        COUNT(PROD_COST)            AS "���� Ƚ��"
FROM    PROD
GROUP BY    PROD_LGU, PROD_BUYER -- 2���� �� �� �� �����! �׷��� �� �� ��
ORDER BY    1,2;

��뿹)
��ǰ���̺�(PROD)�� �� �ǸŰ���(PROD_SALE), ��� �� ���ϱ�
Alias�� ��ǰ�з�(PROD_LGU), ��ǰ���ǸŰ����

SELECT  PROD_LGU                    AS  ��ǰ�з�,
--        SUM(PROD_SALE)              AS  "�� �ǸŰ���",
        ROUND(AVG(PROD_SALE), 2)    AS  ��ǰ���ǸŰ����, --30����Ʈ���� ���� / �ѱ��� �� ���� �� 3����Ʈ
        TO_CHAR(ROUND(AVG(PROD_SALE), 2), 'L9,999,999.00')
FROM    PROD
GROUP BY    PROD_LGU
ORDER BY    PROD_LGU;

��뿹)
�ŷ�ó���̺�(BUYER)�� �����(BUYER_CHARGER)�� �÷����� �Ͽ� COUNT���� �Ͻÿ�.
Alias�� �ڷ��(DISTINCT), �ڷ��, �ڷ��(*)

SELECT  COUNT(DISTINCT BUYER_CHARGER)   AS  "�ڷ��(DISTINCT)", --"�ڷ��(DISTINCT)"���� �� �� ��!
        COUNT(BUYER_CHARGER)            AS  �ڷ��,
        COUNT(*)                        AS  "�ڷ��(*)"
FROM    BUYER;

-- ���� �� : ī��θ�Ƽ
-- ���� �� : ����(DEGREE)
SELECT  COUNT(*), -- *�� ALL! ��� ��(*)�� ���� �� ASTERISK
        COUNT(PROD_COLOR) -- COUNT �� NULL�� ���� �� ��
FROM    PROD;

��뿹)
ȸ�����̺�(MEMBER)�� ���(MEM_LIKE)�� COUNT���� �Ͻÿ�
Alias�� ���, �ڷ��, �ڷ��(*)

SELECT  MEM_LIKE        AS  ���,
        COUNT(MEM_ID)   AS  �ڷ��, -- �⺻ Ű�� ã�� �� ����!! NOT NULL NO DUPLICATE
        COUNT(*)        AS  "�ڷ��(*)" --"�ڷ��(*)" ���� �̷��� �� ��
FROM    MEMBER
GROUP BY    MEM_LIKE
ORDER BY    MEM_LIKE;

-- # _ $�� Alias�� �� �� ���� BUT ù ���� XXXXX

��뿹)
��ٱ������̺��� ȸ���� �ִ뱸�ż����� �˻��Ͻÿ�
Alias�� ȸ��ID, �ִ����, �ּҼ���

SELECT  CART_MEMBER     AS  ȸ��ID,
        MAX(CART_QTY)   AS  �ִ����,
        MIN(CART_QTY)   AS  �ּҼ���
FROM CART
GROUP BY    CART_MEMBER
ORDER BY    CART_MEMBER;

��뿹)
������ 2020�⵵ 7�� 11���̶� �����ϰ� ��ٱ������̺�(CART)�� �߻��� �߰� �ֹ���ȣ(CART_NO)�� �˻��Ͻÿ�
Alias�� �ְ�ġ�ֹ���ȣ MAX(CART_NO), �߰��ֹ���ȣMAX(CART_NO)+1

SELECT  MAX(CART_NO)    AS  �ְ�ġ�ֹ���ȣ,
        MAX(CART_NO)+1  AS  �߰��ֹ���ȣ
FROM    CART
WHERE   SUBSTR(CART_NO,1,8) = '20200711' 
AND     CART_NO LIKE '20200711%' -- LIKE�� �Բ� ���� '%(���� ����)', '_(�� ����)' = ���ϵ�ī��
AND     CART_NO BETWEEN '202007110000' AND '202007119999';
--WHERE �� �� �� ����!!!

��뿹)
��ǰ���̺��� ��ǰ�з�, �ŷ�ó���� �ְ��ǸŰ�, �ּ��ǸŰ�, �ڷ���� �˻��Ͻÿ�

SELECT  PROD_BUYER  AS  �ŷ�ó,
        PROD_LGU    AS  ��ǰ�з�,
        MAX(PROD_SALE) AS �ְ��ǸŰ�,
        MIN(PROD_SALE) AS �ּ��ǸŰ�,
        COUNT(*)    AS  �ڷ��
FROM    PROD
GROUP BY    PROD_BUYER, PROD_LGU
ORDER BY    1;