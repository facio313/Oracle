2022-0818-01)
2. 숫자함수 -- ROUND와 MOD를 많이 씀
- 제공되는 숫자함수로는 수학적 함수(ABS, SIGN, SQRT 등), GREATEST, ROUND, MOD, FLOOR, WIDTH_BUCKET 등이 있음
1)수학적 함수
(1) ABS(n), SIGN(n), POWER(e, n), SQRT(n) - *
- ABS : n의 절대값 반환
- SIGN : n이 양수이면 1, 음수이면 -1, 0이면 0을 반환 -- 값의 크기는 상관이 없음
- POWER : e의 n승 값(e의 n번 거듭 곱한 값)
- SQRT : n의 평방근 -- 부동산 관련

사용예)
SELECT  ABS(10), ABS(-100), ABS(0),
        SIGN(-20000), SIGN(-0.0099), SIGN(0.000005), SIGN(500000), SIGN(0),
        POWER(2,10),
        SQRT(3.3)
FROM    DUAL;

2)GREATEST(n1, n2[,...n]), LEAST(n1, n2[,...n])
- 주어진 값 n1~n 사이의 값 중 제일 큰 값(GREATEST), 제일 작은 값(LEAST) 반환

사용예)
SELECT  GREATEST('KOREA', 1000, '홍길동'), 
--ASCII 코드 값(숫자)로 다 바꿈
--MAX는 하나의 컬럼(열)에 들어있는 값에서 구하는 것, 
--GREATEST는 행으로 나열되어 있는 것 중에 찾는 것
LEAST('ABC', 200, '서울시') --656667 200 15500444155061041502236
FROM    DUAL;        

SELECT ASCII('시') FROM DUAL;

사용예) 회원테이블에서 마일리지가 1000미만인 회원을 찾아 1000으로 변경 출력하시오.
Alias는 회원번호, 회원명, 원본 마일리지, 변경된 마일리지
SELECT  MEM_ID      AS  회원번호,
        MEM_NAME    AS  회원명,
        MEM_MILEAGE AS  "원본 마일리지",
        GREATEST((MEM_MILEAGE), 1000) AS "변경된 마일리지"
FROM    MEMBER;

3)ROUND(n [,l]), TRUNCK(n [,l]) - ****
- 주어진 자료 n에서 소수점 이하 l+1자리에서 반올림하여(ROUNGD) 또는 자리버림(TRUNC)하여 l자리까지 표현함
- l이 생략되면 0으로 간주됨
- l이 음수이면 소수점 이상의 l자리에서 반올림 또는 자리 버림 수행 -- L = LOCATION

사용예)
SELECT  ROUND(12345.678945, 3),
        ROUND(12345.678945),
        ROUND(12345.678945,-3)
FROM    DUAL;        

SELECT  TRUNC(12345.678945, 3),
        TRUNC(12345.678945),
        TRUNC(12345.678945,-3)
FROM    DUAL;        

사용예) HR계정의 사원테이블에서 사원들의 근속년수를 구하여 근속년수에 따른 근속 수당을 계산하시오
근속수당 = 기본급(SALARAY) * (근속년수/100)
급여합계 = 기본급 + 근속수당
세금 = 급여합계의 13%
지급액  급여합계-세금이며 소수 2째자리에서 반올림 하시오.
Alias는 사원번호, 사원명, 입사일, 근속년수, 급여, 근속수당, 세금, 지급액

-- ROUND와 TRUNC는 마지막에 한 번만 해주면 됨! 안 그러면 정확한 값이 안 나옴
-- 날짜 데이터를 숫자 데이터로 바꿀 수 있는 방법이 없음

SELECT  EMPLOYEE_ID    AS  사원번호,
        EMP_NAME        AS  사원명,
        HIRE_DATE       AS  입사일,
        TRUNC((SYSDATE - HIRE_DATE)/365)    AS  근속년수,
        SALARY          AS  기본급여,
        ROUND(SALARY * (TRUNC((SYSDATE - HIRE_DATE)/365))/100)   AS  근속수당,
        ROUND(SALARY + SALARY * (TRUNC((SYSDATE - HIRE_DATE)/365))/100)  AS  급여합계,
        ROUND((SALARY + SALARY * (TRUNC((SYSDATE - HIRE_DATE)/365))/100) * 0.13, 1) AS  세금,
        ROUND((SALARY + SALARY * (TRUNC((SYSDATE - HIRE_DATE)/365))/100) * 0.87, 1) AS 지급액
FROM    HR.EMPLOYEES;

4) FLOOR (n), CEIL(n) - *
- 보통 화폐에 관련된 데이터 처리에 사용
- FLOOR : n과 같거나(n이 정수인 때) n보다 작은 정수 중 가장 큰 정수 -- '=.  받을 때!
- CEIL : n과 같거나(n이 정수인 때) n보다 큰 정수 중 가장 작은 정수 -- '=.  줄 때!
--TRUNC ROUND와 비슷함
--현업에서 많이 사용 안 함

사용예)
SELECT  FLOOR(23.456),  FLOOR(23),  FLOOR(-23.456),
        CEIL(23.456),   CEIL(23),   CEIL(-23.456)
FROM    DUAL;

5) MOD(n, b), REMAINDER(n, b) - *** --자바에서는 %
- 나머지를 반환
- MOD : 일반적 나머지 반환
- REMAINDER : 나머지의 크기가 b값의 절반보다 작으면 일반적 나머지를 반환하고
            b값의 절반보다 크면 다음 몫이 되기 위한 값에서 현재값(n)을 뺀 값을 반환함
- MOD와 REMAINDER는 내부 처리가 다름
    
MOD(n, b) : n - b * FLOOR(n/b)
REMAINDER(n, b) : n - b * ROUND(n/b)
 
 EX) MOD(23, 7), REMAINDER(23, 7)
MOD(23, 7) = 23 - 7 * FLOOR(23/7)
            = 23 - 7 * FLOOR(3.286)
            = 23 - 7 * 3
            = 2
            
REMAINDER(23, 7) = 23 - 7 * ROUND(23/7)
                 = 23 - 7 * ROUND(3.286)
                 = 23 - 7 * 3
                 = 2
                 
MOD(26, 7), REMAINDER(26, 7)
MOD(26, 7) = 26 - 7 * FLOOR(26/7)
            = 26 - 7 * FLOOR(3.714)
            = 26 - 7 * 3
            = 5
            
REMAINDER(26, 7) = 26 - 7 * ROUND(26/7)
                 = 26 - 7 * ROUND(3.714)
                 = 26 - 7 * 4
                 = -2
--REMAINDER는 조금 다름

6)WIDTH_BUCKET(n, min, max, b) -- min, max를 바꿔도 됨!!! -> 사용예 확인 n-max와 달라야 함!
- 최소값 min에서 최대값 max까지를 b개의 구간으로 나누었을 때 -- b는 구간의 개수
n이 어느 구간에 속하는지를 판단하여 구간의 INDEX 값을 반환
- n < min인 경우 0을 반환하고 n >=인 경우 b+1 값을 반환 -- b+2개의 구간이 만들어짐!!
    -- 구간의 상한값은 포함 안 됨
    -- 구간의 하한값은 포함됨

사용예)
SELECT  WIDTH_BUCKET(28,10,39,3),
        WIDTH_BUCKET(8,10,39,3),
        WIDTH_BUCKET(59,10,39,3),
        WIDTH_BUCKET(39,10,39,3),
        WIDTH_BUCKET(10,10,39,3)
FROM    DUAL;

사용예) 회원테이블에서 회원들의 마일리지를 조회하여 1000-9000 사이를 3개의 구간으로 구분하고
    회원번호, 회원명, 마일리지, 비고를 출력하되,
    비고에는 마일리지가 많은 회원부터 '1등급 회원', '2등급 회원', '3등급 회원', '4등급 회원'을 출력하시오.
SELECT  MEM_ID      AS  회원번호,
        MEM_NAME    AS  회원명,
        MEM_MILEAGE AS  마일리지,
        WIDTH_BUCKET(MEM_MILEAGE,9000,999,3)||'등급 회원' AS 비고
        -- 4 - WIDTH_BUCKET(MEM_MILEAGE,1000,9000,3)||'등급 회원' AS 비고 ==> 이게 더 정확함
FROM    MEMBER;