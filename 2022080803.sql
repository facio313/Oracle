2022-0808-03) 자료 검색명령(SELECT)
(사용형식)
    SELECT *|[DISTINCT] 컬럼명 [AS 별칭][,] : 출력할 열 / 컬럼명을 쓰는 것 = 일부 컬럼만 출력하겠다.
        컬럼명 [AS 별칭][,] --> ,는 뒤에 계속 뭐가 나옵니다 하는 말임
              :
     FROM 테이블명;
    [WHERE 조건] : 출력할 행 / 생략되면 전부 다 출력하겠다!!!
    [ORDER BY 컬럼명|컬럼인덱스 [ASC|DESC][,컬럼명|컬럼인덱스 [ASC|DESC],...]];
    . '별칭' : 해당 컬럼을 참조할 때, 출력 시 컬럼의 구별자로 사용 -->컬럼 제목이 길어지는 것 방지
               특수문자(공백 등) 사용 시 반드시 ""안에 기술 --> 될 수 있으면 AS 쓰고 나서!!
               --> ""가 잘 안 쓰이는데(3가지 정도) 그중 하나임
    . 컬럼인덱스 : SELECT 절에서 해당 컬럼의 사용 순번(1번부터 COUNTING)
    . ASC : 오름차순, DESC : 내림차순, 생략하면 ASC임 --> 모든 언어 똑같이 적용됨
    
    . FROM / WHERE / SELECT 순서대로 실행되고 이 세 개가 기본임
    . DISTINCT : 컬럼에서 중복되어 있는 것이 있음(서울, 대전 등등) -> 대표되어지는 것만!!!!! 중복배제(한 번만)
    . WHERE : 조건은 결과가 무조건 참OR거짓이어야만 함 --> 조건이 거짓이면 출력 안 함 / 행에 관련된 것!!!!!
    . ORDER BY : 순서화시키는 것! 자바는 0번부터지만 오라클은 1번부터!
    
** 테이블 삭제
    DROP TABLE 테이블명

DROP TABLE TEMP01;
DROP TABLE TEMP02;
DROP TABLE TEMP03;
DROP TABLE TEMP04;
DROP TABLE TEMP05;
DROP TABLE TEMP06;
DROP TABLE TEMP07;
DROP TABLE TEMP08;
DROP TABLE TEMP09;
DROP TABLE TEMP10;
DROP TABLE TBL_WORK;
DROP TABLE TBL_MAT;
DROP TABLE SITE;
DROP TABLE TBL_EMP;