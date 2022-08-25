2022-0825-01)NULL ó�� �Լ�
- ����Ŭ�� �÷��� ����ڰ� �����͸� �������� ������ NULL���� �⺻���� ����
- NULL���� ����Ǹ� ����� ��� NULL�� ��ȯ��
- NULL�� ���õ� ������ : IS NULL, IS NOT NULL
NNULL ó�� �Լ� : : NVL1, NVL2, NULLIF ���� ����

1) NULL ó�� ������
- NULL ���� '='(Equals to)���� �� �Ұ���
- �ݵ�� IS [NOT] NULL�� ���ؾ� ��

��뿹) ������̺��� ��������(COMMISION_PCT)�� NULL�� �ƴ� ����� ��ȸ�Ͻÿ�.
    Alias�� �����ȣ, �����, ��������, �μ��ڵ�
SELECT  EMPLOYEE_ID     AS  �����ȣ,
        EMP_NAME        AS  �����,
        COMMISSION_PCT  AS  ��������,
        DEPARTMENT_ID   AS   �μ��ڵ�
FROM    HR.EMPLOYEES
WHERE   COMMISSION_PCT  IS  NOT NULL;

2) NVL(expr, val)
- 'expr'�� ���� NULL�̸� 'val'�� ��ȯ�ϰ�, NULL�� �ƴϸ� �ڽ�('expr')�� ��ȯ
- 'expr'�� 'val'�� �ݵ�� ���� ������ Ÿ���̾�� ��

COMMIT;

**��ǰ���̺��� �з��ڵ尡 'P301'�� ������ ��� ��ǰ�� ���ϸ��� �ش� ��ǰ��
�ǸŰ��� 0.5%�� �����Ͻÿ�

UPDATE  PROD
SET     PROD_MILEAGE=ROUND(PROD_PRICE*0.0005)
WHERE   PROD_LGU <> 'P301';

��뿹)
��ǰ���̺��� ��ǰ�� ���ϸ����� NULL�� ��ǰ�� '���ϸ����� �������� �ʴ� ��ǰ'�̶��
�޽����� ���ϸ��� ����÷��� ����Ͻÿ�
    Alias�� ��ǰ��ȣ, ��ǰ��, ���ϸ���
SELECT  PROD_ID         AS  ��ǰ��ȣ,
        PROD_NAME       AS  ��ǰ��,
        NVL(LPAD(TO_CHAR(PROD_MILEAGE),5), '���ϸ����� �������� �ʴ� ��ǰ')   AS  ���ϸ���
        -- expr�� val�� ������Ÿ���� ���ƾ� ��!!
FROM    PROD;

***NVL�� OUTER JOIN�� ���� ����
��뿹) 2020�� 6�� ��� ��ǰ�� �Ǹ����踦 ��ȸ�Ͻÿ�
--OUTER JOING���� ���, ��ü ���� ����
SELECT  A.PROD_ID   AS  ��ǰ�ڵ�,
        A.PROD_NAME AS  ��ǰ��,
        COUNT(B.CART_PROD)  AS  �Ǹ�Ƚ��,
        NVL(SUM(B.CART_QTY),0)     AS  �Ǹż����հ�,
        NVL(SUM(B.CART_QTY*A.PROD_PRICE),0)    AS  �Ǹű޾��հ�
FROM    PROD A
LEFT    OUTER JOIN CART B ON(A.PROD_ID=B.CART_PROD AND B.CART_NO LIKE '202006%')
GROUP BY    A.PROD_ID, A.PROD_NAME
--��ǰ�ڵ尡 ������ �̸��� ���Ƽ� �� �ᵵ ������ ������ --> �׷���̿� �� ����� �� ����̶�
ORDER BY    1;

**2020�� 4�� �Ǹ��ڷḦ �̿��Ͽ� ��� ����ȸ������ ���ϸ����� �����Ͻÿ�
(1. 2020�� 4�� �Ǹ��ڷḦ �̿��� ȸ���� ���ϸ��� �հ�)
SELECT  A.CART_MEMBER,
        SUM(A.CART_QTY*B.PROD_PRICE),
        SUM(A.CART_QTY*B.PROD_MILEAGE)
FROM    CART A, PROD B
WHERE   A.CART_PROD=B.PROD_ID
AND     A.CART_NO LIKE '202004%'
GROUP BY    A.CART_MEMBER;

(2. ȸ�����̺��� ���ϸ��� ����)
UPDATE  MEMBER TA
SET     TA.MEM_MILEAGE=(SELECT  TA.MEM_MILEAGE+TB.MSUM
                        FROM    (SELECT A.CART_MEMBER AS MID,
                                        SUM(A.CART_QTY*B.PROD_MILEAGE) AS MSUM
                                FROM    CART A, PROD B
                                WHERE   A.CART_PROD = B.PROD_ID
                                AND     A.CART_NO LIKE '202004%'
                                GROUP BY A.CART_MEMBER) TB
                                WHERE TB.MID = TA.MEM_ID);
                                
ROLLBACK;

[�����]
CREATE OR REPLACE VIEW V_MEM_MILEAGE
AS
    SELECT  MEM_ID, MEM_NAME, MEM_MILEAGE
    FROM    MEMBER
    WITH    READ    ONLY;

SELECT * FROM V_MEM_MILEAGE;

��뿹)
2020�� 4�� ����ȸ���鿡�� Ư�� ���ϸ��� 300����Ʈ�� �����Ͻÿ�.
UPDATE  MEMBER
SET     MEM_MILEAGE=MEM_MILEAGE+300;
WHERE   MEM_ID IN(SELECT    DISTINCT CART_MEMBER
                    FROM    CART
                   WHERE    CART_NO LIKE '202004%');

3)NVL2(expr, val1, val2)
- 'expr' ���� NULL�̸� 'val2'�� ��ȯ�ϰ� NULL�� �ƴϸ� 'val1'�� ��ȯ
- 'val1'�� 'val2'�� ������ Ÿ���� �����ؾ� ��
- NVL�� Ȯ���� ����

��뿹) ��ǰ���̺��� ��ǰ�� ������ ����Ͻÿ�.
��, ������ ������ '�������'�� ����Ͻÿ�(NVL�� NVL2�� ���� ����)
    Alias�� ��ǰ��ȣ, ��ǰ��, ����

(NVL ���)
SELECT  PROD_ID     AS  ��ǰ��ȣ,
        PROD_NAME   AS  ��ǰ��,
        NVL(PROD_COLOR, '�������')  AS  ����
FROM    PROD;

(NVL2 ���)
SELECT  PROD_ID     AS  ��ǰ��ȣ,
        PROD_NAME   AS  ��ǰ��,
        NVL2(PROD_COLOR,PROD_COLOR, '�������')  AS  ����
FROM    PROD;