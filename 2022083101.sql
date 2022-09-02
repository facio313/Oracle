2022-0831-01)서브쿼리
  - SQL구문 안에 또 다른 SQL 구문이 존재하는 것을 의미
  - 알려지지 않은 조건에 근거하여 값들을 검색할 때 유용    ex)평균급여보다 높은 급여를 뽑아라.->평균급여를 알 수 없다.
  - SELECT, DML(UPDATE, DELETE), CREATE TABLE,
    VIEW(이름이 있는 VIEW를 만들어서 사용할 수 있다. 지금까지 실습한 SELECT문의 결과가 VIEW인데 이름이 없어서 저장되지 않았다)에서 사용  
  - 서브쿼리는 '( )'안에 기술(단, INSERT INTO에 사용되는 서브쿼리는 예외)
  --기본키 외래키는 복사가 안되고 컬럼과 데이터가 복제하는데 사용할 수 있다(CREAT TABLE).
  --중간값을 계산하고 싶을 때 쓰는 것이다. 서브쿼리를 포함하고 있는 것을 메인쿼리라고 한다.
  --최종출력(최종결과를 조회하는)하는 값이 메인 쿼리로 쓰는 것이다.
  
  - 분류
    . 일반서브쿼리(SELECT절에 나오는 서브쿼리), IN LINE 서브쿼리(FROM절에 나오는 서브쿼리:반드시 범위를 선택하면 혼자 실행이 가능해야하는 점이 특징이다.), 
      중첩서브쿼리(WHERE절에 나오는 서브쿼리) 
    . 연관성 있는 서브쿼리(메인서브쿼리에 사용된 테이블과 서브쿼리에 사용된 테이블이 조인으로 연결되지 않았을 때), 
      연관성 없는 서브쿼리(메인서브쿼리에 사용된 테이블과 서브쿼리에 사용된 테이블이 조인으로 연결되었을 때)
    . 단일행(다중행)서브쿼리 --(관계연산자 6가지가 사용되어지는 서브쿼리,단일행은 결과가 1개만 나와야한다)/
      / 단일열(다중열)서브쿼리 
      
  1)연관성 없는 서브쿼리
    - 메인쿼리에 사용된 테이블과 서브쿼리에 사용된 테이블 사이에 조인을 사용하지 않는 서브쿼리
  
  사용법) 사원테이블에서 사원들의 평균급여보다 많은 급여를 받는 사원을 조회하시오.
         Alias는 사원번호,사원명,직책코드,급여
         
         (일반서브쿼리문/중첩서브쿼리/관계연산자 오른쪽에만 쓸 수 있다. 서브쿼리가 SALARY 왼쪽으로 나올 수 없다)
         (메인쿼리 : 사원테이블에서 사원들의 사원번호,사원명,직책코드,급여)
         SELECT 사원번호,사원명,직책코드,급여조회 
           FROM HR.EMPLOYEES
          WHERE SALARY > (평균급여--서브쿼리)  
         
         (서브쿼리 : 평균급여)
         SELECT AVG(SALARY)
           FROM HR.EMPLOYEES
         
         (결합)
          SELECT EMPLOYEE_ID AS 사원번호,
                 EMP_NAME AS 사원명,
                 JOB_ID AS 직책코드,
                 SALARY AS 급여조회 
            FROM HR.EMPLOYEES
           WHERE SALARY >(SELECT AVG(SALARY) --실행횟수가 107번 수행된다
                            FROM HR.EMPLOYEES)
        ORDER BY 4 DESC;
         
         
       (IN LINE 서브쿼리문)
          SELECT A.EMPLOYEE_ID AS 사원번호,
                 A.EMP_NAME AS 사원명,
                 A.JOB_ID AS 직책코드,
                 A.SALARY AS 급여조회 
            FROM HR.EMPLOYEES A, (SELECT AVG(SALARY) AS SAL
                                    FROM HR.EMPLOYEES) B --실행횟수가 1번 뿐이다. 독립적으로 실행이 가능하다. 프롬절엔 테이블과 뷰만이 올 수 있다.
           WHERE A.SALARY > B.SAL
        ORDER BY 4 DESC;
    
    
    

    
    
사용예)2017년 이후에 입사한 사원이 존재하는 부서를 조회하시오.
      Alias 부서번호,부서명,관리사원번호
    
    (메인쿼리 : 부서번호,부서명,관리사원번호)
     SELECT DISTINCT A.DEPARTMENT_ID AS 부서번호,
            B.DEPARTMENT_NAME AS 부서명,
            A.MANAGER_ID AS 관리사원번호
       FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
      WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
        AND B.DEPARTMENT_ID IN(서브쿼리)    --EXTRACT 날짜 데이터에서 6종류 날짜 구성요소의 데이터를 뽑을 때 사용한다.이렇게 뽑아낸 자료 타입은 숫자.
       
       
     (서브쿼리:2017년 이후에 입사한 사원이 존재하는 부서)
      SELECT DEPARTMENT_ID 
        FROM HR.EMPLOYEES
       WHERE HIRE_DATE>TO_DATE('20161231')
       
     (결합)
     연관성 없는 서브쿼리
     SELECT DISTINCT A.DEPARTMENT_ID AS 부서번호,
            B.DEPARTMENT_NAME AS 부서명
       FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
      WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
        AND A.DEPARTMENT_ID IN(SELECT DISTINCT DEPARTMENT_ID
                                 FROM HR.EMPLOYEES
                                WHERE HIRE_DATE>TO_DATE('20161231')) --다중행 서브쿼리
   ORDER BY 1;
                    
                    
    연관성 있는 서브쿼리              
     SELECT DISTINCT A.DEPARTMENT_ID AS 부서번호,
            B.DEPARTMENT_NAME AS 부서명
       FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
      WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
        AND EXISTS(SELECT 1
                     FROM HR.EMPLOYEES C
                    WHERE HIRE_DATE>TO_DATE('20161231')
                      AND C.EMPLOYEE_ID=A.EMPLOYEE_ID) --내부에서 조인 연산자가 실행되어야한다.
    ORDER BY 1;                      

    
사용예)상품테이블에서 상품의 평균판매가보다 판매가가 더 높은 상품의 상품번호,상품명,분류명,판매가를 조회하시오.
      Alias 상품번호,상품명,분류명,판매가
     
     (메인쿼리 : 평균판매가보다 판매가가 더 높은 상품의 상품번호,상품명,분류명,판매가)
         SELECT A.PROD_ID AS 상품번호,
                A.PROD_NAME AS 상품명,
                B.LPROD_NM AS 분류명,
                A.PROD_PRICE AS 판매가격 
           FROM PROD A, LPROD B 
          WHERE PROD_PRICE > (평균판매가--서브쿼리)  
     
     (서브쿼리 : 평균판매가)
         SELECT AVG(PROD_PRICE)
           FROM PROD
           
     (결합)
        SELECT A.PROD_ID AS 상품번호,
                A.PROD_NAME AS 상품명,
                B.LPROD_NM AS 분류명,
                A.PROD_PRICE AS 판매가격 
           FROM PROD A, LPROD B,(SELECT AVG(PROD_PRICE) AS CAVG
                                     FROM PROD) TC
          WHERE A.PROD_LGU=B.LPROD_GU --조건을 넣어주기
            AND A.PROD_PRICE > TC.CAVG
       ORDER BY 4 ASC;
          
          

사용예)회원테이블에서 2000년 이후 출생한 회원들이 보유하고 있는 마일리지보다 
      더 많은 마일리지를 보유한 회원의 회원번호,회원명,주민번호,마일리지를 조회하시오
      Alias  회원번호,회원명,주민번호,마일리지
      
      (메인쿼리 : 마일리지를 보유하고 있는 회원들의 회원번호,회원명,주민번호,마일리지)





      (서브쿼리 : 2000년 이후 출생한 회원들이 보유하고 있는 마일리지)

        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_REGNO1||MEM_REGNO2 AS 주민번호,
               MEM_MILEAGE AS 마일리지
          FROM MEMBER,(SELECT MEM_MILEAGE AS MM
                         FROM MEMBER 
                        WHERE MEM_BIR >= TO_DATE('20000101')) TM  
          WHERE MEM_MILEAGE > ALL(TM.MM)
       ORDER BY 4;
 
        --ALL은 AND의 개념
        SELECT A.MEM_ID AS 회원번호,
               A.MEM_NAME AS 회원명,
               A.MEM_REGNO1||MEM_REGNO2 AS 주민번호,
               A.MEM_MILEAGE AS A마일리지
          FROM MEMBER A
          WHERE A.MEM_MILEAGE > ALL(SELECT TM.MEM_MILEAGE
                           FROM MEMBER TM
                          WHERE TM.MEM_BIR < TO_DATE('20000101')
                          )
       ORDER BY 4;
       
       --ANY는 OR의 개념 => 900보다 큰
       SELECT A.MEM_ID AS 회원번호,
               A.MEM_NAME AS 회원명,
               A.MEM_REGNO1||MEM_REGNO2 AS 주민번호,
               A.MEM_MILEAGE AS A마일리지
          FROM MEMBER A
          WHERE A.MEM_MILEAGE > ANY(SELECT TM.MEM_MILEAGE
                           FROM MEMBER TM
                          WHERE TM.MEM_BIR < TO_DATE('20000101')
                          )
       ORDER BY 4;
 
 
        
        
        
        
        (2000년 이후에 태어난 애들의 마일리지)
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_REGNO1||MEM_REGNO2 AS 주민번호,
               MEM_MILEAGE AS 마일리지
          FROM MEMBER 
         WHERE MEM_BIR >= TO_DATE('20000101')



      

    
사용예)장바구니테이블에서 2020년 5월 회원별 최고 구매금액을 기록한 회원을 조회하시오
      Alias 회원번호,회원명,구매금액합계
      
      
      (서브쿼리 : 2020년 5월 회원별 구매금액 DESC / 회원이름까진 필요없어서 멤버 테이블은 안 쓴다 )
      SELECT A.CART_MEMBER AS CID, --회원번호
             SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM --구매금액 합계
        FROM CART A, PROD B
       WHERE A.CART_PROD=B.PROD_ID
         AND A.CART_NO LIKE '202005%'
    GROUP BY A.CART_MEMBER
    ORDER BY 2 DESC;


      (메인쿼리 : 서브쿼리 결과 중 맨 첫줄에 해당하는 자료 출력 )
      (결합)
      SELECT TA.CID AS 회원번호,
             M.MEM_NAME AS 회원명,
             TA.CSUM AS 구매금액합계
        FROM MEMBER M,  (SELECT A.CART_MEMBER AS CID, --회원번호
                                SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM --구매금액 합계
                           FROM CART A, PROD B
                          WHERE A.CART_PROD=B.PROD_ID
                            AND A.CART_NO LIKE '202005%'
                       GROUP BY A.CART_MEMBER
                       ORDER BY 2 DESC) TA --인라인 서브쿼리, 자기 혼자 스스로 독립해서 실행될 수 있는 쿼리
      WHERE M.MEM_ID=TA.CID --두 개가 같아야 회원명을 끌고 올 수 있다
        AND ROWNUM=1; --서브쿼리에서 갖고온 테이블에서 멤버테이블에서 이름을 출력하고 그 중 최상위 1명을 뽑아내야하는 게 메인쿼리
        
        
     (WITH절 사용)
     WITH A1 AS (SELECT A.CART_MEMBER AS CID, --회원번호
                        SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM --구매금액 합계
                   FROM CART A, PROD B
                  WHERE A.CART_PROD=B.PROD_ID
                    AND A.CART_NO LIKE '202005%'
               GROUP BY A.CART_MEMBER
               ORDER BY 2 DESC)
        SELECT B.MEM_ID, B.MEM_NAME, A1.CSUM
          FROM MEMBER B, A1
         WHERE B.MEM_ID=A1.CID
           AND ROWNUM=1; 
        
        
        
        
