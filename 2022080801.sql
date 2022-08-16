2022-0808-01)
3. 날짜자료형
    - 날짜 시각 정보를 저장(년, 월, 일, 시, 분, 초)
    - 날짜 자료는 덧셈과 뺄셈이 가능함
    - date, timestamp(3가지 - 아주 정교한 시간) 타입 제공
 1)DATE 타입
 . 기본 날짜 및 시각정보 저장 (연/월/일/시/분/초 -> SELECT로 불러올 때 시/분/초는 안 나옴, 하지만 저장된 것)
(사용형식)
    컬럼명 DATE
    . 덧셈은 더해진 정수만큼 다가올 날짜(미래)
    . 뺄셈은 차감한 정수만큼 지나온 날짜(과거)
    . 날짜 자료 사이의 뺄셈은 날 수(DASY) 반환(큰 날짜 - 작은 날짜)
    . 날짜자료는 연/월/일(기본)과 시/분/초(추가) 부분으로 구분하여 저장
    . 정확한 포맷으로 정의해야 함(연월일 중 연 생략x)
    . 시/분/초를 저장하지 않으면 0시 0분 0초!
    . 달력 만들기?? 곱셈, 나눗셈은  안 됨
    . DATE는 크기가 없음
    ** 시스템이 제공하는 날짜정보는 SYSDATE함수를 통하여 참조할 수 있음
사용예) CREATE TABLE TEMP06(
            COL1 DATE,
            COL2 DATE,
            COL3 DATE);
            
        INSERT INTO TEMP06 VALUES(SYSDATE, SYSDATE-10, SYSDATE+10);
        SELECT * FROM TEMP06;
        SELECT TO_CHAR(COL1, 'YYYY-MM-DD'), -- 형식 지정 문자열
               TO_CHAR(COL2, 'YYYY-MM-DD HH24:MI:SS'),
               TO_CHAR(COL3, 'YYYY-MM-DD HH12:MI:SS')
            FROM TEMP06;
            
        SELECT CASE MOD(TRUNC (SYSDATE) - TRUNC(TO_DATE('00010101'))-1,7) -- TRUNC 절삭(자료 버리기) MOD : 나머지
                WHEN 1 THEN '월요일' -- 분기문 / IF문 SWITCH문 따로 없음 그래도 이렇게 비슷하게 씀
                WHEN 1 THEN '화요일'
                WHEN 1 THEN '수요일'
                WHEN 1 THEN '목요일'
                WHEN 1 THEN '금요일'
                WHEN 1 THEN '토요일'
                ELSE '일요일'
            END AS 요일    
            FROM DUAL; -- SELECT 쓰려면 FROM까지 꼭 써줘야 함, 테이블은 필요는 없지만 FROM 규격을 위해 필요함
            
        SELECT SYSDATE-TO_date('20200807') FROM DUAL;
        
 2)TIMESTAMP 타입
 . 시간대 정보(TIME ZONE)나 정교한 시각정보(10억분의 1초)가 필요한 경우 사용

(사용형식)
    컬럼명 TIMESTAMP - 시간대 정보 없이 정교한 시각정보 저장
    컬럼명 TIMESTAMP WITH LOCAL TIME ZONE - 데이터베이스가 운영 중인 서버의 시간대를 기준으로 
                                            서버에 접속하는클라이언트와의 시차가 계산된 시간 입력
                                            시간은 클라이언트 지역의 시간으로 자동 변환 출력되기 때문에
                                            시간대 정보는 저장되지 않음
    컬럼명 TIMESTAMP WITH TIME ZONE - 서버의 시간대 정보 저장 아시아/서울 대륙명/도시명
    
    . 초를 최대 9자리까지 표현할 수 있으나 기본은 6자리임
    
사용예)
CREATE TABLE TEMP07
 (COL1 DATE,
  COL2 TIMESTAMP,
  COL3 TIMESTAMP WITH LOCAL TIME ZONE,
  COL4 TIMESTAMP WITH TIME ZONE);
    
INSERT INTO TEMP07 VALUES(SYSDATE, SYSDATE, SYSDATE, SYSDATE);
SELECT * FROM TEMP07;