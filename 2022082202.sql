2022-0822-02) �����Լ�(������ �Լ�)
- ��� �����͸� Ư�� �÷��� �������� �׷�����ϰ� �� �׷쿡 ����
�հ�(SUM), ���(AVG), �ڷ� ��(COUNT), �ִ밪(MAX), �ּҰ�(MIN)�� ��ȯ�ϴ� �Լ�
- �÷� ���� ��鳢�� ������ ��
- ���� : �׷����� ���� ��
- �Լ� : �Է°� -> ���� -> ��°�
- �����Լ�(TO_CHAR, TO_NUMBER, EXTRACT ��� �̹� ����Ŭ�� �ִ� ��)
�������)
SELECT  [�÷���1 [,]
           :
        [�÷���n][,]
        SUM|AVG|COUNT|MAX|MIN
FROM    ���̺��
[WHDERE ����]
[GROUP BY �÷���1,...,�÷���n]
[HAVING ����]
- SELECT ������ �����Լ��� ���� ��쿡�� GROUP BY���� ����� �ʿ� ����
- SELECT ���� �����Լ� �̿��� �÷��� ����� ���(�Ϲ��Լ� ����) �ݵ�� GROUP BY���� ����Ǿ�� �ϰ� 
GROUP BY ������ ��� �Ϲ��÷��� ','�� �����Ͽ� ����ؾ� ��
- SELECT ���� ������ ���� �÷��� GROUP BY ���� ��� ���� -- �̷� ��� ���� ����
- �����Լ��� ������ �ο��� ������ �ݵ�� HAVING���� ����ó���� �����ؾ� �� -- WHERE�� �ƴ�!
-- �� �μ��� �ο� ���� ��ȸ�ϵ�, 10�� �̻��� �μ��� �ο� ���� ��ȸ�ϼ���~
-- COUNT�Լ��� ������ �ο��� ������ WHERE���� �ƴ� HAVING���� ���!

1) SUM(column | expr)
- ����� �÷��� ���̳� ������ ����� ��� ���� ��� ��ȯ

2) AVG

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
        SUM(PROD_SALE)              AS  "�� �ǸŰ���",
        ROUND(AVG(PROD_SALE), 2)    AS  ��ǰ���ǸŰ���� --30����Ʈ���� ���� / �ѱ��� �� ���� �� 3����Ʈ
FROM    PROD
GROUP BY    PROD_LGU
ORDER BY    PROD_LGU;