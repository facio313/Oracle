2022-0905-01) SEQUENCE ��ü -- ����Ŭ���� ������ ��!
- ���������� ����(����)�ϴ� ���� ��ȯ�ϴ� ��ü
- ���̺�� ���������� ��� : ���� ���̺������� ��� ����
- ����ϴ� ���
    - �⺻Ű�� �ʿ��ϳ� �÷� �� �⺻Ű�� ����ϱ⿡ ������ �÷��� ���� ���
    - ���������� �������� �ʿ��� ���(��, �Խ����� �۹�ȣ ��)
-- ������ �Ŵ� �ٽ� �� �� ����.
-- �ʺ��ڴ� �������� �߸� ���� ������â

(�������)
CREATE  SEQUENCE ��������
    [START WITH n] - ���۰� ���� �����Ǹ� �ּҰ�(MINVAL ��)
    [INCREMENT BY n] - ����(����) �� ����, �����Ǹ� 1
    [MAXVALUUE n|NOMAXVALUE] - �ִ밪. �⺻�� NOMAXVAULE(10^27)
    [MINVALUUE n|NOMINVALUE] - �ּҰ�. �⺻�� NOMINVALUE�̰� ���� 1��
    [CYCLE|NOCYCLE] - �ִ�(�ּ�)������ ���� �� �ٽ� �������� �������� ����. �⺻�� NO
    [CACHE n | NOCACHE] - ĳ���� �̸� �������� ����, �⺻�� CACHE 20
    [ORDER|NOORDER] - ��û�� �ɼǿ� �´� ������ ������ �����ϴ� ����. �⺻�� NO
    
**�������� ���� ���� : �ǻ��÷�(Pseudo Column : NEXTVAL, CURRVAL) ���--RAWNUM
-----------------------------------------------
�ǻ��÷�            �ǹ� 
-----------------------------------------------
��������.NEXTVAL    '������'��ü�� ���� �� ��ȯ
��������.CURRVAL    '������'��ü�� ���� �� ��ȯ

***������ ���� �� �ݵ�� '��������.NEXTVAL' ����� 1�� �̻�, �� ó������ ����Ǿ�� ��
-----------------------------------------------
�з��ڵ�    �з���
-----------------------------------------------
P501        ��깰
P502        ���깰
P503        �ӻ깰

CREATE SEQUENCE SEQ_LPROD_ID
START WITH 10;

SELECT SEQ_LPROD_ID.CURRVAL FROM DUAL; -- �����߻�

INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
VALUES(SEQ_LPROD_ID.NEXTVAL, 'p501', '��깰');

INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
VALUES(SEQ_LPROD_ID.NEXTVAL, 'P502', '���깰');

INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
VALUES(SEQ_LPROD_ID.NEXTVAL, 'P503', '�ӻ깰');

SELECT SEQ_LPROD_ID.NEXTVAL FROM DUAL;

SELECT * FROM LPROD;