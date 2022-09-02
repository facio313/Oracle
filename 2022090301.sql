2022-0902-03)오라클 객체
1. VIEW 객체
- TABLE과 유사한 객체
- 개존의 테이블이나 VIEW를 대상으로 새로운 SELECT 문의 결과가 VIEW가 됨
- SELECT문의 종속 객체가 아니라 독립 객체임
- 사용이유
    - 필요한 정보가 분산되어 매번 조인이 필요한 경우
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
    '[WITH   CHECK   OPTION]' : 뷰를 생성하는 SELECT 문의 조건절을 위배하도록 하는 DML 명령을 사용할 수 없음(뷰에만 적용)
    --원본테이블 where절에 위배되지 않도록
****'[WITH   READ    ONLY]'와 '[WITH   CHECK   OPTION]'는 같이 사용할 수 없음