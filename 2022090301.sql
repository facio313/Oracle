2022-0902-03)����Ŭ ��ü
1. VIEW ��ü
- TABLE�� ������ ��ü
- ������ ���̺��̳� VIEW�� ������� ���ο� SELECT ���� ����� VIEW�� ��
- SELECT���� ���� ��ü�� �ƴ϶� ���� ��ü�� -- ���̺�ó�� ����� �� ����
- �������
    - �ʿ��� ������ �л�Ǿ� �Ź� ������ �ʿ��� ���
    - Ư���ڷ��� ������ �����ϰ��� �ϴ� ���(���Ȼ�)
(�������)
CREAT   [OR REPLACE]    VIEW    ���̸� [(�÷�list)]
AS
    SELECT ��
    [WITH   READ    ONLY]
    [WITH   CHECK   OPTION];
    
    'OR REPLACE' : �̹� �����ϴ� ���� ��� ������ �並 ��ġ�ϰ� �������� �ʴ� ��� ���� ����
    '[(�÷�list)]' : �信�� ����� �÷���(������ ��)
        1) �並 �����ϴ� SELECT ���� SELECT���� �÷���Ī�� ���Ǿ����� �÷���Ī�� ���� �÷����� ��
        2) �並 �����ϴ� SELECT ���� SELECT���� �÷���Ī�� ������ �ʾ����� SELECT���� �÷����� ���� �÷����� ��
    '[WITH   READ    ONLY]' : �б������(�信�� ����) 
        --�������̺��� ������ �� ��. read only�� �信�� ����Ǵ� ��.
        --�������̺��� ����Ǹ� �䵵 �����
        --�� ���� �� ��, �並 �ٲٸ� �������̺� �ٲ�
    '[WITH   CHECK   OPTION]' : �並 �����ϴ� SELECT ���� �������� �����ϵ��� �ϴ� DML ����� ����� �� ����(�信�� ����)
        --�������̺� where���� ������� �ʵ���
****'[WITH   READ    ONLY]'�� '[WITH   CHECK   OPTION]'�� ���� ����� �� ����

��뿹)
ȸ�����̺��� ���ϸ����� 3000�̻��� ȸ���� ȸ����ȣ, ȸ����, ����, ���ϸ����� �並 �����Ͻÿ�

CREATE  OR  REPLACE VIEW    V_MEM01--(MID, MNAME, MJOB, MILE)
AS
SELECT  MEM_ID,--      AS  ȸ����ȣ,
        MEM_NAME,--    AS  ȸ����,
        MEM_JOB,--     AS  ����,
        MEM_MILEAGE-- AS  ���ϸ���
FROM    MEMBER
WHERE   MEM_MILEAGE >= 3000;

SELECT * FROM V_MEM01;

**V_MEM01���� ��ö�� ȸ��(k001)�� ���ϸ����� 2000���� ����
-- VIEW���� �����϶�!! V�� �տ� �پ��³�
-- ���̺�� ��� VIEW �̸� ������ ��
UPDATE  V_MEM01
SET     MEM_MILEAGE = 2000
WHERE   MEM_ID = 'k001';
--V_MEM01 ������ ������ ���ϸ����� 3000 �̻���
--������ ��ö��� 2000���� �ٲ�
--�� ����� �ű⼭ Ż����!
--****������ �ٲ�!!!****
--�׷��ٸ� �������̺��� �ٲٸ� �䰡 �ٲ��?

SELECT * FROM V_MEM01;

**MEMBER���̺��� ��ö�� ȸ��(k001)�� ���ϸ����� 5000���� ����
UPDATE  MEMBER
SET     MEM_MILEAGE = 5000
WHERE   MEM_ID = 'k001';
-- �����ٲ�

SELECT * FROM V_MEM01;

**MEMBER���̺��� ��� ȸ������ ���ϸ����� 1000�� �߰������Ͻÿ�
UPDATE  MEMBER
SET     MEM_MILEAGE = MEM_MILEAGE + 1000;
-- �������̺��� �ٲ�� �䰡 �ڵ����� �ٲ�

SELECT * FROM V_MEM01;

(�б����� ��)
CREATE  OR  REPLACE VIEW    V_MEM01(MID, MNAME, MJOB, MILE)
AS
SELECT  MEM_ID,--      AS  ȸ����ȣ,
        MEM_NAME,--    AS  ȸ����,
        MEM_JOB,--     AS  ����,
        MEM_MILEAGE-- AS  ���ϸ���
FROM    MEMBER
WHERE   MEM_MILEAGE >= 3000
WITH    READ    ONLY;

SELECT * FROM V_MEM01;

**MEMBER���̺��� ��� ȸ���� ���ϸ����� 1000�� ���ҽ�Ű�ÿ�
UPDATE  MEMBER
SET     MEM_MILEAGE = MEM_MILEAGE-1000;

COMMIT;

**�� V_MEM01�� �ڷῡ�� ��ö�� ȸ���� ���ϸ���('k001')�� 3700���� �����Ͻÿ�
UPDATE  V_MEM01
SET     MILE = 3700
WHERE   MID='k001';
-- READ ONLY VIEW�̱� ������ ���� ���� ����!! SELECT�� �����ϴٱ�!!
-- UPDATE�� ������ �Ұ�����
-- �������̺����� �󸶵��� DML ���ɾ�~~~~

(���Ǻο� ��)
CREATE  OR  REPLACE VIEW    V_MEM01(MID, MNAME, MJOB, MILE)
AS
SELECT  MEM_ID,--      AS  ȸ����ȣ,
        MEM_NAME,--    AS  ȸ����,
        MEM_JOB,--     AS  ����,
        MEM_MILEAGE-- AS  ���ϸ���
FROM    MEMBER
WHERE   MEM_MILEAGE >= 3000
WITH    CHECK   OPTION; -- ���⼭ �ɼ��� WHERE!!

SELECT * FROM V_MEM01;

**�� V_MEM01���� �ſ�ȯ ȸ��('c001')�� ���ϸ����� 5500���� �����Ͻÿ�
UPDATE  V_MEM01
SET     MILE = 5500
WHERE   MID='c001';
-- 3000�̻��̶�� ������ �������� �ʾ���
-- �䰡 �ٲ��� ������ �ٲ�!
-- ������ �ٲ�� �䵵 �ٲ��, �䰡 �ٲ�� ������ �ٲ�
-- �ٸ� �並 �ٲ� �� WITH READ ONLY�� ��, WHERE���� ������ WITH CHECK OPTION�� �� DML�� ���� �Ұ����ؼ� ������ �� �ٲ�

**�� V_MEM01���� �ſ�ȯ ȸ��('c001')�� ���ϸ����� 1500���� �����Ͻÿ�
UPDATE  V_MEM01
SET     MILE = 1500
WHERE   MID='c001';
-- �� ������ ������ ������ �ٲ� ���� �ٲ��� ����!

UPDATE  MEMBER
SET     MEM_MILEAGE = 1500
WHERE   MEM_ID='c001';
-- �������̺����� �󸶵��� �ٲ� �� ����
-- �信 �ٷ� ����� �� �ݿ���

SELECT * FROM V_MEM01;

ROLLBACK;