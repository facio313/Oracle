    데이터 정의어(DDL:Data Definition Language)
        - 데이터 구조를 정의하기 위한 테이블 생성, 변경, 삭제 명령
        - CREATE, DROP, ALTER
    1. 테이블 생성명령
    (사용형식)
        CREATE TABLE 테이블명(
        컬럼명 데이터 타입[(크기)] [NOT NULL] [DEFAULT 값][,]
                                :
        컬럼명 데이터 타입[(크기)] [NOT NULL] [DEFAULT 값][,]
        [CONSTRAINT 기본키설정명 PRIMARY KEY(컬럼명[,컬럼명,...])[,]]
        [CONSTRAINT 외래키설정명1 FOREIGN KEY(컬럼명) REFERENCES 테이블명(컬럼명) DELETE ON CASCADE[,]]
                                :
        [CONSTRAINT 외래키설정명n FOREIGN KEY(컬럼명) REFERENCES 테이블명(컬럼) DELETE ON CASCADE];
        
        - 기본키설정명 : 기본키설정에 부여한 이름으로 중복사용할 수 없음
        - 외래키설정명1 : 외래키설정에 부여한 이름으로 중복사용할 수 없
        - REFERENCES 테이블명 : 부모테이블명
        - REFERENCES 테이블명(컬럼명) : 부모테이블에서 사용한 컬럼명
        - DELETE ON CASCADE : 부모테이블에서 특정행(ROW) 삭제 시 자식테이블의 자료부터 삭제하고 
        부모 자료 삭제 허용
        
사용예) 한국건설 요구사항에 맞는 데이터베이스를 설계결과를

(사원테이블)
CREATE TABLE EMP(
    EMP_ID CHAR(4),
    EMP_NAME VARCHAR2(30),
    DEPT_NAME VARCHAR2(50),
        CONSTRAINT pk_emp PRIMARY KEY(EMP_ID));
 
(사업장 테이블)
CREATE TABLE TBL_SITE(
    SITE_ID NUMBER(3) NOT NULL,
    SITE_NAME VARCHAR2(50),
    SITE_ADDR VARCHAR2(255))
        CONSTRAINT pk_tbl_site PRIMARY KEY(SITE_ID));
   
(사업장 자재 테이블)
CREATE TABLE TBL_MAT (
    MAT_ID CHAR(3),
    MAT_NAME VARCHAR2(50),
    SITE_ID NUMBER(3),
    CONSTRAINT pk_tbl_mat PRIMARY KEY(MAT_ID),
    CONSTRAINT fk_tbl_mat_site FOREIGN KEY(SITE_ID)
        REFERENCES SITE(SITE_ID));
       
(근무 테이블)
CREATE TABLE TBL_WORK(
    EMP_ID CHAR(4),
    SITE_ID NUMBER(3),
    INS_DATE DATE,
    CONSTRAINT pk_tbl_work PRIMARY KEY(EMP_ID,SITE_ID),
    CONSTRAINT fk_tbl_work_emp FOREIGN KEY(EMP_ID)
        REFERENCES EMP(EMP_ID),
    CONSTRAINT fk_tbl_work_site FOREIGN KEY(SITE_ID)
        REFERENCES SITE(SITE_ID));
        
2. DROP TABLE
- 테이블 삭제 명령
- 관계가 설정된 부모테이블은 임의로 삭제할 수 없음
    => 관계가 삭제된 후 또는 자식테이블이 삭제된 후 삭제 가능
(사용형식)
DROP TABLE 테이블명;
//지금까지는 메모리 부분에다 저장해놓은 것
COMMIT; //하드웨어 공간에다 저장해야 완료된 것

사용예) 사업장 테이블을 삭제하시오.
--자식테이블부터 삭제
DROP TABLE TBL_MAT;
DROP TABLE TBL_WORK;
DROP TABLE TBL_SITE;

ROLLBACK; // DROP은 ROLLBACK의 대상이 아님! DROP은 TABLE을 구조체 없애버리는 것

--제약조건 삭제 후 테이블 삭제
ALTER TABLE 테이블명 DROP CONSTRAINT 기본키설정명|외래키설정명;

ALTER TABLE TBL_MAT DROP CONSTRAINT fk_tbl_mat_site;
ALTER TABLE TBL_WORK DROP CONSTRAINT fk_tbl_work_site;
DROP TABLE TBL_SITE;

COMMIT;

3. ALTER 명령
- 테이블 이름변경, 컬럼이름 변경, 컬럼타입변경(작은 것으로는 안 되고 큰 것으로 가능-JAVA자동타입변환 같음)
- 컬럼삽입, 제약조건 추가삽입
- 컬럼삭제, 제약조건 삭제 등의 기능을 수행
*제약조건은 변경 안 됨 --> 삭제하고 삽입해야 함

1)테이블 이름 변경
    ALTER TABLE 원본 테이블명 RENAME TO 변경할 테이블명;
    사용예)사업장테이블(TBL_SITE)를 생성하고 SITE로 테이블명을 변경하시오.
        ALTER TABLE TBL_SITE RENAME TO SITE;
2)컬럼 이름 변경
    ALTER TABLE 테이블명 RENAME COLUMN 이전 컬럼명 TO 변경할 컬럼명;
    사용예)SITE테이블에 사업장주소(SITE_ADDR) 컬럼명을 SITE_ADDRESS로 변경하시오.
        ALTER TABLE SITE RENAME COLUMN SITE_ADDR TO SITE_ADDRESS;
3)컬럼의 데이터 타입 또는 크기 변경
    원본 컬럼의 크기보다 작은 크기로 변경은 허용되지 않음(오라클은 절대 불가!!어떤 경우든!!)
    ALTER TABLE 테이블명 MODIFY 컬럼명 타입[(크기)] // 선언하는 것과 똑같음
    사용예)SITE테이블의 SITE_ADDRESS컬럼(VARCHAR2(255))을 고정길이 문자열 100BYTE(CHAR(100))로 변경하시오.
        ALTER TABLE SITE MODIFY SITE_ADDRESS CHAR(30);// 자료가 없을 때는 변경되는데 자료가 삽입되면 절대 안 됨!!!!!!!
//"cannot decrease column length because some value is too big"
//CHAR은 고정길이라 남은 길이가 날라가는 게 아니라 공백이 다채워져서 저장됨. 공백도 유효자료임
//80->50xxxx 80->100OOO ->100->80XXXX
        ALTER TABLE SITE MODIFY SITE_ADDRESS CHAR(80);
        ALTER TABLE SITE MODIFY SITE_ADDRESS VARCHAR(255);
//VARCHAR은 가변이라 가능쓰!
INSERT INTO SITE VALUES(101,'오룡초교신축공사장','대전시 중구 계룡로 846 3층');
4)컬럼 또는 제약조건 추가
    ALTER TABLE 테이블명 ADD(컬럼명 데이터타입[(크기)]) 또는
    ALTER TABLE 테이블명 ADD(CONSTRAINT 기본키설정명 PRIMARY KEY(컬럼명[,...]))
    ALTER TABLE 테이블명 ADD(CONSTRAINT 외래키설정명 FOREIGN KEY(컬럼명)
        REFERENCES 테이블명(컬럼명))
    사용예)SITE테이블에 기본키(SITE_ID)를 설정하시오.
        ALTER TABLE SITE ADD(CONSTRAINT pk_site PRIMARY KEY(SITE_ID));
//삽입, 삭제는 거의 잘 안 일어남 -> CREAT와 마찬가지로 ALTER는 사용빈도가 낮음
//보통 DB MANAGER가 하는 것이지 사용자는 데이터 변경 권한이 없음
5)컬럼 삭제, 제약조건 삭제
    ALTER TABLE 테이블명 DROP COLUMN 컬럼명|DROP CONSTRAINT 제약이름;