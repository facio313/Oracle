2022-0801-01)����� ���� �� ���� ����
1)����� ����
    - CREATE USER ��� ���
    (�������)
    CREATE USER ����ڸ� IDENTIFIED BY ��ȣ;
    
CREATE USER in91 IDENTIFIED BY java;
    
2)���Ѻο�
    - GRANT ��� ���
    (�������)
    GRANT ���Ѹ�[,���Ѹ�,...] TO ����ڸ�;
    . ���Ѹ� : CONNECT, RESOURCE, DBA ���� �ַ� ���
    
GRANT CONNECT, RESOURCE, DBA TO in91;

3)HR ���� Ȱ��ȭ
    - ALTER ��� ����Ͽ� Ȱ��ȭ �� ��ȣ ����
-- ���� ���� alter
-- ���� ���� create
-- ���� ���� drop
ALTER USER HR ACCOUNT UNLOCK;
ALTER USER HR IDENTIFIED BY java;