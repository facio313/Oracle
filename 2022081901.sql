2022-0819-01)
3. 날짜함수
1) SYSDATE - ****
- 시스템이 제공하는 날짜 및 시각정보 제공
- 덧셈과 뺄셈, ROUND, TRUNC 함수의 연산 대상이 됨
- 기본 출력 타입은 '년/월/일'이고 '시/분/초'를 출력하기 위해서는 TO_CHAR 함수 사용
--시분초를 소수점으로 봄

2) ADD_MONTHS(d, n)
- 주어진 날짜 d에 n만큼의 월을 더한 날짜 반환 -- 나오는 결과는 날짜
- 기간이 정해진 날짜가 필요한 경우 많이 사용

사용예)
오늘 어느 단체에 2개월 유료회원으로 등록한 경우 다음 등록일자를 조회하시오.
SELECT  ADD_MONTHS(SYSDATE,2)
FROM    DUAL;

3) NEXT_MONTHS(d, c) - *
- 주어진 날짜 d 이후 c요일에 해당하는 날짜 반환
- c는 ' 월', '월요일', '화', ..., '일요일' 사용
- 한글로 써야 됨!! --> 오라클 설치 후 환경설정할 때 날짜 언어를 KOREA로 해놔서 그렇다

사용예)
SELECT  NEXT_DAY(SYSDATE, '금'),
        NEXT_DAY(SYSDATE, '토요일')
--      NEXT_DAY(SYSDATE, 'FRIDAY')
FROM    DUAL;

4) LAST_DAY(d) - ***
- 주어진 날짜 데이터의 월 마지막 일을 반환 -- 반드시 날짜 데이터!
- 주로 2월의 마지막 일을 반환받는 곳에 사용됨

사용예) 매입테이블에서 2022년  2월 제품별 매입집계를 구하시오.
        Alias 제품코드, 제품명, 매수량합계, 매입금액합계
SELECT  A.BUY_PROD      AS  제품코드, -- BUY_PROD가 외래키인지 아닌지 모르기 때문에...외래키는 이름 바꾸지 말아야 함
        B.PROD_NAME     AS  제품명,
        COUNT(*)        AS  매입횟수,
        SUM(A.BUY_QTY)  AS  매수량합계,
        SUM(A.BUY_QTY * B.PROD_COST)    AS  매입금액합계
FROM    BUYPROD A,  PROD    B --별칭!!!!을 쓰면 '.'을 써야 함. .(DOT)연산자는 소속 관련!!!!!!!!!!********
WHERE   A.BUY_PROD  =   B.PROD_ID-- 두 개 이상 테이블이 쓰이면 조인 조건!!! 써야 됨
AND     A.BUY_DATE BETWEEN TO_DATE('20200201') AND LAST_DAY(TO_DATE('20200201'))
GROUP   BY  A.BUY_PROD,  B.PROD_NAME--이거 왜 씀? : 지금 몰라도 됨
ORDER   BY  1;
--JOIN : 두 테이블 간 관계를 기준(공통의 컬럼 존재)
--공통의 컬럼 : 하나의 부모테이블에 있는 기본키가 자식테이블에 외래키로 사용되고 있다는 뜻
--그렇지 않으면 JOIN을 쓸 수 없음

5) EXTRACT(fmt FROM d) -****굉장히 많이 사용됨 / 날짜자료 일부가 필요한 경우가 많음
- 주어진 날짜 데이터 d에서 'fmt'로 설정한 요소 값을 반환
- 'fmt'는 YEAR, MONTH, DAY, HOUR, MINUTE, SECOND 중 하나
- 반환데이터 타입은 숫자형!!날짜XX글자XX --> 년월일이 있어야 날짜 데이터로 인정되는데 그것들 중 하나를 뽑으니 숫자로 반환됨

**사원테이블의 자료 중 입사일을 10년이 경과된 일자로 변경(UPDATE)하시오.
UPDATE  HR.EMPLOYEES
SET     HIRE_DATE = ADD_MONTHS(HIRE_DATE, 120);

COMMIT;

사용예) 사원테이블에서 50번 부서 직원 중 근속년수가 7년 이상인 직원을 조회하시오.
        Alias는 사원번호, 사원명, 직책, 입사일, 근속년수이며 근속년수가 많은 사원부터 출력
SELECT  EMPLOYEE_ID AS  사원번호,
        EMP_NAME    AS  사원명,
        JOB_ID      AS  직책,
        HIRE_DATE   AS  입사일,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)  AS  근속년수
FROM    HR.EMPLOYEES
WHERE   DEPARTMENT_ID = 50
AND     EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) >= 7--부서번호 50, 근속년수 7년 이상
-- ORDER BY EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
ORDER BY   4 -- = 5 DESC