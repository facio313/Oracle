2022-0808-01)
3. ��¥�ڷ���
    - ��¥ �ð� ������ ����(��, ��, ��, ��, ��, ��)
    - ��¥ �ڷ�� ������ ������ ������
    - date, timestamp(3���� - ���� ������ �ð�) Ÿ�� ����
 1)DATE Ÿ��
 . �⺻ ��¥ �� �ð����� ���� (��/��/��/��/��/�� -> SELECT�� �ҷ��� �� ��/��/�ʴ� �� ����, ������ ����� ��)
(�������)
    �÷��� DATE
    . ������ ������ ������ŭ �ٰ��� ��¥(�̷�)
    . ������ ������ ������ŭ ������ ��¥(����)
    . ��¥ �ڷ� ������ ������ �� ��(DASY) ��ȯ(ū ��¥ - ���� ��¥)
    . ��¥�ڷ�� ��/��/��(�⺻)�� ��/��/��(�߰�) �κ����� �����Ͽ� ����
    . ��Ȯ�� �������� �����ؾ� ��(������ �� �� ����x)
    . ��/��/�ʸ� �������� ������ 0�� 0�� 0��!
    . �޷� �����?? ����, ��������  �� ��
    . DATE�� ũ�Ⱑ ����
    ** �ý����� �����ϴ� ��¥������ SYSDATE�Լ��� ���Ͽ� ������ �� ����
��뿹) CREATE TABLE TEMP06(
            COL1 DATE,
            COL2 DATE,
            COL3 DATE);
            
        INSERT INTO TEMP06 VALUES(SYSDATE, SYSDATE-10, SYSDATE+10);
        SELECT * FROM TEMP06;
        SELECT TO_CHAR(COL1, 'YYYY-MM-DD'), -- ���� ���� ���ڿ�
               TO_CHAR(COL2, 'YYYY-MM-DD HH24:MI:SS'),
               TO_CHAR(COL3, 'YYYY-MM-DD HH12:MI:SS')
            FROM TEMP06;
            
        SELECT CASE MOD(TRUNC (SYSDATE) - TRUNC(TO_DATE('00010101'))-1,7) -- TRUNC ����(�ڷ� ������) MOD : ������
                WHEN 1 THEN '������' -- �б⹮ / IF�� SWITCH�� ���� ���� �׷��� �̷��� ����ϰ� ��
                WHEN 1 THEN 'ȭ����'
                WHEN 1 THEN '������'
                WHEN 1 THEN '�����'
                WHEN 1 THEN '�ݿ���'
                WHEN 1 THEN '�����'
                ELSE '�Ͽ���'
            END AS ����    
            FROM DUAL; -- SELECT ������ FROM���� �� ����� ��, ���̺��� �ʿ�� ������ FROM �԰��� ���� �ʿ���
            
        SELECT SYSDATE-TO_date('20200807') FROM DUAL;
        
 2)TIMESTAMP Ÿ��
 . �ð��� ����(TIME ZONE)�� ������ �ð�����(10����� 1��)�� �ʿ��� ��� ���

(�������)
    �÷��� TIMESTAMP - �ð��� ���� ���� ������ �ð����� ����
    �÷��� TIMESTAMP WITH LOCAL TIME ZONE - �����ͺ��̽��� � ���� ������ �ð��븦 �������� 
                                            ������ �����ϴ�Ŭ���̾�Ʈ���� ������ ���� �ð� �Է�
                                            �ð��� Ŭ���̾�Ʈ ������ �ð����� �ڵ� ��ȯ ��µǱ� ������
                                            �ð��� ������ ������� ����
    �÷��� TIMESTAMP WITH TIME ZONE - ������ �ð��� ���� ���� �ƽþ�/���� �����/���ø�
    
    . �ʸ� �ִ� 9�ڸ����� ǥ���� �� ������ �⺻�� 6�ڸ���
    
��뿹)
CREATE TABLE TEMP07
 (COL1 DATE,
  COL2 TIMESTAMP,
  COL3 TIMESTAMP WITH LOCAL TIME ZONE,
  COL4 TIMESTAMP WITH TIME ZONE);
    
INSERT INTO TEMP07 VALUES(SYSDATE, SYSDATE, SYSDATE, SYSDATE);
SELECT * FROM TEMP07;