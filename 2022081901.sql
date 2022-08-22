2022-0819-01)
3. ��¥�Լ�
1) SYSDATE - ****
- �ý����� �����ϴ� ��¥ �� �ð����� ����
- ������ ����, ROUND, TRUNC �Լ��� ���� ����� ��
- �⺻ ��� Ÿ���� '��/��/��'�̰� '��/��/��'�� ����ϱ� ���ؼ��� TO_CHAR �Լ� ���
--�ú��ʸ� �Ҽ������� ��

2) ADD_MONTHS(d, n)
- �־��� ��¥ d�� n��ŭ�� ���� ���� ��¥ ��ȯ -- ������ ����� ��¥
- �Ⱓ�� ������ ��¥�� �ʿ��� ��� ���� ���

��뿹)
���� ��� ��ü�� 2���� ����ȸ������ ����� ��� ���� ������ڸ� ��ȸ�Ͻÿ�.
SELECT  ADD_MONTHS(SYSDATE,2)
FROM    DUAL;

3) NEXT_MONTHS(d, c) - *
- �־��� ��¥ d ���� c���Ͽ� �ش��ϴ� ��¥ ��ȯ
- c�� ' ��', '������', 'ȭ', ..., '�Ͽ���' ���
- �ѱ۷� ��� ��!! --> ����Ŭ ��ġ �� ȯ�漳���� �� ��¥ �� KOREA�� �س��� �׷���

��뿹)
SELECT  NEXT_DAY(SYSDATE, '��'),
        NEXT_DAY(SYSDATE, '�����')
--      NEXT_DAY(SYSDATE, 'FRIDAY')
FROM    DUAL;

4) LAST_DAY(d) - ***
- �־��� ��¥ �������� �� ������ ���� ��ȯ -- �ݵ�� ��¥ ������!
- �ַ� 2���� ������ ���� ��ȯ�޴� ���� ����

��뿹) �������̺��� 2022��  2�� ��ǰ�� �������踦 ���Ͻÿ�.
        Alias ��ǰ�ڵ�, ��ǰ��, �ż����հ�, ���Աݾ��հ�
SELECT  A.BUY_PROD      AS  ��ǰ�ڵ�, -- BUY_PROD�� �ܷ�Ű���� �ƴ��� �𸣱� ������...�ܷ�Ű�� �̸� �ٲ��� ���ƾ� ��
        B.PROD_NAME     AS  ��ǰ��,
        COUNT(*)        AS  ����Ƚ��,
        SUM(A.BUY_QTY)  AS  �ż����հ�,
        SUM(A.BUY_QTY * B.PROD_COST)    AS  ���Աݾ��հ�
FROM    BUYPROD A,  PROD    B --��Ī!!!!�� ���� '.'�� ��� ��. .(DOT)�����ڴ� �Ҽ� ����!!!!!!!!!!********
WHERE   A.BUY_PROD  =   B.PROD_ID-- �� �� �̻� ���̺��� ���̸� ���� ����!!! ��� ��
AND     A.BUY_DATE BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201'))
GROUP   BY  A.BUY_PROD,  B.PROD_NAME--�̰� �� ��? : ���� ���� ��
ORDER   BY  1;
--JOIN : �� ���̺� �� ���踦 ����(������ �÷� ����)
--������ �÷� : �ϳ��� �θ����̺� �ִ� �⺻Ű�� �ڽ����̺� �ܷ�Ű�� ���ǰ� �ִٴ� ��
--�׷��� ������ JOIN�� �� �� ����

5) EXTRACT(fmt FROM d) -****������ ���� ���� / ��¥�ڷ� �Ϻΰ� �ʿ��� ��찡 ����
- �־��� ��¥ ������ d���� 'fmt'�� ������ ��� ���� ��ȯ
- 'fmt'�� YEAR, MONTH, DAY, HOUR, MINUTE, SECOND �� �ϳ�
- ��ȯ������ Ÿ���� ������!!��¥XX����XX --> ������� �־�� ��¥ �����ͷ� �����Ǵµ� �װ͵� �� �ϳ��� ������ ���ڷ� ��ȯ��

**������̺��� �ڷ� �� �Ի����� 10���� ����� ���ڷ� ����(UPDATE)�Ͻÿ�.
UPDATE  HR.EMPLOYEES
SET     HIRE_DATE = ADD_MONTHS(HIRE_DATE, 120);

COMMIT;

��뿹) ������̺��� 50�� �μ� ���� �� �ټӳ���� 7�� �̻��� ������ ��ȸ�Ͻÿ�.
        Alias�� �����ȣ, �����, ��å, �Ի���, �ټӳ���̸� �ټӳ���� ���� ������� ���
SELECT  EMPLOYEE_ID AS  �����ȣ,
        EMP_NAME    AS  �����,
        JOB_ID      AS  ��å,
        HIRE_DATE   AS  �Ի���,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)  AS  �ټӳ��
FROM    HR.EMPLOYEES
WHERE   DEPARTMENT_ID = 50
AND     EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) >= 7--�μ���ȣ 50, �ټӳ�� 7�� �̻�
-- ORDER BY EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
ORDER BY   4 -- = 5 DESC