2022-0808-02)
4. ��Ÿ�ڷ���
    - �����ڷḦ �����ϱ� ���� ������ Ÿ��
    - RAW, LONG RAW, BLOB, BFILE ���� ������
    - �����ڷ�� ����Ŭ�� �ؼ��ϰų� ��ȯ���� �ʴ´�.(HTML, SCRIPT, SPRING, JSP ���� ����)
 1)RAW
    . ���� �����ڷ� ����
    . �ִ� 2000BYTE���� ���� ����
    . �ε��� ó���� ����
    . 16������ 2���� ���·� ����
    . 2���� BINARY, 10���� DECIMAL, 16���� HEXADECIAML, 8���� OCTAL

(�������)
    �÷��� RAW(ũ��)
    
��뿹)
CREATE TABLE TEMP08(
    COL1 RAW(2000));
    
INSERT INTO TEMP08 VALUES('2A7F'); -- 2BYTE
INSERT INTO TEMP08 VALUES(HEXTORAW('2A7F'));
INSERT INTO TEMP08 VALUES('0010101001111111'); -- (2)0010 (A)1010 (7)0111 (F)1111

SELECT * FROM TEMP08
 2)BFILE
 . �����ڷḦ ����
 . ����� �Ǵ� �����ڷḦ �����ͺ��̽� �ܺο� �����ϰ� �����ͺ��̽����� ��� ������ ����
 --�ش� ������ ���̺� �ȿ� ����Ǹ� BLOB �ۿ� ����Ǹ� BFILE
 . �ִ� 4GB���� ���� ����

(�������)
    �÷��� BFILE;

** �ڷ� �������
    (1) �ڷ� �غ�
        D:\A_TeachingMaterial\02_Oracle\SAMPLE.JPG
        
    (2) ���̺� ����
        CREATE TABLE TEMP09(
        COL1 BFILE);
        
    (3) ���丮 ��ü ���� - ������� �� ���ϸ�
        ���丮 ��ü ����
        CREATE OR REPLACE DIRECTORY ��Ī AS '��θ�';
        
        CREATE OR REPLACE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\02_Oracle';
        
    (4) ����
        INSERT INTO TEMP09 VALUES(BFILENAME('TEST_DIR','SAMPLE.jpg'));
        
SELECT * FROM TEMP09; -- ����Ŭ�� ����� �ؼ����� �ʴ´�! �׳� ������ ���̴�. TEMP09�� ������ ���� ���� �ƴ�
-- �׳� ��ζ� �̸��̶� ���ļ� �־��� / DB���� ���븸(������ �ٲٰ� �ʹٸ�) �ٲ��� �̸��̶� ��θ� �ٲ� ���� �ƴ�

 3)BLOB(Binary Large Objects)
    . ���� 2�� �ڷḦ ���̺� ���ο� ����
    . 4GB���� ���� ����

(�������)
    �÷��� BLOB;
    
��뿹)
CREATE TABLE TEMP10(
    COL1 BLOB);
    
    
������ ����
 DECLARE
  L_DIR VARCHAR2(20):='TEST_DIR';
  L_FILE VARCHAR2(30):='SAMPLE.jpg';
  L_BFILE BFILE;
  L_BLOB BLOB;
 BEGIN
  INSERT INTO TEMP10 VALUES(EMPTY_BLOB())
    RETURN COL1 INTO L_BLOB;
    
    L_BFILE:=BFILENAME(L_DIR,L_FILE);
    
    DBMS_LOB.FILEOPEN(L_BFILE,DBMS_LOB.FILE_READONLY);
    DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE, DBMS_LOB.GETLENGTH(L_BFILE));
    DBMS_LOB.FILECLOSE(L_BFILE);
    
    COMMIT;
 END;
 
SELECT * FROM TEMP10;