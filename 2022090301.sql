2022-0902-03)오라클 객체
1. VIEW 객체
- TABLE과 유사한 객체
- 개존의 테이블이나 VIEW를 대상으로 새로운 SELECT 문의 결과가 VIEW가 됨
- SELECT문의 종속 객체가 아니라 독립 객체임 -- 테이블처럼 사용할 수 있음
- 사용이유
    - 필요한 정보가 분산되어 매번 조인이 필요한 경우
    - 특정자료의 접근을 제한하고자 하는 경우(보안상)
(사용형식)
CREAT   [OR REPLACE]    VIEW    뷰이름 [(컬럼list)]
AS
    SELECT 문
    [WITH   READ    ONLY]
    [WITH   CHECK   OPTION];
    
    'OR REPLACE' : 이미 존재하는 뷰인 경우 기존의 뷰를 대치하고 존재하지 않는 뷰는 새로 생성
    '[(컬럼list)]' : 뷰에서 사용할 컬럼명(생략시 ↓)
        1) 뷰를 생성하는 SELECT 문의 SELECT절에 컬럼별칭이 사용되었으면 컬럼병칭이 뷰의 컬럼명이 됨
        2) 뷰를 생성하는 SELECT 문의 SELECT절에 컬럼별칭이 사용되지 않았으면 SELECT절의 컬럼명이 뷰의 컬럼명이 됨
    '[WITH   READ    ONLY]' : 읽기전용뷰(뷰에만 적용) 
        --원본테이블은 변경이 잘 됨. read only는 뷰에만 적용되는 것.
        --원본테이블이 변경되면 뷰도 변경됨
        --안 쓰게 될 때, 뷰를 바꾸면 원본테이블도 바뀜
    '[WITH   CHECK   OPTION]' : 뷰를 생성하는 SELECT 문의 조건절을 위배하도록 하는 DML 명령을 사용할 수 없음(뷰에만 적용)
        --원본테이블 where절에 위배되지 않도록
****'[WITH   READ    ONLY]'와 '[WITH   CHECK   OPTION]'는 같이 사용할 수 없음

사용예)
회원테이블에서 마일리지가 3000이상인 회원의 회원번호, 회원명, 직업, 마일리지로 뷰를 생성하시오

CREATE  OR  REPLACE VIEW    V_MEM01--(MID, MNAME, MJOB, MILE)
AS
SELECT  MEM_ID,--      AS  회원번호,
        MEM_NAME,--    AS  회원명,
        MEM_JOB,--     AS  직업,
        MEM_MILEAGE-- AS  마일리지
FROM    MEMBER
WHERE   MEM_MILEAGE >= 3000;

SELECT * FROM V_MEM01;

**V_MEM01에서 오철희 회원(k001)의 마일리지를 2000으로 변경
-- VIEW에서 변경하라!! V가 앞에 붙었좌놔
-- 테이블명 대신 VIEW 이름 적으면 됨
UPDATE  V_MEM01
SET     MEM_MILEAGE = 2000
WHERE   MEM_ID = 'k001';
--V_MEM01 모임의 조건은 마일리지가 3000 이상임
--하지만 오철희는 2000으로 바꿈
--그 사람은 거기서 탈락됨!
--****원본도 바뀜!!!****
--그렇다면 원본테이블을 바꾸면 뷰가 바뀔까?

SELECT * FROM V_MEM01;

**MEMBER테이블에서 오철희 회원(k001)의 마일리지를 5000으로 변경
UPDATE  MEMBER
SET     MEM_MILEAGE = 5000
WHERE   MEM_ID = 'k001';
-- ㅇㅇ바뀜

SELECT * FROM V_MEM01;

**MEMBER테이블에서 모든 회원들의 마일리지를 1000씩 추가지급하시오
UPDATE  MEMBER
SET     MEM_MILEAGE = MEM_MILEAGE + 1000;
-- 원본테이블이 바뀌면 뷰가 자동으로 바뀜

SELECT * FROM V_MEM01;

(읽기전용 뷰)
CREATE  OR  REPLACE VIEW    V_MEM01(MID, MNAME, MJOB, MILE)
AS
SELECT  MEM_ID,--      AS  회원번호,
        MEM_NAME,--    AS  회원명,
        MEM_JOB,--     AS  직업,
        MEM_MILEAGE-- AS  마일리지
FROM    MEMBER
WHERE   MEM_MILEAGE >= 3000
WITH    READ    ONLY;

SELECT * FROM V_MEM01;

**MEMBER테이블에서 모든 회원의 마일리지를 1000씩 감소시키시오
UPDATE  MEMBER
SET     MEM_MILEAGE = MEM_MILEAGE-1000;

COMMIT;

**뷰 V_MEM01의 자료에서 오철희 회원의 마일리지('k001')를 3700으로 변경하시오
UPDATE  V_MEM01
SET     MILE = 3700
WHERE   MID='k001';
-- READ ONLY VIEW이기 때문에 읽을 수만 있음!! SELECT만 가능하다구!!
-- UPDATE로 변경은 불가능함
-- 원본테이블에서는 얼마든지 DML 가능쓰~~~~

(조건부여 뷰)
CREATE  OR  REPLACE VIEW    V_MEM01(MID, MNAME, MJOB, MILE)
AS
SELECT  MEM_ID,--      AS  회원번호,
        MEM_NAME,--    AS  회원명,
        MEM_JOB,--     AS  직업,
        MEM_MILEAGE-- AS  마일리지
FROM    MEMBER
WHERE   MEM_MILEAGE >= 3000
WITH    CHECK   OPTION; -- 여기서 옵션은 WHERE!!

SELECT * FROM V_MEM01;

**뷰 V_MEM01에서 신용환 회원('c001')의 마일리지를 5500으로 변경하시오
UPDATE  V_MEM01
SET     MILE = 5500
WHERE   MID='c001';
-- 3000이상이라는 조건을 위배하지 않았음
-- 뷰가 바껴서 원본도 바뀜!
-- 원본이 바뀌면 뷰도 바뀌고, 뷰가 바뀌면 원본도 바뀜
-- 다만 뷰를 바꿀 시 WITH READ ONLY일 때, WHERE조건 위배한 WITH CHECK OPTION일 때 DML로 변경 불가능해서 원본은 안 바뀜

**뷰 V_MEM01에서 신용환 회원('c001')의 마일리지를 1500으로 변경하시오
UPDATE  V_MEM01
SET     MILE = 1500
WHERE   MID='c001';
-- 뷰 조건을 위배한 것으로 바꿀 때는 바뀌지 않음!

UPDATE  MEMBER
SET     MEM_MILEAGE = 1500
WHERE   MEM_ID='c001';
-- 원본테이블에서는 얼마든지 바꿀 수 있음
-- 뷰에 바로 변경된 게 반영됨

SELECT * FROM V_MEM01;

ROLLBACK;