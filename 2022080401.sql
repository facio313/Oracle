    ������ ���Ǿ�(DDL:Data Definition Language)
        - ������ ������ �����ϱ� ���� ���̺� ����, ����, ���� ���
        - CREATE, DROP, ALTER
    1. ���̺� �������
    (�������)
        CREATE TABLE ���̺��(
        �÷��� ������ Ÿ��[(ũ��)] [NOT NULL] [DEFAULT ��][,]
                                :
        �÷��� ������ Ÿ��[(ũ��)] [NOT NULL] [DEFAULT ��][,]
        [CONSTRAINT �⺻Ű������ PRIMARY KEY(�÷���[,�÷���,...])[,]]
        [CONSTRAINT �ܷ�Ű������1 FOREIGN KEY(�÷���) REFERENCES ���̺��(�÷���) DELETE ON CASCADE[,]]
                                :
        [CONSTRAINT �ܷ�Ű������n FOREIGN KEY(�÷���) REFERENCES ���̺��(�÷�) DELETE ON CASCADE];
        
        - �⺻Ű������ : �⺻Ű������ �ο��� �̸����� �ߺ������ �� ����
        - �ܷ�Ű������1 : �ܷ�Ű������ �ο��� �̸����� �ߺ������ �� ��
        - REFERENCES ���̺�� : �θ����̺��
        - REFERENCES ���̺��(�÷���) : �θ����̺��� ����� �÷���
        - DELETE ON CASCADE : �θ����̺��� Ư����(ROW) ���� �� �ڽ����̺��� �ڷ���� �����ϰ� 
        �θ� �ڷ� ���� ���
        
��뿹) �ѱ��Ǽ� �䱸���׿� �´� �����ͺ��̽��� ��������

(������̺�)
CREATE TABLE EMP(
    EMP_ID CHAR(4),
    EMP_NAME VARCHAR2(30),
    DEPT_NAME VARCHAR2(50),
        CONSTRAINT pk_emp PRIMARY KEY(EMP_ID));
 
(����� ���̺�)
CREATE TABLE TBL_SITE(
    SITE_ID NUMBER(3) NOT NULL,
    SITE_NAME VARCHAR2(50),
    SITE_ADDR VARCHAR2(255))
        CONSTRAINT pk_tbl_site PRIMARY KEY(SITE_ID));
   
(����� ���� ���̺�)
CREATE TABLE TBL_MAT (
    MAT_ID CHAR(3),
    MAT_NAME VARCHAR2(50),
    SITE_ID NUMBER(3),
    CONSTRAINT pk_tbl_mat PRIMARY KEY(MAT_ID),
    CONSTRAINT fk_tbl_mat_site FOREIGN KEY(SITE_ID)
        REFERENCES SITE(SITE_ID));
       
(�ٹ� ���̺�)
CREATE TABLE TBL_WORK(
    EMP_ID CHAR(4),
    SITE_ID NUMBER(3),
    INS_DATE DATE,
    CONSTRAINT pk_tbl_work PRIMARY KEY(EMP_ID,SITE_ID),
    CONSTRAINT fk_tbl_work_emp FOREIGN KEY(EMP_ID)
        REFERENCES EMP(EMP_ID),
    CONSTRAINT fk_tbl_work_site FOREIGN KEY(SITE_ID)
        REFERENCES SITE(SITE_ID));
        
2. DROP TABLE
- ���̺� ���� ���
- ���谡 ������ �θ����̺��� ���Ƿ� ������ �� ����
    => ���谡 ������ �� �Ǵ� �ڽ����̺��� ������ �� ���� ����
(�������)
DROP TABLE ���̺��;
//���ݱ����� �޸� �κп��� �����س��� ��
COMMIT; //�ϵ���� �������� �����ؾ� �Ϸ�� ��

��뿹) ����� ���̺��� �����Ͻÿ�.
--�ڽ����̺���� ����
DROP TABLE TBL_MAT;
DROP TABLE TBL_WORK;
DROP TABLE TBL_SITE;

ROLLBACK; // DROP�� ROLLBACK�� ����� �ƴ�! DROP�� TABLE�� ����ü ���ֹ����� ��

--�������� ���� �� ���̺� ����
ALTER TABLE ���̺�� DROP CONSTRAINT �⺻Ű������|�ܷ�Ű������;

ALTER TABLE TBL_MAT DROP CONSTRAINT fk_tbl_mat_site;
ALTER TABLE TBL_WORK DROP CONSTRAINT fk_tbl_work_site;
DROP TABLE TBL_SITE;

COMMIT;

3. ALTER ���
- ���̺� �̸�����, �÷��̸� ����, �÷�Ÿ�Ժ���(���� �����δ� �� �ǰ� ū ������ ����-JAVA�ڵ�Ÿ�Ժ�ȯ ����)
- �÷�����, �������� �߰�����
- �÷�����, �������� ���� ���� ����� ����
*���������� ���� �� �� --> �����ϰ� �����ؾ� ��

1)���̺� �̸� ����
    ALTER TABLE ���� ���̺�� RENAME TO ������ ���̺��;
    ��뿹)��������̺�(TBL_SITE)�� �����ϰ� SITE�� ���̺���� �����Ͻÿ�.
        ALTER TABLE TBL_SITE RENAME TO SITE;
2)�÷� �̸� ����
    ALTER TABLE ���̺�� RENAME COLUMN ���� �÷��� TO ������ �÷���;
    ��뿹)SITE���̺� ������ּ�(SITE_ADDR) �÷����� SITE_ADDRESS�� �����Ͻÿ�.
        ALTER TABLE SITE RENAME COLUMN SITE_ADDR TO SITE_ADDRESS;
3)�÷��� ������ Ÿ�� �Ǵ� ũ�� ����
    ���� �÷��� ũ�⺸�� ���� ũ��� ������ ������ ����(����Ŭ�� ���� �Ұ�!!� ����!!)
    ALTER TABLE ���̺�� MODIFY �÷��� Ÿ��[(ũ��)] // �����ϴ� �Ͱ� �Ȱ���
    ��뿹)SITE���̺��� SITE_ADDRESS�÷�(VARCHAR2(255))�� �������� ���ڿ� 100BYTE(CHAR(100))�� �����Ͻÿ�.
        ALTER TABLE SITE MODIFY SITE_ADDRESS CHAR(30);// �ڷᰡ ���� ���� ����Ǵµ� �ڷᰡ ���ԵǸ� ���� �� ��!!!!!!!
//"cannot decrease column length because some value is too big"
//CHAR�� �������̶� ���� ���̰� ���󰡴� �� �ƴ϶� ������ ��ä������ �����. ���鵵 ��ȿ�ڷ���
//80->50xxxx 80->100OOO ->100->80XXXX
        ALTER TABLE SITE MODIFY SITE_ADDRESS CHAR(80);
        ALTER TABLE SITE MODIFY SITE_ADDRESS VARCHAR(255);
//VARCHAR�� �����̶� ���ɾ�!
INSERT INTO SITE VALUES(101,'�����ʱ����������','������ �߱� ���� 846 3��');
4)�÷� �Ǵ� �������� �߰�
    ALTER TABLE ���̺�� ADD(�÷��� ������Ÿ��[(ũ��)]) �Ǵ�
    ALTER TABLE ���̺�� ADD(CONSTRAINT �⺻Ű������ PRIMARY KEY(�÷���[,...]))
    ALTER TABLE ���̺�� ADD(CONSTRAINT �ܷ�Ű������ FOREIGN KEY(�÷���)
        REFERENCES ���̺��(�÷���))
    ��뿹)SITE���̺� �⺻Ű(SITE_ID)�� �����Ͻÿ�.
        ALTER TABLE SITE ADD(CONSTRAINT pk_site PRIMARY KEY(SITE_ID));
//����, ������ ���� �� �� �Ͼ -> CREAT�� ���������� ALTER�� ���󵵰� ����
//���� DB MANAGER�� �ϴ� ������ ����ڴ� ������ ���� ������ ����
5)�÷� ����, �������� ����
    ALTER TABLE ���̺�� DROP COLUMN �÷���|DROP CONSTRAINT �����̸�;