2022-0831-01)��������
  - SQL���� �ȿ� �� �ٸ� SQL ������ �����ϴ� ���� �ǹ�
  - �˷����� ���� ���ǿ� �ٰ��Ͽ� ������ �˻��� �� ����    ex)��ձ޿����� ���� �޿��� �̾ƶ�.->��ձ޿��� �� �� ����.
  - SELECT, DML(UPDATE, DELETE), CREATE TABLE,
    VIEW(�̸��� �ִ� VIEW�� ���� ����� �� �ִ�. ���ݱ��� �ǽ��� SELECT���� ����� VIEW�ε� �̸��� ��� ������� �ʾҴ�)���� ���  
  - ���������� '( )'�ȿ� ���(��, INSERT INTO�� ���Ǵ� ���������� ����)
  --�⺻Ű �ܷ�Ű�� ���簡 �ȵǰ� �÷��� �����Ͱ� �����ϴµ� ����� �� �ִ�(CREAT TABLE).
  --�߰����� ����ϰ� ���� �� ���� ���̴�. ���������� �����ϰ� �ִ� ���� ����������� �Ѵ�.
  --�������(��������� ��ȸ�ϴ�)�ϴ� ���� ���� ������ ���� ���̴�.
  
  - �з�
    . �Ϲݼ�������(SELECT���� ������ ��������), IN LINE ��������(FROM���� ������ ��������:�ݵ�� ������ �����ϸ� ȥ�� ������ �����ؾ��ϴ� ���� Ư¡�̴�.), 
      ��ø��������(WHERE���� ������ ��������) 
    . ������ �ִ� ��������(���μ��������� ���� ���̺�� ���������� ���� ���̺��� �������� ������� �ʾ��� ��), 
      ������ ���� ��������(���μ��������� ���� ���̺�� ���������� ���� ���̺��� �������� ����Ǿ��� ��)
    . ������(������)�������� --(���迬���� 6������ ���Ǿ����� ��������,�������� ����� 1���� ���;��Ѵ�)/
      / ���Ͽ�(���߿�)�������� 
      
  1)������ ���� ��������
    - ���������� ���� ���̺�� ���������� ���� ���̺� ���̿� ������ ������� �ʴ� ��������
  
  ����) ������̺��� ������� ��ձ޿����� ���� �޿��� �޴� ����� ��ȸ�Ͻÿ�.
         Alias�� �����ȣ,�����,��å�ڵ�,�޿�
         
         (�Ϲݼ���������/��ø��������/���迬���� �����ʿ��� �� �� �ִ�. ���������� SALARY �������� ���� �� ����)
         (�������� : ������̺��� ������� �����ȣ,�����,��å�ڵ�,�޿�)
         SELECT �����ȣ,�����,��å�ڵ�,�޿���ȸ 
           FROM HR.EMPLOYEES
          WHERE SALARY > (��ձ޿�--��������)  
         
         (�������� : ��ձ޿�)
         SELECT AVG(SALARY)
           FROM HR.EMPLOYEES
         
         (����)
          SELECT EMPLOYEE_ID AS �����ȣ,
                 EMP_NAME AS �����,
                 JOB_ID AS ��å�ڵ�,
                 SALARY AS �޿���ȸ 
            FROM HR.EMPLOYEES
           WHERE SALARY >(SELECT AVG(SALARY) --����Ƚ���� 107�� ����ȴ�
                            FROM HR.EMPLOYEES)
        ORDER BY 4 DESC;
         
         
       (IN LINE ����������)
          SELECT A.EMPLOYEE_ID AS �����ȣ,
                 A.EMP_NAME AS �����,
                 A.JOB_ID AS ��å�ڵ�,
                 A.SALARY AS �޿���ȸ 
            FROM HR.EMPLOYEES A, (SELECT AVG(SALARY) AS SAL
                                    FROM HR.EMPLOYEES) B --����Ƚ���� 1�� ���̴�. ���������� ������ �����ϴ�. �������� ���̺�� �丸�� �� �� �ִ�.
           WHERE A.SALARY > B.SAL
        ORDER BY 4 DESC;
    
    
    

    
    
��뿹)2017�� ���Ŀ� �Ի��� ����� �����ϴ� �μ��� ��ȸ�Ͻÿ�.
      Alias �μ���ȣ,�μ���,���������ȣ
    
    (�������� : �μ���ȣ,�μ���,���������ȣ)
     SELECT DISTINCT A.DEPARTMENT_ID AS �μ���ȣ,
            B.DEPARTMENT_NAME AS �μ���,
            A.MANAGER_ID AS ���������ȣ
       FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
      WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
        AND B.DEPARTMENT_ID IN(��������)    --EXTRACT ��¥ �����Ϳ��� 6���� ��¥ ��������� �����͸� ���� �� ����Ѵ�.�̷��� �̾Ƴ� �ڷ� Ÿ���� ����.
       
       
     (��������:2017�� ���Ŀ� �Ի��� ����� �����ϴ� �μ�)
      SELECT DEPARTMENT_ID 
        FROM HR.EMPLOYEES
       WHERE HIRE_DATE>TO_DATE('20161231')
       
     (����)
     ������ ���� ��������
     SELECT DISTINCT A.DEPARTMENT_ID AS �μ���ȣ,
            B.DEPARTMENT_NAME AS �μ���
       FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
      WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
        AND A.DEPARTMENT_ID IN(SELECT DISTINCT DEPARTMENT_ID
                                 FROM HR.EMPLOYEES
                                WHERE HIRE_DATE>TO_DATE('20161231')) --������ ��������
   ORDER BY 1;
                    
                    
    ������ �ִ� ��������              
     SELECT DISTINCT A.DEPARTMENT_ID AS �μ���ȣ,
            B.DEPARTMENT_NAME AS �μ���
       FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
      WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
        AND EXISTS(SELECT 1
                     FROM HR.EMPLOYEES C
                    WHERE HIRE_DATE>TO_DATE('20161231')
                      AND C.EMPLOYEE_ID=A.EMPLOYEE_ID) --���ο��� ���� �����ڰ� ����Ǿ���Ѵ�.
    ORDER BY 1;                      

    
��뿹)��ǰ���̺��� ��ǰ�� ����ǸŰ����� �ǸŰ��� �� ���� ��ǰ�� ��ǰ��ȣ,��ǰ��,�з���,�ǸŰ��� ��ȸ�Ͻÿ�.
      Alias ��ǰ��ȣ,��ǰ��,�з���,�ǸŰ�
     
     (�������� : ����ǸŰ����� �ǸŰ��� �� ���� ��ǰ�� ��ǰ��ȣ,��ǰ��,�з���,�ǸŰ�)
         SELECT A.PROD_ID AS ��ǰ��ȣ,
                A.PROD_NAME AS ��ǰ��,
                B.LPROD_NM AS �з���,
                A.PROD_PRICE AS �ǸŰ��� 
           FROM PROD A, LPROD B 
          WHERE PROD_PRICE > (����ǸŰ�--��������)  
     
     (�������� : ����ǸŰ�)
         SELECT AVG(PROD_PRICE)
           FROM PROD
           
     (����)
        SELECT A.PROD_ID AS ��ǰ��ȣ,
                A.PROD_NAME AS ��ǰ��,
                B.LPROD_NM AS �з���,
                A.PROD_PRICE AS �ǸŰ��� 
           FROM PROD A, LPROD B,(SELECT AVG(PROD_PRICE) AS CAVG
                                     FROM PROD) TC
          WHERE A.PROD_LGU=B.LPROD_GU --������ �־��ֱ�
            AND A.PROD_PRICE > TC.CAVG
       ORDER BY 4 ASC;
          
          

��뿹)ȸ�����̺��� 2000�� ���� ����� ȸ������ �����ϰ� �ִ� ���ϸ������� 
      �� ���� ���ϸ����� ������ ȸ���� ȸ����ȣ,ȸ����,�ֹι�ȣ,���ϸ����� ��ȸ�Ͻÿ�
      Alias  ȸ����ȣ,ȸ����,�ֹι�ȣ,���ϸ���
      
      (�������� : ���ϸ����� �����ϰ� �ִ� ȸ������ ȸ����ȣ,ȸ����,�ֹι�ȣ,���ϸ���)





      (�������� : 2000�� ���� ����� ȸ������ �����ϰ� �ִ� ���ϸ���)

        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_REGNO1||MEM_REGNO2 AS �ֹι�ȣ,
               MEM_MILEAGE AS ���ϸ���
          FROM MEMBER,(SELECT MEM_MILEAGE AS MM
                         FROM MEMBER 
                        WHERE MEM_BIR >= TO_DATE('20000101')) TM  
          WHERE MEM_MILEAGE > ALL(TM.MM)
       ORDER BY 4;
 
        --ALL�� AND�� ����
        SELECT A.MEM_ID AS ȸ����ȣ,
               A.MEM_NAME AS ȸ����,
               A.MEM_REGNO1||MEM_REGNO2 AS �ֹι�ȣ,
               A.MEM_MILEAGE AS A���ϸ���
          FROM MEMBER A
          WHERE A.MEM_MILEAGE > ALL(SELECT TM.MEM_MILEAGE
                           FROM MEMBER TM
                          WHERE TM.MEM_BIR < TO_DATE('20000101')
                          )
       ORDER BY 4;
       
       --ANY�� OR�� ���� => 900���� ū
       SELECT A.MEM_ID AS ȸ����ȣ,
               A.MEM_NAME AS ȸ����,
               A.MEM_REGNO1||MEM_REGNO2 AS �ֹι�ȣ,
               A.MEM_MILEAGE AS A���ϸ���
          FROM MEMBER A
          WHERE A.MEM_MILEAGE > ANY(SELECT TM.MEM_MILEAGE
                           FROM MEMBER TM
                          WHERE TM.MEM_BIR < TO_DATE('20000101')
                          )
       ORDER BY 4;
 
 
        
        
        
        
        (2000�� ���Ŀ� �¾ �ֵ��� ���ϸ���)
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_REGNO1||MEM_REGNO2 AS �ֹι�ȣ,
               MEM_MILEAGE AS ���ϸ���
          FROM MEMBER 
         WHERE MEM_BIR >= TO_DATE('20000101')



      

    
��뿹)��ٱ������̺��� 2020�� 5�� ȸ���� �ְ� ���űݾ��� ����� ȸ���� ��ȸ�Ͻÿ�
      Alias ȸ����ȣ,ȸ����,���űݾ��հ�
      
      
      (�������� : 2020�� 5�� ȸ���� ���űݾ� DESC / ȸ���̸����� �ʿ��� ��� ���̺��� �� ���� )
      SELECT A.CART_MEMBER AS CID, --ȸ����ȣ
             SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM --���űݾ� �հ�
        FROM CART A, PROD B
       WHERE A.CART_PROD=B.PROD_ID
         AND A.CART_NO LIKE '202005%'
    GROUP BY A.CART_MEMBER
    ORDER BY 2 DESC;


      (�������� : �������� ��� �� �� ù�ٿ� �ش��ϴ� �ڷ� ��� )
      (����)
      SELECT TA.CID AS ȸ����ȣ,
             M.MEM_NAME AS ȸ����,
             TA.CSUM AS ���űݾ��հ�
        FROM MEMBER M,  (SELECT A.CART_MEMBER AS CID, --ȸ����ȣ
                                SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM --���űݾ� �հ�
                           FROM CART A, PROD B
                          WHERE A.CART_PROD=B.PROD_ID
                            AND A.CART_NO LIKE '202005%'
                       GROUP BY A.CART_MEMBER
                       ORDER BY 2 DESC) TA --�ζ��� ��������, �ڱ� ȥ�� ������ �����ؼ� ����� �� �ִ� ����
      WHERE M.MEM_ID=TA.CID --�� ���� ���ƾ� ȸ������ ���� �� �� �ִ�
        AND ROWNUM=1; --������������ ����� ���̺��� ������̺��� �̸��� ����ϰ� �� �� �ֻ��� 1���� �̾Ƴ����ϴ� �� ��������
        
        
     (WITH�� ���)
     WITH A1 AS (SELECT A.CART_MEMBER AS CID, --ȸ����ȣ
                        SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM --���űݾ� �հ�
                   FROM CART A, PROD B
                  WHERE A.CART_PROD=B.PROD_ID
                    AND A.CART_NO LIKE '202005%'
               GROUP BY A.CART_MEMBER
               ORDER BY 2 DESC)
        SELECT B.MEM_ID, B.MEM_NAME, A1.CSUM
          FROM MEMBER B, A1
         WHERE B.MEM_ID=A1.CID
           AND ROWNUM=1; 
        
        
        
        
