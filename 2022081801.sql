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