2022-0818-01)
2. �����Լ� -- ROUND�� MOD�� ���� ��
- �����Ǵ� �����Լ��δ� ������ �Լ�(ABS, SIGN, SQRT ��), GREATEST, ROUND, MOD, FLOOR, WIDTH_BUCKET ���� ����
1)������ �Լ�
(1) ABS(n), SIGN(n), POWER(e, n), SQRT(n) - *
- ABS : n�� ���밪 ��ȯ
- SIGN : n�� ����̸� 1, �����̸� -1, 0�̸� 0�� ��ȯ -- ���� ũ��� ����� ����
- POWER : e�� n�� ��(e�� n�� �ŵ� ���� ��)
- SQRT : n�� ���� -- �ε��� ����

��뿹)
SELECT  ABS(10), ABS(-100), ABS(0),
        SIGN(-20000), SIGN(-0.0099), SIGN(0.000005), SIGN(500000), SIGN(0),
        POWER(2,10),
        SQRT(3.3)
FROM    DUAL;

2)GREATEST(n1, n2[,...n]), LEAST(n1, n2[,...n])
- �־��� �� n1~n ������ �� �� ���� ū ��(GREATEST), ���� ���� ��(LEAST) ��ȯ

��뿹)
SELECT  GREATEST('KOREA', 1000, 'ȫ�浿'), 
--ASCII �ڵ� ��(����)�� �� �ٲ�
--MAX�� �ϳ��� �÷�(��)�� ����ִ� ������ ���ϴ� ��, 
--GREATEST�� ������ �����Ǿ� �ִ� �� �߿� ã�� ��
LEAST('ABC', 200, '�����') --656667 200 15500444155061041502236
FROM    DUAL;        

SELECT ASCII('��') FROM DUAL;

��뿹) ȸ�����̺��� ���ϸ����� 1000�̸��� ȸ���� ã�� 1000���� ���� ����Ͻÿ�.
Alias�� ȸ����ȣ, ȸ����, ���� ���ϸ���, ����� ���ϸ���
SELECT  MEM_ID      AS  ȸ����ȣ,
        MEM_NAME    AS  ȸ����,
        MEM_MILEAGE AS  "���� ���ϸ���",
        GREATEST((MEM_MILEAGE), 1000) AS "����� ���ϸ���"
FROM    MEMBER;