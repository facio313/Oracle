2022-0901-01)
   ** 재고수불테이블 생성
   1) 테이블명 : REMAIN
   2) 컬럼명
   --------------------------------------------------------------
     컬럼명          데이터타입         NULLABLE           PK,FK
   --------------------------------------------------------------
   REMAIN_YEAR      CHAR(4)                             PK  --년도
   PROD_ID          VARCHAR2(10)                        PK & FK  --상품코드
   REMAIN_J_00      NUMBER(5)        DEFAULT 0  --기초재고
   REMAIN_I         NUMBER(5)                   --입고수량
   REMAIN_O         NUMBER(5)                   --출고수량
   REMAIN_J_99      NUMBER(5)        DEFAULT 0  --기말(현)재고
   REMAIN_DATE      NUMBER(5)        DEFAULT SYSDATE  --수정일자
   
   
CREATE TABLE REMAIN(
   REMAIN_YEAR      CHAR(4),
   PROD_ID          VARCHAR2(10),
   REMAIN_J_00      NUMBER(5) DEFAULT 0,
   REMAIN_I         NUMBER(5),
   REMAIN_O         NUMBER(5),
   REMAIN_J_99      NUMBER(5) DEFAULT 0,
   REMAIN_DATE      DATE DEFAULT SYSDATE,
   
CONSTRAINT pk_remain PRIMARY KEY(REMAIN_YEAR, PROD_ID),
CONSTRAINT fk_remain_PROD FOREIGN KEY(PROD_ID) REFERENCES PROD(PROD_ID));



**재고수불테이블(REMAIN)에 다음 자료를 입력하세요
 
 년도 : 2020년
 상품코드 : PROD 테이블의 모든 상품코드
 기초재고 : PROD 테이블의 적정재고량(PROD_PROPERSTOCK)
 입고/출고수량 : 0
 기말재고 : PROD 테이블의 적정재고량(PROD_PROPERSTOCK)
 갱신일자 : 2020년 1월 1일



 1) INSERT문과 SUBQUERY
   . '( )'를 사용하지 않는다
   . VALUES 절을 생략하고 서브쿼리를 기술
   -- INSERT 문을 쓸 때에는 VALUES 대신에 서브쿼리를 쓰는 것인데 괄호를 쓰지 않는다.
   
   INSERT INTO REMAIN(REMAIN_YEAR,PROD_ID,REMAIN_J_00,REMAIN_I,REMAIN_O,REMAIN_J_99,REMAIN_DATE)
        SELECT '2020',PROD_ID,PROD_PROPERSTOCK,0,0,PROD_PROPERSTOCK,TO_DATE('20200101')
          FROM PROD;
 COMMIT;
 SELECT * FROM REMAIN;
 
 2) 서브쿼리를 이용한 UPDATE문
 (사용형식)
  UPDATE 테이블명 
     SET (컬럼명1[,컬럼명2,...])=(서브쿼리)--서브쿼리의 셀렉트절의 열의 갯수가 바깥에 있는 컬럼의 개수와 같아야한다. WHERE 입고 수량과 날짜등을 변경시킬 수 있는 조건
  [WHERE 조건]--WHERE 업데이트 되야할 컬럼을 찾는 조건
  . SET 절에서 변경시킬 컬럼이 하나이상이 있는 경우 보통 ( )안에 컬럼명을 기술하며 
    서브쿼리의 SELECT 절의 컬럼들이  기술된 순서대로 1대1대응되어 할당됨
  . SET 절에서 ()를 사용하지 않으면 변경시킬 컬럼마다 서브쿼리를 기술해야함
  
  
사용예) 2020년 1월 상품들의 매입집계를 이용하여 재고수불테이블을 갱신하시오
       작업일자는 2020년 1월 31일이다. 
       (1월부터 3월까지 재고준비기간이라 가정, 4월 이전엔 매입만 발생되었다고 가정)


       (메인쿼리 : 재고수불테이블을 갱신)       
       UPDATE REMAIN A --테이블 별칭을 쓸 수 있다
          SET (REMAIN_I,REMAIN_J_99,REMAIN_DATE)=
              (서브쿼리 : 2020년 1월 제품별 매입수량집계)
        WHERE  A.PROD_ID IN(SELECT BUY_PROD --어떤 상품을 업데이트해야되는지 가려내야함.
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'))--2020년 1월에 매입된 상품 코드가 나온다
 

       (서브쿼리 : 2020년 1월 제품별 매입수량집계)
       
        SELECT BUY_PROD,
               SUM(BUY_QTY)
          FROM BUYPROD
         WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
      GROUP BY BUY_PROD;--제품별 매입수량 집계 39개가 나온다
      
      
      
      (결합)
       UPDATE REMAIN A --테이블 별칭을 쓸 수 있다
          SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
              (SELECT A.REMAIN_I + B.BSUM, 
                      A.REMAIN_J_99 + B.BSUM, 
                      TO_DATE('20200131')
                 FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM--(매입수량)
                         FROM BUYPROD
                        WHERE BUY_DATE BETWEEN TO_DATE('20200101') 
                          AND TO_DATE('20200131')
                     GROUP BY BUY_PROD
                     ORDER BY 1) B
                WHERE A.PROD_ID=B.BUY_PROD
                )
        WHERE  A.PROD_ID IN(SELECT BUY_PROD --어떤 상품을 업데이트해야되는지 가려내야함.
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'));--2020년 1월에 매입된 상품 코드가 나온다
 
 
 
 
 사용예) 2020년 2-3월 상품들의 매입집계를 이용하여 재고수불테이블을 갱신하시오
       작업일자는 2020년 3월 31일이다. 
       
       
       (메인쿼리 : 재고수불테이블을 갱신)       
       UPDATE REMAIN A --테이블 별칭을 쓸 수 있다
          SET (REMAIN_I,REMAIN_J_99,REMAIN_DATE)=
              (서브쿼리 : 2020년 2-3월 제품별 매입수량집계)
        WHERE  A.PROD_ID IN(SELECT BUY_PROD --어떤 상품을 업데이트해야되는지 가려내야함.
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200331'))--2020년 3월에 매입된 상품 코드가 나온다
 
       
       (서브쿼리 : 2020년 3월 제품별 매입수량집계)
        SELECT BUY_PROD,
               SUM(BUY_QTY)
          FROM BUYPROD
         WHERE BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331')
      GROUP BY BUY_PROD;--제품별 매입수량 집계 39개가 나온다
       

       (결합)
        UPDATE REMAIN A --테이블 별칭을 쓸 수 있다
          SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
              (SELECT A.REMAIN_I + B.BSUM, 
                      A.REMAIN_J_99 + B.BSUM, 
                      TO_DATE('20200331')
                 FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM--(매입수량)
                         FROM BUYPROD
                        WHERE BUY_DATE BETWEEN TO_DATE('20200201') 
                          AND TO_DATE('20200331')
                     GROUP BY BUY_PROD
                     ORDER BY 1) B
                WHERE A.PROD_ID=B.BUY_PROD
                )
        WHERE  A.PROD_ID IN(SELECT BUY_PROD --어떤 상품을 업데이트해야되는지 가려내야함.
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200331'));--2020년 2-3월에 매입된 상품 코드가 나온다
 
       
       
       
       
       
사용예) 2020년 4-7월 매입매출집계를 이용하여 재고수불테이블을 갱신하시오
       작업일자는 2020년 8월 1일이다.
       
      (메인쿼리 : 재고수불테이블을 갱신)   
      
      
       UPDATE REMAIN A --테이블 별칭을 쓸 수 있다
          SET (A.REMAIN_I,A.REMAIN_O,A.REMAIN_J_99,A.REMAIN_DATE)=
              (서브쿼리 : 2020년 4-7월 제품별 매입집계)B
              (서브쿼리 : 2020년 4-7월 제품별 매출집계)C
        WHERE  A.PROD_ID IN(SELECT A.BUY_PROD, 
                                   SUM(A.BUY_QTY),
                                   SUM(B.CART_QTY)
                              FROM BUYPROD A, CART B
                             WHERE B.CART_PROD=A.BUY_PROD
                               AND BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200731')
                               GROUP BY A.BUY_PROD);--2020년 4-7월에 매입매출된 상품 코드가 나온다
 
       

      (서브쿼리 : 2020년 4-7월 제품별 매입집계)B
        SELECT BUY_PROD, 
               SUM(BUY_QTY) AS BSUM
          FROM BUYPROD 
         WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200731')
      GROUP BY BUY_PROD;  --74개
       
       
       (서브쿼리 : 2020년 4-7월 제품별 매출집계)
        SELECT CART_PROD, 
               SUM(CART_QTY) AS CSUM
          FROM CART 
         WHERE SUBSTR(CART_NO,0,8) BETWEEN TO_DATE('20200401') AND TO_DATE('20200731')   
      GROUP BY CART_PROD; --73개
       
       
       
        (매입)
         UPDATE REMAIN A --테이블 별칭을 쓸 수 있다
           SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
                (SELECT A.REMAIN_I+BSUM,
                        A.REMAIN_J_99+BSUM,
                        TO_DATE('20200801')
                  FROM (SELECT BUY_PROD, SUM(BUY_QTY) AS BSUM
                          FROM BUYPROD 
                         WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND TO_DATE('20200731')
                      GROUP BY BUY_PROD) B
             WHERE  A.PROD_ID=B.BUY_PROD)
        WHERE  A.PROD_ID IN(SELECT BUY_PROD 
                              FROM BUYPROD
                             WHERE BUY_DATE BETWEEN TO_DATE('20200401') 
                               AND TO_DATE('20200731'));
                             
                             
                             
        (매출)
         UPDATE REMAIN A --테이블 별칭을 쓸 수 있다
           SET (A.REMAIN_O,A.REMAIN_J_99,A.REMAIN_DATE)=
                (SELECT A.REMAIN_O+CSUM,
                        A.REMAIN_J_99-CSUM,
                        TO_DATE('20200801')
                   FROM (SELECT CART_PROD, 
                               SUM(CART_QTY) AS CSUM
                         FROM CART 
                        WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007'   
                     GROUP BY CART_PROD) C
             WHERE  A.PROD_ID=C.CART_PROD)
        WHERE  A.PROD_ID IN(SELECT CART_PROD
                              FROM CART
                             WHERE SUBSTR(CART_NO,1,6) BETWEEN '202004' AND '202007');    
                             
                             
  --나중에 커밋해야할 때 매입이랑 매출 쿼리 둘 다 실행 후에 커밋하기                           
                             
                             
  3) 서브쿼리를 이용한 DELETE문
  (사용형식)
  DELETE FROM 테이블명
   WHERE 조건
   
   -'조건'에 IN이나 EXISTS 연산자를 사용하여 서브쿼리를 적용
   
   
   
   
   
사용예)장바구니테이블에서 2020년 4월 'm001'회원의 구매자료 중 'p202000005' 제품의
      구매내역을 삭제하시오.
    
    DELETE FROM CART A
     WHERE EXISTS(SELECT 1
                   FROM MEMBER B
                  WHERE B.MEM_ID='m001'
                    AND B.MEM_ID=A.CART_MEMBER)
       AND A.CART_NO LIKE '202004%'
       AND A.CART_PROD = 'p202000005';
                                
ROLLBACK;
                             
                             