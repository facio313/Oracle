2020-0830-01
5. SEMI Join
- 세미조인은 서브쿼리를 이용하는 조인으로 서브쿼리의 결과 내에서 최종결과를 추출하는 조인
- IN, EXISTS 연산자를 사용하는 조인

사용예)
사원테이블에서 급여가 10000 이상인 사원이 존재하는 부서를 조회하시오.
Alias 부서코드, 부서명, 관리사원명
(IN 연산자 사용)
SELECT	A.DEPARTMENT_ID	AS	부서코드,
		A.DEPARTMENT_NAME	AS	부서명,
		B.EMP_NAME		AS	관리사원명
FROM	HR.DEPARTMENTS A, HR.EMPLOYEES B
WHERE	A.DEPARTMENT_ID	IN(서브쿼리)
AND		A.MANAGER_ID=B.EMPLOYEE_ID
ORDER BY	1;
(서브쿼리 : 급여가 10000이상인 사원이 존재하는 부서)
SELECT	DEPARTMENT_ID
FROM	HR.EMPLOYEES
WHERE	SALARY>=10000
(결합)
SELECT	A.DEPARTMENT_ID	AS	부서코드,
		A.DEPARTMENT_NAME	AS	부서명,
		B.EMP_NAME		AS	관리사원명
FROM	HR.DEPARTMENTS A, HR.EMPLOYEES B
WHERE	A.DEPARTMENT_ID	IN(SELECT	DEPARTMENT_ID
						FROM	HR.EMPLOYEES
						WHERE	SALARY>=10000)
AND		A.MANAGER_ID=B.EMPLOYEE_ID
ORDER BY	1;
(EXISTS 연산자 사용)
SELECT	A.DEPARTMENT_ID	AS	부서코드,
		A.DEPARTMENT_NAME	AS	부서명,
		B.EMP_NAME		AS	관리사원명
FROM	HR.DEPARTMENTS A, HR.EMPLOYEES B
WHERE	EXISTS(SELECT *
				FROM HR.EMPLOYEES C
				WHERE	C.SALARY>=10000)
				?AND		A.DEPARTMENT_ID=C.DEPARTMENT_ID)
AND		A.MANAGER_ID=B.EMPLOYEE_ID
ORDER BY	1;

6.SELF Join
- 하나의 테이블에 2개 이상의 별칭을 부여하여 서로 다른 테이블로 간주한 후 조인을 수행하는 방법

사용예)
회원테이블에서 ‘오철희’ 회원들의 평균 마일리지보다 많은 마일리지를 보유한 회원정보를 출력하시오.
Alias는 회원번호, 회원명, 직업, 마일리지
SELECT	B.MEM_ID	AS	회원번호,
		B.MEM_NAME	AS	회원명,
		B.MEM_JOB	AS	직업,
		B.MEM_MILEAGE	AS	마일리지
FROM	MEMBER A, MEMBER B
WHERE	A.MEM_JOB=‘오철희’
AND		A.MEM_MILEAGE<B.MEM_MILEAGE;

사용예)
상품코드 ‘P20200002’와 같은 분류에 속한
Alias는 상품콛, 상품명, 분류명, 매입단가
SELECT	B.PROD_ID		AS	상품코드,
		B.PROD_NAME	AS	상품명,
		C.LPROD_NM	AS	분류명,
		B.PROD_COST	AS	매입단가
FROM	PROD A,	PROD B, LPROD C
WHERE	A.PROD_ID=‘P20200002’
AND		A.PROD_LGU=B.PROD_LGU
AND		A.PROD_COST<B.PROD_COST
AND		A.PROD_LGU=C.LPROD_GU;

2022-0830-02)외부조인(OUTER Join)
- 내부조인은 조인조건을 만족하는 결과만 반환하지만, 외부조인은 자료가 부족한 테이블에 NULL행을 추가하여 조인을 수행
- 조인조건 기술 시 자료가 부족한 테이블의 컬럼 뒤에 외부조인 연산자 ‘(+)’를 추가 기술함
- 외부조인 조건이 복수 개일 때 모든 외부조인 조건에 모두 ‘(+)’연산자를 기술해야 함
- 한번에 한 테이블에만 외부조인을 할 수 있음
즉, A,B,B 테이블을 외부조인할 경우 A를 기준으로 B와 외부조인하고 동시에 C를 기준으로 B를 외부조인할 수 없다
(A=B (+) AND C=B(+)는 허용되지 않음)
- 일반 외부조인에서 일반조건이 부여되면 정확한 결과가 반환되지 않음
	=> 서브쿼리를 사용한 외부조인 또는 ANSI 외부 조인으로 해결해야 함
- IN 연산자와 외부조인연산자 (‘+’)는 같이 사용할 수 없다.
(일반외부조인 형식)
SELECT	컬럼list
FROM	테이블명1 [별칭1], 테이블명2 [별칭2], …
WHERE	별칭1.컬럼명 (+) = 별칭2.컬럼명 => 테이블명1이 자료가 부족한 테이블인 경우

(ANSI 외부조인 사용형식)
SELECT	컬럼list
FROM	테이블명1 [별칭1]
RIGHT|LEFT|FULL OUTER JOIN 테이블명2 [별칭2] ON(조인조건1 [AND 일반조건1])
:
[WHERE	일반조건]
- ‘RIGHT|LEFT|FULL’: FROM절에 기술된 테이블(테이블1)의 자료가 OUTER JOIN 테이블명2보다 
많으면 ‘LEFT’, 적으면 ‘RIGHT’, 양족 모두 적으면 ‘FULL’ 사용

**
	1) SELECT에 사용하는 컬럼 중 양쪽 테이블에 모두 존재하는 컬럼은 많은 쪽 테이블 것을 사용해야함
	2) 외부조인의 SELECT절에 COUNT 함수를 사용하는 경우
	‘*’는 NULL값을 갖는 행도 하나의 행으로 인식하여 부정확한 값을 반환함.
	따라서 ‘*’ 대신 해당테이블의 기본키를 사용

사용예) 모든 분류에 속한 상품의 수를 출력하시오
(일반외부조인)
SELECT	B.LPROD_GU	AS	분류코드,
		B.LPROD_NM	AS	분류명,
		COUNT(A.PROD_ID)	AS	“상품의 수”
FROM	PROD A,	LPROD B
WHERE	A.PROD_LGU(+)=B.LPROD_GU
GROUP BY	B.PROD_LGU, B.LPROD_NM
ORDER BY	1;

(ANSI외부조인)
SELECT	B.LPROD_GU	AS	분류코드,
		B.LPROD_NM	AS	분류명,
		COUNT(A.PROD_ID)	AS	“상품의 수”
FROM	PROD A
RIGHT OUTER JOIN	LPROD B	ON(A.PROD_LGU=B.LPROD_GU)
GROUP BY	B.PROD_LGU, B.LPROD_NM
ORDER BY	1;

사용예) 2020년 6월 모든 거래처별 매입집계를 조회하시오
	Alias는 거래처코드, 거래처명, 매입금액합계
SELECT	A.BUYER_ID	AS	거래처코드,
		A.BUYER_NAME	AS	거래처명,
		SUM(B.BUY_QTY*C.PROD_COST)	AS	매입금액합계
FROM	BUYER A,	BUYPROD B,	PROD C
WHERE	B.BUY_PROD(+)=C.PROD_ID
AND		A.BUYER_ID=C.PROD_BUYER(+)
AND		BUY_DATE BETWEEN TO_DATE(‘20200601’) AND TO_DATE(‘20200630’)
GROUP BY A.BUYER_ID,	A.BUYER_NAME;

(ANSI조인)
SELECT	A.BUYER_ID	AS	거래처코드,
		A.BUYER_NAME	AS	거래처명,
		SUM(B.BUY_QTY*C.PROD_COST)	AS	매입금액합계
FROM	BUYER A
LEFT OUTER JOIN	 PROD C	ON(A.BUYER_ID=C.PROD_BUYER)
LEFT OUTER JOIN BUYPROD B	ON(B.BUY_PROD=C.PROD_ID
AND		BUY_DATE BETWEEN TO_DATE(‘20200601’) AND TO_DATE(‘20200630’)
GROUP BY A.BUYER_ID,	A.BUYER_NAME
ORDER BY	1;

(SUBQUERY)
SELECT	A.BUYER_ID	AS	거래처코드,
		A.BUYER_NAME	AS	거래처명,
		NVL(TBL.BSUM,0)	AS	매입금액합계
FROM	BUYER A,	
		? 2020년 6월 거래처별 매입금액합계
		(SELECT	C.PROD_BUYER	AS	CID,
		SUM(B.BUY_QTY*C.PROD_COST)	AS	BSUM
		FROM	BUYPROD B,	PROD C
		WHERE B.BUY_DATE BETWEEN TO_DATE(‘20200601’) AND TO_DATE(‘20200630’)
		AND B.BUY_PROD=C.PROD_ID
		GROUP BY	C.PROD_BUYER)	TBL
		BUYPROD B,	PROD C
WHERE	B.BUY_PROD(+)=TBL.CID(+)
ORDER BY 1;

사용예) 2020년 상반기(1~6월) 모든 제품별 매입수량집계를 조회하시오

사용예) 2020년 상반기(1~6월) 모든 제품별 매출수량집계를 조회하시오

사용예) 2020년 상반기(1~6월) 모든 제품별 매입/매출수량집계를 조회하시오