2020-0830-01
5. SEMI Join
- ���������� ���������� �̿��ϴ� �������� ���������� ��� ������ ��������� �����ϴ� ����
- IN, EXISTS �����ڸ� ����ϴ� ����

��뿹)
������̺��� �޿��� 10000 �̻��� ����� �����ϴ� �μ��� ��ȸ�Ͻÿ�.
Alias �μ��ڵ�, �μ���, ���������
(IN ������ ���)
SELECT	A.DEPARTMENT_ID	AS	�μ��ڵ�,
		A.DEPARTMENT_NAME	AS	�μ���,
		B.EMP_NAME		AS	���������
FROM	HR.DEPARTMENTS A, HR.EMPLOYEES B
WHERE	A.DEPARTMENT_ID	IN(��������)
AND		A.MANAGER_ID=B.EMPLOYEE_ID
ORDER BY	1;
(�������� : �޿��� 10000�̻��� ����� �����ϴ� �μ�)
SELECT	DEPARTMENT_ID
FROM	HR.EMPLOYEES
WHERE	SALARY>=10000
(����)
SELECT	A.DEPARTMENT_ID	AS	�μ��ڵ�,
		A.DEPARTMENT_NAME	AS	�μ���,
		B.EMP_NAME		AS	���������
FROM	HR.DEPARTMENTS A, HR.EMPLOYEES B
WHERE	A.DEPARTMENT_ID	IN(SELECT	DEPARTMENT_ID
						FROM	HR.EMPLOYEES
						WHERE	SALARY>=10000)
AND		A.MANAGER_ID=B.EMPLOYEE_ID
ORDER BY	1;
(EXISTS ������ ���)
SELECT	A.DEPARTMENT_ID	AS	�μ��ڵ�,
		A.DEPARTMENT_NAME	AS	�μ���,
		B.EMP_NAME		AS	���������
FROM	HR.DEPARTMENTS A, HR.EMPLOYEES B
WHERE	EXISTS(SELECT *
				FROM HR.EMPLOYEES C
				WHERE	C.SALARY>=10000)
				?AND		A.DEPARTMENT_ID=C.DEPARTMENT_ID)
AND		A.MANAGER_ID=B.EMPLOYEE_ID
ORDER BY	1;

6.SELF Join
- �ϳ��� ���̺� 2�� �̻��� ��Ī�� �ο��Ͽ� ���� �ٸ� ���̺�� ������ �� ������ �����ϴ� ���

��뿹)
ȸ�����̺��� ����ö�� ȸ������ ��� ���ϸ������� ���� ���ϸ����� ������ ȸ�������� ����Ͻÿ�.
Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ���
SELECT	B.MEM_ID	AS	ȸ����ȣ,
		B.MEM_NAME	AS	ȸ����,
		B.MEM_JOB	AS	����,
		B.MEM_MILEAGE	AS	���ϸ���
FROM	MEMBER A, MEMBER B
WHERE	A.MEM_JOB=����ö��
AND		A.MEM_MILEAGE<B.MEM_MILEAGE;

��뿹)
��ǰ�ڵ� ��P20200002���� ���� �з��� ����
Alias�� ��ǰ��, ��ǰ��, �з���, ���Դܰ�
SELECT	B.PROD_ID		AS	��ǰ�ڵ�,
		B.PROD_NAME	AS	��ǰ��,
		C.LPROD_NM	AS	�з���,
		B.PROD_COST	AS	���Դܰ�
FROM	PROD A,	PROD B, LPROD C
WHERE	A.PROD_ID=��P20200002��
AND		A.PROD_LGU=B.PROD_LGU
AND		A.PROD_COST<B.PROD_COST
AND		A.PROD_LGU=C.LPROD_GU;

2022-0830-02)�ܺ�����(OUTER Join)
- ���������� ���������� �����ϴ� ����� ��ȯ������, �ܺ������� �ڷᰡ ������ ���̺� NULL���� �߰��Ͽ� ������ ����
- �������� ��� �� �ڷᰡ ������ ���̺��� �÷� �ڿ� �ܺ����� ������ ��(+)���� �߰� �����
- �ܺ����� ������ ���� ���� �� ��� �ܺ����� ���ǿ� ��� ��(+)�������ڸ� ����ؾ� ��
- �ѹ��� �� ���̺��� �ܺ������� �� �� ����
��, A,B,B ���̺��� �ܺ������� ��� A�� �������� B�� �ܺ������ϰ� ���ÿ� C�� �������� B�� �ܺ������� �� ����
(A=B (+) AND C=B(+)�� ������ ����)
- �Ϲ� �ܺ����ο��� �Ϲ������� �ο��Ǹ� ��Ȯ�� ����� ��ȯ���� ����
	=> ���������� ����� �ܺ����� �Ǵ� ANSI �ܺ� �������� �ذ��ؾ� ��
- IN �����ڿ� �ܺ����ο����� (��+��)�� ���� ����� �� ����.
(�Ϲݿܺ����� ����)
SELECT	�÷�list
FROM	���̺��1 [��Ī1], ���̺��2 [��Ī2], ��
WHERE	��Ī1.�÷��� (+) = ��Ī2.�÷��� => ���̺��1�� �ڷᰡ ������ ���̺��� ���

(ANSI �ܺ����� �������)
SELECT	�÷�list
FROM	���̺��1 [��Ī1]
RIGHT|LEFT|FULL OUTER JOIN ���̺��2 [��Ī2] ON(��������1 [AND �Ϲ�����1])
:
[WHERE	�Ϲ�����]
- ��RIGHT|LEFT|FULL��: FROM���� ����� ���̺�(���̺�1)�� �ڷᰡ OUTER JOIN ���̺��2���� 
������ ��LEFT��, ������ ��RIGHT��, ���� ��� ������ ��FULL�� ���

**
	1) SELECT�� ����ϴ� �÷� �� ���� ���̺� ��� �����ϴ� �÷��� ���� �� ���̺� ���� ����ؾ���
	2) �ܺ������� SELECT���� COUNT �Լ��� ����ϴ� ���
	��*���� NULL���� ���� �൵ �ϳ��� ������ �ν��Ͽ� ����Ȯ�� ���� ��ȯ��.
	���� ��*�� ��� �ش����̺��� �⺻Ű�� ���

��뿹) ��� �з��� ���� ��ǰ�� ���� ����Ͻÿ�
(�Ϲݿܺ�����)
SELECT	B.LPROD_GU	AS	�з��ڵ�,
		B.LPROD_NM	AS	�з���,
		COUNT(A.PROD_ID)	AS	����ǰ�� ����
FROM	PROD A,	LPROD B
WHERE	A.PROD_LGU(+)=B.LPROD_GU
GROUP BY	B.PROD_LGU, B.LPROD_NM
ORDER BY	1;

(ANSI�ܺ�����)
SELECT	B.LPROD_GU	AS	�з��ڵ�,
		B.LPROD_NM	AS	�з���,
		COUNT(A.PROD_ID)	AS	����ǰ�� ����
FROM	PROD A
RIGHT OUTER JOIN	LPROD B	ON(A.PROD_LGU=B.LPROD_GU)
GROUP BY	B.PROD_LGU, B.LPROD_NM
ORDER BY	1;

��뿹) 2020�� 6�� ��� �ŷ�ó�� �������踦 ��ȸ�Ͻÿ�
	Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��հ�
SELECT	A.BUYER_ID	AS	�ŷ�ó�ڵ�,
		A.BUYER_NAME	AS	�ŷ�ó��,
		SUM(B.BUY_QTY*C.PROD_COST)	AS	���Աݾ��հ�
FROM	BUYER A,	BUYPROD B,	PROD C
WHERE	B.BUY_PROD(+)=C.PROD_ID
AND		A.BUYER_ID=C.PROD_BUYER(+)
AND		BUY_DATE BETWEEN TO_DATE(��20200601��) AND TO_DATE(��20200630��)
GROUP BY A.BUYER_ID,	A.BUYER_NAME;

(ANSI����)
SELECT	A.BUYER_ID	AS	�ŷ�ó�ڵ�,
		A.BUYER_NAME	AS	�ŷ�ó��,
		SUM(B.BUY_QTY*C.PROD_COST)	AS	���Աݾ��հ�
FROM	BUYER A
LEFT OUTER JOIN	 PROD C	ON(A.BUYER_ID=C.PROD_BUYER)
LEFT OUTER JOIN BUYPROD B	ON(B.BUY_PROD=C.PROD_ID
AND		BUY_DATE BETWEEN TO_DATE(��20200601��) AND TO_DATE(��20200630��)
GROUP BY A.BUYER_ID,	A.BUYER_NAME
ORDER BY	1;

(SUBQUERY)
SELECT	A.BUYER_ID	AS	�ŷ�ó�ڵ�,
		A.BUYER_NAME	AS	�ŷ�ó��,
		NVL(TBL.BSUM,0)	AS	���Աݾ��հ�
FROM	BUYER A,	
		? 2020�� 6�� �ŷ�ó�� ���Աݾ��հ�
		(SELECT	C.PROD_BUYER	AS	CID,
		SUM(B.BUY_QTY*C.PROD_COST)	AS	BSUM
		FROM	BUYPROD B,	PROD C
		WHERE B.BUY_DATE BETWEEN TO_DATE(��20200601��) AND TO_DATE(��20200630��)
		AND B.BUY_PROD=C.PROD_ID
		GROUP BY	C.PROD_BUYER)	TBL
		BUYPROD B,	PROD C
WHERE	B.BUY_PROD(+)=TBL.CID(+)
ORDER BY 1;

��뿹) 2020�� ��ݱ�(1~6��) ��� ��ǰ�� ���Լ������踦 ��ȸ�Ͻÿ�

��뿹) 2020�� ��ݱ�(1~6��) ��� ��ǰ�� ����������踦 ��ȸ�Ͻÿ�

��뿹) 2020�� ��ݱ�(1~6��) ��� ��ǰ�� ����/����������踦 ��ȸ�Ͻÿ�