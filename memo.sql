1. 테이블 만들기 --DB설계
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

2. 시퀀스 만들기
user(in91) - 시퀀스 - 오른쪽 마우스 - 새 시퀀스 - 이름 적고 - 확인

3. 자바 패키지(memo)하나 만들기

4. 클래스(*MVC패턴)
-MemoApplication (main)
-MemoView(뷰)
-MemoController(컨트롤러)
-MemoService(모델)
-MemoDAO(모델)
*개발 순서 : View - Controller - Service - DAO

*DAO
*DAO에서 받아온 것들을 담을 MemoVO클래스의 메소드를 만들어야 됨










