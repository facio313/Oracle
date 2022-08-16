2022-0810-01)
4. ��Ÿ������
 - ����Ŭ���� �����ϴ� ��Ÿ �����ڴ� IN, ANY, SOME, ALL, EXISTS, BETWEEN, LIKE�� ����
 1) IN ������
    . IN �����ڿ��� '='(Equal to) ����� ����
    . IN ���� '( )'�ȿ� ����� �� �� ��� �ϳ��� ��ġ�ϸ� ��ü ����� ��(TRUE)�� ��ȯ
    . IN �����ڴ� '=ANY', '=SOME'���� ġȯ ���� ('ANY', 'SOME'�� �� �پ��ϰ� �� �� ���� / ���� �� ����)
    -- ANY�� SOME���� ���� ��ȣ�� �پ�� IN ������ ġȯ�ϴ� �� ����
    . IN �����ڴ� OR �����ڷ� ġȯ ����
(�������)
    expr IN(��1, ��2,...��n); -- expr �÷��̳� ����, ���� ���
    => expr = ��1
    OR expr = ��2
    OR  :
    OR expr = ��n
        . IN �����ڴ� �ҿ������� ���̳� �ұ�Ģ�� ���� ���� �� �ַ� ���
        => �������� ���� ���� BETWEEN ���
(��뿹) ������̺��� �μ���ȣ�� 20, 50, 60, 100���� ���� ������� ��ȸ�Ͻÿ�.
        Alias�� �����ȣ, �����, �μ���ȣ, �Ի���
        
(OR ������ ���)
SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �����,
       DEPARTMENT_ID AS �μ���ȣ,
       HIRE_DATE AS �Ի���
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID = 20
OR DEPARTMENT_ID = 50
OR DEPARTMENT_ID = 60
OR DEPARTMENT_ID = 100
ORDER BY 3;

(IN ������ ���)
SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �����,
       DEPARTMENT_ID AS �μ���ȣ,
       HIRE_DATE AS �Ի���
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID IN (20, 50, 60, 100)
ORDER BY 3;

(ANY ������ ���)
SELECT EMPLOYEE_ID AS �����ȣ,
       EMP_NAME AS �����,
       DEPARTMENT_ID AS �μ���ȣ,
       HIRE_DATE AS �Ի���
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID =ANY(20, 50, 60, 100)
-- WHERE DEPARTMENT_ID=SOME(20, 50, 60, 100)
ORDER BY 3;

 2) ANY(SOME) ������
    . IN �����ڿ� ����� ��� ����
    . ANY�� SOME�� �Ϻ��ϰ� ���������� ���� ���
    . ���� ���� ���� �������� ��
(�������)
 expr ���迬����ANY|SOME(��1,...��n) -- ���迬���� �ʼ�! <>= �������� ��!!
    - expr�� ���� ( ) ���� �� �� ��� �ϳ��� ���õ� ���迬���ڸ� �����ϸ� ��ü�� ��(true)�� ��ȯ��

(��뿹) ������̺��� �μ���ȣ 60�� �μ��� ���� ������� �޿� �� 
         ���� ���� �޿����� �� ���� �޿��� �޴� ������� ��ȸ�Ͻÿ�.
        Alias�� �����ȣ, �����, �޿�, �μ���ȣ�̸� �޿��� ���� ������� ����Ͻÿ�.
    SELECT  EMPLOYEE_ID     AS �����ȣ,
            EMP_NAME        AS �����,
            SALARY          AS �޿�,
            DEPARTMENT_ID   AS �μ���ȣ
      FROM  HR.EMPLOYEES
     WHERE  SALARY >ANY (SELECT SALARY FROM HR.EMPLOYEES WHERE DEPARTMENT_ID=60)
     -- ���� ���� ���ƾ� �� ������ ORA-01428
     -- ������ ������
       AND  DEPARTMENT_ID!=60
  ORDER BY  3;

SELECT SALARY
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID=60;
-- 4200���� ���� ��� �˾ƺ���!
-- �˷����� ���� ���� ���� ������ ���ϴ� ��� SUBQUERY

-- ���� : ���� ������ �ȷ��� �ٸ� ������ ����� ���� BUYPROD - �ŷ�ó ������ �־�� �ϴµ� ���� -> �˷��� JOIN ���
-- CART : ���⼭ ���� �簬��, ��¥/����(��ٱ��� ��ȣ), �� �簬��, �󸶳� �簬��!
(��뿹) 2020�� 4�� �Ǹŵ� ��ǰ �� ���Ե��� ���� ��ǰ�� ��ȸ�Ͻÿ�.
        Alias�� ��ǰ�ڵ��̴�.

    SELECT  DISTINCT    CART_PROD   AS  ��ǰ�ڵ�
    FROM    CART
    WHERE   CART_NO LIKE '202004%' --WHERE���� �����̸� SELECT ���� �� ��
    AND NOT CART_PROD =ANY(SELECT DISTINCT BUY_PROD FROM BUYPROD WHERE BUY_DATE >= '20200401' AND BUY_DATE <= '20200430')

EXISTS�� �ݵ�� SUBQUERY�� ���;� �ؼ� �װ� ���� �� �� ����

 3) ALL ������
(�������)
 expr ALL(��1,...��n)
    - expr�� ���� �־��� '��1'~'��n'�� ��� ���� ���迬���� ������ ����� ���̸�
      WHERE ���� ��� TRUE�� ��ȯ
    - ANY(SOME)�� ���� ���� ���� �������� �ϰ�, ALL�� ���� ū ���� �������� ��
    - ALL�� =�� ���� ���� �� ���� / =�� ���ٰ� ������ ���� ���� �ƴ����� �������� ���� ����

(��뿹) ������̺��� �μ���ȣ 60�� �μ��� ���� ������� �޿� �� 
         ���� ���� �޿����� �� ���� �޿��� �޴� ������� ��ȸ�Ͻÿ�.
        Alias�� �����ȣ, �����, �޿�, �μ���ȣ�̸� �޿��� ���� ������� ����Ͻÿ�.
    SELECT  EMPLOYEE_ID     AS �����ȣ,
            EMP_NAME        AS �����,
            SALARY          AS �޿�,
            DEPARTMENT_ID   AS �μ���ȣ
    FROM    HR.EMPLOYEES
    WHERE   SALARY >ALL(9000, 6000, 4800, 4200) --> 9000���� ŭ / 60�� �μ��� ����! �̹� Ż����
    ORDER BY 3;















