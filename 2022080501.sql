2022-0805-01)������ Ÿ��
    -   ����Ŭ���� ���ڿ�, ����, ��¥, ������ �ڷ�Ÿ���� ����
    1. ���� ������Ÿ��
        . ����Ŭ�� �����ڷ�� ' ' �ȿ� ����� �ڷ�(������ ������ ����ǥ �ȿ� ���ڵ��� ASCII �ڵ�� �����)
        --> ����ǥ �ȿ��� ��ҹ��� ���� �ֳĸ� �ڵ� ���� �ٸ��ŵ� A�� a��
        . ��ҹ��� ����
        . CHAR, VARCHAR, VARCHAR2, NVARCHAR2, LONG, CLOB, NCLOB ���� ������
        //CHARACTOR : ��������(ū �� ���� ���� ���� �� ����Ŭ�� �߷������� ���� ���� �Է��� �� �� ��)
        //CHAR ���� �������� �� �������� VARIABLECHARATOR --> �� ������ ��� �ü���� �ݳ���
        //VARCHAR2�� ����Ŭ������ ���� VARCHAR�� ��������� �Ȱ��� 
        //N�� NATIONAL(�ٱ��� ����) --> UTF-16���, 8��ĵ�?
        //LONG 2GB ���ڿ� ������ �� �� --> ���ӰԴ� ���� ����� ��
        //CHARATER LARGE OBJECT 4GB ���ڿ� ������ �� ��
        *()�� ��� []�� �ᵵ �ǰ� �� �ᵵ �ǰ�?
    1)  CHAR(n[BYTE|CHAR])
    - �������� ���ڿ� ����
    - �ִ� 2000BYTE���� ���尡��
    - 'n[BYTE|CHAR]' : '[BYTE|CHAR]'�� �����Ǹ� BYTE�� ���
        'CHAR'�� n���ڼ����� ����(������ ����)
    - �߿��߿�)(�ϼ���)�ѱ� �� ���ڴ� 3BYTE�� ����(n�� 2000�̶�� 666������ ��� ����) <-> (������)
    - �⺻Ű�� ���̰� ������ �ڷ�(�ֹι�ȣ, �����ȣ)�� ���缺�� Ȯ���ϱ� ���� ���
    - �ݵ�� ũ�� ���� �ʿ�! *�ҹ��� c ĳ���� d�� ������
    *���ڴ� ���� ���� ������� ������ ����
��뿹)
CREATE TABLE TEMP01(
    COL1 CHAR(10),
    COL2 CHAR(10 BYTE),
    COL3 CHAR(10 CHAR));
    
INSERT INTO TEMP01 VALUES('����','���ѹ�','���ѹα�');

SELECT * FROM TEMP01;

//LENGTHB ���� Ȯ��

SELECT LENGTHB(COL1) AS COL1,
       LENGTHB(COL2) AS COL2,
       LENGTHB(COL3) AS COL3
    FROM TEMP01;
//���ѹα�(4*3=12) ������ 6���� ���� �������� �����
//CHAR!!!�̶�

    2) VARCHAR2(n{BYTE|CHAR])
    - �������� ���ڿ� �ڷ� ����
    - �ִ� 4000BYTE���� ���� ����
    - VARCHAR, NVARCHAR2�� �������� ����
    - ����Ŭ������ �� �� ���� / �� �ܿ��� VARCHAR�� �Ȱ���!!
��뿹)
CREATE TABLE TEMP02(
    COL1 CHAR(20),
    COL2 VARCHAR2(2000 BYTE),
    COL3 VARCHAR2(4000 CHAR));
INSERT INTO TEMP02 VALUES('ILPOSTINO', 'BOYHOOD',
                          '����ȭ ���� �Ǿ����ϴ�-������');
SELECT * FROM TEMP02;

SELECT LENGTHB(COL1) AS COL1,
       LENGTHB(COL2) AS COL2,
       LENGTHB(COL3) AS COL3,
       LENGTH(COL1) AS COL1,
       LENGTH(COL2) AS COL2,
       LENGTH(COL3) AS COL3
    FROM TEMP02;
    
    3) LONG
    - �������� ���ڿ� �ڷ� ����
    - �ִ� 2GB���� ���� ����
    - �� ���̺� �� �÷��� LONGŸ�� ��� ����
    - ���� ��� �������� ����(����Ŭ 8i) => CLOB(CHARATER LARGE OBJECT)�� Upgrade --> �� ���̺� ���� �÷��� ���Ե� �� ����
    * ũ�⸦ �������� �ʰ� ���� ���� �� �ݳ���(����)
(�������)
    �÷��� LONG
    . LONG Ÿ������ ����� �ڷḦ �����ϱ� ���� �ּ� 31bit�� �ʿ�
    =>�Ϻ� ���(LENGTHB ���� �Լ�)�� ���� --> CLOB�� ��� ����
    . SELECT���� SELECT��, UPDATE�� SET��, INSERT���� VALUES������ ��� ����   
��뿹)
CREATE TABLE TEMP03(
    COL1 VARCHAR2(2000),
    COL2 LONG);
    
INSERT INTO TEMP03 VALUES ('������ �߱� ���� 846',' ������ �߱� �Է�� 846');
    
SELECT SUBSTR(COL1,8,3)
    --SUBSTR(COL2,8,3)
    --LENGTHB(COL2)
FROM TEMP03;    
    
    4) CLOB(Chrater Large OBject)
    - ��뷮�� �������� ���ڿ� ����
    - �ִ� 4GB���� ó�� ����
    - �� ���̺� �������� CLOB Ÿ�� ���� ����
    - �Ϻ� ����� DBMS_LOB API(Application Programming Interface)���� �����ϴ� �Լ� ���
(�������)
    �÷��� CLOB
��뿹)
CREATE TABLE TEMP04(
    COL1 VARCHAR2(255),
    COL2 CLOB,
    COL3 CLOB);

INSERT INTO TEMP04 VALUES('APPLE BANANA PERSIMMON','APPLE BANANA PERSIMMON',
                            'APPLE BANANA PERSIMMON');
                            
SELECT * FROM TEMP04;

SELECT SUBSTR(COL1,7,6) AS COL1,
       SUBSTR(COL3,7,6) AS COL3, --> 7���翡�� 6����
       -- LENGTHB(COL2) AS COL4, --> �������� ����
       DBMS_LOB.GETLENGTH(COL2) AS COL4, --> ���ڼ� ��ȯ(LONGŸ���� �� ��)
       DBMS_LOB.SUBSTR(COL2,7,6) AS COL2 --> 6��°���� 7����
    FROM TEMP04;
    
    //TRIM ����ϸ� ���ʿ��� ���� �߶�! LONG�� SUBSTR �� �ƴµ� CLOB�� ó���� �� �ִ� ���̸� SUBSTR�� ��