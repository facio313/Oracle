2022-0810-02)
 4) LIKE ������
    - ������ �����Ͽ� ���� �񱳸� ����
    - ���ڿ� ��
(�������)
    expr   LIKE    ���Ϲ��忭
    . ���ϱ������� '%'�� '_'�� ���ϵ�ī��(���Ϲ���) --> ���ڿ��� ��! ���ڶ� ��¥ ���� ��!!!!
    . '%' : '%'�� ���� ��ġ ������ ��� ���ڿ��� ������(���鵵 ��)
    EX) '��%' : '��'���� �����ϴ� ��� �ܾ�� ��(TRUE)�� ��ȯ
        '%��' : '��'���� ������ ��� ���ڿ��� ��(TRUE)�� ��ȯ
        '%��%' : ���ڿ� ���ο� '��'�� �����ϸ� ��(TRUE)�� ��ȯ
    . '_' : '_'�� ���� ��ġ���� �ϳ��� ���ڿ� ������
    EX) '��_' : �� ���ڷ� �����ǰ� ù ���ڰ� '��'�̸� ��(TRUE)�� ��ȯ
        '_��' : �� ���ڷ� �����ǰ� '��'���� ������ ��(TRUE)�� ��ȯ
        '_��_%' : �� ���ڷ� �����ǰ� �߰� ���ڰ� '��'�̸� ��(TRUE)�� ��ȯ
    . ���� ����� ��ȯ�ϱ� ������(���� �Ǵ� ��찡 ���� �߻�)
      ����� �ڷḦ �����ϰ� �ִ� ��� ��� �󵵼��� ������ �˻�ȿ���� ������
      
��뿹) ȸ�����̺꿡�� �������� '����'�� ȸ������ ��ȸ�Ͻÿ�.
        Alias�� ȸ����ȣ, ȸ����, �ּ�
    SELECT  MEM_ID AS ȸ����ȣ,
            MEM_NAME AS ȸ����,
            MEM_ADD1||' '||MEM_ADD2 AS �ּ�
    FROM    MEMBER
    WHERE   MEM_ADD1 LIKE '����%';
        
��뿹) ��ٱ������̺��� 2020��  6���� �Ǹŵ� ��ǰ�� ��ȸ�Ͻÿ�.
        Alias�� ��ǰ��ȣ
    SELECT  DISTINCT CART_PROD AS ��ǰ��ȣ
    FROM    CART
    WHERE   CART_NO LIKE '202006%' -- CART_NO�� ���ڿ� �׷��� LIKE ��� ����
    ORDER BY 1;
        
��뿹) �������̺��� 2020�� 6���� ���Ե� ��ǰ�� ��ȸ�Ͻÿ�. -- DATE Ÿ���̶� LIKE�� ��� �� ��!!!!!
        Alias�� ��ǰ��ȣ
    SELECT  BUY_PROD AS ��ǰ��ȣ
    FROM    BUYPROD
    WHERE   BUY_DATE>=TO_DATE('20200601')
    AND     BUY_DATE<=TO_DATE('20200630');
    -- WHERE BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630');
    -- ��¥�� ���� BETWEEN�� �� ���!!!!����
    -- ���ڿ��� �ٲ��� ����! �ֳ��ϸ� ��¥������ �������־ ������ Ȯ���ؾ� ��
    -- ����ũ ���� �����ؤ̤̤�
    
 5) BETWEEN ������
 - ������ ���� �ڷḦ ��
(�������)
expr BETWEEN ��1  AND ��2
    . expr�� ���� '��1'���� '��2' ���̿� �����ϴ� ���̸� ���� ��ȯ
    . BETWEEN �����ڴ� AND �����ڷ� �ٲپ� ����� �� ���� -- AND�� ���� �����
    . ��� ������ Ÿ�Կ� ��� ���� -- ���ڿ��� LIKE ����� ��� / �� �� ��¥ ���ڴ� BETWEEN�� ���� �����

��뿹) ��ǰ���̺��� �ǸŰ����� 10����~20���� ������ ��ǰ�� ��ȸ�Ͻÿ�.
        Alias ��ǰ��ȣ, ��ǰ��, �ǸŰ���
    SELECT  PROD_ID     AS  ��ǰ��ȣ,
            PROD_NAME   AS  ��ǰ��,
            PROD_PRICE  AS  �ǸŰ���
    FROM    PROD
    WHERE   PROD_PRICE>=100000 AND PROD_PRICE<=200000
    ORDER BY 3;
    
    (BETWEEN���� ����ϱ�)
    
    SELECT  PROD_ID     AS  ��ǰ��ȣ,
            PROD_NAME   AS  ��ǰ��,
            PROD_PRICE  AS  �ǸŰ���
    FROM    PROD
    WHERE   PROD_PRICE BETWEEN 100000 AND 200000
    ORDER BY 3;
            
��뿹) ������̺��� 2005��~2007�� ���̿� �Ի��� ������� ��ȸ�Ͻÿ�.
        Alias �����ȣ, �����, �μ��ڵ�, �����ڵ�, �Ի���
    SELECT  EMPLOYEE_ID AS  �����ȣ,
            EMP_NAME    AS  �����,
            DEPARTMENT_ID   AS  �μ��ڵ�,
            JOB_ID      AS  �����ڵ�,
            HIRE_DATE   AS  �Ի���                     
    FROM    HR.EMPLOYEES
    WHERE   HIRE_DATE BETWEEN '20050101' AND '20071231'
    ORDER BY 5;
    
��뿹) ��ǰ���̺��� ��ǰ�� �з��ڵ尡 'P100'����� 'P300'������ ��ǰ���� ��ȸ�Ͻÿ�.
        Alias ��ǰ��ȣ, ��ǰ��, �з��ڵ�
    SELECT  PROD_ID     AS  ��ǰ��ȣ,
            PROD_NAME   AS  ��ǰ��,
            PROD_LGU    AS  �з��ڵ�
    FROM    PROD
    WHERE   PROD_LGU BETWEEN 'P100' AND 'P102'
    OR      PROD_LGU BETWEEN 'P301' AND 'P302'
    ORDER BY 3;