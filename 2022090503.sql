2022-0905-03) 인덱스(INDEX) 객체
- 자료검색을 효율적으로 수행하기 위한 객체
- DBMS의 성능개선에 도움
- B-TREE 개념이 적용되어 동일 시간 안에 모든 자료 검색을 담보함
-- B-TREE 개념으로 만든 인.덱.스.
-- 검색 이진 트리의 전제 조건 좌자<부<우자
- 데이터 검색, 삽입, 변경 시 필요자료 선택의 효율성 증대
- 정렬과 그룹화의 성능 개선에 도움
- 인덱스 구성과 자원이 많이 소요됨
- 지속적인 데이터 변경이 발생되면 인덱스 파일 갱신에 많은 시간이 소요됨
-- 찾는 것은 빨리 찾지만 인덱스를 재구성하는 데에 시간이 많이 소요되는 것임
-- 인덱스의 개수는 적.당.히. 만드는 것이 좋음
-- 몇 개인지는 환경에 따라 다르므로 몰라. 그러니가 그냥 적.당.히. 만들어
- 인덱스의 종류
    - Unique / Non Unique Index 
    -- Unique : 키 값이 중복되면 안 됨. NULL값도 취급하지만 딱 하나만! > 중복돼서는 안 되니까
    -- 기본키 아님!!!!(기본키는 NULL값 안 됨)
    - Single / Composite Index 
    -- Single : 한 컬럼 기준으로 키
    - Normal / Bitmap / Function-Based Normal Index
    -- Normal : B-TREE, 컬럼의 값과 물리적 주소값을 이용해서 다른 데이터의 주소값을 정하는 것
    -- Bitmap : 이진수의 맵핑 자료를 조작해서 만든 인덱스
    -- FUNCTION~ : 테이블의 컬럼들을 가공한 값을 인덱스로 생성한 것
    
(사용형식)
CREATE [UNIQUE|BITMAP] INDEX 인덱스명
    ON  테이블명(컬럼명[,컬럼명,...])[ASC|DESC]
    
사용예)
회원테이블에서 이름 컬럼으로 인덱스를 구성하시오
CREATE INDEX IDX_NAME -- Unique면 안 됨! 이름은 중복될 수 있어서.
    ON  MEMBER(MEM_NAME);
-- 인덱스 안 만들어도 잘 만들어져 있음...
-- 기본키가 만들어질 때 자동으로 만들어짐. 자동인덱스
-- 위와 같이 인덱스를 만들 때 60가지 값 셋팅이 만들어짐ㄷㄷ

SELECT  *
FROM    MEMBER
WHERE   MEM_NAME = '배인정';

DROP    INDEX   IDX_NAME;

COMMIT;

CREATE  INDEX   IDX_REGNO
    ON  MEMBER(SUBSTR(MEM_REGNO2,2,4)); -- Function-Based Normal Index
    
SELECT  *
FROM    MEMBER
WHERE   SUBSTR(MEM_REGNO2,2,4) = '4558';