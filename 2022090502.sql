2022-0905-02)���Ǿ� ��ü(SYNONYM)
- ����Ŭ ��ü�� ��Ī�� �ο��� �� ���
- �ٸ� �������� ��ü�� �����ϴ� ��� "��Ű����.��ü��" �������� �����ؾ� ��
    => �̸� ����ϱ� ���� ����� ������ �ܾ�� ��� �� �� �ִ� ��� ����
    
(�������)
CREATE [OR REPLACE] SYNONYM ��Ī
FOR     ���� ��ü��

��뿹)
HR ������ EMPLOYEES ���̺�� DEPARTMENTS ���̺��� EMP �� DEPT�� ��Ī�� �ο��Ͻÿ�

DROP SYNONYM EMP;

SELECT * FROM EMP;

CREATE  OR  REPLACE SYNONYM    EMPL     FOR HR.EMPLOYEES;--EMP�� �ҷ��µ� �ٸ� ���̺� �����ϴ°���;;; ���� �� ��

SELECT  *   FROM    EMPL;

CREATE  OR  REPLACE SYNONYM    DEPT    FOR HR.DEPARTMENTS;

SELECT  *   FROM    DEPT;

SELECT  A.EMPLOYEE_ID,
        A.EMP_NAME,
        B.DEPARTMENT_NAME
FROM    EMPL A, DEPT B
WHERE   B.DEPARTMENT_ID IN (20, 30, 50, 60)
AND     A.DEPARTMENT_ID = B.DEPARTMENT_ID;
