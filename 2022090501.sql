2022-0905-01) SEQUENCE 객체 -- 오라클에만 존재한 것!
- 순차적으로 증가(감소)하는 값을 반환하는 객체
- 테이블과 독립적으로 운용 : 여러 테이블에서동시 사용 가능
- 사용하는 경우
    - 기본키가 필요하나 컬럼 중 기본키로 사용하기에 적합한 컬럼이 없는 경우
    - 순차적으로 증가값이 필요한 경우(예, 게시판의 글번호 등)
-- 지나온 거는 다시 쓸 수 없음.
-- 초보자는 쓰지마러 잘못 쓰면 엉망진창

(사용형식)
CREATE  SEQUENCE 시퀀스명
    [START WITH n] - 시작값 설정 생략되면 최소값(MINVAL 값)
    [INCREMENT BY n] - 증가(감소) 값 설정, 생략되면 1
    [MAXVALUUE n|NOMAXVALUE] - 최대값. 기본은 NOMAXVAULE(10^27)
    [MINVALUUE n|NOMINVALUE] - 최소값. 기본은 NOMINVALUE이고 값은 1임
    [CYCLE|NOCYCLE] - 최대(최소)값까지 도달 후 다시 시퀀스를 생성할지 여부. 기본은 NO
    [CACHE n | NOCACHE] - 캐쉬에 미리 생성할지 여부, 기본은 CACHE 20
    [ORDER|NOORDER] - 요청한 옵션에 맞는 시퀀스 생성을 보장하는 여부. 기본은 NO
    
**시퀀스의 값을 참조 : 의사컬럼(Pseudo Column : NEXTVAL, CURRVAL) 사용--RAWNUM
-----------------------------------------------
의사컬럼            의미 
-----------------------------------------------
시퀀스명.NEXTVAL    '시퀀스'객체의 다음 값 반환
시퀀스명.CURRVAL    '시퀀스'객체의 현재 값 반환

***시퀀스 생성 후 반드시 '시퀀스명.NEXTVAL' 명령이 1번 이상, 맨 처음으로 수행되어야 함
-----------------------------------------------
분류코드    분류명
-----------------------------------------------
P501        농산물
P502        수산물
P503        임산물

CREATE SEQUENCE SEQ_LPROD_ID
START WITH 10;

SELECT SEQ_LPROD_ID.CURRVAL FROM DUAL; -- 에러발생

INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
VALUES(SEQ_LPROD_ID.NEXTVAL, 'p501', '농산물');

INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
VALUES(SEQ_LPROD_ID.NEXTVAL, 'P502', '수산물');

INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM)
VALUES(SEQ_LPROD_ID.NEXTVAL, 'P503', '임산물');

SELECT SEQ_LPROD_ID.NEXTVAL FROM DUAL;

SELECT * FROM LPROD;