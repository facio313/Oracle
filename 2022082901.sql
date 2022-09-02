2022-0829-01)���̺� ����
- ������ �����ͺ��̽����� ����(Relationship)�� �̿��Ͽ� ���� ���� ���̺�κ��� �ʿ��� �ڷḦ �����ϴ� ����
- ���ο� �����ϴ� ���̺��� �ݵ�� ����(�߷�Ű ����)�� �ξ����(���谡 ���� ���̺� ���� ������ cartessian(cross) joindl��� ��)
- ������ ����
	- �������ΰ� �ܺ�����(Inner join, outer join)
	- �Ϲ����ΰ� ANSI Join
	- Equi Join, Non-Equi Join, Self Join, Cartesian product
1.�Ϲ� ����
- �� DB�������� �ڻ��� DBMS�� ����ȭ�� ���������� ����
- ��� DB�� �ٲ�� ����� ������ ���� �����ؾ� ��
(�������)
SELECT	�÷� list
FROM	���̺��1 [��Ī1], ���̺��2 [��Ī2] [,��]
WHERE	[��Ī1.|���̺��1.]�÷��� ������ [��Ī2.|���̺��2.]�÷���
[AND ��������]
[AND �Ϲ�����]
:
- n���� ���̺��� ���Ǹ� ���������� ��� n-1�� �̻� �Ǿ�� ��
- �Ϲ����ǰ� ���������� ��� ������ �ٲ� ��� ����

2.ANSI ��������
SELECT	�÷� list
FROM	���̺��1[��Ī1]
INNER|CROSS|NATURAL JOIN ���̺��2 [��Ī2] ON(�������� [AND �Ϲ�����])
INNER|CROSS|NATURAL JOIN ���̺��3 [��Ī3] ON(�������� [AND �Ϲ�����])
:
[WHERE �Ϲ�����]
:
- ���̺��1�� ���̺��2�� �ݵ�� ���� JOIN �����ؾ� ��
- ���̺��3�� ���̺��1�� ���̺��2�� ���� ����� ���� ����
- ��CROSS JOIN���� �Ϲ������� Cartessian Product�� ����
- ��NATURAL JOIN���� ���ο��꿡 ���� ���̺� ���� �÷����� �����ϸ� �ڵ����� ���� �߻�

3. Cartessian Product Join(Cross Join)
- ���������� ������� �ʾҰų� �߸� ����� ��� �߻�
- n�� m���� ���̺�� a�� b���� ���̺��� Cross Join�� ��� �־��� ���(���������� ������ ���)
����� n*a �� m+b ���� ��ȯ��
- �ݵ�� �ʿ��� ��찡 �ƴϸ� ����� �����ؾ� ��

��뿹)
SELECT	COUNT(*)	AS	��PROD ���̺� ���� ���� FROM	PROD;
SELECT	COUNT(*)	AS	��CART ���̺� ���� ����	FROM	CART;
SELECT	COUNT(*)	AS	��BUYPROD ���̺� ���� ���� FROM	BUYPROD;

SELECT	COUNT(*)	FROM	PROD,CART,BUYPROD;

SELECT	COUNT(*)
FROM	PROD 
CROSS	JOIN 	CART
CROSS	JOIN	BUYPROD;

4.Equi Join(ANSI�� INNER JOIN)
(�Ϲ����� �������)
SELECT	�÷�list
FROM	���̺��1 [��Ī1], ���̺��2 [��Ī2] [,���̺��3 [��Ī3],��]
INNER JOIN	���̺��2 [��Ī2] ON([��Ī1.]�÷���1=[��Ī2.]�÷���2 [AND �Ϲ�����1]
[INNER JOIN]	���̺��3 [��Ī3] ON([��Ī1.]�÷���1=[��Ī3.]�÷���3 [AND �Ϲ�����2]
:
WEHRE	[��Ī1.]�÷���1=[��Ī2.]�÷���2 ? ��������
[AND]	[��Ī1.]�÷���1=[��Ī3.]�÷���3 ? ��������
:
[AND �Ϲ�����]

(ANSI���� �������)
SELECT	�÷�list
FROM	���̺��1 [��Ī1], ���̺��2 [��Ī2] [,���̺��3 [��Ī3],��]
INNER JOIN	���̺��2 [��Ī2] ON([��Ī1.]�÷���1=[��Ī2.]�÷���2 [AND �Ϲ�����1]
[INNER JOIN]	���̺��3 [��Ī3] ON([��Ī1.]�÷���1=[��Ī3.]�÷���3 [AND �Ϲ�����2]
:
[WHERE �Ϲ�����]

��뿹)
�������̺��� 2020�� 7�� ���Ի�ǰ������ ��ȸ�Ͻÿ�
Alias�� ����, ��ǰ��ȣ, ��ǰ��, ����, �ݾ�
SELECT	A.BUY_DATE		AS	����,
		B.PROD_ID			AS	��ǰ��ȣ,
		B.PROD_NAME		AS	��ǰ��,
		A.BUY_QTY		AS	����,
		A.BUY_QTY*B.PROD_COST	AS	�ݾ�
FROM	BUYPROD A, PROD B
WHERE	A.BUY_PROD=B.PROD_ID ? ��������
AND		A.BUY_DATE BETWEEN TO_DATE(��20200701��) AND TO_DATE(��20200731��) ?�Ϲ�����
ORDER BY	1;

��뿹)
(�Ϲ�����)
��ǰ���̺��� ��P10202�� �ŷ�ó���� ��ǰ�ϴ� ��ǰ������ ��ȸ�Ͻÿ�
Alias�� ��ǰ�ڵ�, ��ǰ��, �ŷ�ó��, ���Դܰ�
SELECT	A.PROD_ID		AS	��ǰ�ڵ�,
		A.PROD_NAME	AS	��ǰ��,
		B.BUYER_NAME	AS	�ŷ�ó��,
		A.PROD_COST	AS	���Դܰ�,
FROM	PROD A,	BUYER	B
WHERE	A.PROD_BUYER=��P10202��
AND	A.PROD_BUYER=B.BUYER_ID;

��뿹)
��ǰ���̺��� ���� ������ ��ȸ�Ͻÿ�
Alias�� ��ǰ��, ��ǰ��, �з���, �ǸŴܰ�
SELECT	A.PROD_ID	AS	��ǰ�ڵ�,
		A.PROD_NAME	AS	��ǰ��,
		B.LPROD_NM	AS	�з���,
		A.PROD_PRICE	AS	�ǸŴܰ�
FROM	PROD A,	LPROD B
WHERE	A.PROD_LGU=B.LPROD_GU;

��뿹)
������̺��� �����ȣ, �����, �μ���, �Ի����� ����Ͻÿ�.
SELECT	A.EMPLOYEE_ID	AS	�����ȣ,
		A.EMP_NAME	AS	�����,
		B.DEPARTMENT_NAME	AS	�μ���,
		A.HIRE_DATE	AS	�Ի���
FROM	HR.EMPLOYEES AS,	HR.DEPARTMENTS B
WHERE	A.DEPARTMENT_ID=B.DEPARTMENT_ID


��뿹)
2020�� 4�� ȸ����, ��ǰ�� �Ǹ����踦 ��ȸ�Ͻÿ�
Alias�� ȸ����ȣ, ȸ����, ��ǰ��, ���ż����հ�, ���űݾ��հ�
SELECT	A.CART_MEMBER	AS	ȸ����ȣ,
		B.MEM_NAME		AS	ȸ����,
		C.PROD_NAME		AS	��ǰ��,
		SUM(A.CART_QTY)	AS	���ż����հ�,
		SUM(A.CART_QTY*C.PROD_PRICE)	AS	���űݾ��հ�
FROM	CART A,	MEMBER B,	PROD C
WHERE	A.CART_MEMBER=B.MEM_ID ? ��������(ȸ����)
AND		A.CART_PROD=C.PROD_ID ? ��������(��ǰ��, �ǸŴܰ�)
AND		A.CART_NO LIKE ��202004%��
GROUP BY	A.CART_MEMBER, B.MEM_NAME, C.PROD_NAME
ORDER BY	1;

(ANSI ����)
SELECT	A.BUY_DATE	AS	����,
		B.PROD_ID		AS	��ǰ��ȣ,
		B.PROD_NAME	AS	��ǰ��,
		A.BUY_QTY	AS	����,
		A.BUY_QTY*B.RPOD_COST	AS	�ݾ�
FROM	BUYPROD A
?INNER JOIN	PROD B	ON(A.BUY_PROD=B.PROD_ID	AND
?			(A.BUY_DATE BETWEEN TO_DATE(��20200601��) AND TO_DATE(��20200630��)))
INNER JOIN	PROD B	ON(A.BUY_PROD=B.PROD_ID)
AND			A.BUY_DATE BETWEEN TO_DATE(��20200601��) AND TO_DATE(��20200630��)
ORDER BY	1;

(ANSI ����)
SELECT	A.PROD_ID		AS	��ǰ�ڵ�,
		A.PROD_NAME	AS	��ǰ��,
		B.BUYER_NAME	AS	�ŷ�ó��,
		A.PROD_COST	AS	���Դܰ�,
FROM	PROD A
INNER JOIN	BUYER B ON(A.PROD_BUYER=B.BUYER_ID)
WHERE	A.PROD_BUYER=��P10202��;

(ANSI ����)
SELECT	A.EMPLOYEE_ID	AS	�����ȣ,
		A.EMP_NAME	AS	�����,
		B.DEPARTMENT_NAME	AS	�μ���,
		A.HIRE_DATE	AS	�Ի���,
FROM	HR.EMPLOYEES A
INNER JOIN	HR.DEPARTMENT ????????

(ANSI ����)
SELECT	A.CART_MEMBER	AS	ȸ����ȣ,
		B.MEM_NAME		AS	ȸ����,
		C.PROD_NAME		AS	��ǰ��,
		SUM(A.CART_QTY)	AS	���ż����հ�,
		SUM(A.CART_QTY*C.PROD_PRICE)	AS	���űݾ��հ�
FROM	CART A
INNER JOIN	MEMBER B ON(A.CART_MEMBER=B.MEM_ID)
? INNER JOIN	PROD C ON(A.CART_PROD=C.PROD_ID AND A.CART_NO LIKE ��202004%��)
INNER JOIN	PROD C ON(A.CART_PROD=C.PROD_ID)
WHERE		A.CART_NO LIKE ��202004%��	?where inner join �ٲ㵵 ��� ���� ��� ����
GROUP BY	A.CART_MEMBER, B.MEM_NAME, C.PROD_NAME
ORDER BY	1;

(�Ϲ�����)
2020�� 5�� �ŷ�ó�� �������踦 ��ȸ�Ͻÿ�
Alias�� �ŷ�ó �ڵ�, �ŷ�ó��, ����ݾ��հ�
SELECT	B.BUYER_ID	AS	�ŷ�ó�ڵ�,
		B.BUYER_NAME	AS	�ŷ�ó��,
		SUM(A.CART_QTY*C.PROD_PRICE)	AS	����ݾ��հ�,
FROM	CART A, BUYER B, PROD C
WHERE	A.CART_NO	LIKE	��202005�� ?�Ϲ�����
AND		A.CART_PROD=C.PROD_ID ?��������
AND		C.PROD_BUYER=B.BUYER_ID ?��������
GROUP BY	B.BUYER_ID, B.BUYER_NAME
ORDER BY	1;

(ANSI ����)
SELECT	B.BUYER_ID	AS	�ŷ�ó�ڵ�,
		B.BUYER_NAME	AS	�ŷ�ó��,
		SUM(A.CART_QTY*C.PROD_PRICE)	AS	����ݾ��հ�,
FROM	CART A
INNER JOIN	PROD C	ON(A.CART_PROD=C.PROD_ID)
INNER JOIN	BUYER B	ON(B.BUYER_ID=C.PROD_BUYER)
WHERE	A.CART_NO	LIKE	��202005�� ?�Ϲ�����
AND		A.CART_PROD=C.PROD_ID ?��������
AND		C.PROD_BUYER=B.BUYER_ID ?��������
GROUP BY	B.BUYER_ID, B.BUYER_NAME
ORDER BY	1;


��뿹)
HR�������� �̱��̿��� ������ ��ġ�� �μ������� ��ȸ�Ͻÿ�
Alias�� �μ���ȣ, �μ���, �ּ�, ������
SELECT	A.DEPARTMENT_ID		AS	�μ���ȣ,
		A.DEPARTMENT_NAME	AS	�μ���,
		B.STREET_ADDRESS||��, ��||B.CITY||�� ��||STATE_PROVINCE	AS     �ּ�,
		C.COUNTRY_NAME		AS	������
FROM	HR.DEPARTMENTS A,	HR.LOCATIONS B,	HR.COUNTRIES C
WHERE	A.LOCATION_ID=B.LOCATION_ID
AND		B.COUNTRY_ID=C.COUNTRY_ID
AND		B.COUNTRY_ID!=��US��
ORDER BY	1;