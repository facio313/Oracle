2022-0830-02)�ܺ�����(OUTER JOIN) --������ ������� ����� ����

  - ���������� ���������� �����ϴ� ����� ��ȯ������, �ܺ������� 
    �ڷᰡ ������ ���̺� NULL���� �߰��Ͽ� ������ ����
  - �������� ����� �ڷᰡ ������ ���̺��� �÷� �ڿ� �ܺ����� ������ '(+)'�� �߰������
  - �ܺ����� ������ �������� �� ��� �ܺ����� ���ǿ� ��� '(+)'�����ڸ� ���
    �ؾ� ��
  - �ѹ��� �� ���̺��� �ܺ������� �� �� ����
    ��, A,B,C ���̺��� �ܺ������� ��� A�� �������� B�� �ܺ������ϰ� ���ÿ� 
    C�� �������� B�� �ܺ������� �� ����(A=B(+) AND C=B(+)�� ������ ����)
    
  - �Ϲ� �ܺ����ο��� �Ϲ������� �ο��Ǹ� ��Ȯ�� ����� ��ȯ���� ����=>
    ���������� ����� �ܺ����� �Ǵ� ANSI�ܺ� �������� �ذ��ؾ���
    
  - IN������ �Ǵ� OR�����ڴ� �ܺ����ο�����('(+)')�� ���� ����� �� ����.--�������̺��ʿ� �ٿ����Ѵ�.
  --�Ϲ������� �ܺ������� ����ϸ� �����ȴ�
  (�Ϲݿܺ����� ����)
  SELECT �÷�list
    FROM ���̺��1 [��Ī1], ���̺��2 [��Ī2],...
   WHERE ��Ī1.�÷���(+)=��Ī2.�÷���2 => ���̺��1�� �ڷᰡ ������ ���̺��� ���
   
   
  (ANSI �ܺ����� �������)
  
                      SELECT �÷�list
                        FROM ���̺��1 [��Ī1]
  RIGHT|LEFT|FULL OUTER JOIN ���̺��2 [��Ī2] ON(��������1 [AND �Ϲ�����1])
                               :
                      [WHERE �Ϲ�����]
  
  -'RIGHT|LEFT|FULL' : FROM���� ����� ���̺�(���̺�1)�� �ڷᰡ 
   OUTER JOIN ���̺��2 ���� ������ 'LEFT', ������ 'RIGHT'
   ���� ��� ������ 'FULL'���
 
 ** 1)SELECT ����ϴ� �÷� �� ���� ���̺� ��� �����ϴ� �÷��� ���� �� ���̺� ���� ����ؾ��Ѵ�
    2)�ܺ������� SELECT���� COUNT�Լ��� ����ϴ� ���
    '*'�� NULL ���� ���� �൵ �ϳ��� ������ �ν��Ͽ� ����Ȯ�� ���� ��ȯ��. ���� '*'��� �ش����̺��� �⺻Ű�� ���
    
��뿹) ��� �з��� ���� ��ǰ�� ���� ����Ͻÿ�.
--   SELECT DISTINCT PROD_LGU
--   FROM PROD
    (�Ϲݿܺ�����)
      SELECT B.LPROD_GU AS �з��ڵ�,
             B.LPROD_NM AS �з���,
             COUNT(A.PROD_ID) AS "��ǰ�� ��" --*�� ���� NULL���� ���� �൵ 1�� ī��Ʈ�ȴ�
        FROM PROD A, LPROD B
       WHERE A.PROD_LGU(+)=B.LPROD_GU
    GROUP BY B.LPROD_GU, B.LPROD_NM
    ORDER BY 1;
    
    
    (ANSI�ܺ�����)  
      SELECT B.LPROD_GU AS �з��ڵ�,
             B.LPROD_NM AS �з���,
             COUNT(A.PROD_ID) AS "��ǰ�� ��" --*�� ���� NULL���� ���� �൵ 1�� ī��Ʈ�ȴ�
        FROM PROD A
       RIGHT OUTER JOIN LPROD B ON(A.PROD_LGU=B.LPROD_GU)--���������� ������ ���� ���̺��� �����Ͱ� ������ right�� ����
    GROUP BY B.LPROD_GU, B.LPROD_NM
    ORDER BY 1;


��뿹) 2020�� 6�� ��� �ŷ�ó�� �������踦 ��ȸ�Ͻÿ�
       Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��հ�
       
       SELECT A.BUYER_ID AS �ŷ�ó�ڵ�, 
              A.BUYER_NAME AS �ŷ�ó��, 
              SUM(B.BUY_QTY*C.PROD_COST) AS ���Աݾ��հ�
         FROM BUYER A, BUYPROD B, PROD C 
        WHERE B.BUY_PROD(+)=C.PROD_ID
          AND A.BUYER_ID=C.PROD_BUYER(+) 
          AND BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
     GROUP BY A.BUYER_ID, A.BUYER_NAME;
     
     
     (ANSI �ܺ�����)
     SELECT A.BUYER_ID AS �ŷ�ó�ڵ�, 
              A.BUYER_NAME AS �ŷ�ó��, 
              NVL(SUM(B.BUY_QTY*C.PROD_COST),0) AS ���Աݾ��հ�
         FROM BUYER A
         LEFT OUTER JOIN PROD C ON(A.BUYER_ID=C.PROD_BUYER) --�������� ������ ���̺� �ڷᰡ �� �پ��ϸ� LEFT�� ����
         LEFT OUTER JOIN BUYPROD B ON(B.BUY_PROD=C.PROD_ID AND --PROD�� �ִ� ��ǰ�ڵ庸�� BUYPROD���� �� �پ��� ��ǰ �ڵ带 ������ �־ LEFT��
              BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630'))
     GROUP BY A.BUYER_ID, A.BUYER_NAME
     ORDER BY 1;
        
     (SUBQUERY)
       SELECT A.BUYER_ID AS �ŷ�ó�ڵ�, 
              A.BUYER_NAME AS �ŷ�ó��, 
              NVL(TBL.BSUM,0) AS ���Աݾ��հ�
         FROM BUYER A,
              (--2020�� 6�� �ŷ�ó�� ���Աݾ��հ�
                SELECT C.PROD_BUYER AS CID,
                       SUM(B.BUY_QTY*C.PROD_COST) AS BSUM
                  FROM BUYPROD B, PROD C 
                 WHERE B.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630')
                   AND B.BUY_PROD = C.PROD_ID
              GROUP BY C.PROD_BUYER) TBL       
         WHERE A.BUYER_ID=TBL.CID(+)
      ORDER BY 1;
     
        
        

��뿹) 2020�� ��ݱ� 1��//�Ϲ����� ���//�ܺ� ��ǰ��//�׷������ ���Լ�������//�� ��ȸ�Ͻÿ�
     --�������ϴ� ��Ȳ, ���ó�¥�� ���ó���� �ϱ� ���ؼ�
     --�������� ���⵵�������� �Ѿ�� �� ��ǰ�� �⺻���� �����Ǵ� ������, �־����� �����Ǿ �ȵȴ�
     --�԰������ ���ϱ� �������� ������ ���� �⸻���(����� �� �ִ�, ���� ���⿡ ����)
     --���Ե� ������ ���ϰ� ��������� ����
     SELECT B.PROD_ID AS ��ǰ�ڵ�, 
            B.PROD_NAME AS ��ǰ��, 
            SUM(A.BUY_QTY) AS ���Լ����հ� --���� ������ ����
       FROM BUYPROD A, PROD B
      WHERE A.BUY_PROD(+)=B.PROD_ID --�̷��� �Ǹ� �������ΰ� �ٸ��� ����.
        AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
   GROUP BY B.PROD_ID, B.PROD_NAME
   ORDER BY 1;
   
   
   (ANSI ���� FORMAT)
      SELECT B.PROD_ID AS ��ǰ�ڵ�, 
             B.PROD_NAME AS ��ǰ��, 
             SUM(A.BUY_QTY) AS ���Լ����հ� --���� ������ ����
        FROM BUYPROD A --�������� ����Ǿ��ִ� �� ������ LEFT
       RIGHT OUTER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID
         AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'))
--    RIGHT OUTER JOIN PROD B ON(A.BUY_PROD=B.PROD_ID)
--    WHERE A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
--�ƿ��������� �� ���� ������ �Ϲ������� ����������Ѵ�
--�̷��� �ϸ� �ƿ������� �� ����� �Ŀ� �������� ����Ǽ� 35���� ���� ���ֱ⶧���� �̷��� �ϸ� �ܺ������� �ǹ̰� ����
    GROUP BY B.PROD_ID,B.PROD_NAME
    ORDER BY 1;
    
    
    (�������� ����)
     SELECT B.PROD_ID AS ��ǰ�ڵ�, 
            B.PROD_NAME AS ��ǰ��, 
            A.BSUM AS ���Լ����հ� 
        FROM PROD B,
            (2020�� 1�� ��ǰ�� ���Լ��� ���� --��������)A
       WHERE B.PROD_ID=A.BUY_PROD(+)
    ORDER BY 1;
        
 (��������   2020�� 1�� ��ǰ�� ���Լ��� ����--��������, ������ ���� �÷����� �ѱ۷� �Ἥ�� �ȵȴ�.)
   SELECT BUY_PROD,--c.���� ��Ű���� ǥ���Ǿ��ִ� ��쿡�� ��Ī�� ������ش�
          SUM(BUY_QTY) AS BSUM
     FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
 GROUP BY BUY_PROD;
     
    
    (����)
    SELECT B.PROD_ID AS ��ǰ�ڵ�, 
            B.PROD_NAME AS ��ǰ��, 
            A.BSUM AS ���Լ����հ� 
        FROM PROD B,
            (SELECT BUY_PROD,--c.���� ��Ű���� ǥ���Ǿ��ִ� ��쿡�� ��Ī�� ������ش�//���������� �������� ���� ���� �Ѵ�.
                    SUM(BUY_QTY) AS BSUM
               FROM BUYPROD
              WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
           GROUP BY BUY_PROD) A
       WHERE B.PROD_ID=A.BUY_PROD(+)
    ORDER BY 1;
    
    
--������ CART

��뿹) 2020�� ��ݱ�4�� ��� ��ǰ�� ����������踦 ��ȸ�Ͻÿ�
       Alias ��ǰ�ڵ�, ��ǰ��, ��������հ�
       
       (ANSI FORMAT)
       SELECT A.PROD_ID AS ��ǰ�ڵ�, 
              A.PROD_NAME AS ��ǰ��, 
              SUM(B.CART_QTY) AS ��������հ� --������ �ƹ��� �߻��Ǿ�� PROD���� ��ǰ������ ���� �� ���⶧���� PROD�� �� ������ ���̺��̴�
         FROM PROD A
         LEFT OUTER JOIN CART B ON(B.CART_PROD=A.PROD_ID AND B.CART_NO LIKE '202004%')
     GROUP BY A.PROD_ID, A.PROD_NAME
     ORDER BY 1;



��뿹)2020�� ��ݱ�6�� ��� ��ǰ�� ����/����������踦 ��ȸ�Ͻÿ�
      Alias ��ǰ�ڵ�, ��ǰ��, ���Լ���, �������
      
      (ANSI ����)
      SELECT A.PROD_ID AS ��ǰ�ڵ�, 
             A.PROD_NAME AS ��ǰ��, 
             SUM(B.BUY_QTY) AS ���Լ���, 
             SUM(C.CART_QTY) AS �������
        FROM PROD A
        LEFT OUTER JOIN BUYPROD B ON(A.PROD_ID=B.BUY_PROD 
         AND B.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630'))
        LEFT OUTER JOIN CART C ON(C.CART_PROD=A.PROD_ID AND C.CART_NO LIKE '202006%')
    GROUP BY A.PROD_ID, A.PROD_NAME
    ORDER BY 1;
      

    
    
  