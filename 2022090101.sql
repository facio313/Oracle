2022-0901-01)
   ** ���������̺� ����
   1) ���̺�� : REMAIN
   2) �÷���
   --------------------------------------------------------------
     �÷���          ������Ÿ��         NULLABLE           PK,FK
   --------------------------------------------------------------
   REMAIN_YEAR      CHAR(4)                             PK  --�⵵
   PROD_ID          VARCHAR2(10)                        PK & FK  --��ǰ�ڵ�
   REMAIN_J_00      NUMBER(5)        DEFAULT 0  --�������
   REMAIN_I         NUMBER(5)                   --�԰����
   REMAIN_O         NUMBER(5)                   --������
   REMAIN_J_99      NUMBER(5)        DEFAULT 0  --�⸻(��)���
   REMAIN_DATE      NUMBER(5)        DEFAULT SYSDATE  --��������
   
   
CREATE TABLE REMAIN(
   REMAIN_YEAR      CHAR(4),
   PROD_ID          VARCHAR2(10),
   REMAIN_J_00      NUMBER(5) DEFAULT 0,
   REMAIN_I         NUMBER(5),
   REMAIN_O         NUMBER(5),
   REMAIN_J_99      NUMBER(5) DEFAULT 0,
   REMAIN_DATE      DATE DEFAULT SYSDATE,
   
CONSTRAINT pk_remain PRIMARY KEY(REMAIN_YEAR, PROD_ID),
CONSTRAINT fk_remain_PROD FOREIGN KEY(PROD_ID) REFERENCES PROD(PROD_ID));



**���������̺�(REMAIN)�� ���� �ڷḦ �Է��ϼ���
 
 �⵵ : 2020��
 ��ǰ�ڵ� : PROD ���̺��� ��� ��ǰ�ڵ�
 ������� : PROD ���̺��� �������(PROD_PROPERSTOCK)
 �԰�/������ : 0
 �⸻��� : PROD ���̺��� �������(PROD_PROPERSTOCK)
 �������� : 2020�� 1�� 1��



 1) INSERT���� SUBQUERY
   . '( )'�� ������� �ʴ´�
   . VALUES ���� �����ϰ� ���������� ���
   -- INSERT ���� �� ������ VALUES ��ſ� ���������� ���� ���ε� ��ȣ�� ���� �ʴ´�.
   
   INSERT INTO REMAIN(REMAIN_YEAR,PROD_ID,REMAIN_J_00,REMAIN_I,REMAIN_O,REMAIN_J_99,REMAIN_DATE)
        SELECT '2020',PROD_ID,PROD_PROPERSTOCK,0,0,PROD_PROPERSTOCK,TO_DATE('20200101')
          FROM PROD;
 COMMIT;
 SELECT * FROM REMAIN;
 
 2) ���������� �̿��� UPDATE��
 (�������)
  UPDATE ���̺�� 
     SET (�÷���1[,�÷���2,...])=(��������)--���������� ����Ʈ���� ���� ������ �ٱ��� �ִ� �÷��� ������ ���ƾ��Ѵ�. WHERE �԰� ������ ��¥���� �����ų �� �ִ� ����
  [WHERE ����]--WHERE ������Ʈ �Ǿ��� �÷��� ã�� ����
  . SET ������ �����ų �÷��� �ϳ��̻��� �ִ� ��� ���� ( )�ȿ� �÷����� ����ϸ� 
    ���������� SELECT ���� �÷�����  ����� ������� 1��1�����Ǿ� �Ҵ��
  . SET ������ ()�� ������� ������ �����ų �÷����� ���������� ����ؾ���
  
  
��뿹) 2020�� 1�� ��ǰ���� �������踦 �̿��Ͽ� ���������̺��� �����Ͻÿ�
       �۾����ڴ� 2020�� 1�� 31���̴�. 
       (1������ 3������ ����غ�Ⱓ�̶� ����, 4�� ������ ���Ը� �߻��Ǿ��ٰ� ����)


       (�������� : ���������̺��� ����)       
       UPDATE REMAIN A --���̺� ��Ī�� �� �� �ִ�
          SET (REMAIN_I,REMAIN_J_99,REMAIN_DATE)=
              (�������� : 2020�� 1�� ��ǰ�� ���Լ�������)
        WHERE  A.PROD_ID IN(SELECT BUY_PROD --� ��ǰ�� ������Ʈ�ؾߵǴ��� ����������.
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'))--2020�� 1���� ���Ե� ��ǰ �ڵ尡 ���´�
 

       (�������� : 2020�� 1�� ��ǰ�� ���Լ�������)
       
        SELECT BUY_PROD,
               SUM(BUY_QTY)
          FROM BUYPROD
         WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
      GROUP BY BUY_PROD;--��ǰ�� ���Լ��� ���� 39���� ���´�
      
      
      
      (����)
       UPDATE REMAIN A --���̺� ��Ī�� �� �� �ִ�
          SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
              (SELECT A.REMAIN_I + B.BSUM, 
                      A.REMAIN_J_99 + B.BSUM, 
                      TO_DATE('20200131')
                 FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM--(���Լ���)
                         FROM BUYPROD
                        WHERE BUY_DATE BETWEEN TO_DATE('20200101') 
                          AND TO_DATE('20200131')
                     GROUP BY BUY_PROD
                     ORDER BY 1) B
                WHERE A.PROD_ID=B.BUY_PROD
                )
        WHERE  A.PROD_ID IN(SELECT BUY_PROD --� ��ǰ�� ������Ʈ�ؾߵǴ��� ����������.
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'));--2020�� 1���� ���Ե� ��ǰ �ڵ尡 ���´�
 
 
 
 
 ��뿹) 2020�� 2-3�� ��ǰ���� �������踦 �̿��Ͽ� ���������̺��� �����Ͻÿ�
       �۾����ڴ� 2020�� 3�� 31���̴�. 
       
       
       (�������� : ���������̺��� ����)       
       UPDATE REMAIN A --���̺� ��Ī�� �� �� �ִ�
          SET (REMAIN_I,REMAIN_J_99,REMAIN_DATE)=
              (�������� : 2020�� 2-3�� ��ǰ�� ���Լ�������)
        WHERE  A.PROD_ID IN(SELECT BUY_PROD --� ��ǰ�� ������Ʈ�ؾߵǴ��� ����������.
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200331'))--2020�� 3���� ���Ե� ��ǰ �ڵ尡 ���´�
 
       
       (�������� : 2020�� 3�� ��ǰ�� ���Լ�������)
        SELECT BUY_PROD,
               SUM(BUY_QTY)
          FROM BUYPROD
         WHERE BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331')
      GROUP BY BUY_PROD;--��ǰ�� ���Լ��� ���� 39���� ���´�
       

       (����)
        UPDATE REMAIN A --���̺� ��Ī�� �� �� �ִ�
          SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
              (SELECT A.REMAIN_I + B.BSUM, 
                      A.REMAIN_J_99 + B.BSUM, 
                      TO_DATE('20200331')
                 FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM--(���Լ���)
                         FROM BUYPROD
                        WHERE BUY_DATE BETWEEN TO_DATE('20200201') 
                          AND TO_DATE('20200331')
                     GROUP BY BUY_PROD
                     ORDER BY 1) B
                WHERE A.PROD_ID=B.BUY_PROD
                )
        WHERE  A.PROD_ID IN(SELECT BUY_PROD --� ��ǰ�� ������Ʈ�ؾߵǴ��� ����������.
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200331'));--2020�� 2-3���� ���Ե� ��ǰ �ڵ尡 ���´�
 
       
       
       
       
       
��뿹) 2020�� 4-7�� ���Ը������踦 �̿��Ͽ� ���������̺��� �����Ͻÿ�
       �۾����ڴ� 2020�� 8�� 1���̴�.
       
      (�������� : ���������̺��� ����)   
      
      
       UPDATE REMAIN A --���̺� ��Ī�� �� �� �ִ�
          SET (A.REMAIN_I,A.REMAIN_O,A.REMAIN_J_99,A.REMAIN_DATE)=
              (�������� : 2020�� 4-7�� ��ǰ�� ��������)B
              (�������� : 2020�� 4-7�� ��ǰ�� ��������)C
        WHERE  A.PROD_ID IN(SELECT A.BUY_PROD, 
                                   SUM(A.BUY_QTY),
                                   SUM(B.CART_QTY)
                              FROM BUYPROD A, CART B
                             WHERE B.CART_PROD=A.BUY_PROD
                               AND BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200731')
                               GROUP BY A.BUY_PROD);--2020�� 4-7���� ���Ը���� ��ǰ �ڵ尡 ���´�
 
       

      (�������� : 2020�� 4-7�� ��ǰ�� ��������)B
        SELECT BUY_PROD, 
               SUM(BUY_QTY) AS BSUM
          FROM BUYPROD 
         WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200731')
      GROUP BY BUY_PROD;  --74��
       
       
       (�������� : 2020�� 4-7�� ��ǰ�� ��������)
        SELECT CART_PROD, 
               SUM(CART_QTY) AS CSUM
          FROM CART 
         WHERE SUBSTR(CART_NO,0,8) BETWEEN TO_DATE('20200401') AND TO_DATE('20200731')   
      GROUP BY CART_PROD; --73��
       
       
       
        (����)
         UPDATE REMAIN A --���̺� ��Ī�� �� �� �ִ�
           SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
                (SELECT A.REMAIN_I+BSUM,
                        A.REMAIN_J_99+BSUM,
                        TO_DATE('20200801')
                  FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM
                          FROM BUYPROD 
                         WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200731')
                      GROUP BY BUY_PROD) B
             WHERE  A.PROD_ID=B.BUY_PROD)
        WHERE  A.PROD_ID IN(SELECT BUY_PROD 
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN TO_DATE('20200401') 
                               AND TO_DATE('20200731'));
                             
                             
                             
        (����)
         UPDATE REMAIN A --���̺� ��Ī�� �� �� �ִ�
           SET (A.REMAIN_O,A.REMAIN_J_99,A.REMAIN_DATE)=
                (SELECT A.REMAIN_O+CSUM,
                        A.REMAIN_J_99-CSUM,
                        TO_DATE('20200801')
                   FROM (SELECT CART_PROD, 
                               SUM(CART_QTY) AS CSUM
                         FROM CART 
                        WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007'   
                     GROUP BY CART_PROD) C
             WHERE  A.PROD_ID=C.CART_PROD)
        WHERE  A.PROD_ID IN(SELECT CART_PROD
                              FROM CART
                             WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007');    
                             
                             
  --���߿� Ŀ���ؾ��� �� �����̶� ���� ���� �� �� ���� �Ŀ� Ŀ���ϱ�                           
                             
                             
  3) ���������� �̿��� DELETE��
  (�������)
  DELETE FROM ���̺��
   WHERE ����
   
   -'����'�� IN�̳� EXISTS �����ڸ� ����Ͽ� ���������� ����
   
   
   
   
   
��뿹)��ٱ������̺��� 2020�� 4�� 'm001'ȸ���� �����ڷ� �� 'p202000005' ��ǰ��
      ���ų����� �����Ͻÿ�.
    
    DELETE FROM CART A
     WHERE EXISTS(SELECT 1
                   FROM MEMBER B
                  WHERE B.MEM_ID='m001'
                    AND B.MEM_ID=A.CART_MEMBER)
       AND A.CART_NO LIKE '202004%'
       AND A.CART_PROD = 'p202000005';
                                
ROLLBACK;
                             
                             