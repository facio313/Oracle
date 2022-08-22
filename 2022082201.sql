2022-0822-01)형변환 함수
- 오라클의 데이터 형변환 함수는 TO_CHAR, TO_DATE, TO_NUMBER, CAST 함수가 제공됨
- 형의 변환은 해당 함수가 사용된곳에 일시적 변환

1) CAST(expr AS TYPE) - *
- expr로 제공되는 데이터(수식, 함수 등)를 'type' 형태로 변환하여 반환함

사용예)
SELECT  BUYER_ID        AS  거래처코드,
        BUYER_NAME      AS  거래처명,
        CAST(BUYER_NAME AS  CHAR(30))   AS  거래처명2, --함수가 사용된 곳에서만! 테이블에 영향을 끼치지 않음
        BUYER_CHARGER   AS  담당자
FROM    BUYER;

SELECT  --CAST(BUY_DATE AS NUMBER) --날짜를 숫자로 못 바꿈.. CAST를 쓴다고 다 되는 것이 아님!!! 허락된 것만 바꿈
        CAST(TO_CHAR(BUY_DATE, 'YYYYMMDD') AS NUMBER) -- 바꾸려면 이렇게 해야 됨.../ 없애고 ! 바꾸기 !
FROM    BUYPROD
WHERE   BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131');

2) TO_CHAR(d [,fmt]) - *****
- 변환함수 중 가장 널리 사용
- 숫자, 날짜, 문자 타입을 문자타입으로 변환
- 문자타입은 CHAR, CLOB를 VARCHAR2로 변환할 때만 사용 가능
- 'fmt'는 형식 문자열로 크게 날짜형과 숫자형으로 구분됨
------------------------------------------------------------------------------------------------------------------
**문자형 형식문자
------------------------------------------------------------------------------------------------------------------
FORMAT 문자           의미                  사용예
------------------------------------------------------------------------------------------------------------------
CC                    세기                  SELECT TO_CHAR(SYSDATE, 'CC')||'세기'   FROM DUAL;
AD, BC                기원 전, 기원 후      SELECT TO_CHAR(SYSDATE, 'CC BC')||EXTRACT(YEAR FROM SYSDATE) FROM DUAL;
YYYY, YYY, YY, Y      년도 - 2022,022,22,2  SELECT TO_CHAR(SYSDATE, 'YYYY YEAR')    FROM DUAL;
YEAR                  년도를 알파벳으로     SELECT TO_CHAR(SYSDATE, 'YYYY YEAR')    FROM DUAL;
Q                     분기(QUARTER)         SELECT TO_CHAR(SYSDATE, 'Q')            FROM DUAL;
MM, RM(로마식)        월                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM')      FROM DUAL;
MONTH, MON            월(한글 상관X 영어ㅜ) SELECT TO_CHAR(SYSDATE, 'YYYY-MONTH')   FROM DUAL;
WW(년 주차),W(월 주차)주 ~52 / ~5           SELECT TO_CHAR(SYSDATE, 'YYYY-MM WW')   FROM DUAL;
DDD(년),DD,D(주 차수) 일                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')   FROM DUAL;
DAY(FULL), DY(AGG)    요일                  SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DY')FROM DUAL;
AM,PM,A.M.,P.M.       오전/오후             SELECT TO_CHAR(SYSDATE, 'AM YYYY-MM-DD DY')FROM DUAL;
HH, HH12, HH24        시각                  SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH')FROM DUAL;
MI                    분                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI')FROM DUAL;
SS, SSSSS(오늘 경과)  초                    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS SSSSS')FROM DUAL;

------------------------------------------------------------------------------------------------------------------
**숫자형 형식문자
------------------------------------------------------------------------------------------------------------------
FORMAT 문자           의미                  사용예
------------------------------------------------------------------------------------------------------------------
9,0                   숫자자료 출력         SELECT  TO_CHAR(12345.56, '9,999,999.9'), -- 9: 유효숫자와 대응 시 숫자 출력/무효의 '0'과 대응 시 (공백 출력 ,도 공백)
- 9모드 쓰면 오른쪽 정렬돼도 그거슨 문자!             TO_CHAR(12345.56, '0,000,000.0')  FROM    DUAL; -- 0: 유효숫자와 대응 시 숫자 출력/무효의 '0'과 대응 시 0 출력
,(COMMA)              3자리마다 자리점(,)
.(DOT)                소수점
$,L                   화폐기호              SELECT  TO_CHAR(PROD_PRICE, 'L9,999,999')   FROM    PROD; -- L : LOCATOR
                                            SELECT  TO_CHAR(SALARY, '$999,999') AS  급여1, --오른쪽 정렬돼도 숫자가 아니라 문자여서 사칙연산XX
                                                    TO_CHAR(SALARY)             AS  급여2      FROM    HR.EMPLOYEES;
PR                    '<음수자료>'          SELECT  TO_CHAR(-2500,'99,999PR')           FROM    DUAL;
MI                    '-'음수자료           SELECT  TO_CHAR(-2500,'99,999MI')           FROM    DUAL;

" " 사용자가 직접 정의하는 문자열           SELECT  TO_CHAR(SYSDATE, 'YYYY"년 "MM"월" DD"일"') FROM DUAL;
--컬럼 별칭 사용 시에도 ""씀 / 다른 이의 테이블을 접근할 때 스키마를 기술할 시 그 스키마를 묶어서 기술하기 위해 사용

3) TO_DATE(c [, fmt]) - ***
- 주어진 문자열 자료 c를 날짜 타입의 자료로 형변환시킴
- c에 포함된 문자열 중 날짜자료로 변환될 수 없는 문자열이 포함된 경우 'fmt' 를 사용하여 기본형식으로 변환할 수 있음
- 'fmt'는 TO_CHAR함수의 '날짜형 형식문자'와 동일

사용예) 형식지정 문자열 --> 원본 데이터가 기본 타입으로 바꿀 수 없을 때(중간에 뭐가 끼여있을 때) 사용하기 위해
SELECT  TO_DATE('20200504'), -- 숫자 자료는 절대로 날짜로 변경 불가능
        TO_DATE('20200504', 'YYYY-MM-DD'), -- /보다 -가 더 빠름!(우선순위)
        TO_DATE('2020년 08월 22일', 'YYYY"년" MM"월" DD"일"') -- 출력은 기본 날짜 타입이 됨
FROM    DUAL;

4) TO_NUMBER(c, [,fmt]) - **
- 주어진 문자열 자료 c를 숫자타입의 자료로 형변환시킴
- c에 포함된 문자열 중 숫자자료로 변환될 수 없는 문자열이 포함된 경우 'fmt'를 사용하여 기본 숫자 형식으로 변환할 수 있음
- 'fmt'는 TO_CHAR함수의 '숫자형 형식문자'와 동일

사용예)
SELECT  TO_NUMBER('2345') / 7, -- <-- 제일 많이 쓰는 형식
        TO_NUMBER('2345.56'), -- 소수점은 따로 변형 안 해도 됨!
        TO_NUMBER('2,345','9,999'), -- 그냥 '2,345'거나 '2345', '99,999'면 안 됨
        TO_NUMBER('$2345', '$9999'), -- '$2345' 오류
        TO_NUMBER('002,345', '000,000'), -- '002,345' 오류
        TO_NUMBER('<2,345>', '9,999PR') -- '<2,345>' 오류
FROM    DUAL;        