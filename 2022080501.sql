2022-0805-01)데이터 타입
    -   오라클에는 문자열, 숫자, 날짜, 이진수 자료타입이 제공
    1. 문자 데이터타입
        . 오라클의 문자자료는 ' ' 안에 기술된 자료(예약어와 같더라도 따옴표 안에 글자들은 ASCII 코드로 저장됨)
        --> 따옴표 안에는 대소문자 구별 왜냐면 코드 값이 다르거든 A랑 a랑
        . 대소문자 구별
        . CHAR, VARCHAR, VARCHAR2, NVARCHAR2, LONG, CLOB, NCLOB 등이 제공됨
        //CHARACTOR : 고정길이(큰 걸 작은 곳에 넣을 때 오라클은 잘려나가는 것이 없고 입력이 걍 안 됨)
        //CHAR 외의 나머지는 다 가변길이 VARIABLECHARATOR --> 빈 공간의 경우 운영체제에 반납함
        //VARCHAR2는 오라클에서만 쓰고 VARCHAR와 기능적으로 똑같음 
        //N은 NATIONAL(다국어 형식) --> UTF-16방식, 8방식도?
        //LONG 2GB 문자열 저장할 때 씀 --> 새롭게는 쓰지 말라고 함
        //CHARATER LARGE OBJECT 4GB 문자열 저장할 때 씀
        *()꼭 써라 []는 써도 되고 안 써도 되고?
    1)  CHAR(n[BYTE|CHAR])
    - 고정길이 문자열 저장
    - 최대 2000BYTE까지 저장가능
    - 'n[BYTE|CHAR]' : '[BYTE|CHAR]'이 생략되면 BYTE로 취급
        'CHAR'은 n글자수까지 저장(영문자 기준)
    - 중요중요)(완성형)한글 한 글자는 3BYTE로 저장(n이 2000이라면 666개까지 사용 가능) <-> (조합형)
    - 기본키나 길이가 고정된 자료(주민번호, 우편번호)의 정당성을 확보하기 위해 사용
    - 반드시 크기 지정 필요! *소문자 c 캐릭터 d는 데이터
    *문자는 왼쪽 정렬 빈공간은 오른쪽 정렬
사용예)
CREATE TABLE TEMP01(
    COL1 CHAR(10),
    COL2 CHAR(10 BYTE),
    COL3 CHAR(10 CHAR));
    
INSERT INTO TEMP01 VALUES('대한','대한민','대한민국');

SELECT * FROM TEMP01;

//LENGTHB 공백 확인

SELECT LENGTHB(COL1) AS COL1,
       LENGTHB(COL2) AS COL2,
       LENGTHB(COL3) AS COL3
    FROM TEMP01;
//대한민국(4*3=12) 나머지 6개는 영어 기준으로 저장됨
//CHAR!!!이라

    2) VARCHAR2(n{BYTE|CHAR])
    - 가변길이 문자열 자료 저장
    - 최대 4000BYTE까지 저장 가능
    - VARCHAR, NVARCHAR2와 저장형식 동일
    - 오라클에서만 쓸 수 있음 / 그 외에는 VARCHAR와 똑같음!!
사용예)
CREATE TABLE TEMP02(
    COL1 CHAR(20),
    COL2 VARCHAR2(2000 BYTE),
    COL3 VARCHAR2(4000 CHAR));
INSERT INTO TEMP02 VALUES('ILPOSTINO', 'BOYHOOD',
                          '무궁화 꽃이 피었습니다-김진명');
SELECT * FROM TEMP02;

SELECT LENGTHB(COL1) AS COL1,
       LENGTHB(COL2) AS COL2,
       LENGTHB(COL3) AS COL3,
       LENGTH(COL1) AS COL1,
       LENGTH(COL2) AS COL2,
       LENGTH(COL3) AS COL3
    FROM TEMP02;
    
    3) LONG
    - 가변길이 문자열 자료 저장
    - 최대 2GB까지 저장 가능
    - 한 테이블에 한 컬럼만 LONG타입 사용 가능
    - 현재 기능 개선서비스 종료(오라클 8i) => CLOB(CHARATER LARGE OBJECT)로 Upgrade --> 한 테이블에 여러 컬럼에 포함될 수 있음
    * 크기를 지정하지 않고 쓰고 남은 거 반납함(가변)
(사용형식)
    컬럼명 LONG
    . LONG 타입으로 저장된 자료를 참조하기 위해 최소 31bit가 필요
    =>일부 기능(LENGTHB 등의 함수)이 제한 --> CLOB는 사용 가능
    . SELECT문의 SELECT절, UPDATE의 SET절, INSERT문의 VALUES절에서 사용 가능   
사용예)
CREATE TABLE TEMP03(
    COL1 VARCHAR2(2000),
    COL2 LONG);
    
INSERT INTO TEMP03 VALUES ('대전시 중구 계룡로 846',' 대전시 중구 게룡로 846');
    
SELECT SUBSTR(COL1,8,3)
    --SUBSTR(COL2,8,3)
    --LENGTHB(COL2)
FROM TEMP03;    
    
    4) CLOB(Chrater Large OBject)
    - 대용량의 가변길이 문자열 저장
    - 최대 4GB까지 처리 가능
    - 한 테이블에 복수개의 CLOB 타입 정의 가능
    - 일부 기능은 DBMS_LOB API(Application Programming Interface)에서 제공하는 함수 사용
(사용형식)
    컬럼명 CLOB
사용예)
CREATE TABLE TEMP04(
    COL1 VARCHAR2(255),
    COL2 CLOB,
    COL3 CLOB);

INSERT INTO TEMP04 VALUES('APPLE BANANA PERSIMMON','APPLE BANANA PERSIMMON',
                            'APPLE BANANA PERSIMMON');
                            
SELECT * FROM TEMP04;

SELECT SUBSTR(COL1,7,6) AS COL1,
       SUBSTR(COL3,7,6) AS COL3, --> 7번재에서 6글자
       -- LENGTHB(COL2) AS COL4, --> 지원되지 않음
       DBMS_LOB.GETLENGTH(COL2) AS COL4, --> 글자수 반환(LONG타입은 안 됨)
       DBMS_LOB.SUBSTR(COL2,7,6) AS COL2 --> 6번째에서 7글자
    FROM TEMP04;
    
    //TRIM 사용하면 불필요한 공백 잘라냄! LONG은 SUBSTR 안 됐는데 CLOB은 처리할 수 있는 길이면 SUBSTR이 됨