1. ���̺� ����� --DB����
create table memo (
no Number,
title varchar2(100),
content varchar2(1000),
writer varchar2(50),
register_date date default sysdate,
modify_date date,
CONSTRAINT pk_memo PRIMARY KEY (no)
);

drop table memo;

2. ������ �����
user(in91) - ������ - ������ ���콺 - �� ������ - �̸� ���� - Ȯ��

3. �ڹ� ��Ű��(memo)�ϳ� �����

4. Ŭ����(*MVC����)
-MemoApplication (main)
-MemoView(��)
-MemoController(��Ʈ�ѷ�)
-MemoService(��)
-MemoDAO(��)
*���� ���� : View - Controller - Service - DAO

*DAO
*DAO���� �޾ƿ� �͵��� ���� MemoVOŬ������ �޼ҵ带 ������ ��










